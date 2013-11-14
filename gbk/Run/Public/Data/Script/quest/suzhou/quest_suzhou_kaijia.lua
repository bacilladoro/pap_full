--苏州任务之  购买铠甲配材
--MisDescBegin
--当前脚本的索引号
x100017_g_ScriptId = 100017

--当前任务的MissionID，具体由专人负责分配，9开头的默认为是为测试任务分配的ID
x100017_g_MissionId = 117

--任务归类
x100017_g_MissionKind = 13
x100017_g_MissionLevel = 13

--任务起始npc
x100017_g_NameHead	= "楚留香"

--任务提交npc
x100017_g_NameEnd	= "楚留香"

--任务是否已经完成
x100017_g_IsMissionOkFail = 0		--变量的第0位

x100017_g_DemandItem ={{id=11960011,num=1}}

x100017_g_MissionName="购买铠甲配材"

--任务描述(接任务时，和所有目标完成交任务时)支持多条语句
x100017_g_MissionInfo={"现在正是非常时期，我们要随时小心黑衣人的袭击，我现在要存下一些装备，以备不时只需。你能帮我吗？"} 

x100017_g_MissionTarget="收集一个上等祖母绿，你可以到#aB{159,275,9,苏州01,杂货商人}[杂货商人]#aE处购买一套上等祖母绿，完成后回#aB{333,275,9,苏州01,楚留香}[楚留香]#aE处复命"	

x100017_g_ContinueInfo={"一定要快啊！以备不测。"}

x100017_g_MissionComplete={"这么快就回来了？你果然有做大侠的天赋。"}

x100017_g_MoneyBonus=10000
x100017_g_ItemBonus={id=12010002,num=2}
--MisDescEnd

--****************************************任务可接条件判断*************************************************************************
--任务可接等级范围
x100017_g_MissionMinLevel = 10
x100017_g_MissionMaxLevel = 100

--前置任务的MissionID,可以填写多个前置任务
x100017_g_MisIdPre = {116}

--需要后续任务在该任务结束后直接弹出，则填写下面的参数，否则不填写，只能填写一个后续任务
--ScriptId为后续任务的ScriptId。LV为后续任务的等级要求，要和ScriptId对应脚本里面的等级要求一致
x100017_g_ScriptIdNext = {ScriptId = 100018 ,LV = 14 }

--****************************************任务内容开始********************************************************************* 
--任务未完成时去交任务的提示文字 ，支持多条语句
x100017_g_UnDoneMissionInfo={"找到杂货商人，并购买一份上等祖母绿"}
--总的大体任务目标描述，一句话描述
x100017_g_MissionAim="找到杂货商人，并购买一份上等祖母绿"		

--任务目标类型(可以多任务目标)
--COLLECT						--收集物品                    --item为采集的物品类型,name为道具名称,num为需求道具个数
x100017_g_COLLECT = {{item=11960011,name="上等祖母绿",num=1,type="COLLECT",order=0}}

--********************************任务目标的组合********************************
--*切记*****切记*****切记*******************************************************************************
--*********************一个任务的目标个数最多只能为8个,现在已经超出了,请修正*******************************
--********************任务目标为最小元素,比如杀3种怪,算作3个任务目标计算***********************************
--*切记*****切记*****切记********************************************************************
x100017_g_QuestType = {x100017_g_COLLECT}
x100017_g_Quest = {}
x100017_g_QuestNum = 0
x970012_MP_ISCOMPLETE = 7

function  x100017_g_QuestOrder(QuestType)
	local count = 0
	for i, QuestLabel in pairs(QuestType) do
		for j, QuestInfo in pairs(QuestLabel) do
			count = count + 1
			QuestInfo.order = count
			x100017_g_Quest[count] = QuestInfo
		end
	end
	x100017_g_QuestNum = count
end
	
--任务奖励(exp为经验调节参数，money为金钱调节参数)
--经验奖励
x100017_g_ExpBonustxt = ""
x100017_g_exp = 1

function x100017_g_ExpBonus(sceneId, selfId, exp)
	local LV = GetLevel( sceneId, selfId )
	local ExpBonus =90
	return ExpBonus*x100017_g_exp
end

