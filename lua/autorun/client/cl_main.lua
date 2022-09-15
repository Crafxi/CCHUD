--[[
░█████╗░░█████╗░██╗░░██╗██╗░░░██╗██████╗░
██╔══██╗██╔══██╗██║░░██║██║░░░██║██╔══██╗
██║░░╚═╝██║░░╚═╝███████║██║░░░██║██║░░██║
██║░░██╗██║░░██╗██╔══██║██║░░░██║██║░░██║
╚█████╔╝╚█████╔╝██║░░██║╚██████╔╝██████╔╝
░╚════╝░░╚════╝░╚═╝░░╚═╝░╚═════╝░╚═════╝░

by Crafxi - 2022 | Crafxi Custom HUD
If you read this, only edit something here, if you
really know, what you're doing! Trust me, if something
goes wrong here, it wont end very well.
]]--




require("rdb")
rdb.activate()

--// Fonts
surface.CreateFont("CCHUD-Font", {
    font = "Poppins Medium",
    extended = true,
    size = ScrH() * 35 / 1080,
})

surface.CreateFont("CCHUD-Font1", {
    font = "Poppins Medium",
    extended = true,
    size = ScrH() * 30 / 1080,
})

surface.CreateFont("CCHUD-Font2", {
    font = "Poppins Medium",
    extended = true,
    size = ScrH() * 25 / 1080,
})
--// Colo(u)rs
local White = Color(255, 255, 255)
local Black = Color(0, 0, 0)
local Red = Color(255, 0, 0)
local Green = Color(0, 255, 0)
local Blue = Color(0, 0, 255)
local Yellow = Color(255, 255, 0)
local Purple = Color(255, 0, 255)
local Cyan = Color(0, 255, 255)

--// Other Variables
local scrw, scrh = ScrW(), ScrH()

--// Debug
Check = 0

--// Data
Data = {
    ["Health"] = {
        ["Length"] = 100,
        ["Position"] = {
            ["X"] = 0.01,
            ["Y"] = 0.95
        }
    },
    ["Armor"] = {
        ["Length"] = 100,
        ["Position"] = {
            ["X"] = 0.01,
            ["Y"] = 0.915
        }
    },
    ["Hintergrund"] = {
        ["Size"] = {
            ["X"] = 0.2,
            ["Y"] = 0.12
        },
        ["Position"] = {
            ["X"] = 0,
            ["Y"] = 0.88
        }
    },
    ["Color"] = {
        ["Health"] = Color(46, 204, 113),
        ["Armor"] = Color(52, 152, 219),
        ["Geld"] = Color(255,255,255),
        ["Text"] = Color(255,255,255),
        ["Background"] = Color(20,20,20,150),
        ["Background2"] = Color(20,20,20,0)
    },
    ["Name"] = {
        ["Position"] = {
            ["X"] = 0.165,
            ["Y"] = 0.89
        }
    },
    ["Weapon"] = {
        ["Position"] = {
            ["X"] = 1,
            ["Y"] = 1.03
        }
    },
    ["Geld"] = {
        ["Position"] = {
            ["X"] = 0.03,
            ["Y"] = 0.888
        }
    },
    ["Other"] = {
        ["Corner"] = 6,
    }
}

--// Saving User Data
function SaveUserData()
    file.Write("HUD_Settings_User_" .. steamID64 .. ".txt", util.TableToJSON(Data))
end


