local TextBoxStateController = {};
StateController = require("StateController");
TextBoxStates = require("TextBoxStates");
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
  -- make TextNode findable, dont pass it in -- eventually D:
  if not ControlNode or ControlNode:get_class() ~= "Control" then
    error("TextBox .new() needs a Control Node passed as its first parameter");
  elseif not TextNode or TextNode:get_class() ~= "RichTextLabel" then
    error("TextBox .new() needs a RichTextLabel Node passed as its second parameter");
  elseif not ControlNode.total_dialogue then
		error("Set the total_dialogue property of the Control Node; It needs to be a lua table.")
	end;


  ControlNode.TextNode = TextNode;
  ControlNode.TextNode:add_theme_font_size_override("normal_font_size", 90); -- check window size to try set this dynamically
	ControlNode.bbcode_enabled = true;
	ControlNode.TextNode.scroll_active = false;
  ControlNode.currentState = StateController.currentState;
	ControlNode.switchState = StateController.switchState;
	ControlNode.process = StateController.process;
	ControlNode.physics_process = StateController.physics_process;
	ControlNode.input = StateController.input;

  ControlNode:switchState(TextBoxStates.Active);
end;

return TextBoxStateController;