--金钱奖励
x100017_g_MoneyBonustxt = 10000
x100017_g_money = 1

function x100017_g_MoneyBonus(sceneId, selfId, money)
	local MoneyBonus=10000
	return MoneyBonus*x100017_g_money
end

--固定物品奖励，最多8种
x100017_g_ItemBonus={{id=12010003,num=5}}

--**********************************任务入口函数**********************************

function x100017_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	x100017_g_QuestOrder(x100017_g_QuestType)
    if IsHaveMission(sceneId,selfId,x100017_g_MissionId) > 0 then
		if (GetName(sceneId,targetId)==x100017_g_NameEnd) then
			local m = 0
			for i, QuestInfo in pairs(x100017_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					if (#(x100017_g_DELIVERY)==1) and (x100017_g_NameEnd == x100017_g_DELIVERY[1].npc) then	
						m = 2
					else
						m = 1
					end
				else
					m = 1
				end
			end
			if m == 1 then
				local Done = x100017_CheckSubmit( sceneId, selfId )
				BeginEvent(sceneId)
					if Done == 1 then
						x100017_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x100017_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
				BeginEvent(sceneId)
             AddText(sceneId,"#Y"..x100017_g_MissionName)
		         AddText(sceneId,"这么快就回来了？你果然有做大侠的天赋。我就知道你会顺利归来！")
		         AddMoneyBonus(sceneId, 10000)
		         if x100017_g_ItemBonus ~= nil then
		          	for i, item in pairs(x100017_g_ItemBonus) do
			        	AddItemBonus( sceneId, item.id, item.num )
			          end
		         end
		    EndEvent()
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x100017_g_ScriptId,x100017_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x100017_g_ScriptId,x100017_g_MissionId,0)
				end
			elseif m == 2 then
				local Done = 0
				if x100017_g_DELIVERY[1].item > 0 and x100017_g_DELIVERY[1].num > 0 then
					if	(LuaFnGetItemCount(sceneId,selfId,x100017_g_DELIVERY[1].item)>=x100017_g_DELIVERY[1].num) then
						Done = 1						
					end
				else
					Done = 1
				end
				if Done == 1 then
					local misIndex = GetMissionIndexByID(sceneId,selfId,x100017_g_MissionId)
					for i, QuestInfo in pairs(x100017_g_Quest) do
						if (QuestInfo.type == "DELIVERY") then
							if (GetName(sceneId,targetId)==QuestInfo.npc)then
								SetMissionByIndex(sceneId,selfId,misIndex,7,1)
							end
						end
					end
				end
				BeginEvent(sceneId)
					if Done == 1 then
						x100017_ShowQuestInfo( sceneId, selfId, targetId , 1)
					else
						x100017_ShowQuestInfo( sceneId, selfId, targetId , 2)
					end
				EndEvent( )
				if (Done == 1) then
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x100017_g_ScriptId,x100017_g_MissionId)
				else
					DispatchMissionDemandInfo(sceneId,selfId,targetId,x100017_g_ScriptId,x100017_g_MissionId,0)
				end
			end
		elseif (x100017_g_DELIVERY ~= nil) then
			local n = 0 
			for i, QuestInfo in pairs(x100017_g_Quest) do
				if (QuestInfo.type == "DELIVERY") then
					n = 1
					break
				end
			end
			if  n == 1 then
				for i, DeliveryInfo in pairs(x100017_g_DELIVERY) do
					if (GetName(sceneId,targetId)==DeliveryInfo.npc)then
						if DeliveryInfo.comeitem > 0 and DeliveryInfo.comenum > 0 then
							BeginAddItem(sceneId)		
								AddItem( sceneId,DeliveryInfo.comeitem, DeliveryInfo.comenum )
							local ret = EndAddItem(sceneId,selfId)
							if  ret <=0 then
								BeginEvent(sceneId)
									strText = "物品栏已满，请整理下再来！"
									AddText(sceneId,strText);
								EndEvent(sceneId)
								DispatchMissionTips(sceneId,selfId)
								return
							end					
						end
						local m = 0
						if DeliveryInfo.item == 0 or DeliveryInfo.num == 0 then
							m = 1
						elseif DeliveryInfo.item > 0 or DeliveryInfo.num > 0 then
							if	(LuaFnGetItemCount(sceneId,selfId,DeliveryInfo.item)>=DeliveryInfo.num) then
								m = 2
							end
						end
						if m > 0 then
							local misIndex = GetMissionIndexByID(sceneId,selfId,x100017_g_MissionId)
							for i, QuestInfo in pairs(x100017_g_Quest) do
								if QuestInfo.type == "DELIVERY" then
									if (GetName(sceneId,targetId)==QuestInfo.npc)then
										SetMissionByIndex(sceneId,selfId,misIndex,7,1)
									end
								end
							end
							BeginEvent(sceneId)
								strText = DeliveryInfo.info.."   1/1"
								AddText(sceneId,strText);
							EndEvent(sceneId)
							DispatchMissionTips(sceneId,selfId)
							BeginEvent(sceneId)
								AddText(sceneId,DeliveryInfo.dialog)
							EndEvent( )	
							DispatchEventList(sceneId,selfId,targetId)
							if m == 2 then
								DelItem(sceneId,selfId,DeliveryInfo.item,DeliveryInfo.num)
							end
							if DeliveryInfo.comeitem > 0 and DeliveryInfo.comenum > 0 then
								AddItemListToHuman(sceneId,selfId)
							end	
						elseif m == 0 then
							BeginEvent(sceneId)
								AddText(sceneId,x100017_g_NameHead.."让你带给我的东西在哪呢？")
							EndEvent( )	
							DispatchEventList(sceneId,selfId,targetId)
						end
					end
				end
			end
		end
    elseif x100017_CheckAccept(sceneId,selfId,targetId) > 0 then
		--满足任务可接条件，开始显示任务的相关内容
		BeginEvent(sceneId)
			x100017_ShowQuestInfo( sceneId, selfId, targetId ,0)
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x100017_g_ScriptId,x100017_g_MissionId)
    end	
