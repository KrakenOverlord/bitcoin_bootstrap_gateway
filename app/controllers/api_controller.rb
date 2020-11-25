require_relative '../../../bitcoin_bootstrap_api/source/lambda_function'

class ApiController < ApplicationController
  def api
    event = {
      'requestContext' => { 'http' => { 'method' => 'POST' } },
      'stage' => 'development',
      'body' => args.to_json
    }

    render json: lambda_handler(event: event, context: nil)
  end

  private

  def args
    h = params.permit(params.keys).to_h.to_h # Rails is retarded.
    h.delete('controller')
    h.delete('action')
    h
  end
end
