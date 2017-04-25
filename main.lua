local applePay = require("plugin.applePay")
local json = require("json")
local status = display.newText("Apple Pay", display.contentCenterX, display.contentCenterY, system.nativeFont, 20)
local didComplete = false
local secretKey = "secretKey"
applePay.init("merchant id, "pk_test", function (e)
    if e.status == "showing" then
        status.text = "showing"
    end
    if e.status == "completed" then
        didComplete = true
        status.text = "completed"
        network.request( "https://api.stripe.com/v1/charges", "POST", function ( ev )
            if ev.isError then
                status.text = "Payment could not be processed"
            end
        end, {headers= {["Content-Type"]= "application/x-www-form-urlencoded", ["Authorization"]= "Bearer "..secretKey}, body= "amount=50001".."&currency=usd".."&source="..e.token.."&description=Pay Rob, Scott, and Brent" } ) -- 50001 = 500.01
    end
    if e.status == "hiding" then
        if didComplete == false then
            status.text = "failed"
        end
        didComplete = false
    end

end)
applePay.requestToken({{label="Scott", amount = 200.00}, {label="Rob", amount = 300.00}, {label="Brent", amount = .01}}, "USD")

