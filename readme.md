# Ruby CLI Program

## Project Summary
Using the Thor gem the program is able to simplify the process of parsing arguments passed to your CLI application. Given a JSON file of product data, this program takes in a product type and zero or more product options, and returns the remaining product option categories with the available options. The JSON gem is used in this project to allow parsing the json data from ruby data structure.

### Testing
This project uses the Rspec gem. RSpec is a testing tool for Ruby, created for behavior-driven development (BDD). It is the most frequently used testing library for Ruby in production applications.

Example: Rspec Testing.
```
> rspec ./spec/cli_shop_spec.rb

```

### Specification
:heavy_check_mark: A command line program that takes in a product type and 0 or more product options. `./my_program product_type [option1 option2 option3]`
:heavy_check_mark: Returns available product options for the criteria, excluding the options that have already been specified
:heavy_check_mark: A product list `products.json` is included;  your app should load it or otherwise be able to handle a new product list (with the same specification) being swapped in.
:heavy_check_mark: For the sake of simplicity, you can assume options will always be in the order specified in `products.json`.

### Example Input/Output
Example: Product type only.
```
> ./my_program tshirt
Gender: male, female
Color: red, blue, green
Size: small, medium, large, extra-large, 2x-large
```

Example: No Gender Option when 'female' is given
```
> ./my_program tshirt female
Color: red, blue, green
Size: small, medium, large, extra-large, 2x-large
```

Example: Options for Sticker
```
> ./my_program sticker
Size: x-small, small, medium, large, x-large
Style: matte, glossy
```

Example: Options for Small Sticker (no Size Option when 'small' is given)
```
> ./my_program sticker small
Style: matte
```

## Appendix
### Product List Schema
```
[
  {
    "id": 1,
    "product_type": "tshirt",
    "options": {
      "gender": "male",
      "color": "red",
      "size": "small"
    }
  }
]
```


### Used resources
- Adding to hash : 
https://stackoverflow.com/questions/9571768/how-to-add-new-item-to-hash/37676702
- Read json data and add to ruby : 
https://stackoverflow.com/questions/4464050/ruby-objects-and-json-serialization-without-rails?rq=1
https://stackoverflow.com/questions/3226054/how-to-convert-a-ruby-object-to-json
https://stackoverflow.com/questions/6879589/using-custom-to-json-method-in-nested-objects/6880638#6880638
- commandline applications: https://www.rubyguides.com/2018/12/ruby-argv/
- thor gem: https://www.rubyguides.com/2018/12/ruby-argv/
- creating hash in ruby for easy search: http://alanwsmith.com/convert-ruby-array-into-keys-of-new-hash
- creating json file with ruby: https://stackoverflow.com/questions/5507512/how-to-write-to-a-json-file-in-the-correct-format
- rspec gem: https://relishapp.com/rspec/rspec-core/docs/command-line
- global variables: https://stackoverflow.com/questions/12112765/how-to-reference-global-variables-and-class-variables
- directory: https://stackoverflow.com/questions/12832148/how-do-i-read-from-a-file-in-the-same-directory
- fake args array for rspec: https://stackoverflow.com/questions/1274675/what-does-warray-mean