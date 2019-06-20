require 'csv'

module Api
  module Endpoints
    class ChartsEndpoint < Grape::API
      content_type :png, 'image/png'
      format :png

      namespace :charts do
        desc 'Get chart.'
        params do
          requires :q, type: String
          optional :i, type: Integer, default: 360
          optional :p, type: String, default: '1d'
        end
        get ':q' do
          client = IEX::Api::Client.new
          chart = client.chart(params[:q], params[:p])
          data = chart.map(&:market_average).select { |v| v >= 0 }
          g = Gruff::Line.new
          g.data params[:q], data
          content_type 'image/png'
          g.to_blob
        end
      end
    end
  end
end
