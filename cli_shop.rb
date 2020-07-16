require 'json'
require "thor"

# def hello
#     p "Hello!"
#  end

# def productOne(name)
#     data = []
#     genderOptions = {"male" =>"gender", "female" => "gender"}
#     colorOptions = {"white" =>"color","red" =>"color","navy" =>"color","blue" =>"green","black" =>"color"}
#     sizeOptions = {"small" =>"size", "medium" => "size", "large" => "size","extra-large" =>"size", "2x-large" => "size"} 
#     if !genderOptions[name[0]]
#         string = "Gender:"
#         genderOptions.map do |n, i|
#             if genderOptions.keys[0] === n
#                 string = string + " " + n 
#             else
#                 string = string + ", " + n 
#             end
#     end
#         p string 
#     end

#     if !colorOptions[name[1]] 
#         string = "Color:"
#         colorOptions.map do |n, i|
#             if colorOptions.keys[0] === n
#                 string = string + " " + n 
#             else
#                 string = string + ", " + n 
#             end
#         end
#         p string 
#     end

#     if sizeOptions[name[2]] 
#         data.push(
#             {
#             "id": data[-1]["id"] + 1,
#             "product_type": "tshirt",
#             "options": {
#               "gender": name[0],
#               "color": name[1],
#               "size": name[2]
#             }
#           })
        
#         # File.open("products.json","w") do |f|
#         #     f.write(data.to_json)
#         #   end
#         p             {
#             "id" => 1,
#             "product_type" => "tshirt",
#             "options" : {
#               "gender": name[0],
#               "color": name[1],
#               "size": name[2]
#             }
#     else
#         string = "Size:"
#         sizeOptions.map do |n, i|
#             if sizeOptions.keys[0] === n
#                 string = string + " " + n 
#             else
#                 string = string + ", " + n 
#             end
#         end
#         p string 
#     end
# end

class ShopApp < Thor
    desc "database", "View all products in database"
    desc "tshirt", "Add t shirt to store"

    def tshirt(*name)
        data = JSON.parse(File.read('products.json'))
        genderOptions = {"male" =>"gender", "female" => "gender"}
        colorOptions = {"white" =>"color","red" =>"color","navy" =>"color","blue" =>"green","black" =>"color"}
        sizeOptions = {"small" =>"size", "medium" => "size", "large" => "size","extra-large" =>"size", "2x-large" => "size"} 
        if !genderOptions[name[0]]
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

        if !colorOptions[name[1]] 
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
            
            File.open("products.json","w") do |f|
                f.write(data.to_json)
              end
            p data[-1]
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
    end

    desc "sticker", "Add sticker to store"
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
        end
        if styleOptions[name[1]]
            data.push(
                {
                "id": data[-1]["id"] + 1,
                "product_type": "sticker",
                "options": {
                  "size": name[0],
                  "style": name[1]
                }
              })
            File.open("products.json","w") do |f|
                f.write(data.to_json)
            end
            p data[-1]
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

    desc "mug", "Add mug to store"
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
            File.open("products.json","w") do |f|
                f.write(data.to_json)
              end
            p data[-1]
        else
            string = "Type:"
            typeOptions.map do |n, i|
                if typeOptions.keys[0] === n
                    string = string + " " + n 
                else
                    string = string + ", " + n 
                end
            end
            p string 
        end
    end
end

ShopApp.start(ARGV)