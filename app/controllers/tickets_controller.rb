
class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: [:show, :update]

  def index
  if current_user.usertype == 'Admin'
    tickets = Ticket.includes(:created_by, :department).all
  else
    tickets = Ticket.includes(:created_by, :department).where(created_by: current_user)
  end

  render json: tickets.as_json(
    include: {
      created_by: { only: [:id, :fullname, :username] },
      department: { only: [:id, :name] }
    }
  )
end

  def show
    render json: @ticket.as_json(
      include: {
        created_by: { only: [:id, :name, :email, :username] },
        department: { only: [:id, :name] } 
      }
    )
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.created_by = current_user
    @ticket.user = current_user if @ticket.user.nil?

    if @ticket.save
      render json: @ticket.as_json(
        include: {
          created_by: { only: [:id, :name, :email, :username] },
          department: { only: [:id, :name] }
        }
      ), status: :created
    else
      render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

# update status
def update
  if @ticket.update(ticket_params)
    render json: @ticket, status: :ok
  else
    render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
  end
end



  private

  def ticket_params
    params.require(:ticket).permit(
      :subject, :description, :department_id,
      :category, :priority, :branch, :status,
      :attachment, :created_at, :updated_at, :notes,
    )
  end

  def set_ticket
    @ticket = Ticket.find_by(ticket_id: params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Ticket not found" }, status: :not_found
  end
end
