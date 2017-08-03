class Recipe < ActiveRecord::Base
  has_many :ingredients
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  has_many :ratings
  belongs_to :user
  has_many :comments, as: :commentable
  mount_uploader :recipe_image, RecipeImageUploader
  validates_presence_of :author, :instructions, :servings
  validates :name, presence: true, length: { minimum: 5, maximum: 80 }
  validates :user_id, presence: true
  validate :recipe_image_size

  def average_rating
    if ratings.size > 0
      (ratings.sum(:score) / ratings.size).to_f
    else
      0
    end
  end

  filterrific :default_filter_params => { :sorted_by => 'name_desc' },
                :available_filters => %w[
                  sorted_by
                  search_query
                  search_query_ingredients
                  with_flavor_wine
                ]
  #An array of two search query methods
  searchArr = [
    {
      name: "search_query",
      conditions: 1,
      query: "recipes.name"
    },
    {
      name: "search_query_ingredients",
      conditions: 1,
      query:"recipes.author"
      # query:"recipes.ingredients.map(&:category)",
      # query:"recipes.ingredients.map(&:name)"

    }
  ]
  searchArr.each do |search|
    scope search[:name].to_sym, lambda { |query|
      return nil  if query.blank?
      terms = query.downcase.split(/\s+/)
      terms = terms.map { |e|
        ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
      }
      num_or_conditions = search[:conditions]
      where(
        terms.map {
          or_clauses = [
            "LOWER(#{search[:query]}) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conditions }.flatten
      )
    }
  end

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^name_/
      order("LOWER(recipes.name) #{ direction }")
    when /^author_/
      order("LOWER(recipes.author) #{ direction }")
    when /^created_at_/
      order("LOWER(recipes.created_at) #{ direction }")
    when /^avg_rating_/
      order("LOWER(recipes.avg_rating) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
  scope :with_flavor_wine, lambda { |flavors|
    where(:flavor => [*flavors])
  }
  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Author (a-z)', 'author_asc'],
      ['Date Created (Newest First)', 'created_at_desc'],
      ['Rating (Highest first)', 'avg_rating_desc']    ]
  end

  private

  def recipe_image_size
    if recipe_image.size > 5.megabytes
      errors.add(:recipe_image, "should be less than 5MB")
    end
  end
end
