require 'json'
# puts "What's your name?"
# name = {hi:""}
# name.hi = gets.chomp

# puts "Hi #{name}! How old are you?"
# puts name.hi

# ****out putting data***
# data = [
#     {
#       "id": 1,
#       "product_type": "tshirt",
#       "options": {
#         "gender": "male",
#         "color": "red",
#         "size": "small"
#       }
#     }
#   ]
#   data.push(
#     {
#     "id": 2,
#     "product_type": "tshirt",
#     "options": {
#       "gender": "male",
#       "color": "red",
#       "size": "small"
#     }
#   })
#   puts data

# ***Create store function ***

# class Shop
#     attr_accessor :name, :products
#     def initialize(name)
#         @name = name
#         @products =[  
#             {
#             "id": 1,
#             "product_type": "tshirt",
#             "options": {
#               "gender": "male",
#               "color": "red",
#               "size": "small"
#             }
#           }]
#     end

#     def as_json(options={})
#     {
#         name: @name,
#         apartments: @products
#     }
#   end
  
#   def to_json(*options)
#     as_json(*options).to_json(*options)
#   end
# end
# shop = Shop.new("fixmylife shop")

# p shop.to_json 
# p {a: [1,2,3]; b: 4}.to_json
# p JSON.pretty_generate(shop)

# *** http request ***
data = []
url = "https://gist.githubusercontent.com/michaelporter/b2743e0cdad0664fa9517c0a6b82cdda/raw/67e4606007391f678c9330ee3a77a9024fce4e64/products.json"
# require 'net/http'
# require 'json'
# # response = Net::HTTP.get_response("https://gist.githubusercontent.com/michaelporter/b2743e0cdad0664fa9517c0a6b82cdda/raw/67e4606007391f678c9330ee3a77a9024fce4e64/products.json", '/')
# # p response
require 'httparty'
response = HTTParty.get(url)
# data.push(response.parsed_response)
data =JSON.parse( response)
p response.parsed_response
  data.push(
    {
    "id": data.length + 1,
    "product_type": "tshirt",
    "options": {
      "gender": "male",
      "color": "red",
      "size": "wsmall"
    }
  })
p data
# p data[1]
# p JSON.parse(response)