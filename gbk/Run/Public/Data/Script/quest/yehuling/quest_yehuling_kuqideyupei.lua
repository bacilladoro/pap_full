--哭泣的玉佩

--MisDescBegin
x207000_g_ScriptId = 207000
x207000_g_MissionIdPre =1
x207000_g_MissionId = 1
x207000_g_MissionKind = 1
x207000_g_ScriptIdNext = {ScriptId = 207001 ,LV = 1 }
x207000_g_Name	="豁儿赤" 
x207000_g_Name2	="速不台" 

x207000_g_MissionName="哭泣的玉佩"
x207000_g_MissionInfo="，很高兴见到你，或许你能帮我解决心里的疑问，但是千万别对第三个人说，如果你能以对长生天发誓的话……（他神秘兮兮的看了看四周，低声的在你耳边说）\n \n    我在众多的百姓尸体里面搜索战利品的时候，一具尸体的手里紧紧的握着这个玉佩。这玉佩冰凉透彻，玉质细腻，温润洁白，质料带油脂感，润泽富足，只有新疆昆仑山脉才产的和阗白玉……，你闻闻，还带有一股女人的香味！\n \n    #G速不台#W将军是第一个提着马刀攻克野狐岭的，他的刀就像死神的镰刀一样锋利，刀过不留痕！我认得他杀人的手段，就像切萝卜一样，喀嚓！喀嚓！。\n \n握玉佩的那人一定是成了#G速不台#W的刀下亡魂，你帮我问问他关于那尸体的事情，因为我感觉到这玉佩在哭泣，似乎跟一个女人有关。"  --任务描述
x207000_g_MissionTarget="    询问#G速不台#W关于他刀下亡魂的事"		
x207000_g_MissionComplete="    你是在跟我说话吗？我没空理你……!\n \n    天啊，你这人这么婆婆妈妈叽叽歪歪，就好象整天有一只苍蝇，嗡……对不起，不是一只，是一堆苍蝇围着你，嗡…嗡…嗡…嗡…飞到耳朵里面，我恨不得把你一刀给剁了！"					--完成任务npc说话的话
--任务奖励
--金钱奖励
x207000_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207000_g_ItemBonus={}

--可选物品奖励，最多8种
x207000_g_RadioItemBonus={}

--MisDescEnd


--**********************************

--任务入口函数

--**********************************

function x207000_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207000_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207000_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x207000_g_Name2) then
                     	BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207000_g_MissionName)
			AddText(sceneId,x207000_g_MissionComplete)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207000_g_MissionTarget) 
			AddMoneyBonus(sceneId, x207000_g_MoneyBonus)	
			EndEvent()
			DispatchMissionContinueInfo(sceneId, selfId, targetId, x207000_g_ScriptId, x207000_g_MissionId)
		end
        elseif x207000_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207000_g_MissionName)
                AddText(sceneId,"    "..GetName(sceneId, selfId)..x207000_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207000_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207000_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207000_g_ScriptId, x207000_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207000_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207000_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207000_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207000_g_ScriptId, x207000_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207000_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207000_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207000_CheckPushList(sceneId, selfId, targetId)
        if (GetName(sceneId,targetId)==x207000_g_Name) then
                if IsHaveMission(sceneId,selfId, x207000_g_MissionId)<= 0 then
                    return 1
                end
        end
	if (GetName(sceneId,targetId)==x207000_g_Name2) then
		    if IsHaveMission(sceneId,selfId, x207000_g_MissionId) > 0 then
		    return 1
                    end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207000_OnAccept(sceneId, selfId)

	--加入任务到玩家列表
	BeginEvent(sceneId)
	AddMission( sceneId, selfId, x207000_g_MissionId, x207000_g_ScriptId, 1, 0, 0)
	AddText(sceneId,"接受任务："..x207000_g_MissionName) 
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end



--**********************************

--放弃

--**********************************

function x207000_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207000_g_MissionId)

end



--**********************************

--检测是否可以提交

--**********************************

function x207000_CheckSubmit( sceneId, selfId, targetId)

	if IsHaveMission(sceneId, selfId, x207000_g_MissionId) >= 0 then
		return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207000_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207000_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207000_g_MissionId)
		AddExp(sceneId, selfId, x207000_g_ExpBonus)
		AddMoney(sceneId, selfId, x207000_g_MoneyBonus)
		for i, item in pairs(x207000_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end
	        CallScriptFunction( x207000_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )

	end
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207000_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x207000_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207000_OnItemChanged(sceneId, selfId, itemdataId)

end

