class BranchesController < ApplicationController
  before_action :set_branch, only: [:destroy]

  def index
    if params[:query].present?
      @branches = Branch.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @branches = Branch.all
    end
    render json: @branches
  end

  def create
    branch = Branch.new(branch_params)
    if branch.save
      render json: branch, status: :created
    else
      render json: branch.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @branch.destroy
    head :no_content
  end

  private

  def set_branch
    @branch = Branch.find(params[:id])
  end

  def branch_params
    params.require(:branch).permit(:name)
  end
end
