local frame = CreateFrame("Frame", "MountHelperFrame", UIParent, "BasicFrameTemplateWithInset")
frame:SetSize(600, 400)
frame:SetPoint("CENTER")
frame:Hide()

local scrollFrame = CreateFrame("ScrollFrame", "MountListScrollFrame", frame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", 10, -30)
scrollFrame:SetPoint("BOTTOMRIGHT", -30, 10)

local content = CreateFrame("Frame", "MountListScrollChild", scrollFrame)
content:SetSize(560, 300)
scrollFrame:SetScrollChild(content)

local mountListContent = content:CreateFontString("MountListContent", "OVERLAY", "GameFontNormal")
mountListContent:SetPoint("TOPLEFT")

frame.title = frame:CreateFontString(nil, "OVERLAY")
frame.title:SetFontObject("GameFontHighlight")
frame.title:SetPoint("LEFT", frame.TitleBg, "LEFT", 5, 0)
frame.title:SetText("Mount Collection Helper")

local refreshButton = CreateFrame("Button", "RefreshButton", frame, "GameMenuButtonTemplate")
refreshButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
refreshButton:SetSize(120, 30)
refreshButton:SetText("Refresh")
refreshButton:SetNormalFontObject("GameFontNormalLarge")
refreshButton:SetHighlightFontObject("GameFontHighlightLarge")

local mountData = {}

function RefreshMountList()
    -- Obtener los datos de las monturas
    local numMounts = C_MountJournal.GetNumMounts()
    mountData = {}

    for i = 1, numMounts do
        local name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected = C_MountJournal.GetMountInfo(i)
        if isCollected then
            table.insert(mountData, {name = name, icon = icon, source = sourceType})
        end
    end

    -- Actualizar la lista de monturas
    local listText = ""
    for _, mount in ipairs(mountData) do
        listText = listText .. "|T" .. mount.icon .. ":20|t " .. mount.name .. " - Source: " .. mount.source .. "\n"
    end
    mountListContent:SetText(listText)
end

refreshButton:SetScript("OnClick", RefreshMountList)

frame:SetScript("OnShow", function()
    if not MountCollectionHelperDB then
        MountCollectionHelperDB = {}
    end
    mountData = MountCollectionHelperDB
    RefreshMountList()
end)

frame:SetScript("OnHide", function()
    MountCollectionHelperDB = mountData
end)
