require_relative "../cli_shop"
# require "helper"

describe "CLI Project" do

    it "says hello to someone" do
        expect(productOne(["male", "white","small"])).to eq "Size: small, medium, large, extra-large, 2x-large"
      end

    # describe "tshirt" do 
    #     it "returns all options for tshirt" do
    #         args = %w(tshirt)
    #         expect(ShopApp.start(args)).to eq nil
    #     end
    # end

    # describe "the hello function" do
    #     it "says hello" do
    #       expect(tshirt).to put "jhhe"
    #     end
    #   end

    #   it 'prints awesome things' do
    #     expect do
    #         productOne(["male"])
    #     end.to output('Awesome tests').to_stdout
    #   end
end