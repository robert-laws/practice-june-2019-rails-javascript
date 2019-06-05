class AdminsController < ApplicationController
  def index
    render layout: "admin"
  end

  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = ''
        req.params['client_secret'] = ''
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end

      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render :search
  end

  def gitsearch
  end

  def github
    begin
      @resp = Faraday.get 'https://api.github.com/search/repositories' do |req| 
        req.params['q'] = params[:query]
        req.params['client_id'] = ''
        req.params['client_secret'] = ''      
      end

      body = JSON.parse(@resp.body)

      if @resp.success?
        @repos = body["items"]
      else
        @error = body["errors"]
      end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render :gitsearch
  end
end