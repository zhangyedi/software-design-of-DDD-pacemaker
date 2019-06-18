function [States,AP,VP]=HW3_YediZhang_PM(Ain,Vin,States,Param)
 AP=States.AP_internal;
 VP=States.VP_internal;
 switch States.Cur_stateVRP
     case 'VRP_off'
         if Vin==1 %%% TV_1
             States.VS=1;
             States.Cur_stateVRP='VS_up';
         elseif States.VP_internal==1 %%% TV_2
             States.TVRP_cur=Param.TVRP_def;
             States.Cur_stateVRP='VRP_on';
         else    
         end
     case 'VS_up' %%% TV_3
         States.TVRP_cur=Param.TVRP_def;
         States.VS=0;
         States.Cur_stateVRP='VRP_on';
     case 'VRP_on'
         if States.TVRP_cur>0 %%% TV_4
             States.TVRP_cur=States.TVRP_cur-1;
         elseif States.TVRP_cur<=0 %%% TV_5
             States.Cur_stateVRP='VRP_off';
         else
         end
 end
        
 switch States.Cur_statePVARP
     case 'PVARP_off'
         if Ain==1 %%% TP_1
             States.AS=1;
             States.Cur_statePVARP='AS_up';
         elseif States.VS==1 || States.VP_internal==1 %%% TP_2
             States.TPVARP_cur=Param.TPVARP_def;
             States.Cur_statePVARP='PVARP_on';
         else    
         end
     case 'AS_up' %%% TP_3
         States.AS=0;
         States.Cur_statePVARP='PVARP_off';
     case 'PVARP_on'
         if Ain==1 %%% TP_4
             States.AR=1;
             States.Cur_statePVARP='AR_up';
         elseif States.TPVARP_cur>0 %%% TP_5
             States.TPVARP_cur = States.TPVARP_cur-1;
         elseif States.TPVARP_cur<=0 %%% TP_6
             States.Cur_statePVARP='PVARP_off';
         else
         end
     case 'AR_up' %%% TP_7
         States.AR=0;
         States.TPVARP_cur = States.TPVARP_cur-1;
         States.Cur_statePVARP='PVARP_on';
 end 
 
 switch States.Cur_stateURI
     case 'URI_off'
         if States.VS==1 || States.VP_internal==1 %%% TU_1
             States.TURI_cur=Param.TURI_def;
             States.URI_block=1;
             States.Cur_stateURI='URI_on';
         else
         end
     case 'URI_on'
         if States.VS==1 || States.VP_internal==1  %%% TU_2
             States.TURI_cur=Param.TURI_def;
             States.URI_block=1;
         elseif States.TURI_cur>0  %%% TU_3
             States.TURI_cur=States.TURI_cur-1;
         elseif States.TURI_cur<=0  %%% TU_4
             States.URI_block=0;
             States.Cur_stateURI='URI_off';
         else
         end
 end
 
 switch States.Cur_stateAVI
     case 'AVI_off'
         if States.ifSwitch==0 && (States.AP_internal==1 || States.AS==1) %%% TA_2
             States.TAVI_cur=Param.TAVI_def;
             States.Cur_stateAVI='AVI_on';
         elseif States.ifSwitch==1 %%% TA_1
             States.Cur_stateAVI='AVI_off';         
         else
         end
     case 'AVI_on'
         if States.ifSwitch==0 && States.TAVI_cur<=0 && States.URI_block==0 %%% TA_5
             VP=1;
             States.VP_internal=1;
             States.Cur_stateAVI='AVI_VP_up';
         elseif States.VS==1 || States.VP_internal==1 || States.ifSwitch==1 %%% TA_3
             States.Cur_stateAVI='AVI_off';
         elseif States.ifSwitch==0&& States.TAVI_cur>0 %%% TA_4
             States.TAVI_cur = States.TAVI_cur-1;
             States.Cur_stateAVI = 'AVI_on';         
         elseif States.ifSwitch==0 && States.TAVI_cur<=0 && States.URI_block==1 %%% TA_6
             States.Cur_stateAVI='AVI_on';
         else
         end
     case 'AVI_VP_up' %%% TA_7
         VP=0;
         States.VP_internal=0;
         States.Cur_stateAVI='AVI_off';        
         
 end
 
 switch States.Cur_stateLRI
     case 'LRI_off'
         if States.ifSwitch==1 %%% TL_1
             States.TLRI_cur = States.TLRI_cur-1;
             States.Cur_stateLRI='SM_LRI';
         elseif States.ifSwitch==0&&(States.VS==1||States.VP_internal==1) %%% TL_2
             States.TLRI_cur=Param.TLRI_def;
         elseif States.ifSwitch==0&&States.AS==1 %%% TL_3
             States.TLRI_cur = States.TLRI_cur-1;
             States.Cur_stateLRI='LRI_wait';
         elseif States.ifSwitch==0 && States.TLRI_cur>Param.TAVI_def %%% TL_4
             States.TLRI_cur=States.TLRI_cur-1;
         elseif States.ifSwitch==0 && States.TLRI_cur<=Param.TAVI_def %%% TL_5
             AP=1;
             States.AP_up=1;
             States.AP_internal=1;
             States.TLRI_cur = States.TLRI_cur-1;
             States.Cur_stateLRI='LRI_wait';
         else
         end
     case 'LRI_wait'
         if States.AP_up==1 %%% TL_6
             States.AP_up=States.AP_up+1;
             AP=0;
             States.AP_internal=0;
             States.TLRI_cur = States.TLRI_cur-1;
         elseif States.ifSwitch==0&&(States.VS==1 || States.VP_internal==1) %%% TL_7
             States.TLRI_cur=Param.TLRI_def;
             States.Cur_stateLRI='LRI_off';
         elseif States.ifSwitch==0 && States.TLRI_cur>0 %%% TL_8
             States.TLRI_cur=States.TLRI_cur-1;
         elseif States.ifSwitch==0&&States.TLRI_cur<=0 %%% TL_9
             VP=1;
             States.VP_internal=1;
             States.Cur_stateLRI='LRI_VP_up';
