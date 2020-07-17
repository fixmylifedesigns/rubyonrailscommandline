require 'json'
require "thor"
require 'yaml'
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
            string = "Gender:"
            genderOptions.map do |n, i|
                if genderOptions.keys[0] === n
                    string = string + " " + n 
                else
                    string = string + ", " + n 
                end
            end
            p string 
        end

        if colorOptions[name[1]] 
            product.options[:color]= name[1]
        else
            string = "Color:"
            colorOptions.map do |n, i|
                if colorOptions.keys[0] === n
                    string = string + " " + n 
                else
                    string = string + ", " + n 
                end
            end
            p string 
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
            string = "Size:"
            sizeOptions.map do |n, i|
                if sizeOptions.keys[0] === n
                    string = string + " " + n 
                else
                    string = string + ", " + n 
                end
            end
            p string 
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

        if !sizeOptions[name[0]]
            string = "Size: "
            sizeOptions.map do |n, i|
                # p typeOptions.keys[0]
                if sizeOptions.keys[0] === n
                    string = string + " " + n 
                else
                    string = string + ", " + n 
                end
            end
            p string
            # p "Size : #{sizeOptions.keys.inspect.to_s}"
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
            string = "Style: "
            styleOptions.map do |n, i|
                # p typeOptions.keys[0]
                if styleOptions.keys[0] === n
                    string = string + " " + n 
                else
                    string = string + ", " + n 
                end
            end
            p string
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
            string = "Type:"
            # typeOptions.map { |n, i| string = string + " " + n } 
            typeOptions.map do |n, i|
                # p typeOptions.keys[0]
                if typeOptions.keys[0] === n
                    string = string + " " + n 
                else
                    string = string + ", " + n 
                end
            end
            p string 
            # p "Style : #{typeOptions.keys.inspect.to_s}".to_yaml
        end
        # p product
    end
end

class TestShop


end

ShopApp.start(ARGV)
# p JSON.parse(File.read('products.json'))