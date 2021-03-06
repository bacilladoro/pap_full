--士兵的耳朵

--MisDescBegin
x217002_g_ScriptId = 217002
x217002_g_MissionIdPre =173
x217002_g_MissionId = 174
x217002_g_MissionKind = 6
x217002_g_MissionLevel = 30
--x217002_g_ScriptIdNext = {ScriptId = 205005 ,LV = 1 }
x217002_g_Name	="哲别" 
x217002_g_DemandItem ={{id=13010067,num=20}}
x217002_g_noDemandKill ={{id=452,num=1}}	

x217002_g_MissionName="士兵的耳朵"
x217002_g_MissionInfo="    作为长生天护佑的战士，每个人都应该记住进攻，进攻，再进攻这句话！鲜血不会让你变得软弱，它的味道和颜色，会激发你生命的潜力。\n \n    "  --任务描述
x217002_g_MissionInfo2="，请不要手软，想想金国每年对我们的灭丁屠杀，他们连三岁的儿童都不放过！\n \n    复仇的时候到了，燃烧吧，我的战士，听从拖雷王子的命令，屠杀乌月营。\n \n    记住，一定不能放过任何一个有生命的东西，即使是一只老鼠，一只苍蝇你也要把它给射下来！\n \n    只有猩红的鲜血才能浇灭仇恨，我们要让这里变成死城，屠杀乌月营剑士，割下剑士的左耳，证明你的价值。"
x217002_g_MissionTarget="    到#G中隅#W去战斗，取得20只#c0080C0剑士的耳朵#W给#G哲别#W带回来做证明。"		
x217002_g_MissionComplete="    做的好，我们的草原战士个个都是以一敌十。"					--完成任务npc说话的话
x217002_g_ContinueInfo="    吩咐你的任务你做了吗？"
--任务奖励
x217002_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x217002_g_ItemBonus={}

--可选物品奖励，最多8种
x217002_g_RadioItemBonus={}

--MisDescEnd
x217002_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x217002_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x217002_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x217002_g_MissionId) > 0 then
		if x217002_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x217002_g_MissionName)
			AddText(sceneId,x217002_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x217002_g_MissionTarget) 
			AddText(sceneId,format("\n    剑士的耳朵   %d/%d", LuaFnGetItemCount(sceneId,selfId,x217002_g_DemandItem[1].id),x217002_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x217002_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x217002_g_MissionName)
		     AddText(sceneId,x217002_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x217002_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x217002_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x217002_g_ScriptId, x217002_g_MissionId)
                end

        elseif x217002_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x217002_g_MissionName)
                AddText(sceneId,x217002_g_MissionInfo..GetName(sceneId, selfId)..x217002_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x217002_g_MissionTarget) 
		AddMoneyBonus(sceneId, x217002_g_MoneyBonus)
		EndEvent()
		DispatchMissionInfo(sceneId, selfId, targetId, x217002_g_ScriptId, x217002_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x217002_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x217002_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x217002_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x217002_g_ScriptId, x217002_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x217002_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x217002_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x217002_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==20) then
        	if IsMissionHaveDone(sceneId, selfId, x217002_g_MissionIdPre) > 0 then
        	         return 1
        	end
		
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x217002_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x217002_g_MissionId, x217002_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x217002_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x217002_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x217002_g_MissionId)
	for i, item in pairs(x217002_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x217002_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x217002_g_DemandItem[1].id) == x217002_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x217002_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x217002_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x217002_g_MissionId)
		AddExp(sceneId, selfId, x217002_g_ExpBonus)
		AddMoney(sceneId, selfId, x217002_g_MoneyBonus)
		for i, item in pairs(x217002_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x217002_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x217002_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end

	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x217002_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x217002_g_MissionId) >= 0 then                                       
       		 if objdataId == x217002_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x217002_g_DemandItem[1].id) < x217002_g_DemandItem[1].num then
       		         if random(1,100)>20 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x217002_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("剑士的耳朵   %d/%d", LuaFnGetItemCount(sceneId,selfId,x217002_g_DemandItem[1].id)+1,x217002_g_DemandItem[1].num )) 
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

function x217002_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x217002_OnItemChanged(sceneId, selfId, itemdataId)

end

