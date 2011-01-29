require 'savon'

client = Savon::Client.new do
	wsdl.document = "http://schemas.monster.com/Current/WSDL/MonsterBusinessGateway.wsdl"
	wsse.credentials "xtestxftp", "ftp12345"
end

body = {
	"LicenseFilter" => "All",
	"LicenseType" => "Job Inventory",
	:attributes! => {
		"LicenseFilter" => { "monsterId" => "3" },
		"LicenseType" => { "monsterId" => "1" }
	}
}

header = {
	"mh:MonsterHeader" => {
		"mh:MessageId" => "0.38895300 1201759202",
		"mh:Timestamp" => "2008-01-31T07:00:02Z"
	},
	:attributes! => { 
		"mh:MonsterHeader" => { 
			"xmlns:mh" => "http://schemas.monster.com/MonsterHeader" 
		}
	}
}

response = client.request 'InventoriesQuery' do
	soap.namespaces["xmlns"] = "http://schemas.monster.com/Monster"
	soap.header = header
	soap.body = body
end

puts response.to_hash[:inventories_query_response][:inventories][:inventory].inspect