end

--**********************************任务内容显示**********************************
function	x100017_ShowQuestInfo( sceneId, selfId, targetId ,Done)
	local DoneEX = Done
	AddText(sceneId,"#Y"..x100017_g_MissionName)
	if DoneEX==2 then
		for i, Info in pairs(x100017_g_UnDoneMissionInfo) do
			AddText(sceneId,Info)
		end
	else
		for i, Info in pairs(x100017_g_MissionInfo) do
			AddText(sceneId,Info)
		end
	end
	AddText(sceneId,x100017_g_ExpBonustxt)
	AddText(sceneId,"#Y任务目标:")
	AddText(sceneId,x100017_g_MissionAim)
	--多任务目标的显示
	if Done >= 1 then
		Done = 1
	end	
	x100017_ShowQuestAim( sceneId, selfId, targetId,Done )	
	AddMoneyBonus( sceneId, x100017_g_MoneyBonustxt )
	if DoneEX == 2 then
	else
		if x100017_g_ItemBonus ~= nil then
			for i, item in pairs(x100017_g_ItemBonus) do
				AddItemBonus( sceneId, item.id, item.num )
			end
		end			
	end
end

--**********************************任务目标显示**********************************

function	x100017_ShowQuestAim( sceneId, selfId, targetId ,Done)
	x100017_g_QuestOrder(x100017_g_QuestType)
	if x100017_g_Quest ==nil then
		print("该任务没有绑目标!!!")
	else
		local Many = 0
		misIndex = GetMissionIndexByID(sceneId,selfId,x100017_g_MissionId)
		for i, QuestInfo in pairs(x100017_g_Quest) do

			if QuestInfo.type == "MONSTER_KILL" or QuestInfo.type == "COLLECT_SPECIAL"  or QuestInfo.type == "MONSTER_ITEM" then
				if Done == 1 then
					Many = GetMissionParam(sceneId,selfId,misIndex,7)
					if Many == nil then
						Many = 0
					end
				end
				StrTxt = QuestInfo.name.."    "..Many.."/"..QuestInfo.num
				AddText(sceneId,StrTxt)				
			elseif  (QuestInfo.type == "COLLECT") then
				if Done == 1 then
					Many = LuaFnGetItemCount(sceneId,selfId,QuestInfo.item)
					if Many == nil then
						Many = 0
					elseif Many >  QuestInfo.num then
						Many = QuestInfo.num
					end
				end
				StrTxt = QuestInfo.name.."    "..Many.."/"..QuestInfo.num
				AddText(sceneId,StrTxt)
    end
	end
