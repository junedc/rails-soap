#http://www.greenacorn-websolutions.com/web-services/creating-a-ruby-soap-client.php

require 'savon'
#require "spec_helper"

client = Savon.client(wsdl: 'http://203.152.112.249:8107/CardWorksService.asmx?wsdl')
 
client.operations
# => food_get_food
 puts client.operations
# call the 'getFood' operation
response = client.call(:cw_get_user_profile_by_email, 
	          message: {
	          	emailaddress:'june@a.com'
	        }
	       )

#response = call_and_fail_gracefully(client, :cw_get_user_profile_by_email, :message => { :EmailAddress => "leo@a.com"})

puts '****************************************************'
puts response
puts '****************************************************'
puts response.to_hash
puts '****************************************************'
puts response.body[:cw_get_user_profile_by_email_response]
puts '****************************************************'
puts response.body[:row[0]]
puts '****************************************************'


#https://stackoverflow.com/questions/11224219/how-to-read-value-from-a-savon-response
doc = Nokogiri::XML(response.to_xml)
puts doc
puts '****************************************************'
element=doc.at('UserProfileID')
puts element


#https://stackoverflow.com/questions/16852631/how-do-i-print-the-values-and-their-tag-names-of-all-non-blank-xml-nodes-using-n
leaves = doc.xpath('//*[not(*)]')

leaves.each do |node|
  puts "#{node.name}: #{node.text}" unless node.text.empty?
end