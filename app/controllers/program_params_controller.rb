class ProgramParamsController < ApplicationController
  load_and_authorize_resource

  def create
    @program_param.save
  end

  def update
    @program_param.update program_param_params
  end

  private

  def program_param_params
    params.require(:program_param).permit :program_id, :program_parammable_type, :program_parammable_id, :unipos_request
  end
end
