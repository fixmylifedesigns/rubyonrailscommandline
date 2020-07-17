require_relative "../cli_shop"
require 'json'

# To run this test file simply just run "rspec .\cli_shop_spec.rb" in your command line
# I chose to use rspec because it was the testing tool I first used. It is also really popular

describe "CLI Project" do

  # Here I create senerios where I am adding tshirts, stickers and mugs to the database
  # I have created test to make sure I am receiving the right type of data and the data
  # being entered is correct
  describe "Added to Database" do 
    # I repeated these test for each product option.
    describe "Adding tshirts" do
      # I use %w to mimic ARGS and put custom input for each test
      args = %w[tshirt male blue small]
      tshirt1 = ShopApp.start(args)
      it "Return should be a hash" do
        expect(tshirt1).to be_kind_of(Hash)
      end

      it "options should have 3 variables inside" do
        expect(tshirt1[:options].length).to eq 3
      end

      it "return has product type that is equal to tshirt" do
        expect(tshirt1).to include(:product_type=>"tshirt")
      end

      it "Tshirt return includes an id" do
        expect(tshirt1).to include(:id)
      end    

      it "Checking that tshirt data was added by filtering by id" do
        data =  JSON.parse(File.read(File.join(File.dirname(__FILE__), '../products.json')))
        id = data.select {|x| x["id"] == tshirt1[:id]}
        expect(id[0]["id"]).to eq(tshirt1[:id])
        expect(id[0]["product_type"]).to eq(tshirt1[:product_type])
      end

    end

    describe "Adding mugs" do 
      args = %w[mug travel-mug]
      mug1 = ShopApp.start(args)
      it "Mug return should be a hash" do
        expect(mug1).to be_kind_of(Hash)
      end

      it "Mug return includes an id" do
        expect(mug1).to include(:id)
      end 

      it "Mug options should have 1 variables inside" do
        expect(mug1[:options].length).to eq 1
      end

      it "Checking that mug data was added to the json file by comparing id" do
        data =  JSON.parse(File.read(File.join(File.dirname(__FILE__), '../products.json')))
        mugid = data.select {|m| m["id"] == mug1[:id]}
        p mugid
        expect(mugid[0]["id"]).to eq(mug1[:id])
        expect(mugid[0]["product_type"]).to eq(mug1[:product_type])
      end
    end

    describe "Adding stickers" do 
      args = %w[sticker small matt]
      sticker1 = ShopApp.start(args)
      sticker2 = ShopApp.start(args)
      it "Sticker return should be a hash" do
        expect(sticker1).to be_kind_of(Hash)
        expect(sticker2).to be_kind_of(Hash)

      end

      it "Sticker return includes an id" do
        expect(sticker1).to include(:id)
      end 

      it "sticker options should have 2 variables inside" do
        expect(sticker1[:options].length).to eq 2
        expect(sticker2[:options].length).to eq 2

      end

      it "Checking that sticker data was added to the json file by comparing id" do
        data =  JSON.parse(File.read(File.join(File.dirname(__FILE__), '../products.json')))
        stickerid1 = data.select {|m| m["id"] == sticker1[:id]}
        stickerid2 = data.select {|m| m["id"] == sticker2[:id]}

        expect(stickerid1[0]["id"]).to eq(sticker1[:id])
        expect(stickerid1[0]["product_type"]).to eq(sticker1[:product_type])

        expect(stickerid2[0]["id"]).to eq(sticker2[:id])
        expect(stickerid2[0]["product_type"]).to eq(sticker2[:product_type])
      end
    
    end

  end

  # Here I am testing out the messages sent to the user when they are either missing an option in 
  # their product or if the option does not exist. This is why I print and return. I print so the user 
  # can see it in the console and return so the user can do anything with the data also allowing me to 
  # test properly
  describe "Pop up options" do 

    it "is empty when option is not specified" do
      args = %w[]
      run = ShopApp.start(args)
      expect(run).to eq({})
    end

    describe "Tshirt options" do

      it "should return all tshirt options" do
        args = %w[tshirt]
        run = ShopApp.start(args)
        expect(run).to eq "Gender: male, female\nColor: white, red, navy, blue, black\nSize: small, medium, large, extra-large, 2x-large\n"
      end

      it "Wrong input should return options for incorrect input" do
        wrongGender = ShopApp.start(%w(tshirt fmale white large))
        wrongColor = ShopApp.start(%w(tshirt male whiite large))
        wrongSize = ShopApp.start(%w(tshirt male white xmall))

        expect(wrongGender).to eq "Gender: male, female\n"
        expect(wrongColor).to eq "Color: white, red, navy, blue, black\n"
        expect(wrongSize).to eq "Size: small, medium, large, extra-large, 2x-large\n"

      end

      it "should return tshirt options for color and size" do
        args = %w[tshirt male]
        run = ShopApp.start(args)
        expect(run).to eq "Color: white, red, navy, blue, black\nSize: small, medium, large, extra-large, 2x-large\n"
      end

      it "should return tshirt options for size" do
        args = %w[tshirt male white]
        run = ShopApp.start(args)
        expect(run).to eq "Size: small, medium, large, extra-large, 2x-large\n"
      end
    end

    describe "Sticker options" do

      it "should return all sticker options" do
        args = %w[sticker]
        run = ShopApp.start(args)
        expect(run).to eq "Size: x-small, small, medium, large, x-large\nStyle: matt, glossy\n"
      end

      it "should return sticker style options" do
        args = %w[sticker small]
        run = ShopApp.start(args)
        expect(run).to eq "Style: matt, glossy\n"
      end

      it "Wrong input should return options for incorrect input" do
        wrongSize = ShopApp.start(%w[sticker xmall matt])
        wrongStyle = ShopApp.start(%w[sticker small mat])
        expect(wrongSize).to eq "Size: x-small, small, medium, large, x-large\n"
        expect(wrongStyle).to eq "Style: matt, glossy\n"
      end

    end

    describe "Mug options" do

      it "should return all mug options" do
        args = %w[mug]
        run = ShopApp.start(args)
        expect(run).to eq "Type: coffee-mug, travel-mug\n"
      end

      it "Wrong mug type input should return mug options" do
        args = %w[mug no-travel-mug]
        run = ShopApp.start(args)
        expect(run).to eq "Type: coffee-mug, travel-mug\n"
      end

    end
 
  end

  # Here I am testing the data in the hashtable I created to make sure it has the proper
  # information
  describe "JSON Data" do

    it "Return is a string" do
      expect($productOptions["tshirt"]["gender"]["female"]).to be_kind_of(String)
    end

    it "Should not be empty" do
      expect($productOptions["tshirt"]).not_to be_empty
    end

    it "Male should return gender" do
        expect($productOptions["tshirt"]["gender"]["male"]).to eq "gender"
    end

    it "Should be a hash" do
      expect($productOptions).to be_kind_of(Hash)
    end
  end

  # Here I am testing the optionsmapping method I created to help with making the messages for the user
  # I should be able to put any kind of data and get a message in return with no errors
  describe "Options mapping method" do



    it "message" do
      exampleHash = {
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
      # p exampleHash["tshirt"] 
      ShopApp.start(%w[])
      expect(optionMapping(exampleHash["tshirt"]["gender"], "Gender" )).to eq ""
    end
  end

end
