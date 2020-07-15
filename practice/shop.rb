require 'json'
require 'httparty'

url = "https://gist.githubusercontent.com/michaelporter/b2743e0cdad0664fa9517c0a6b82cdda/raw/67e4606007391f678c9330ee3a77a9024fce4e64/products.json"
response = HTTParty.get(url)
data = JSON.parse(response)

class Product
    attr_accessor :id, :product_type, :options
    def initialize(id, product_type, options)
        @id = id
        @product_type = product_type
        @options = options
    end
end

class Store
    attr_accessor :name, :products
    def initialize(name)
        @name = name
        @products = []
    end
end
# create shop
shop = Store.new("TeePublic")

# testing add products
product1 = Product.new(shop.products.length() + 1, "t-shirt", ["size": "large"])
product1.options[0][:gender] = "male"
product1.options[0][:size] = "large"
shop.products << product1

product2 = Product.new(shop.products.length() + 1,"sticker", ["size": "large"])
product2.options[0][:gender] = "male"
product2.options[0][:size] = "large"
shop.products << product2


p shop.products