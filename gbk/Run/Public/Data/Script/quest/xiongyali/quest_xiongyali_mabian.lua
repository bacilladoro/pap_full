--马鞭

--MisDescBegin
x213010_g_ScriptId = 213010
--x213010_g_MissionIdPre =148
x213010_g_MissionId = 155
x213010_g_MissionKind = 24
x213010_g_MissionLevel = 125
--x213010_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x213010_g_Name	="速不台" 
x213010_g_DemandItem ={{id=13010046,num=10}}
x213010_g_noDemandKill ={{id=396,num=1}}	

x213010_g_MissionName="马鞭"
x213010_g_MissionInfo="    追随瓦如丁来的是一些#R马扎尔骑兵#W，听说他们的马鞭不错。在杀了他们之后帮我留意一下他们的马鞭，给我拿来10条让我挑一挑。"  --任务描述
x213010_g_MissionTarget="    杀死#R马扎尔骑兵#W，带回10条#c0080C0马扎尔马鞭#W给#G速不台#W。"		
x213010_g_MissionComplete="    真是见面不如闻名，这些也能称作马鞭吗？怎么会说马扎尔人的马鞭比较好。"					--完成任务npc说话的话
x213010_g_ContinueInfo="    那些马扎尔骑兵就在西边。"
--任务奖励
x213010_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x213010_g_ItemBonus={}

--可选物品奖励，最多8种
x213010_g_RadioItemBonus={}

--MisDescEnd
x213010_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x213010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x213010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x213010_g_MissionId) > 0 then
		if x213010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x213010_g_MissionName)
			AddText(sceneId,x213010_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x213010_g_MissionTarget) 
			AddText(sceneId,format("\n    马扎尔马鞭   %d/%d", LuaFnGetItemCount(sceneId,selfId,x213010_g_DemandItem[1].id),x213010_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x213010_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x213010_g_MissionName)
		     AddText(sceneId,x213010_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x213010_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x213010_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x213010_g_ScriptId, x213010_g_MissionId)
                end

        elseif x213010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x213010_g_MissionName)
                AddText(sceneId,x213010_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x213010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x213010_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x213010_g_ScriptId, x213010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x213010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x213010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x213010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x213010_g_ScriptId, x213010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x213010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x213010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x213010_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==13) then
        	         return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x213010_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x213010_g_MissionId, x213010_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x213010_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x213010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x213010_g_MissionId)
	for i, item in pairs(x213010_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x213010_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x213010_g_DemandItem[1].id) == x213010_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x213010_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x213010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x213010_g_MissionId)
		AddExp(sceneId, selfId, x213010_g_ExpBonus)
		AddMoney(sceneId, selfId, x213010_g_MoneyBonus)
		for i, item in pairs(x213010_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x213010_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x213010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x213010_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x213010_g_MissionId) >= 0 then                                       
       		 if objdataId == x213010_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x213010_g_DemandItem[1].id) < x213010_g_DemandItem[1].num then
       		         if random(1,100)>30 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x213010_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("马扎尔马鞭   %d/%d", LuaFnGetItemCount(sceneId,selfId,x213010_g_DemandItem[1].id)+1,x213010_g_DemandItem[1].num )) 
				 	EndEvent()
				 	DispatchMissionTips(sceneId, selfId)
				 	AddItemListToHuman(sceneId,selfId) 
		        	 else                                                             
		        	 	BeginEvent(sceneId)                                      
				     	AddText(sceneId,"物品栏已满！")                    
				        EndEvent(sceneId)                                        
				        DispatchMissionTips(sceneId,selfId) 
				 end                     
		         end             
       		    end
       		 end
       		 
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x213010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x213010_OnItemChanged(sceneId, selfId, itemdataId)

end

