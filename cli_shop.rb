require 'json'
require "thor"

# to run this program simply run it as you would your other ruby programs but 
# at the end of the command add in your options.
#### For example: ruby .\cli_shop.rb tshirt male blue small ####
# testing is available in the spec folder simply option ./spec/cli_shop_spec.rb

# After some research on Cli programs I came accross the Thor gem which seems to 
# be a popular option and saves a couple of steps. If I didn't use thor I would 
# have built out a program that recieves the ARGV and I might just look at the first 
# element in the array to choose what method to run next.

# Created Global variables to avoid repeating to much and for certian variables 
# to be available in all methods
$jsonDirc = File.join(File.dirname(__FILE__), './products.json')
$readJsonData
$message
# created a hash table with data on products and options for o(1) search
# This hash table was created using the option information in the documentation 
# and available in the json data
$productOptions = {
    "tshirt" => {
      "gender" => {"male" =>"gender", "female" => "gender"},
      "color" => {"white" =>"color","red" =>"color","navy" =>"color","blue" =>"green","black" =>"color"},
      "size" => {"small" =>"size", "medium" => "size", "large" => "size","extra-large" =>"size", "2x-large" => "size"} 
    },
    "sticker" => {
      "size" => {"x-small" => "size", "small" =>"size", "medium" => "size", "large" => "size","x-large" =>"size" },
      "style" => {"matt" =>"style", "glossy" => "style"} 
    },
    "mug" => {
      "type" => {"coffee-mug" =>"type", "travel-mug" => "type"}
    }
}

# created this method to map over options available in the hash table to then 
# print message for the user o(n)
def optionMapping(options, name)
    # in this method I recieve the missing options for a given choice which I 
    # then map over and add to the global string 
    string = name + ":"
    options.map do |n, i|
        # if value equals first options its added to the string normally 
        if options.keys[0] === n
            string = string + " " + n 
        else
            # if value isn't the first options a comma is added to the start of the 
            # word to separate it from the one before it
            string = string + ", " + n 
        end
    end
    $message = $message + string + "\n"
end

class ShopApp < Thor 
    # desc "database", "View all products in database"
    desc "tshirt", "Add t shirt to store"
    def tshirt(*name)
        # reading through available json data to populate global variable I 
        # can then alter and create new file with added data reading through the data is o(n)
        # Json data is read and global variable updated at the start of this method to make sure 
        # the data is correct.
        $readJsonData = JSON.parse(File.read($jsonDirc))
        # when this function is first runned it sets the global variable to an empty string to
        # avoid any weird strings being created from running the application multiple times.
        $message = ""
        tshirt = $productOptions["tshirt"] 
        genderOptions = tshirt["gender"]
        colorOptions = tshirt["color"]
        sizeOptions = tshirt["size"] 
        # conditions that check the data recieved from the user to search the hash table. If the data
        # isn't in the table then it runs the optionsmapping method to create the message
        if !genderOptions[name[0]]
            # here is where I use the options mapping method I have above it accepts the product 
            # options that we want mapped into a string and the options title to add at the start 
            # of the string.
            optionMapping(genderOptions, "Gender")
        end
        if !colorOptions[name[1]] 
            optionMapping(colorOptions, "Color")
        end
        if sizeOptions[name[2]] && colorOptions[name[1]] && genderOptions[name[0]]
            $readJsonData.push(
                {
                "id": $readJsonData[-1]["id"] + 1,
                "product_type": "tshirt",
                "options": {
                  "gender": name[0],
                  "color": name[1],
                  "size": name[2]
                }
              })
            # writting new json file with added data
            File.open($jsonDirc,"w") do |f|
                f.write($readJsonData.to_json)
              end
            # here I am printing out the last input in the json data to assure the user their data
            # was added
            p $readJsonData[-1]
            return $readJsonData[-1]
        elsif !sizeOptions[name[2]]
            optionMapping(sizeOptions, "Size")
        end
        # I'm printing the data for the user to be able to see the message with available options
        # I'm also returning the data for testing purposes
        print $message
        return $message
    end

    # I am then repeating similar steps from tshirt except for stickers being an option less
    desc "sticker", "Add sticker to store"
    def sticker(*name)
        $readJsonData = JSON.parse(File.read($jsonDirc))
        $message = ""
        sticker = $productOptions["sticker"]
        sizeOptions = sticker["size"] 
        styleOptions = sticker["style"]

        if !sizeOptions[name[0]]
            optionMapping(sizeOptions, "Size")   
        end
        if styleOptions[name[1]] && sizeOptions[name[0]]
            $readJsonData.push(
                {
                "id": $readJsonData[-1]["id"] + 1,
                "product_type": "sticker",
                "options": {
                  "size": name[0],
                  "style": name[1]
                }
              })
            File.open($jsonDirc,"w") do |f|
                f.write($readJsonData.to_json)
            end
            p $readJsonData[-1]
            return $readJsonData[-1]
        elsif !styleOptions[name[1]]
            optionMapping(styleOptions, "Style")
        end
        print $message
        return $message
    end
    # rinse and repeat
    desc "mug", "Add mug to store"
    def mug(*name)
        $readJsonData = JSON.parse(File.read($jsonDirc))
        $message = ""
        typeOptions = $productOptions["mug"]["type"]
        if typeOptions[name[0]] 
            $readJsonData.push(
                {
                "id": $readJsonData[-1]["id"] + 1,
                "product_type": "mug",
                "options": {
                  "type": name[0]
                }
              })
            File.open($jsonDirc,"w") do |f|
                f.write($readJsonData.to_json)
              end
            p $readJsonData[-1]
            return $readJsonData[-1]
        else
            optionMapping(typeOptions, "Type")
        end
        print $message
        return $message
    end
end

# Because the program reads the json file this program runs in o(n). If it weren't for that 
# and the user put in all the correct data it would run in o(1) seeing as I have a hashtable 
# to improve performace on searching available options with the users inputs

ShopApp.start(ARGV)