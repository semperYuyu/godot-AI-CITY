local textbox = {
	extends = Control;
}

function textbox:_ready()
	local TextBoxStateController = require("TextBoxStateController");
	local TextNode = self:get_node("TextContent/Text")
	TextBoxStateController.new(self, TextNode)
end;

function textbox:_input(event)
	self:input(event)
end;

function textbox:_process(dt)
	self:process(dt)
end;

function textbox:_physics_process(dt)
	self:process(dt)
end;



return textbox
