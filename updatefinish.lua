--Alter the date which the updating region process finishes at.
local gui = require 'gui'
local widgets = require 'gui.widgets'
local vw = df.global.gview.view.child
local yr
local mn
local dy


updater=defclass(updater,gui.Screen)
updater.focus_path = 'updatefinish'
function updater:init()
    self:addviews{
        widgets.Label{
            view_id="mainLabel",
            frame = {xalign=0,yalign=0},
            text={
		{id="cmd", text="Left/Right: Day(-/+), Up/Down: Month(-/+), Enter/Esc: Resume, Date: "},
		{id="yr", text=self:callback("getYear")},{text="/"}, {id="mn", text=self:callback("getMonth")},{text="/"}, {id="dy", text=self:callback("getDay")}}
			  }
			}
end

function updater:getYear()
	yr = vw.year
	return yr
end

function updater:getMonth()
		if vw.year_tick>=33600 then
			mn = math.floor(vw.year_tick/33600)+1
		else
			mn = 1
		end
	return mn
end

function updater:getDay()
	local dy
	local mf = (mn-1)*33600
	local yf = math.floor(vw.year_tick/1200)
		if vw.year_tick>=1200 then
			dy = math.floor(yf-(mf/1200))+1
		else
			dy = 1
		end
	return dy
end

function updater:onInput(keys)
	if df.viewscreen_update_regionst:is_instance(vw) then
		if keys.LEAVESCREEN or keys.SELECT then
		       	self:dismiss()
		end
		if keys.CURSOR_RIGHT then
			if vw.year_tick>=402000 then
				vw.year = vw.year+1
				vw.year_tick = 0
			else
				vw.year_tick = vw.year_tick+1200
			end
		elseif keys.CURSOR_LEFT then
			if vw.year_tick<=1200 then
				vw.year = vw.year-1
				vw.year_tick = 402000
			else
				vw.year_tick = vw.year_tick-1200
			end
		elseif keys.CURSOR_UP then
			if vw.year_tick<=33600 then
				vw.year = vw.year-1
				vw.year_tick = 369600
			else
				vw.year_tick = vw.year_tick-33600
			end
		elseif keys.CURSOR_DOWN then
			if vw.year_tick>=369600 then
				vw.year = vw.year+1
				vw.year_tick = 0
			else
				vw.year_tick = vw.year_tick+33600
			end
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