--// HUD Hook
hook.Add("HUDPaint" , "CCHUD" , function()
    --// Variables
    local HP = LocalPlayer():Health()
    local AR = LocalPlayer():Armor()
    Open_Overhead()

    if Check == 0 then
        steamID64 = LocalPlayer():SteamID64()
        if file.Exists("HUD_Settings_User_" .. steamID64 .. ".txt", "DATA") then
            Data = util.JSONToTable(file.Read("HUD_Settings_User_" .. steamID64 .. ".txt", "DATA"))
            Check = Check + 1
        end
    end
    --// Background
    draw.RoundedBox(Data.Other.Corner, scrw * Data.Hintergrund.Position.X, scrh * Data.Hintergrund.Position.Y, scrw * Data.Hintergrund.Size.X, scrh * Data.Hintergrund.Size.Y, Data.Color.Background2)
    --// Name
    local PlayerName = LocalPlayer():Nick()
    local WidthPlayerName, HeightPlayerName = surface.GetTextSize(PlayerName)
    if WidthPlayerName < 200 then
        draw.SimpleText(PlayerName, "CCHUD-Font1", scrw * Data.Name.Position.X, scrh * Data.Name.Position.Y, Data.Color.Text, TEXT_ALIGN_RIGHT)
    else
        draw.SimpleText(PlayerName, "CCHUD-Font2", scrw * Data.Name.Position.X, scrh * Data.Name.Position.Y * 1.001, Data.Color.Text, TEXT_ALIGN_RIGHT)
    end
    --// Health
    if HP <= Data.Health.Length then
        draw.RoundedBox(Data.Other.Corner, scrw * Data.Health.Position.X, scrh * Data.Health.Position.Y, scrw * Data.Health.Length * 3 / 1920, scrh * 0.03, Data.Color.Background)
        draw.RoundedBox(Data.Other.Corner, scrw * Data.Health.Position.X, scrh * Data.Health.Position.Y, HP * 3, scrh * 0.03, Data.Color.Health)
    else
        draw.RoundedBox(Data.Other.Corner, scrw * Data.Health.Position.X, scrh * Data.Health.Position.Y, scrw * Data.Health.Length * 3 / 1920, scrh * 0.03, Data.Color.Health)
    end
    draw.SimpleText(HP, "CCHUD-Font", scrw * Data.Health.Position.X, scrh * Data.Health.Position.Y * 1.001, Data.Color.Text, TEXT_ALIGN_LEFT)

    --// Armor
    if AR <= Data.Armor.Length then
        draw.RoundedBox(Data.Other.Corner, scrw * Data.Armor.Position.X, scrh * Data.Armor.Position.Y, scrw * Data.Armor.Length * 3 / 1920, scrh * 0.03, Data.Color.Background)
        draw.RoundedBox(Data.Other.Corner, scrw * Data.Armor.Position.X, scrh * Data.Armor.Position.Y, AR * 3, scrh * 0.03, Data.Color.Armor)
    else
        draw.RoundedBox(Data.Other.Corner, scrw * Data.Armor.Position.X, scrh * Data.Armor.Position.Y, scrw * Data.Armor.Length * 3 / 1920, scrh * 0.03, Data.Color.Armor)
    end
    draw.SimpleText(AR, "CCHUD-Font", scrw * Data.Armor.Position.X, scrh * Data.Armor.Position.Y * 1.001, Data.Color.Text, TEXT_ALIGN_LEFT)

    --// Weapon
    if HP > 0 then
        local Weapon = LocalPlayer():GetActiveWeapon()
        local AmmunitionType = Weapon:GetPrimaryAmmoType()
        local Magazine = Weapon:GetMaxClip1() or 0
        local Ammunition = Weapon:Clip1() or 0
        local AmmunitionFull = LocalPlayer():GetAmmoCount(AmmunitionType)
        local Weaponname = Weapon:GetPrintName()
        local zeichenwaffe = "|"
        if Magazine > 0 then
            draw.RoundedBox(Data.Other.Corner, scrw * 0.445 * Data.Weapon.Position.X,scrh * 0.919 * Data.Weapon.Position.Y,scrw * 215 / 1920,scrh * 34 / 1080,Data.Color.Background)
            draw.RoundedBox(Data.Other.Corner, scrw * 0.454 * Data.Weapon.Position.X,scrh * 0.885 * Data.Weapon.Position.Y,scrw * 180 / 1920,scrh * 34 / 1080,Data.Color.Background)
            draw.SimpleText(zeichenwaffe, "CCHUD-Font", ScrW() * 0.5 * Data.Weapon.Position.X, ScrH() * 0.92 * Data.Weapon.Position.Y,White, TEXT_ALIGN_CENTER)
            draw.SimpleText(Magazine, "CCHUD-Font", ScrW() * 0.487 * Data.Weapon.Position.X, ScrH() * 0.921* Data.Weapon.Position.Y,White, TEXT_ALIGN_CENTER)
            draw.SimpleText("/", "CCHUD-Font1", ScrW() * 0.475 * Data.Weapon.Position.X, ScrH() * 0.924 * Data.Weapon.Position.Y,White, TEXT_ALIGN_CENTER)
            draw.SimpleText(Ammunition, "CCHUD-Font", ScrW()*0.463* Data.Weapon.Position.X, ScrH() * 0.921* Data.Weapon.Position.Y,White, TEXT_ALIGN_CENTER)
            draw.SimpleText(AmmunitionFull, "CCHUD-Font", ScrW()*0.525* Data.Weapon.Position.X, ScrH() * 0.921* Data.Weapon.Position.Y,White, TEXT_ALIGN_CENTER)
            local weitee, hoehee = surface.GetTextSize(Weaponname)
            if weitee < 165 then
                draw.SimpleText(Weaponname, "CCHUD-Font", ScrW()*0.5* Data.Weapon.Position.X, ScrH()*0.885* Data.Weapon.Position.Y,White, TEXT_ALIGN_CENTER)
            else
                if weitee < 220 then
                    draw.SimpleText(Weaponname, "CCHUD-Font1", ScrW()*0.5* Data.Weapon.Position.X, ScrH()*0.888* Data.Weapon.Position.Y,White, TEXT_ALIGN_CENTER)
                else
                    draw.SimpleText(Weaponname, "CCHUD-Font2", ScrW()*0.5* Data.Weapon.Position.X, ScrH()*0.89* Data.Weapon.Position.Y,White, TEXT_ALIGN_CENTER)
                end
            end
        end
    end
    geld = LocalPlayer():getDarkRPVar("money")
    geldformatiert = DarkRP.formatMoney(geld)
    Geldhohe = ScrH() * 0.903
    Geldbreite = ScrW() * 0.01
    if geld < 101 then
        draw.SimpleText(geldformatiert, "CCHUD-Font", ScrW() * Data.Geld.Position.X * 0.4, ScrH() * Data.Geld.Position.Y,Data.Color.Geld, TEXT_ALIGN_LEFT)
    elseif geld < 1000000 then
        draw.SimpleText(geldformatiert, "CCHUD-Font1", ScrW() * Data.Geld.Position.X * 0.38, ScrH() * Data.Geld.Position.Y * 1.003 ,Data.Color.Geld, TEXT_ALIGN_LEFT)
    else
        draw.SimpleText(geldformatiert, "CCHUD-Font2", ScrW() * Data.Geld.Position.X * 0.33, ScrH() * Data.Geld.Position.Y * 1.005,Data.Color.Geld, TEXT_ALIGN_LEFT)
    end
end)

