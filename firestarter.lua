local tinder
    if dfhack.gui.getCurFocus() == 'item' then
        tinder=dfhack.gui.getCurViewscreen().item
	tinder.flags.on_fire=true
    elseif dfhack.gui.getSelectedUnit(true) then
        tinder=dfhack.gui.getSelectedUnit(true).inventory
		for k,v in ipairs(tinder) do
			tinder[k].item.flags.on_fire=true
		end 
end