%          elseif States.ifSwitch==1 %%% TL_10
%              States.Cur_stateLRI='SM_LRI';
         else
         end
     case 'LRI_VP_up'
         if States.ifSwitch==0 %%% TL_11
             VP=0;
             States.VP_internal=0;
             States.TLRI_cur=Param.TLRI_def;
             States.Cur_stateLRI='LRI_off';
         elseif States.ifSwitch==1 %%% TL_12
             VP=0;
             States.VP_internal=0;
             States.TLRI_cur=Param.TLRI_def;
             States.Cur_stateLRI='SM_LRI';
         else
         end
     case 'SM_LRI'
         if States.ifSwitch==1&&States.VS==1 %%% TL_13
             States.TLRI_cur=Param.TLRI_def;
         elseif States.ifSwitch==1&&States.TLRI_cur<=0 %%% TL_14
             VP=1;
             States.VP_internal=1;
             States.Cur_stateLRI='LRI_VP_up';
         elseif States.ifSwitch==1&&States.TLRI_cur>0 %%% TL_15
             States.TLRI_cur=States.TLRI_cur-1;
         elseif States.ifSwitch==0 %%% TL_16
             States.TLRI_cur = States.TLRI_cur-1;
             States.Cur_stateLRI='LRI_off';
         else
         end
 end
 
 switch States.Cur_statePreDur
     case 'Pre_on'
         if States.monitor==0&&(States.AS==1||States.AR==1) %%% TPC_1
             States.monitor=1;
             States.TMon_cur=0;
         elseif States.monitor==1&&States.AR==0&&States.AS==0 %%% TPC_2
             States.TMon_cur=States.TMon_cur+1;
         elseif States.monitor==1&&(States.AR==1||States.AS==1)&&(States.TMon_cur>Param.triggerRate) %%% TPC_3
             States.TMon_cur=0;
             States.preCounter=States.preCounter-1;
         elseif States.monitor==1&&(States.AR==1||States.AS==1)&&(States.TMon_cur<=Param.triggerRate) %%% TPC_4
             States.TMon_cur=0;
             States.preCounter=States.preCounter+1;
         else
         end
 end
 
 switch States.Cur_stateDur
     case 'counterMon'
         if States.preCounter>=Param.entry_count_def %%% TD_1
             States.durCounter=0;
             States.Cur_stateDur='Dur_on';
         end
     case 'Dur_on'
         if States.VS==1||States.VP_internal==1 %%% TD_2
             States.durCounter=States.durCounter+1;
         elseif States.durCounter>Param.duration_def && States.preCounter>0 %%% TD_3
             States.ifSwitch=1;
             States.Cur_stateDur='VDI_on';
         elseif States.durCounter>Param.duration_def && States.preCounter<=0 %%% TD_4
             States.ifSwitch=0;
             States.Cur_stateDur='counterMon';
         else
         end
     case 'VDI_on'
         if States.preCounter>0 %%% TD_5
             States.Cur_stateDur='VDI_on';
         elseif States.preCounter<=0 %%% TD_6
             States.ifSwitch=0;
             States.durCounter=0;
             States.Cur_stateDur='counterMon';
         else
         end
  end
         
end