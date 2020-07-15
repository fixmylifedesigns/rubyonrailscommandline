p ARGV

if ARGV.include? "dog"
    p "hello"
else
    p "no"
end

hash = Hash[ARGV.collect { |item| [item.downcase, item.downcase] } ]
p hash.key("i")
p hash