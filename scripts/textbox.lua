local textbox = {
	extends = Control;
}

function textbox:_ready()
	if not self.total_dialogue then
		self.total_dialogue = {
			"This is default dialogue";
			"This is here becaus you forgor to set self.total_dialogue";
			"to fix, set self.total_dialogue = {\'text\'; \'text\' ; \'text\'} in _ready()";
			"you could also set total_dialogue directly inside of the node object at the top"
		}
	end;
	local StateController = require("StateController")
	local TextBoxStates = require("TextBoxStates")
	local TextNode = self:get_node("TextContent/Text")
	StateController.newTextBox(self, TextNode, TextBoxStates.Active)
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
