class ProgramsController < ApplicationController
  load_and_authorize_resource :group, find_by: :slug, except: :tutorial
  load_and_authorize_resource except: %i[tutorial new]

  def new
    @program = Program.new
    @program.programmable = @group ? @group : current_user
  end

  def create
    if @program.save
      redirect_to @program.programmable if @program.programmable.is_a?(User)
      redirect_to [@program.programmable.project, @program.programmable] if @program.programmable.is_a?(Group)
    else
      render :new
    end
  end

  def tutorial
    @program = Program.find(params[:program_id])
  end

  private

  def program_params
    params.require(:program).permit :program_type, :unipos_share_number, :programmable_id, :programmable_type
  end
end
