
description "vrp_slot_machine"

dependency "vrp"

client_scripts{ 
	"@vrp/client/Proxy.lua",
	"@vrp/client/Tunnel.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/MySQL.lua",
  "@vrp/lib/utils.lua",
  "server.lua"
}