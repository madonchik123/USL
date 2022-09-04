getgenv().showuniversal = false

local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()
local GUI = Mercury:Create{
    Name = "Scriptblox/Rbxscripts Powered Script Searcher",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}

if game.CoreGui:FindFirstChild("info") then
    game.CoreGui["info"]:Destroy()
end

if isfolder("UniversalSearcher") then
    delfolder("UniversalSearcher")
end

makefolder("UniversalSearcher")

local info = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local img = Instance.new("ImageLabel")
local desc = Instance.new("TextLabel")
local download = Instance.new("TextLabel")
local title = Instance.new("TextLabel")
local close = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

--Properties:

info.Name = "info"
info.Parent = game.CoreGui
info.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
info.ResetOnSpawn = false

main.Name = "main"
main.Parent = info
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BackgroundTransparency = 0.400
main.Size = UDim2.new(1.11738741, 0, 1, 0)

img.Name = "img"
img.Parent = main
img.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
img.BorderSizePixel = 0
img.Position = UDim2.new(0.258523524, 0, 0.21042484, 0)
img.Size = UDim2.new(0.370301604, 0, 0.447574109, 0)
img.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

desc.Name = "desc"
desc.Parent = main
desc.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
desc.BorderSizePixel = 0
desc.Position = UDim2.new(0.258523524, 0, 0.6579988, 0)
desc.Size = UDim2.new(0.370301634, 0, 0.165781249, 0)
desc.Font = Enum.Font.Ubuntu
desc.Text = "1"
desc.TextColor3 = Color3.fromRGB(255, 255, 255)
desc.TextScaled = true
desc.TextWrapped = true
desc.TextXAlignment = Enum.TextXAlignment.Left
desc.TextYAlignment = Enum.TextYAlignment.Top

download.Name = "download"
download.Parent = main
download.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
download.BackgroundTransparency = 0.500
download.Position = UDim2.new(0.505391181, 0, 0.631144404, 0)
download.Size = UDim2.new(0.123433866, 0, 0.0255756583, 0)
download.Font = Enum.Font.Roboto
download.TextColor3 = Color3.fromRGB(0, 0, 0)
download.TextScaled = true
download.TextSize = 22.000
download.TextWrapped = true

title.Name = "title"
title.Parent = main
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 0.500
title.Position = UDim2.new(0.257906318, 0, 0.631144404, 0)
title.Size = UDim2.new(0.247484878, 0, 0.0255756583, 0)
title.Font = Enum.Font.Roboto
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextScaled = true
title.TextSize = 22.000
title.TextWrapped = true

close.Name = "close"
close.Parent = main
close.BackgroundColor3 = Color3.fromRGB(255, 127, 127)
close.Position = UDim2.new(0.61667639, 0, 0.194762692, 0)
close.Size = UDim2.new(0, 27, 0, 27)
close.Font = Enum.Font.SourceSans
close.Text = "X"
close.TextColor3 = Color3.fromRGB(0, 0, 0)
close.TextScaled = true
close.TextSize = 14.000
close.TextWrapped = true

UICorner.CornerRadius = UDim.new(0, 128)
UICorner.Parent = close

info.Enabled = false
close.MouseButton1Click:Connect(function()
    info.Enabled = false
end)

local HttpService = game:GetService("HttpService")


local Abbreviations = {"k", "M", "B", "T", "Qa", "Qn", "Sx", "Sp", "Oc", "N"}

local function formatNumber(Number, Decimals)
	return math.floor(((Number < 1 and Number) or math.floor(Number) / 10 ^ (math.log10(Number) - math.log10(Number) % 3)) * 10 ^ (Decimals or 3)) / 10 ^ (Decimals or 3)..(Abbreviations[math.floor(math.log10(Number) / 3)] or "")
end

local getfakeasset = getcustomasset or getsynasset

