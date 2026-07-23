local TextBoxStateController = {};
StateController = require("StateController");
TextBoxStates = require("TextBoxStates");

TextBoxStateController.new = function(ControlNode, TextNode)
  -- make TextNode findable, dont pass it in -- eventually D:
  if not ControlNode or ControlNode:get_class() ~= "Control" then
    error("TextBox .new() needs a Control Node passed as its first parameter");
  elseif not TextNode or TextNode:get_class() ~= "RichTextLabel" then
    error("TextBox .new() needs a RichTextLabel Node passed as its second parameter");
  elseif not ControlNode.total_dialogue then
		error("Set the total_dialogue property of the Control Node; It needs to be a lua table.")
	end;

  ControlNode.SoundController = AudioStreamPlayer3D:new();
  ControlNode:add_child(ControlNode.SoundController);
  ControlNode.TextNode = TextNode;
  ControlNode.TextNode:add_theme_font_size_override("normal_font_size", 90); -- check window size to try set this dynamically
	ControlNode.TextNode.bbcode_enabled = true;
	ControlNode.TextNode.scroll_active = false;
  StateController.new(ControlNode, TextBoxStates.Active);
end;

return TextBoxStateController;
