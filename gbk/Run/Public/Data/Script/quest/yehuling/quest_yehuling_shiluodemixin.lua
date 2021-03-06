--失落的密信

--MisDescBegin
x207005_g_ScriptId = 207005
x207005_g_MissionIdPre =5
x207005_g_MissionId = 6
x207005_g_MissionKind = 1
x207005_g_ScriptIdNext = {ScriptId = 207006 ,LV = 1 }
x207005_g_Name	="赤老温" 
x207005_g_Name2	="算命先生" 
x207005_g_DemandItem ={}
x207005_g_DemandKill ={id=276,num=10}

x207005_g_MissionName="失落的密信"
x207005_g_MissionInfo=",真想不到你能拿到金国官府的密信，恩，我看看。原来是这样，这封信应该是给金国的皇帝写的。嘿嘿，既然玉佩跟#R神秘人#W有关，你不如先去会会#G算命先生#W！\n \n嘿，还有一件，一件很小，很小的事情，需要跟你商量，当然，你可以拒绝，不过像你这样拉风的勇士，是不会拒绝这样一个小要求的，也不会到处乱说的，对吧！\n \n恩，是这样的，有些胆小懦弱的人害怕打仗，在偷偷的潜逃，如果让他们成功逃跑，会很大的影响我们的军心，咳，实话跟你说，最重要的是，我很没面子，那些是我的手下。可是我又没有足够的证据去抓他们，你正好路过，替我把他们给杀了！"  --任务描述
x207005_g_MissionTarget="    杀掉10个#R蒙古逃兵#W之后去寻找#G算命先生#W。"		                                                                                               
x207005_g_MissionComplete="    什么#R神秘人#W啊，面具啊，我不知道你说什么，我只是为了逃避战争而来到这里落脚，没想到到哪都是战乱……"					--完成任务npc说话的话
x207005_g_ContinueInfo="    附近一些蒙古兵鬼鬼祟祟，实在很奇怪，你路过那的时候没发现吗？"
--任务奖励
x207005_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207005_g_ItemBonus={}

--可选物品奖励，最多8种
x207005_g_RadioItemBonus={}

--MisDescEnd
--**********************************

--任务入口函数

--**********************************

function x207005_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207005_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207005_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x207005_g_MissionId)
		if x207005_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207005_g_MissionName)
			AddText(sceneId,x207005_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207005_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死蒙古逃兵   %d/10", GetMissionParam(sceneId,selfId,misIndex,0) ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x207005_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x207005_g_MissionName)
		     AddText(sceneId,x207005_g_MissionComplete)
		     AddText(sceneId,"#Y任务目标#W") 
		     AddText(sceneId,x207005_g_MissionTarget) 
		     AddText(sceneId,format("\n    杀死蒙古逃兵   %d/10", GetMissionParam(sceneId,selfId,misIndex,0) ))
                     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207005_g_ScriptId, x207005_g_MissionId)
                end

        elseif x207005_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207005_g_MissionName)
                AddText(sceneId,x207005_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207005_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207005_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207005_g_ScriptId, x207005_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207005_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207005_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207005_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207005_g_ScriptId, x207005_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207005_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207005_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207005_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207005_g_Name) then
                if IsMissionHaveDone(sceneId, selfId, x207005_g_MissionIdPre) > 0 then
                    if IsHaveMission(sceneId,selfId, x207005_g_MissionId)<= 0 then
                    return 1
                    end
                end
        end
	if (GetName(sceneId,targetId)==x207005_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207005_g_MissionId) > 0 then
		    return 1
                    end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207005_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x207005_g_MissionId, x207005_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x207005_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x207005_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207005_g_MissionId)
	for i, item in pairs(x207005_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207005_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207005_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == 10 then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207005_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207005_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207005_g_MissionId)
		AddExp(sceneId, selfId, x207005_g_ExpBonus)
		AddMoney(sceneId, selfId, x207005_g_MoneyBonus)
		for i, item in pairs(x207005_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x207005_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x207005_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207005_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x207005_g_MissionId) >= 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x207005_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
       		 if objdataId == x207005_g_DemandKill.id then 
       		    if num < 10 then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死蒙古逃兵   %d/10", GetMissionParam(sceneId,selfId,misIndex,0) )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x207005_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207005_OnItemChanged(sceneId, selfId, itemdataId)

end

