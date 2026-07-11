local textbox = {
	extends = Control,
}

function textbox:_ready()
	local StateController = require("StateController")
	local TextBoxStates = require("TextBoxStates")
	StateController.newTextBox(self, TextBoxStates.Active)
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
