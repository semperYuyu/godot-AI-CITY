local Interactables = {
  extends = Node
};
-- if any parameters need to be passed into any of these functions, and youre using it as a function for an interactable
-- make sure to wrap the function in an anonymous one inside of the file importing the function
-- i.e.
--[[
  InteractableStateController.new(Node, type, function() Interactables.spawnTextBox("words omg omg") end)
]]

Interactables.spawnTextBox = function(firstDialogue, secondDialogue)
  local Scene_TextBox = ResourceLoader:load("uid://c2ssllmammc33")
  local Array_TextBoxes = GlobalVariables:get_node("/root/Environment/TextBoxes")
  local TextBox = Scene_TextBox:instantiate()
  TextBox.total_dialogue = firstDialogue;
  TextBox.alternate_dialogue = secondDialogue;

  if GlobalVariables.global_interact and GlobalVariables:get_node("InteractTimer").time_left <= 0 then
			Array_TextBoxes:add_child(TextBox)
		end;

end;

return Interactables;
