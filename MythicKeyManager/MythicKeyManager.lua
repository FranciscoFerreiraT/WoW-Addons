local frame = CreateFrame("Frame", "KeyManagerFrame", UIParent, "BasicFrameTemplateWithInset")
frame:SetSize(500, 600)
frame:SetPoint("CENTER")
frame:Hide()

local scrollFrame = CreateFrame("ScrollFrame", "KeyListScrollFrame", frame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", 10, -30)
scrollFrame:SetPoint("BOTTOMRIGHT", -30, 10)

local content = CreateFrame("Frame", "KeyListScrollChild", scrollFrame)
content:SetSize(460, 480)
scrollFrame:SetScrollChild(content)

local keyListContent = content:CreateFontString("KeyListContent", "OVERLAY", "GameFontNormal")
keyListContent:SetPoint("TOPLEFT")

frame.title = frame:CreateFontString(nil, "OVERLAY")
frame.title:SetFontObject("GameFontHighlight")
frame.title:SetPoint("LEFT", frame.TitleBg, "LEFT", 5, 0)
frame.title:SetText("Mythic Key Manager")

local refreshButton = CreateFrame("Button", "RefreshButton", frame, "GameMenuButtonTemplate")
refreshButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
refreshButton:SetSize(120, 30)
refreshButton:SetText("Refresh")
refreshButton:SetNormalFontObject("GameFontNormalLarge")
refreshButton:SetHighlightFontObject("GameFontHighlightLarge")

local keyData = {}

function RefreshKeyList()
    -- Simulación de obtención de datos de claves
    keyData = {
        {player = "Player1", dungeon = "De Other Side", level = 15, time = "34:12", best = "30:45"},
        {player = "Player2", dungeon = "Halls of Atonement", level = 12, time = "25:30", best = "24:20"},
        {player = "Player3", dungeon = "Mists of Tirna Scithe", level = 10, time = "22:10", best = "20:15"},
    }
    
    local listText = ""
    for _, key in ipairs(keyData) do
        listText = listText .. key.player .. ": " .. key.dungeon .. " + " .. key.level .. " - " .. key.time .. " (Best: " .. key.best .. ")\n"
    end
    keyListContent:SetText(listText)
end

refreshButton:SetScript("OnClick", RefreshKeyList)

frame:SetScript("OnShow", function()
    if not MythicKeyManagerDB then
        MythicKeyManagerDB = {}
    end
    keyData = MythicKeyManagerDB
    RefreshKeyList()
end)

frame:SetScript("OnHide", function()
    MythicKeyManagerDB = keyData
end)
