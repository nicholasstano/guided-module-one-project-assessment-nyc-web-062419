require 'rest-client'
require 'json'
require 'pry'

 def bond_array
      response_string = RestClient.get("http://dybushnell.com/bond/bonddata_edit.txt")
      response_hash = JSON.parse(response_string)
    response_hash
 end