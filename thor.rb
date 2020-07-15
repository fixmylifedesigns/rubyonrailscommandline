require 'json'
require "thor"

# data = JSON.parse(File.read('products.json'))

class Product
    attr_accessor :id, :product_type, :options
    def initialize(id, product_type, options)
        @id = id
        @product_type = product_type
        @options = options
    end

    # def as_json(input={})
    #     {
    #         id: @id,
    #         product_type: @product_type
    #         options: @options
    #     }
    # end

    # def to_json(*input)
    #     as_json(*input).to_json(*input)
    # end
end

class ShopApp < Thor

    desc "tshirt", "add t shirt to store"

    def tshirt(*name)
        data = JSON.parse(File.read('products.json'))
        # p data[-1].id
        genderOptions = {"male" =>"gender", "female" => "gender"}
        colorOptions = {"white" =>"color","red" =>"color","navy" =>"color","blue" =>"green","black" =>"color"}
        sizeOptions = {"small" =>"size", "medium" => "size", "large" => "size","extra-large" =>"size", "2x-large" => "size"} 
        hash = Hash[name.collect { |item| [item.downcase, item.downcase] } ]
        product = Product.new(data[-1]["id"] + 1, "t-shirt", {})

        if genderOptions[name[0]]
            product.options[:gender]= name[0]
        else
            p "Gender: male, female"
        end

        if colorOptions[name[1]] 
            product.options[:color]= name[1]
        else
            p "Color: red, blue, green, navy, black"
        end

        if sizeOptions[name[2]] 
            # product.options[:size]= name[2]
            # data.push(product)
            # p data[-2]["id"]
            # p data.length()
            data.push(
                {
                "id": data[-1]["id"] + 1,
                "product_type": "tshirt",
                "options": {
                  "gender": name[0],
                  "color": name[1],
                  "size": name[2]
                }
              })
            p data
            File.open("products.json","w") do |f|
                f.write(data.to_json)
              end
            # p product
        else
            p "Size: small, medium, large, extra-large, 2x-large"
        end

        # # p hash
        # p genderOptions["male"]
        # # p product[1]
        # p product
    end

    desc "sticker", "add sticker to store"
    def sticker(*name)
        data = JSON.parse(File.read('products.json'))
        sizeOptions = {"x-small" => "size", "small" =>"size", "medium" => "size", "large" => "size","x-large" =>"size" } 
        styleOptions = {"matt" =>"style", "glossy" => "style"} 

        if sizeOptions[name[0]]
            # product.options[:size]= name[0]
        else
            p "Size : #{sizeOptions.keys.inspect.to_s}"
        end
        if styleOptions[name[1]]
            # product.options[:size]= name[1]
            data.push(
                {
                "id": data[-1]["id"] + 1,
                "product_type": "sticker",
                "options": {
                  "size": name[0],
                  "style": name[1]
                }
              })
            p data
            File.open("products.json","w") do |f|
                f.write(data.to_json)
              end
        else
            p "Style : #{styleOptions.keys.inspect.to_s}"
        end
    end

    desc "mug", "add mug to store"
    def mug(*name)
        data = JSON.parse(File.read('products.json'))

        typeOptions = {"coffee-mug" =>"type", "travel-mug" => "type"}
        # product = Product.new(1, "t-mug", {"type" => name[0]})
        if typeOptions[name[0]]
            # product.options[:size]= name[1]
            data.push(
                {
                "id": data[-1]["id"] + 1,
                "product_type": "mug",
                "options": {
                  "type": name[0]
                }
              })
            p data
            File.open("products.json","w") do |f|
                f.write(data.to_json)
              end
        else
            p "Style : #{typeOptions.keys.inspect.to_s}"
        end
        # p product
    end
end

ShopApp.start(ARGV)
# p JSON.parse(File.read('products.json'))