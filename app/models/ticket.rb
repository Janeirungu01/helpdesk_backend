class Ticket < ApplicationRecord
  # Associations
  belongs_to :user 
  belongs_to :department                      
  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"
  belongs_to :assigned_agent, class_name: "User", foreign_key: "assigned_agent_id", optional: true

  has_one_attached :attachment             

  # Validations
  validates :subject, :department, :description, :branch, :category,:user_id, :created_by, :status, :priority, presence: true
  # validates :ticket_id, uniqueness: true

  def as_json(options = {})
    super(options.merge(include: { department: { only: [:name] } }))
  end

  # Instance Methods
  def attachment_url
    Rails.application.routes.url_helpers.rails_blob_url(attachment, only_path: true) if attachment.attached?
  end
end
