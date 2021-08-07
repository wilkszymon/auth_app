class Post < ApplicationRecord
    # belongs_to :user


    validates :city, presence: true
    validates :description, presence: true


    def self.from_API(city)

        begin
            
            url = URI.parse("https://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=724a091b8b8b8252b892bd42b7c03b6d")
            json = Net::HTTP.get(url)
            response = JSON.parse(json)
            response = response['main']['temp']
            (response - 273.15).round(1)
            
        rescue => exception

            return nil
            
        end
        
        
    end
end