end
end

--**********************************判断任务是否显示**********************************
function x100017_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if IsMissionHaveDone(sceneId,selfId,x100017_g_MissionId) > 0 then
    	return 
	end
    --如果已接此任务
    --else
    if IsHaveMission(sceneId,selfId,x100017_g_MissionId) > 0 then
		AddNumText(sceneId,x100017_g_ScriptId,x100017_g_MissionName);
    --满足任务接收条件
    elseif x100017_CheckAccept(sceneId,selfId ,targetId) > 0 then
		AddNumText(sceneId,x100017_g_ScriptId,x100017_g_MissionName);
    end
end


--**********************************判断任务可接条件****************************************
--**********************************1、点击的当前NPC为任务接受NPC****************************
--**********************************2、满足等级范围需求、满足前续任务完成需求*****************

function x100017_CheckAccept( sceneId, selfId ,targetId )
	if (GetName(sceneId,targetId)==x100017_g_NameHead) then
		if (GetLevel( sceneId, selfId ) >= x100017_g_MissionMinLevel ) and (GetLevel( sceneId, selfId ) <= x100017_g_MissionMaxLevel ) then
			if	x100017_g_MisIdPre == nil then
				return	1
			else
				for i, questpre in pairs(x100017_g_MisIdPre) do
					if IsMissionHaveDone(sceneId,selfId,questpre) == 0 then
						return 0
					end
				end
				return 1
			end		
		else
			return 0
		end
	else
		return 0
	end	
end
--**********************************接受任务**********************************
function x100017_OnAccept(sceneId, selfId )		
	x100017_g_QuestOrder(x100017_g_QuestType)
	if GetMissionCount(sceneId, selfId)>=20 then
		Msg2Player(  sceneId, selfId,"#Y你的任务日志已经满了" , MSG2PLAYER_PARA )
		BeginEvent(sceneId)
			strText = "#Y你的任务日志已经满了"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	local DoKill,DoArea,DoItem = 0,0,0
	for i, QuestInfo in pairs(x100017_g_Quest) do
		if QuestInfo.type == "MONSTER_KILL" then
			DoKill = 1
		elseif QuestInfo.type == "COLLECT"	then			--收集物品
			DoItem = 1
		end
	end	
	--第5个参数表示是否回调OnKillObject	第6个参数表示是否回调OnEnterArea	第7个参数表示是否回调OnItemChange
	AddMission( sceneId,selfId, x100017_g_MissionId, x100017_g_ScriptId, DoKill, DoArea, DoItem )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x100017_g_MissionId)			--得到任务的序列号
	if x100017_g_QuestNum > 8 then
		print("一个任务的目标个数最多只能为8个,现在已经超出了,请修正")
		return
	end
	for j=1,x100017_g_QuestNum do
		SetMissionByIndex(sceneId,selfId,misIndex,7,0)	--根据序列号把任务变量的第0位置0
	end
	BeginEvent(sceneId)
	  	strText = "你接受了任务  "..x100017_g_MissionName
	  	AddText(sceneId,strText);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--放弃
--**********************************
function x100017_OnAbandon( sceneId, selfId )
	x100017_g_QuestOrder(x100017_g_QuestType)
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x100017_g_MissionId )
    for i, QuestInfo in pairs(x100017_g_Quest) do
		if QuestInfo.type ==  "COLLECT_SPECIAL" then
			local collectitemnum = LuaFnGetItemCount(sceneId,selfId,QuestInfo.item)
			if collectitemnum > 0 then
				DelItem(sceneId,selfId,QuestInfo.item,collectitemnum)
			end
		end
		if QuestInfo.type ==  "MONSTER_ITEM" then
			local monsteritemnum = LuaFnGetItemCount(sceneId,selfId,QuestInfo.item)
			if monsteritemnum > 0 then
				DelItem(sceneId,selfId,QuestInfo.item,monsteritemnum)
			end
		end
	end    
end

