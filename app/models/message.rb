class Message
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :email, :content, :subject, :mobile

  validates :name,
    presence: true

  validates :email,
    presence: true

  validates :content,
    presence: true

end
