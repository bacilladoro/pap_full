--ɱ���Ѿ�

--MisDescBegin
x206003_g_ScriptId = 206003
x206003_g_MissionIdPre =29
x206003_g_MissionId = 30
x206003_g_MissionKind = 8
x206003_g_MissionLevel = 40
x206003_g_ScriptIdNext = {ScriptId = 206004 ,LV = 1 }
x206003_g_Name	="ľ����" 
x206003_g_DemandItem ={}
x206003_g_DemandKill ={{id=402,num=20},{id=403,num=1}}

x206003_g_MissionName="ɱ���Ѿ�"
x206003_g_MissionInfo="    �����ǳɼ�˼���ľ��ӣ����������κ�Ӱ����ġ������������£����Ѿ����������Щ�Ѿ�������׽�Ѿ�����#R������#W��"  --��������
x206003_g_MissionTarget="    ɱ��20��#RѲ�ߵ��Ѿ�#W��#������#W����#Gľ����#W������"		                                                                                               
x206003_g_MissionComplete="     �������Ǹ���ɼ�˼��̤ƽ̫������ʱ�򣬹������ǵ�һ�������󺹵��ˣ����������ڳ��������ߣ�����ս������ɳ���ܹ��ƣ����������ĵ��ӣ�\n \n    ��³�������ߣ��������������кܴ�ԭ�򣬲������⺢�ӡ���"					--�������npc˵���Ļ�
x206003_g_ContinueInfo="    ɱ������������"
--������
x206003_g_MoneyBonus = 10000
--�̶���Ʒ���������8��
x206003_g_ItemBonus={}

--��ѡ��Ʒ���������8��
x206003_g_RadioItemBonus={}

--MisDescEnd
x206003_g_ExpBonus = 1000
--**********************************

--������ں���

--**********************************

function x206003_OnDefaultEvent(sceneId, selfId, targetId)	--����������ִ�д˽ű�

	--����г�����
	if x206003_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--����ѽӴ�����
	if IsHaveMission(sceneId,selfId, x206003_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x206003_g_MissionId)
		if x206003_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x206003_g_MissionName)
			AddText(sceneId,x206003_g_ContinueInfo)
		        AddText(sceneId,"#Y����Ŀ��#W") 
			AddText(sceneId,x206003_g_MissionTarget) 
			AddText(sceneId,format("\n    ɱ��Ѳ�ߵ��Ѿ�   %d/%d\n    ɱ��������   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x206003_g_DemandKill[1].num,GetMissionParam(sceneId,selfId,misIndex,1),x206003_g_DemandKill[2].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x206003_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x206003_g_MissionName)
		     AddText(sceneId,x206003_g_MissionComplete)
		     EndEvent()
		     AddMoneyBonus(sceneId, x206003_g_MoneyBonus)
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x206003_g_ScriptId, x206003_g_MissionId)
                end

        elseif x206003_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	--�����������ʱ��ʾ����Ϣ
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x206003_g_MissionName)
                AddText(sceneId,x206003_g_MissionInfo) 
		AddText(sceneId,"#Y����Ŀ��#W") 
		AddText(sceneId,x206003_g_MissionTarget) 
		AddMoneyBonus(sceneId, x206003_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x206003_g_ScriptId, x206003_g_MissionId)
        end
	
end



--**********************************

--�о��¼�

--**********************************

function x206003_OnEnumerate(sceneId, selfId, targetId)


	--��������ɹ��������
	if IsMissionHaveDone(sceneId, selfId, x206003_g_MissionId) > 0 then
		return 0
	end
	--����ѽӴ�����
	if  x206003_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x206003_g_ScriptId, x206003_g_MissionName)
	end
	return 0
	
end



--**********************************

--����������

--**********************************

function x206003_CheckAccept(sceneId, selfId, targetId)
	if IsMissionHaveDone(sceneId, selfId, x206003_g_MissionIdPre) > 0 then
		return 1
	end
	return 0
end


--**********************************

--���鿴����

--**********************************

function x206003_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==6) then
        	if IsMissionHaveDone(sceneId, selfId, x206003_g_MissionIdPre) > 0 then
                	return 1
                end
        end
        return 0
		
end

--**********************************

--����

--**********************************

function x206003_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x206003_g_MissionId, x206003_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"��������"..x206003_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--����

--**********************************

function x206003_OnAbandon(sceneId, selfId)

	--ɾ����������б��ж�Ӧ������
	DelMission(sceneId, selfId, x206003_g_MissionId)
	for i, item in x206003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--����Ƿ�����ύ

--**********************************

function x206003_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x206003_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x206003_g_DemandKill[1].num then
		if GetMissionParam(sceneId,selfId,misIndex,1) == x206003_g_DemandKill[2].num then
	        	return 1
	        end
	end
	return 0

end



--**********************************

--�ύ

--**********************************

function x206003_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x206003_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x206003_g_MissionId)
		AddExp(sceneId, selfId, x206003_g_ExpBonus)
		AddMoney(sceneId, selfId, x206003_g_MoneyBonus)
		for i, item in x206003_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x206003_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x206003_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--ɱ����������

--**********************************

function x206003_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x206003_g_MissionId) >= 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x206003_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0)
	 num2 = GetMissionParam(sceneId,selfId,misIndex,1)  
		 if objdataId == x206003_g_DemandKill[1].id then 
       		    if num < x206003_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("ɱ��Ѳ�ߵ��Ѿ�   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x206003_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 if objdataId == x206003_g_DemandKill[2].id then 
       		    if num2 < x206003_g_DemandKill[2].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,1,num2+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("ɱ��������   %d/%d", GetMissionParam(sceneId,selfId,misIndex,1),x206003_g_DemandKill[2].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--���������¼�

--**********************************

function x206003_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--���߸ı�

--**********************************

function x206003_OnItemChanged(sceneId, selfId, itemdataId)

end
