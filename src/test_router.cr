require "yaml"

data = YAML.parse <<-END
         ---
         root:
           "/" : "func1"

         application:
           "/": "func2"
           sous_application:
             "/": "func3"
             "/dada": "func4"
         END

def rec_walk(hash : Hash, url : String)
  hash.each do |key, value|
    if value.as_h?
    	rec_walk value.as_h, url+key.as_s+"/"
    else
      puts "ROUTE : #{url+key.as_s[1..-1]}"
    end
  end
end

rec_walk data.as_h, ""