local hide = {
    ["DarkRP_HUD"] = true,
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["DarkRP_EntityDisplay"] = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
    if ( hide[ name ] ) then
        return false
    end
end)

function InGameConfig_Open()
    CCHUD_Panel = vgui.Create("DFrame")
    CCHUD_Panel:SetSize(ScrW() * 0.3, ScrH() * 0.5)
    CCHUD_Panel:Center()
    CCHUD_Panel:SetTitle("CCHUD Config")
    CCHUD_Panel:SetDraggable(true)
    CCHUD_Panel:ShowCloseButton(true)
    CCHUD_Panel:MakePopup()
    CCHUD_Panel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
    end

    CCHUD_DScrollPanel = vgui.Create("DScrollPanel", CCHUD_Panel)
    CCHUD_DScrollPanel:Dock(FILL)

    CCHUD_DScrollPanel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    end

    local sbar = CCHUD_DScrollPanel:GetVBar()
    function sbar:Paint(w, h)
    	draw.RoundedBox(0, 0, 0, w, h, Color(141, 141, 141))
    end
    function sbar.btnUp:Paint(w, h)
    	draw.RoundedBox(0, 0, 0, w, h, White)
    end
    function sbar.btnDown:Paint(w, h)
    	draw.RoundedBox(0, 0, 0, w, h, White)
    end
    function sbar.btnGrip:Paint(w, h)
    	draw.RoundedBox(0, 0, 0, w, h, Color(210, 210, 210))
    end

    CCHUD_Health_Length = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Health_Length:Dock(TOP)
    CCHUD_Health_Length:SetSize( 300, 40 )
    CCHUD_Health_Length:SetText( "" )
    CCHUD_Health_Length:SetMin( 0 )
    CCHUD_Health_Length:SetMax( 2000 )
    CCHUD_Health_Length:SetDecimals( 0 )
    CCHUD_Health_Length:SetValue( Data.Health.Length )
    CCHUD_Health_Length.OnValueChanged = function( panel, value )
        Data.Health.Length = value
    end
    CCHUD_Health_Length.Paint = function(self, w, h)
        draw.SimpleText("Health Length", "CCHUD-Font2", 0, h/3, White, TEXT_ALIGN_LEFT)
    end

    CCHUD_Health_Position_X = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Health_Position_X:Dock(TOP)
    CCHUD_Health_Position_X:SetSize( 300, 40 )
    CCHUD_Health_Position_X:SetText( "" )
    CCHUD_Health_Position_X:SetMin( 0 )
    CCHUD_Health_Position_X:SetMax( 1 )
    CCHUD_Health_Position_X:SetDecimals( 2 )
    CCHUD_Health_Position_X:SetValue( Data.Health.Position.X )
    CCHUD_Health_Position_X.OnValueChanged = function( panel, value )
        Data.Health.Position.X = value
    end
    CCHUD_Health_Position_X.Paint = function(self, w, h)
        draw.SimpleText("Health Position X", "CCHUD-Font2", 0, h/3, White, TEXT_ALIGN_LEFT)
    end

    CCHUD_Health_Position_Y = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Health_Position_Y:Dock(TOP)
    CCHUD_Health_Position_Y:SetSize( 300, 40 )
    CCHUD_Health_Position_Y:SetText( "" )
    CCHUD_Health_Position_Y:SetMin( 0 )
    CCHUD_Health_Position_Y:SetMax( 1 )
    CCHUD_Health_Position_Y:SetDecimals( 2 )
    CCHUD_Health_Position_Y:SetValue( Data.Health.Position.Y )
    CCHUD_Health_Position_Y.OnValueChanged = function( panel, value )
        Data.Health.Position.Y = value
    end
    CCHUD_Health_Position_Y.Paint = function(self, w, h)
        draw.SimpleText("Health Position Y", "CCHUD-Font2", 0, h/3, White, TEXT_ALIGN_LEFT)
    end

    CCHUD_Armor_Length = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Armor_Length:Dock(TOP)
    CCHUD_Armor_Length:SetSize( 300, 40 )
    CCHUD_Armor_Length:SetText( "" )
    CCHUD_Armor_Length:SetMin( 0 )
    CCHUD_Armor_Length:SetMax( 2000 )
    CCHUD_Armor_Length:SetDecimals( 0 )
    CCHUD_Armor_Length:SetValue( Data.Armor.Length )
    CCHUD_Armor_Length.OnValueChanged = function( panel, value )
        Data.Armor.Length = value
    end
    CCHUD_Armor_Length.Paint = function(self, w, h)
        draw.SimpleText("Armor Length", "CCHUD-Font2", 0, h/3, White, TEXT_ALIGN_LEFT)
    end

    CCHUD_Armor_Position_X = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Armor_Position_X:Dock(TOP)
    CCHUD_Armor_Position_X:SetSize( 300, 40 )
    CCHUD_Armor_Position_X:SetText( "" )
    CCHUD_Armor_Position_X:SetMin( 0 )
    CCHUD_Armor_Position_X:SetMax( 1 )
    CCHUD_Armor_Position_X:SetDecimals( 2 )
    CCHUD_Armor_Position_X:SetValue( Data.Armor.Position.X )
    CCHUD_Armor_Position_X.OnValueChanged = function( panel, value )
        Data.Armor.Position.X = value
    end
    CCHUD_Armor_Position_X.Paint = function(self, w, h)
        draw.SimpleText("Armor Position X", "CCHUD-Font2", 0, h/3, White, TEXT_ALIGN_LEFT)
    end

    CCHUD_Armor_Position_Y = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Armor_Position_Y:Dock(TOP)
    CCHUD_Armor_Position_Y:SetSize( 300, 40 )
    CCHUD_Armor_Position_Y:SetText( "" )
    CCHUD_Armor_Position_Y:SetMin( 0 )
    CCHUD_Armor_Position_Y:SetMax( 1 )
    CCHUD_Armor_Position_Y:SetDecimals( 2 )
    CCHUD_Armor_Position_Y:SetValue( Data.Armor.Position.Y )
    CCHUD_Armor_Position_Y.OnValueChanged = function( panel, value )
        Data.Armor.Position.Y = value
    end
    CCHUD_Armor_Position_Y.Paint = function(self, w, h)
        draw.SimpleText("Armor Position Y", "CCHUD-Font2", 0, h/3, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    CCHUD_Geld_Position_X = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Geld_Position_X:Dock(TOP)
    CCHUD_Geld_Position_X:SetSize( 300, 40 )
    CCHUD_Geld_Position_X:SetText( "" )
    CCHUD_Geld_Position_X:SetMin( 0 )
    CCHUD_Geld_Position_X:SetMax( 1 )
    CCHUD_Geld_Position_X:SetDecimals( 2 )
    CCHUD_Geld_Position_X:SetValue( Data.Geld.Position.X )
    CCHUD_Geld_Position_X.OnValueChanged = function( panel, value )
        Data.Geld.Position.X = value
    end
    CCHUD_Geld_Position_X.Paint = function(self, w, h)
        draw.SimpleText("Geld Position X", "CCHUD-Font2", 0, h/3, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    CCHUD_Geld_Position_Y = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Geld_Position_Y:Dock(TOP)
    CCHUD_Geld_Position_Y:SetSize( 300, 40 )
    CCHUD_Geld_Position_Y:SetText( "" )
    CCHUD_Geld_Position_Y:SetMin( 0 )
    CCHUD_Geld_Position_Y:SetMax( 1 )
    CCHUD_Geld_Position_Y:SetDecimals( 2 )
    CCHUD_Geld_Position_Y:SetValue( Data.Geld.Position.Y )
    CCHUD_Geld_Position_Y.OnValueChanged = function( panel, value )
        Data.Geld.Position.Y = value
    end
    CCHUD_Geld_Position_Y.Paint = function(self, w, h)
        draw.SimpleText("Geld Position Y", "CCHUD-Font2", 0, h/3, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    CCHUD_Other_Corner = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Other_Corner:Dock(TOP)
    CCHUD_Other_Corner:SetSize( 300, 40 )
    CCHUD_Other_Corner:SetText( "" )
    CCHUD_Other_Corner:SetMin( 0 )
    CCHUD_Other_Corner:SetMax( 100 )
    CCHUD_Other_Corner:SetDecimals( 0 )
    CCHUD_Other_Corner:SetValue( Data.Other.Corner )
    CCHUD_Other_Corner.OnValueChanged = function( panel, value )
        Data.Other.Corner = value
    end
    CCHUD_Other_Corner.Paint = function(self, w, h)
        draw.SimpleText("Roundness", "CCHUD-Font2", 0, h/3, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    CCHUD_Name_Position_X = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Name_Position_X:Dock(TOP)
    CCHUD_Name_Position_X:SetSize( 300, 40 )
    CCHUD_Name_Position_X:SetText( "" )
    CCHUD_Name_Position_X:SetMin( 0 )
    CCHUD_Name_Position_X:SetMax( 1 )
    CCHUD_Name_Position_X:SetDecimals( 2 )
    CCHUD_Name_Position_X:SetValue( Data.Name.Position.X )
    CCHUD_Name_Position_X.OnValueChanged = function( panel, value )
        Data.Name.Position.X = value
    end
    CCHUD_Name_Position_X.Paint = function(self, w, h)
        draw.SimpleText("Name Position X", "CCHUD-Font2", 0, h/3, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    CCHUD_Name_Position_Y = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Name_Position_Y:Dock(TOP)
    CCHUD_Name_Position_Y:SetSize( 300, 40 )
    CCHUD_Name_Position_Y:SetText( "" )
    CCHUD_Name_Position_Y:SetMin( 0 )
    CCHUD_Name_Position_Y:SetMax( 1 )
    CCHUD_Name_Position_Y:SetDecimals( 2 )
    CCHUD_Name_Position_Y:SetValue( Data.Name.Position.Y )
    CCHUD_Name_Position_Y.OnValueChanged = function( panel, value )
        Data.Name.Position.Y = value
    end
    CCHUD_Name_Position_Y.Paint = function(self, w, h)
        draw.SimpleText("Name Position Y", "CCHUD-Font2", 0, h/3, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    CCHUD_Hintergrund_Position_X = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Hintergrund_Position_X:Dock(TOP)
    CCHUD_Hintergrund_Position_X:SetSize( 300, 40 )
    CCHUD_Hintergrund_Position_X:SetText( "" )
    CCHUD_Hintergrund_Position_X:SetMin( 0 )
    CCHUD_Hintergrund_Position_X:SetMax( 1 )
    CCHUD_Hintergrund_Position_X:SetDecimals( 2 )
    CCHUD_Hintergrund_Position_X:SetValue( Data.Hintergrund.Position.X )
    CCHUD_Hintergrund_Position_X.OnValueChanged = function( panel, value )
        Data.Hintergrund.Position.X = value
    end
    CCHUD_Hintergrund_Position_X.Paint = function(self, w, h)
        draw.SimpleText("Background Position X", "CCHUD-Font2", 0, h/3, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    CCHUD_Hintergrund_Position_Y = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Hintergrund_Position_Y:Dock(TOP)
    CCHUD_Hintergrund_Position_Y:SetSize( 300, 40 )
    CCHUD_Hintergrund_Position_Y:SetText( "" )
    CCHUD_Hintergrund_Position_Y:SetMin( 0 )
    CCHUD_Hintergrund_Position_Y:SetMax( 1 )
    CCHUD_Hintergrund_Position_Y:SetDecimals( 2 )
    CCHUD_Hintergrund_Position_Y:SetValue( Data.Hintergrund.Position.Y )
    CCHUD_Hintergrund_Position_Y.OnValueChanged = function( panel, value )
        Data.Hintergrund.Position.Y = value
    end
    CCHUD_Hintergrund_Position_Y.Paint = function(self, w, h)
        draw.SimpleText("Background Position Y", "CCHUD-Font2", 0, h/3, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    CCHUD_Hintergrund_Size_X = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Hintergrund_Size_X:Dock(TOP)
    CCHUD_Hintergrund_Size_X:SetSize( 300, 40 )
    CCHUD_Hintergrund_Size_X:SetText( "" )
    CCHUD_Hintergrund_Size_X:SetMin( 0 )
    CCHUD_Hintergrund_Size_X:SetMax( 1 )
    CCHUD_Hintergrund_Size_X:SetDecimals( 2 )
    CCHUD_Hintergrund_Size_X:SetValue( Data.Hintergrund.Size.X )
    CCHUD_Hintergrund_Size_X.OnValueChanged = function( panel, value )
        Data.Hintergrund.Size.X = value
    end
    CCHUD_Hintergrund_Size_X.Paint = function(self, w, h)
        draw.SimpleText("Background Size X", "CCHUD-Font2", 0, h/3, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    CCHUD_Hintergrund_Size_Y = CCHUD_DScrollPanel:Add( "DNumSlider" )
    CCHUD_Hintergrund_Size_Y:Dock(TOP)
    CCHUD_Hintergrund_Size_Y:SetSize( 300, 40 )
    CCHUD_Hintergrund_Size_Y:SetText( "" )
    CCHUD_Hintergrund_Size_Y:SetMin( 0 )
    CCHUD_Hintergrund_Size_Y:SetMax( 1 )
    CCHUD_Hintergrund_Size_Y:SetDecimals( 2 )
    CCHUD_Hintergrund_Size_Y:SetValue( Data.Hintergrund.Size.Y )
    CCHUD_Hintergrund_Size_Y.OnValueChanged = function( panel, value )
        Data.Hintergrund.Size.Y = value
    end
    CCHUD_Hintergrund_Size_Y.Paint = function(self, w, h)
        draw.SimpleText("Background Size Y", "CCHUD-Font2", 0, h/3, Color(255, 255, 255), TEXT_ALIGN_LEFT)
    end

    CCHUD_Color_Health_Label = CCHUD_DScrollPanel:Add( "DLabel" )
    CCHUD_Color_Health_Label:Dock(TOP)
    CCHUD_Color_Health_Label:SetSize( 300, 50 )
    CCHUD_Color_Health_Label:SetText( "" )
    CCHUD_Color_Health_Label.Paint = function( self, w, h )
        draw.SimpleText( "Health Color", "CCHUD-Font", w / 2, h / 2, White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end


    CCHUD_Color_Health = CCHUD_DScrollPanel:Add( "DColorMixer" )
    CCHUD_Color_Health:Dock(TOP)
    CCHUD_Color_Health:SetSize( 300, 200 )
    CCHUD_Color_Health:SetPalette( true )
    CCHUD_Color_Health:SetAlphaBar( true )
    CCHUD_Color_Health:SetWangs( true )
    CCHUD_Color_Health:SetColor( Data.Color.Health )
    CCHUD_Color_Health.ValueChanged = function( panel, color )
        Data.Color.Health = color
    end

    CCHUD_Color_Armor_Label = CCHUD_DScrollPanel:Add( "DLabel" )
    CCHUD_Color_Armor_Label:Dock(TOP)
    CCHUD_Color_Armor_Label:SetSize( 300, 50 )
    CCHUD_Color_Armor_Label:SetText("")
    CCHUD_Color_Armor_Label.Paint = function( self, w, h )
        draw.SimpleText( "Armor Color", "CCHUD-Font", w / 2, h / 2, White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    CCHUD_Color_Armor = CCHUD_DScrollPanel:Add( "DColorMixer" )
    CCHUD_Color_Armor:Dock(TOP)
    CCHUD_Color_Armor:SetSize( 300, 200 )
    CCHUD_Color_Armor:SetPalette( true )
    CCHUD_Color_Armor:SetAlphaBar( true )
    CCHUD_Color_Armor:SetWangs( true )
    CCHUD_Color_Armor:SetColor( Data.Color.Armor )
    CCHUD_Color_Armor.ValueChanged = function( panel, color )
        Data.Color.Armor = color
    end

    CCHUD_Color_Geld_Label = CCHUD_DScrollPanel:Add( "DLabel" )
    CCHUD_Color_Geld_Label:Dock(TOP)
    CCHUD_Color_Geld_Label:SetSize( 300, 50 )
    CCHUD_Color_Geld_Label:SetText("")
    CCHUD_Color_Geld_Label.Paint = function( self, w, h )
        draw.SimpleText( "Geld Color", "CCHUD-Font", w / 2, h / 2, White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    CCHUD_Color_Geld = CCHUD_DScrollPanel:Add( "DColorMixer" )
    CCHUD_Color_Geld:Dock(TOP)
    CCHUD_Color_Geld:SetSize( 300, 200 )
    CCHUD_Color_Geld:SetPalette( true )
    CCHUD_Color_Geld:SetAlphaBar( true )
    CCHUD_Color_Geld:SetWangs( true )
    CCHUD_Color_Geld:SetColor( Data.Color.Geld )
    CCHUD_Color_Geld.ValueChanged = function( panel, color )
        Data.Color.Geld = color
    end

    CCHUD_Color_Background2_Label = CCHUD_DScrollPanel:Add( "DLabel" )
    CCHUD_Color_Background2_Label:Dock(TOP)
    CCHUD_Color_Background2_Label:SetSize( 300, 50 )
    CCHUD_Color_Background2_Label:SetText("")
    CCHUD_Color_Background2_Label.Paint = function( self, w, h )
        draw.SimpleText( "Color Background Main", "CCHUD-Font", w / 2, h / 2, White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    CCHUD_Color_Background2 = CCHUD_DScrollPanel:Add( "DColorMixer" )
    CCHUD_Color_Background2:Dock(TOP)
    CCHUD_Color_Background2:SetSize( 300, 200 )
    CCHUD_Color_Background2:SetPalette( true )
    CCHUD_Color_Background2:SetAlphaBar( true )
    CCHUD_Color_Background2:SetWangs( true )
    CCHUD_Color_Background2:SetColor( Data.Color.Background2 )
    CCHUD_Color_Background2.ValueChanged = function( panel, color )
        Data.Color.Background2 = color
    end

    CCHUD_Color_Text_Label = CCHUD_DScrollPanel:Add( "DLabel" )
    CCHUD_Color_Text_Label:Dock(TOP)
    CCHUD_Color_Text_Label:SetSize( 300, 50 )
    CCHUD_Color_Text_Label:SetText("")
    CCHUD_Color_Text_Label.Paint = function( self, w, h )
        draw.SimpleText( "Text Color", "CCHUD-Font", w / 2, h / 2, White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    CCHUD_Color_Text = CCHUD_DScrollPanel:Add( "DColorMixer" )
    CCHUD_Color_Text:Dock(TOP)
    CCHUD_Color_Text:SetSize( 300, 200 )
    CCHUD_Color_Text:SetPalette( true )
    CCHUD_Color_Text:SetAlphaBar( true )
    CCHUD_Color_Text:SetWangs( true )
    CCHUD_Color_Text:SetColor( Data.Color.Text )
    CCHUD_Color_Text.ValueChanged = function( panel, color )
        Data.Color.Text = color
    end

    CCHUD_Color_Background_Label = CCHUD_DScrollPanel:Add( "DLabel" )
    CCHUD_Color_Background_Label:Dock(TOP)
    CCHUD_Color_Background_Label:SetSize( 300, 50 )
    CCHUD_Color_Background_Label:SetText("")
    CCHUD_Color_Background_Label.Paint = function( self, w, h )
        draw.SimpleText( "Background Color", "CCHUD-Font", w / 2, h / 2, White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    CCHUD_Color_Background = CCHUD_DScrollPanel:Add( "DColorMixer" )
    CCHUD_Color_Background:Dock(TOP)
    CCHUD_Color_Background:SetSize( 300, 200 )
    CCHUD_Color_Background:SetPalette( true )
    CCHUD_Color_Background:SetAlphaBar( true )
    CCHUD_Color_Background:SetWangs( true )
    CCHUD_Color_Background:SetColor( Data.Color.Background )
    CCHUD_Color_Background.ValueChanged = function( panel, color )
        Data.Color.Background = color
    end

    CCHUD_Data_Reset = CCHUD_DScrollPanel:Add( "DButton" )
    CCHUD_Data_Reset:Dock(TOP)
    CCHUD_Data_Reset:SetSize( 300, 75 )
    CCHUD_Data_Reset:SetText( "" )
    CCHUD_Data_Reset.DoClick = function()
        Data = {
            ["Health"] = {
                ["Length"] = 100,
                ["Position"] = {
                    ["X"] = 0.01,
                    ["Y"] = 0.95
                }
            },
            ["Armor"] = {
                ["Length"] = 100,
                ["Position"] = {
                    ["X"] = 0.01,
                    ["Y"] = 0.915
                }
            },
            ["Hintergrund"] = {
                ["Size"] = {
                    ["X"] = 0.2,
                    ["Y"] = 0.12
                },
                ["Position"] = {
                    ["X"] = 0,
                    ["Y"] = 0.88
                }
            },
            ["Color"] = {
                ["Health"] = Color(46, 204, 113),
                ["Armor"] = Color(52, 152, 219),
                ["Geld"] = Color(255,255,255),
                ["Text"] = Color(255,255,255),
                ["Background"] = Color(20,20,20,150),
                ["Background2"] = Color(20,20,20,0)
            },
            ["Name"] = {
                ["Position"] = {
                    ["X"] = 0.165,
                    ["Y"] = 0.89
                }
            },
            ["Weapon"] = {
                ["Position"] = {
                    ["X"] = 1,
                    ["Y"] = 1.03
                }
            },
            ["Geld"] = {
                ["Position"] = {
                    ["X"] = 0.03,
                    ["Y"] = 0.888
                }
            },
            ["Other"] = {
                ["Corner"] = 6,
            }
        }
        CCHUD_Health_Length:SetValue( Data.Health.Length )
        CCHUD_Health_Position_X:SetValue( Data.Health.Position.X )
        CCHUD_Health_Position_Y:SetValue( Data.Health.Position.Y )
        CCHUD_Geld_Position_X:SetValue( Data.Geld.Position.X )
        CCHUD_Geld_Position_Y:SetValue( Data.Geld.Position.Y )
        CCHUD_Armor_Length:SetValue( Data.Armor.Length )
        CCHUD_Armor_Position_X:SetValue( Data.Armor.Position.X )
        CCHUD_Armor_Position_Y:SetValue( Data.Armor.Position.Y )
        CCHUD_Name_Position_X:SetValue( Data.Name.Position.X )
        CCHUD_Name_Position_Y:SetValue( Data.Name.Position.Y )
        CCHUD_Hintergrund_Size_X:SetValue( Data.Hintergrund.Size.X )
        CCHUD_Hintergrund_Size_Y:SetValue( Data.Hintergrund.Size.Y )
        CCHUD_Hintergrund_Position_X:SetValue( Data.Hintergrund.Position.X )
        CCHUD_Hintergrund_Position_Y:SetValue( Data.Hintergrund.Position.Y )
        CCHUD_Other_Corner:SetValue( Data.Other.Corner )
        CCHUD_Color_Health:SetColor( Data.Color.Health )
        CCHUD_Color_Armor:SetColor( Data.Color.Armor )
        CCHUD_Color_Text:SetColor( Data.Color.Text )
        CCHUD_Color_Geld:SetColor( Data.Color.Geld )
        CCHUD_Color_Background:SetColor( Data.Color.Background )
        CCHUD_Color_Background2:SetColor( Data.Color.Background2 )
    end
    CCHUD_Data_Reset.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, red )
        draw.SimpleText( "Reset", "CCHUD-Font", w / 2, h / 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    CCHUD_Data_Save = CCHUD_DScrollPanel:Add( "DButton" )
    CCHUD_Data_Save:Dock(TOP)
    CCHUD_Data_Save:SetSize( 300, 75 )
    CCHUD_Data_Save:SetText( "" )
    CCHUD_Data_Save.DoClick = function()
        steamID64 = tostring(LocalPlayer():SteamID64())
        file.Write("HUD_Settings_User_" .. steamID64 .. ".txt", util.TableToJSON(Data))
        CCHUD_Panel:Close()
    end
    CCHUD_Data_Save.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, green )
        draw.SimpleText( "Save", "CCHUD-Font", w / 2, h / 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end
end

hook.Add( "OnPlayerChat", "cchud", function( ply, strText, bTeam, bDead )
    if ( ply != LocalPlayer() ) then return end
    strText = string.lower( strText )
    if ( strText == "/cchud") then
        ServerIP = game.GetIPAddress()
        if (ServerIP == "loopback" or ServerIP == "84.200.229.45:27020") then
            InGameConfig_Open()
        else
            chat.AddText( Red, "Naja, Scripts unerlaubt nutzen ist nicht so nice der Herr." )
        end
        return true
    end
end )