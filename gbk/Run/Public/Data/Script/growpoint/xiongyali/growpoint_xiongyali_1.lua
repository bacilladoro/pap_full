--������


--�ű��� 301006




--��̬������ʼ������
x213001_g_MissionId = 146


--���ɺ�����ʼ************************************************************************

function 		x301006_OnCreate(sceneId,growPointType,x,y)
	
	local ItemBoxId = ItemBoxEnterScene(x,y,7,sceneId,0,13010061)
	
	
end






--���ɺ�������**********************************************************************


--��ǰ������ʼ&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	 x301006_OnOpen(sceneId,selfId,targetId)
	if IsHaveMission(sceneId,selfId, x213001_g_MissionId) > 0 then
		misIndex = GetMissionIndexByID(sceneId,selfId,x213001_g_MissionId)
		if GetMissionParam(sceneId,selfId,misIndex,1) < 1 then
			return 0
		else
			BeginEvent(sceneId)
			AddText(sceneId,"���޷�������")                    
			EndEvent(sceneId)                                        
			DispatchMissionTips(sceneId,selfId)
			return 1 
		end
	else
		BeginEvent(sceneId)                                      
		AddText(sceneId,"��û���������")                    
		EndEvent(sceneId)                                        
		DispatchMissionTips(sceneId,selfId) 
		return 1
	end

end
--��ǰ��������&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


--���պ�����ʼ########################################################################
function	 x301006_OnRecycle(sceneId,selfId,targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x213001_g_MissionId)
	num = GetMissionParam(sceneId,selfId,misIndex,1) 
	SetMissionByIndex(sceneId,selfId,misIndex,1,num+1)
		BeginEvent(sceneId)
		AddText(sceneId,format("������ɯ����������ʾ   %d/1", GetMissionParam(sceneId,selfId,misIndex,1)))
	        EndEvent()
		DispatchMissionTips(sceneId, selfId)
		return 0 
	 
	
end
--���պ�������########################################################################



--�򿪺�����ʼ@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x301006_OnProcOver(sceneId,selfId,targetId)

end
--�򿪺�������@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



function	x301006_OpenCheck(sceneId,selfId,AbilityId,AblityLevel)

end