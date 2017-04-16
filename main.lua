local applePay = require("plugin.applePay")
local status = display.newText("Apple Pay", display.contentCenterX, display.contentCenterY, system.nativeFont, 20)
local didComplete = false
applePay.init("merchantID", "stripeKey", function (e)
    if e.status == "showing" then
        status.text = "showing"
    end
    if e.status == "completed" then
        didComplete = true
        status.text = "completed"
    end
    if e.status == "hiding" then
        if didComplete == false then
            status.text = "failed"
        end
        didComplete = false
    end

end)
applePay.pay({{label="Scott", amount = 200.00}, {label="Rob", amount = 300.00}, {label="Brent", amount = .01}}, "USD")

