class BaseController < ApplicationController
  def alive
    result = {
      status: "success",
      message: 'server is running well'
    }
    render json: result
  end
end
