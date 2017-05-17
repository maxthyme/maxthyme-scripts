--Alter the date which the updating region process finishes at.
local gui = require 'gui'
local widgets = require 'gui.widgets'
local vw = df.global.gview.view.child

updater=defclass(updater,gui.Screen)
updater.focus_path = 'updatefinish'
function updater:init()
    self:addviews{
        widgets.Label{
            view_id="mainLabel",
            frame = {xalign=0,yalign=0},
            text='Left/Right to Select Day(-/+), Up/Down to Change Month(-/+), Enter/Esc to Resume'
			  }
			}
end

function updater:onInput(keys)
	if df.viewscreen_update_regionst:is_instance(vw) then
		if keys.LEAVESCREEN or keys.SELECT then
		       	self:dismiss()
		end
		if keys.CURSOR_RIGHT then
			vw.year_tick = vw.year_tick+1200
		elseif keys.CURSOR_LEFT then
			vw.year_tick = vw.year_tick-1200
		elseif keys.CURSOR_UP then
			vw.year_tick = vw.year_tick-33600
		elseif keys.CURSOR_DOWN then
			vw.year_tick = vw.year_tick+33600
		end
	elseif not df.viewscreen_update_regionst:is_instance(vw) then
		if keys then
			self:dismiss()
			qerror("This has to be used on the updating region screen!")		
		end
	end
	self.super.onInput(self,keys)
end

function updater:onRenderBody(dc)
	self._native.parent:render()
end

updater():show()
