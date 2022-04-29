local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_slot_machine")

MySQL.createCommand("vRP/init_slot","INSERT IGNORE INTO vrp_slot_machine(user_id,pills,body_armor) VALUES(@user_id,@pills,@body_armor)")
MySQL.createCommand("vRP/my_slot_get", "SELECT * FROM vrp_slot_machine WHERE user_id = @user_id")
MySQL.createCommand("vRP/add_amount","UPDATE vrp_slot_machine SET pills = pills + @pills WHERE user_id = @user_id")
MySQL.createCommand("vRP/add_amount2","UPDATE vrp_slot_machine SET body_armor = body_armor + @body_armor WHERE user_id = @user_id")
MySQL.createCommand("vRP/slot_reset","UPDATE vrp_slot_machine SET pills = 0, body_armor = 0")

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if os.date("%X") == "00:00:00" then
      MySQL.execute("vRP/slot_reset", {})
    end
  end
end)

RegisterServerEvent("vrp_slot_machine:menu")
AddEventHandler("vrp_slot_machine:menu",function()
  open_menu(source)
end)

RegisterServerEvent("vrp_slot_machine:menu2")
AddEventHandler("vrp_slot_machine:menu2",function()
  open_menu2(source)
end)

function open_menu(source)
  local user_id = vRP.getUserId({source})
  local menu = {name="자판기",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
  menu["진통제 자판기"] = {function(player) pills(player) end}
  vRP.openMenu({source,menu})
end

function open_menu2(source)
  local user_id = vRP.getUserId({source})
  local menu = {name="자판기",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
  menu["방탄복 자판기"] = {function(player) body_armor(player) end}
  vRP.openMenu({source,menu})
end


function pills(source)
	local user_id = vRP.getUserId({source})
  vRP.prompt({source,"구매 개수를 선택해주세요","",function(source,amount)
    if amount ~= nil and amount ~= "" then
      amount = tonumber(amount)
      if amount > 0 then
        MySQL.query("vRP/my_slot_get", {user_id = user_id},function(rows, affected)
          local amount_check = rows[1].pills + amount
          if amount_check <= 100 then
            local company_id = 2
            local money_amount = 2500000 * amount
            local money_amount2 = 2500000 * amount
            if vRP.hasPermission({user_id, "userlist.police"}) or vRP.hasPermission({user_id, "userlist.prison"}) or vRP.hasPermission({user_id, "userlist.ems"}) then
              if vRP.tryFullPayment({user_id, money_amount}) then
                vRP.giveInventoryItem({user_id,"pills1231",amount,true})
                vRP.AddToCompany({company_id, money_amount})
                vRPclient.notify(source,{"~g~진통제 구매가 완료되었습니다.\n\n~r~"..comma_value(money_amount).. "~w~원"})
                vRP.pills_slot_machine("16711680", "OO서버 진통제 자판기 로그", "[ 고유번호 : ".. user_id .."번 ]\n\n[ 닉네임 : ".. GetPlayerName(source) .." ]\n\n[ 개수 : " .. comma_value(amount) .."개 ]\n\n[ 금액 : ".. comma_value(money_amount) .."원 ]\n\n", os.date("처리 일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | Made by : ! 에어#5285"))
                MySQL.execute("vRP/add_amount", {user_id = user_id, pills = amount})
              else
                vRPclient.notify(source,{"~r~금액이 부족합니다."})
              end
            elseif vRP.hasPermission({user_id, "userlist.dogsapa"}) or vRP.hasPermission({user_id, "userlist.society"}) or vRP.hasPermission({user_id, "userlist.heuglyongpa"}) or vRP.hasPermission({user_id, "userlist.goldmoon"}) or vRP.hasPermission({user_id, "userlist.wreckcar"}) or vRP.hasPermission({user_id, "userlist.ssg"}) then
              if vRP.tryFullPayment({user_id, money_amount2}) then
                vRP.giveInventoryItem({user_id,"pills1231",amount,true})
                vRP.AddToCompany({company_id, money_amount2})
                vRPclient.notify(source,{"~g~진통제 구매가 완료되었습니다.\n\n~r~"..comma_value(money_amount2).. "~w~원"})
                vRP.pills_slot_machine("16711680", "OO서버 진통제 자판기 로그", "[ 고유번호 : ".. user_id .."번 ]\n\n[ 닉네임 : ".. GetPlayerName(source) .." ]\n\n[ 개수 : " .. comma_value(amount) .."개 ]\n\n[ 금액 : ".. comma_value(money_amount2) .."원 ]\n\n", os.date("처리 일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | Made by : ! 에어#5285"))
                MySQL.execute("vRP/add_amount", {user_id = user_id, pills = amount})
              else
                vRPclient.notify(source,{"~r~금액이 부족합니다."})
              end
            else
              if vRP.tryFullPayment({user_id, money_amount}) then
                vRP.giveInventoryItem({user_id,"pills1231",amount,true})
                vRP.AddToCompany({company_id, money_amount})
                vRPclient.notify(source,{"~g~진통제 구매가 완료되었습니다.\n\n~r~"..comma_value(money_amount).. "~w~원"})
                vRP.pills_slot_machine("16711680", "OO서버 진통제 자판기 로그", "[ 고유번호 : ".. user_id .."번 ]\n\n[ 닉네임 : ".. GetPlayerName(source) .." ]\n\n[ 개수 : " .. comma_value(amount) .."개 ]\n\n[ 금액 : ".. comma_value(money_amount) .."원 ]\n\n", os.date("처리 일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | Made by : ! 에어#5285"))
                MySQL.execute("vRP/add_amount", {user_id = user_id, pills = amount})
              else
                vRPclient.notify(source,{"~r~금액이 부족합니다."})
              end
            end
          else
            vRPclient.notify(source,{"~r~하루에 진통제 100개만 구매 가능합니다."})
          end
        end)
      else
        vRPclient.notify(source,{"~r~정확히 입력해주세요."})
      end
    else
      vRPclient.notify(source,{"~r~정확히 입력해주세요."})
    end
  end})
end

function body_armor(source)
	local user_id = vRP.getUserId({source})
  vRP.prompt({source,"구매 개수를 선택해주세요","",function(source,amount)
    if amount ~= nil and amount ~= "" then
      amount = tonumber(amount)
      if amount > 0 then
        MySQL.query("vRP/my_slot_get", {user_id = user_id},function(rows, affected)
          local amount_check = rows[1].body_armor + amount
          if amount_check <= 30 then
            local money_amount = 5000000 * amount
            if vRP.tryFullPayment({user_id, money_amount}) then
              vRP.giveInventoryItem({user_id,"body_armor",amount,true})
              vRPclient.notify(source,{"~g~방탄복 구매가 완료되었습니다.\n\n~r~"..comma_value(money_amount).. "~w~원"})
              vRP.body_armor_slot_machine("16711680", "OO서버 방탄복 자판기 로그", "[ 고유번호 : ".. user_id .."번 ]\n\n[ 닉네임 : ".. GetPlayerName(source) .." ]\n\n[ 개수 : " .. comma_value(amount) .."개 ]\n\n[ 금액 : ".. comma_value(money_amount) .."원 ]\n\n", os.date("처리 일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | Made by : ! 에어#5285"))
              MySQL.execute("vRP/add_amount2", {user_id = user_id, body_armor = amount})
            else
              vRPclient.notify(source,{"~r~금액이 부족합니다."})
            end
          else
            vRPclient.notify(source,{"~r~하루에 방탄복 30개만 구매 가능합니다."})
          end
        end)
      else
        vRPclient.notify(source,{"~r~정확히 입력해주세요."})
      end
    else
      vRPclient.notify(source,{"~r~정확히 입력해주세요."})
    end
  end})
end

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
  MySQL.execute("vRP/init_slot", {user_id = user_id, pills = 0, body_armor = 0}, function(affected)
  end)
end)

function comma_value(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

function vRP.pills_slot_machine(color, name, message, footer)
  local embed = {
      {
        ["color"] = color,
        ["title"] = "**".. name .."**",
        ["description"] = message,
        ["footer"] = {
        ["text"] = footer,
        },
      }
    }
  
  PerformHttpRequest('웹훅링크', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function vRP.body_armor_slot_machine(color, name, message, footer)
  local embed = {
      {
        ["color"] = color,
        ["title"] = "**".. name .."**",
        ["description"] = message,
        ["footer"] = {
        ["text"] = footer,
        },
      }
    }
  
  PerformHttpRequest('웹훅링크', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end