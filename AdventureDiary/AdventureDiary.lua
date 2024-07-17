local frame = CreateFrame("Frame", "DiaryFrame", UIParent, "BasicFrameTemplateWithInset")
frame:SetSize(400, 500)
frame:SetPoint("CENTER")
frame:Hide()

local scrollFrame = CreateFrame("ScrollFrame", "DiaryScrollFrame", frame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", 10, -30)
scrollFrame:SetPoint("BOTTOMRIGHT", -30, 10)

local editBox = CreateFrame("EditBox", "DiaryEditBox", scrollFrame)
editBox:SetMultiLine(true)
editBox:SetFontObject("ChatFontNormal")
editBox:SetWidth(360)
editBox:SetHeight(460)
scrollFrame:SetScrollChild(editBox)

frame.title = frame:CreateFontString(nil, "OVERLAY")
frame.title:SetFontObject("GameFontHighlight")
frame.title:SetPoint("LEFT", frame.TitleBg, "LEFT", 5, 0)
frame.title:SetText("Diario de Aventuras")

local saveButton = CreateFrame("Button", "SaveButton", frame, "GameMenuButtonTemplate")
saveButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
saveButton:SetSize(120, 30)
saveButton:SetText("Guardar")
saveButton:SetNormalFontObject("GameFontNormalLarge")
saveButton:SetHighlightFontObject("GameFontHighlightLarge")

local screenshotButton = CreateFrame("Button", "ScreenshotButton", frame, "GameMenuButtonTemplate")
screenshotButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 10, 10)
screenshotButton:SetSize(100, 30)
screenshotButton:SetText("Captura")
screenshotButton:SetNormalFontObject("GameFontNormalLarge")
screenshotButton:SetHighlightFontObject("GameFontHighlightLarge")

local showButton = CreateFrame("Button", "ViewEntriesButton", frame, "GameMenuButtonTemplate")
showButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 10)
showButton:SetSize(100, 30)
showButton:SetText("Ver Entradas")
showButton:SetNormalFontObject("GameFontNormalLarge")
showButton:SetHighlightFontObject("GameFontHighlightLarge")

frame:SetScript("OnShow", function()
    if not AdventureDiaryDB then
        AdventureDiaryDB = {}
    end
    diaryEntries = AdventureDiaryDB
end)

function SaveEntry()
    local text = editBox:GetText()
    local entry = {
        date = date("%Y-%m-%d"),
        content = text
    }
    table.insert(diaryEntries, entry)
    AdventureDiaryDB = diaryEntries
    print("Entrada guardada!")
    editBox:SetText("")
end

function TakeScreenshot()
    Screenshot()
end

function ShowEntries()
    for _, entry in ipairs(diaryEntries) do
        print(entry.date .. ": " .. entry.content)
    end
end

saveButton:SetScript("OnClick", SaveEntry)
screenshotButton:SetScript("OnClick", TakeScreenshot)
showButton:SetScript("OnClick", ShowEntries)