local function save_image(url)
    local path = "UniversalSearcher/"
    local img = game:HttpGetAsync("https://process.filestackapi.com/AhTgLagciQByzXpFGRI0Az/output=format:png/"..url)
    local uuid = HttpService:GenerateGUID(false):gsub("-", ""):lower()
    writefile(path .. uuid .. ".png", img)
    return getfakeasset(path .. uuid .. ".png")
end


local Tab = GUI:Tab{
	Name = "Scriptblox",
	Icon = "rbxassetid://8569322835"
}
local Tab2 = GUI:Tab{
	Name = "Rbxscripts",
	Icon = "rbxassetid://8569322835"
}

Tab:Textbox{
	Name = "Search Bar Scriptblox",
	Callback = function(Value)
    spawn(function()
        for z,x in pairs(game:GetService("CoreGui").ScreenGui:GetChildren()) do
        for i,v in pairs(x:GetDescendants()) do
            pcall(function()
            if v:IsA("TextButton") and v.TextLabel.Text ~= "Show Universal Scripts" and v.Parent.Name == "ScrollingFrame" and not v:FindFirstChild("TextBox") then
                for c,b in pairs(v.Parent:GetChildren()) do
                    if b:IsA("TextButton") and b:FindFirstChild("TextBox") and b.TextLabel.Text == "Search Bar Scriptblox" then
                    v:Destroy()
                    end
                end
            end 
            end)
        end
        end
        end)

        local name = game:GetService('HttpService'):UrlEncode(Value)
            for _, v in pairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://www.scriptblox.com/api/script/search?q=" ..name))) do
               for z,c in pairs(v['scripts']) do
                    if getgenv().showuniversal == false then
                    if c['game']['name'] ~= "Universal Script 📌" then
                    local MyDropdown = Tab:Dropdown{
                    	Name = c['game']['name'].." ["..c['title'] .. '] \nViews: ' .. formatNumber(c['views']),
                    	StartingText = "Select...",
                    	Description = nil,
                    	Items = {"Execute","Preview Script"},
                    	Callback = function(value) 
                            if value == "Preview Script" then
                                    if not info.Enabled then
                                        if string.find(c['game']['imageUrl'],"/images") then
                                        img.Image = save_image("https://scriptblox.com"..c['game']['imageUrl'])
                                        else
                                        img.Image = save_image(c['game']['imageUrl'])    
                                        end
                                        desc.Text = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://www.scriptblox.com/api/script/"..c['slug']))['script']['features']
                                        download.Text = formatNumber(c['views']) .. " Views and "..game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://www.scriptblox.com/api/script/"..c['slug']))['script']['likeCount'].." Likes"
                                        if game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://www.scriptblox.com/api/script/"..c['slug']))['script']['verified'] == true then
                                        title.Text = c['title'].." Is Verified and Made By "..game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://www.scriptblox.com/api/script/"..c['slug']))['script']['owner']['username']    
                                        else
                                        title.Text = c['title'].." Made By "..game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://www.scriptblox.com/api/script/"..c['slug']))['script']['owner']['username']    
                                        end
                                        info.Enabled = true
                                    end
                            elseif value == "Execute" then
                                if c['isPatched'] then
                                    GUI:Prompt{
                                    	Followup = false,
                                    	Title = "Warning!",
                                    	Text = "This script is patched would you like to use it?",
                                        	Buttons = {
                                        		yes = function()
                                        			loadstring(c['script'])()
                                        		end;
                                        		no = function()
                                        			print("Declined")
                                        		end;
                                        	}
                                        }
                                    else
                                   loadstring(c['script'])()
                                    end    
                                end      
                    	end
                    }
                    end
                    else
                    local MyDropdown = Tab:Dropdown{
                    	Name = c['game']['name'].." ["..c['title'] .. '] \nViews: ' .. formatNumber(c['views']),
                    	StartingText = "Select...",
                    	Description = nil,
                    	Items = {"Execute","Preview Script"},
                    	Callback = function(value) 
                            if value == "Preview Script" then
                                    if not info.Enabled then
                                        local newapi = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://www.scriptblox.com/api/script/"..c['slug']))
                                        if string.find(c['game']['imageUrl'],"/images") then
                                        img.Image = save_image("https://scriptblox.com"..c['game']['imageUrl'])
                                        else
                                        img.Image = save_image(c['game']['imageUrl'])    
                                        end
                                        desc.Text = newapi['script']['features']  
                                        download.Text = formatNumber(c['views']) .. " Views and "..game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://www.scriptblox.com/api/script/"..c['slug']))['script']['likeCount'].." Likes"
                                        if newapi['script']['verified'] == true then
                                        title.Text =  c['title'].." Is Verified and Made By "..newapi['script']['owner']['username']    
                                        else
                                        title.Text = c['title'].." Made By "..newapi['script']['owner']['username']    
                                        end
                                        info.Enabled = true
                                    end
                            elseif value == "Execute" then
                                if c['isPatched'] then
                                    GUI:Prompt{
                                    	Followup = false,
                                    	Title = "Warning!",
                                    	Text = "This script is patched would you like to use it?",
                                    	Buttons = {
                                    		yes = function()
                                    			loadstring(c['script'])()
                                    		end;
                                    		no = function()
                                    			print("Declined")
                                    		end;
                                    	}
                                    }
                                    else
                                   loadstring(c['script'])()
                                end    
                                end      
                    	end
                    }
                    end
               end
            end  	    
	end
}
Tab:Toggle{
	Name = "Show Universal Scripts",
	StartingState = false,
	Description = nil,
	Callback = function(state)
	    getgenv().showuniversal = state
	 end
}
Tab2:Textbox{
	Name = "Search Bar Rbxscripts",
	Callback = function(Value)
	    spawn(function()
                for z,x in pairs(game:GetService("CoreGui").ScreenGui:GetChildren()) do
                    for i,v in pairs(x:GetDescendants()) do
                        pcall(function()
                        if v:IsA("TextButton") and v.TextLabel.Text ~= "Show Universal Scripts" and v.Parent.Name == "ScrollingFrame" and not v:FindFirstChild("TextBox") then
                            for c,b in pairs(v.Parent:GetChildren()) do
                                if b:IsA("TextButton") and b:FindFirstChild("TextBox") and b:FindFirstChild("TextButton") and not b.TextButton.Text == "Show Universal Scripts" then
                                v:Destroy()
                                end
                            end
                        end 
                    end)
                end
            end
	    end)
        local v = Value
        pcall(function()
        local scripts_data = HttpService:JSONDecode(game:HttpGet("https://WheatHub.kelprepl.repl.co/search?game_name="..string.gsub(v," ", "%%20")))
        for i1, v1 in pairs(scripts_data) do
            if string.match(v1.title:lower(), "^"..v:lower()) then
                -- Tab:AddButton({
                --     Name = v1.title .. ' | ' .. formatNumber(v1.download_script) .. " used",
                --     Callback = function()
                --         local script = game:HttpGet("https://WheatHub.kelprepl.repl.co/get_script?url="..v1.url)
                --         loadstring(script)()
                --     end    
                -- }) 
                local MyDropdown = Tab2:Dropdown{
                	Name = " "..v1.title .. '\nViews: ' .. formatNumber(v1.download_script),
                	StartingText = "Select...",
                	Description = nil,
                	Items = {"Execute", "Preview Script"},
                	Callback = function(value) 
                	   if value == "Preview Script" then
                            if not info.Enabled then
                                img.Image = save_image(v1.image_url)
                                desc.Text = v1.description
                                download.Text = formatNumber(v1.download_script) .. " download"
                                title.Text = v1.title
                                info.Enabled = true
                            end
                        elseif value == "Execute" then
                            local script = game:HttpGet("https://WheatHub.kelprepl.repl.co/get_script?url="..v1.url)
                            loadstring(script)()
                        end  
                	end
                }
            end
            task.wait(0.1)
        end
    end)
end}
