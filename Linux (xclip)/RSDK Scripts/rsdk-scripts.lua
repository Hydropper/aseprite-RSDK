function copySpriteFrame()
  local sprite = app.activeSprite
  
  if sprite == nil then
    app.alert("No active sprite")
    return
  end
  
  -- Get the selection bounds
  local selectionBounds = sprite.selection.bounds
  
  if selectionBounds == nil or selectionBounds.isEmpty then
    app.alert("No selection")
    return
  end
  
  -- Get width, height, x position, y position
  local width = selectionBounds.width
  local height = selectionBounds.height
  local xpos = selectionBounds.x
  local ypos = selectionBounds.y
  
  -- Calculate the center of the selection and round down
  local centerX = math.floor(width / 2)
  local centerY = math.floor(height / 2)
  
  -- Format as (-centerX, -centerY, width, height, xpos, ypos)
  local formattedText = string.format("SpriteFrame(-%d, -%d, %d, %d, %d, %d)", centerX, centerY, width, height, xpos, ypos)
  
  -- Copy to clipboard
  -- Windows
  -- local command = 'echo ' .. formattedText .. ' | clip'
  
  -- MacOS
  -- local command = 'echo "' .. formattedText .. '" | pbcopy'
  
  -- Linux (xclip only)
  local command = 'echo "' .. formattedText .. '" | xclip -selection clipboard'
  
  os.execute(command)
  
  -- app.alert("SpriteFrame copied to clipboard: " .. formattedText) // If you want an alert for some reason
end

function init(plugin)
    local parentGroup = "edit_clipboard"

    if app.apiVersion >= 22 then

        plugin:newMenuGroup{
            id = parentGroup,
            title = "RSDK",
            group = "edit_clipboard"
        }
    end

    plugin:newCommand{
        id = "SpriteFrame",
        title = "Copy SpriteFrame",
        group = parentGroup,
        onclick = function()
           copySpriteFrame()
        end
    }
end

function exit(plugin)
  print("Aseprite is closing my plugin, MyFirstCommand was called "
        .. plugin.preferences.count .. " times")
end