local Text = {
	extends = RichTextLabel,
	textDone = false;
	iterationDone = false;
	iterator = 1;
}

local function render()
    local done = STR:sub(1, revealed)
    local rest = STR:sub(revealed + 1)
    RICH_TEXT_LABEL.text = "[color=" .. reveal_color .. "]" .. done .. "[/color]"
                          .. "[color=" .. BASE_COLOUR .. "]" .. rest .. "[/color]"
end
-- now that you have working text display code
-- DO NOT USE THIS AS IT IS
-- convert to state machine
function Text:_ready()
	self:add_theme_font_size_override("normal_font_size", 90)
	self.scroll_active = false
STR = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In in cursus urna, non consectetur justo. Pellentesque tristique'
BASE_COLOUR = "black"
reveal_color = "white"
revealed = 0
timer = 0
interval = 0.002 -- seconds per character
RICH_TEXT_LABEL = self
render() -- initial display, all BASE_COLOUR
end


function Text:_process(delta)
    if revealed >= #STR then return end
    timer = timer + delta
    if timer >= interval then
        timer = timer - interval
        revealed = revealed + 1
        render()
    end
end

return Text;
