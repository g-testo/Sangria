class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :ratings
  belongs_to :user
  has_many :comments, as: :commentable
  mount_uploader :recipe_image, RecipeImageUploader
  validates_presence_of :author, :instructions, :servings
  validates :name, presence: true, length: { minimum: 5, maximum: 80 }
  validates :user_id, presence: true
  validate :recipe_image_size

  filterrific :default_filter_params => { :sorted_by => 'name_desc' },
                :available_filters => %w[
                  sorted_by
                  with_flavor_wine
                ]

  def average_rating
    if ratings.size > 0
      (ratings.sum(:score) / ratings.size).to_f
    else
      0
    end
  end

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^name_/
      order("LOWER(recipes.name) #{ direction }")
    when /^author_/
      order("LOWER(recipes.author) #{ direction }")
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
      ['Rating (Highest first)', 'avg_rating_desc']    ]
  end

  private

  def recipe_image_size
    if recipe_image.size > 5.megabytes
      errors.add(:recipe_image, "should be less than 5MB")
    end
  end
end
