class NamesController < ApplicationController
  def index
    response = HTTParty.get(
      'https://api.opensea.io/api/v1/assets?order_direction=desc&offset=0&limit=50',
      headers: headers
    )
    json = response.parsed_response
    
    @names = {}
    
    json['assets'].each do |asset|
      name = asset['name']
      views = asset['num_views']
      
      category = get_category(name)
      
      if @names[category]
        @names[category] << { name: name, views: views }
      else
        @names[category] = [{ name: name, views: views }]
      end
    end
    
    @names.each do |category, names|
      @names[category] = names.sort_by { |name| name[:views] }.reverse
    end
  end
  
  private
  
  def headers
    {
      "X-API-KEY" => AppConfig.opensea_api_key
    }
  end

  def get_category(name)
    if name.match?(/^\d{3}$/)
      '3 digits'
    elsif name.match?(/^\d{4}$/)
      '4 digits'
    elsif name.match?(/^[a-z]+$/i)
      'nouns'
    else
      'other'
    end
  end
end
