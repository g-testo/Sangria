class Recipe < ActiveRecord::Base
  include PublicActivity::Common
  # tracked owner: ->(controller, model) { controller && controller.current_user }
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  has_many :ratings, dependent: :destroy
  belongs_to :user
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true
  mount_uploader :recipe_image, RecipeImageUploader
  validates_presence_of :author, :instructions, :servings
  validates :name, presence: true, length: { minimum: 5, maximum: 30 }
  validates :user_id, presence: true
  validate :recipe_image_size

  def average_rating
    if ratings.size > 1
      (ratings.sum(:score) / (ratings.size - 1))
    else
      nil
    end
  end

  filterrific :default_filter_params => { :sorted_by => 'name_desc' },
                :available_filters => %w[
                  sorted_by
                  search_query
                  search_query_ingredients
                  with_flavor_wine
                ]

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    terms = query.downcase.split(/\s+/)
    terms = terms.map { |e|
      ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    num_or_conditions = 1
    where(
      terms.map { |term|
        or_clauses = [
          "LOWER(recipes.name) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :search_query_ingredients, lambda { |query|
    return nil  if query.blank?
    terms = query.downcase.split(/\s+/)
    terms = terms.map { |e|
      ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    where(
      terms.map { |term|
        or_clauses = [
          "LOWER(ingredients.name) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] }.flatten
    ).joins(:ingredients)
  }

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