--**********************************
--继续
--**********************************
function x100017_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x100017_CheckSubmit( sceneId, selfId )
	if LuaFnGetItemCount(sceneId,selfId,x100017_g_DemandItem[1].id) == x100017_g_DemandItem[1].num then
	        return 1
	end
	return 0
end
--**********************************
--提交
--**********************************
function x100017_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	x100017_g_QuestOrder(x100017_g_QuestType)
	if (x100017_CheckSubmit( sceneId, selfId ) == 1) then
		BeginAddItem(sceneId)
		local givebonus = 0
		local giveitem = 0
		if #(x100017_g_ItemBonus) ==0 then
			givebonus = 1
		else
			for i, item in pairs(x100017_g_ItemBonus) do
				if item.id>0 and item.num>0 then
					AddItem( sceneId,item.id, item.num )
					giveitem = 1
				end
			end
			if giveitem == 1 then
				giveitem = EndAddItem(sceneId,selfId)
			end
		end				
		if (giveitem<=0) and (givebonus==0)  then
			--任务奖励没有加成功
			BeginEvent(sceneId)
				strText = "物品栏已满，请整理下再来！"
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		else
			ret = DelMission( sceneId, selfId, x100017_g_MissionId )
			if ret > 0 then
			 for i, QuestInfo in pairs(x100017_g_Quest) do					
				if QuestInfo.type ==  "COLLECT"  or QuestInfo.type ==  "COLLECT_SPECIAL" or QuestInfo.type ==  "MONSTER_ITEM" then
						DelItem(sceneId,selfId,QuestInfo.item,QuestInfo.num)
				end						
		  	end   
				MissionCom( sceneId,selfId, x100017_g_MissionId )
				if (x100017_g_ExpBonustxt~=nil) then
					LuaFnAddExp( sceneId, selfId,x100017_g_ExpBonus(sceneId, selfId, x100017_g_exp))
				end					
				if (x100017_g_MoneyBonustxt~=nil) then
					AddMoney(sceneId,selfId,x100017_g_MoneyBonus(sceneId, selfId, x100017_g_money) );
				end
				if giveitem > 0 then
					AddItemListToHuman(sceneId,selfId)
				end
				BeginEvent(sceneId)
				  	strText = "你完成了任务  "..x100017_g_MissionName
				  	AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				if (x100017_g_ScriptIdNext.ScriptId~=nil) and (x100017_g_ScriptIdNext.ScriptId>0) then
					local CanNext = CallScriptFunction( x100017_g_ScriptIdNext.ScriptId, "CheckAccept",sceneId, selfId, targetId )
					if (CanNext == 1) then
						CallScriptFunction( x100017_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
					else
						BeginEvent(sceneId)
							AddText(sceneId,"哎呀哎呀，可以了可以了")
						EndEvent( )	
						DispatchEventList(sceneId,selfId,targetId)
					end
				end
			end
		end
	end
end

--**********************************--杀死怪物或玩家--**********************************
function x100017_OnKillObject( sceneId, selfId, objdataId )

end

--**********************************--进入区域事件--**********************************
function x100017_OnEnterArea( sceneId, selfId, areaId )

end

function x100017_OnTimer( sceneId, selfId )

end

function x100017_OnLeaveArea( sceneId, selfId )

end
--**********************************--道具改变--**********************************
function x100017_OnItemChanged( sceneId, selfId, itemdataId )
	x100017_g_QuestOrder(x100017_g_QuestType)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x100017_g_MissionId)
	for i, QuestInfo in pairs(x100017_g_Quest) do
		if QuestInfo.type == "COLLECT_SPECIAL" or QuestInfo.type == "COLLECT" or QuestInfo.type == "MONSTER_ITEM" then
			if (QuestInfo.item == itemdataId) then
				local questitemnum = LuaFnGetItemCount(sceneId,selfId,QuestInfo.item)
				if ( questitemnum >= 0 ) and ( questitemnum <= QuestInfo.num )then
					SetMissionByIndex(sceneId,selfId,misIndex,7,questitemnum)
					BeginEvent(sceneId)
						strText = format("已获得  "..QuestInfo.name.."  %d/"..QuestInfo.num,questitemnum )
					 	AddText(sceneId,strText);
				 	EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
				end
			end
		end
	end
end