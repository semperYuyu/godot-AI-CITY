local TextBoxStateController = {};
StateController = require("StateController");
TextBoxStates = require("TextBoxStates")
StateController.add(TextBoxStateController);

-- StateController.newTextBox = function (ControlNode, TextNode)
-- 	if not ControlNode then
-- 		error("..newTextBox() function needs a Control node passed as first parameter\nSyntax is \"..newTextBox(--> ControlNode <--, TextNode)\"")
-- 	elseif not TextNode then
-- 		error("..newTextBox() function needs a RichTextLabel passed as second parameter\nSyntax is \"..newTextBox(ControlNode, --> TextNode <--)\"")
-- 	end;
-- 	-- update to iterate and dynamically find a richtextlabel node

-- 	ControlNode.TextNode = TextNode;
-- 	ControlNode.TextNode:add_theme_font_size_override("normal_font_size", 90) -- check window size to try set this dynamically
-- 	ControlNode.bbcode_enabled = true;
-- 	ControlNode.TextNode.scroll_active = false;
-- 	ControlNode:switchState(defaultState);
-- end;

TextBoxStateController.new = function(ControlNode, TextNode)
  -- make TextNode findable, dont pass it in

  Node.currentState = StateController.currentState;
	Node.switchState = StateController.switchState;
	Node.process = StateController.process;
	Node.physics_process = StateController.physics_process;
	Node.input = StateController.input;
end;

return TextBoxStateController;
