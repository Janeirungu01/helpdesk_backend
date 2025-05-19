class Ticket < ApplicationRecord
  belongs_to :user 
  belongs_to :department                      
  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"
  belongs_to :assigned_agent, class_name: "User", foreign_key: "assigned_agent_id", optional: true

  has_one_attached :attachment             

  validates :subject, :description, :branch, :category, :user_id, :created_by_id, :department_id, :status, :priority, presence: true

  validates :ticket_id, uniqueness: true

  before_validation :generate_ticket_id, on: :create

def index
  tickets = Ticket.includes(:department, :created_by).all

  render json: tickets.as_json(include: {
    department: { only: [:id, :name] },
    created_by: { only: [:id, :name, :email] }
  })
end

  def attachment_url
    Rails.application.routes.url_helpers.rails_blob_url(attachment, only_path: true) if attachment.attached?
  end

  private

  def generate_ticket_id
    last_number = Ticket.maximum(:id).to_i + 1
    self.ticket_id = "TKT-#{last_number.to_s.rjust(6, '0')}" 
  end
end
