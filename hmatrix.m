function h=hmatrix(PMUBus,PMUNeiBus,Ybus,gij,bij,bsi,V,teta,branch)
  P = [];
  Q = [];
  for i=1:size(PMUBus,1)
      for j=1:size(PMUNeiBus,1)
        if((Ybus(PMUBus(i),PMUNeiBus(j)) ~= 0) && (PMUBus(i)~=PMUNeiBus(j)))
            for u=1:size(branch)
               if(branch(u,1)==PMUBus(i) || branch(u,1)==PMUNeiBus(j))
                   if(branch(u,2)==PMUBus(i) || branch(u,2)==PMUNeiBus(j))
                        ok=u;
                   end
               end
            end
            pt = (V(PMUBus(i))^2)*(gij(PMUBus(i),PMUNeiBus(j))) ...
            - (V(PMUBus(i)))*(V(PMUNeiBus(j)))*(gij(PMUBus(i),PMUNeiBus(j))*cos(teta(PMUBus(i))-teta(PMUNeiBus(j)))+bij(PMUBus(i),PMUNeiBus(j))*sin(teta(PMUBus(i))-teta(PMUNeiBus(j)))); 
            qt = -(V(PMUBus(i))^2)*(bij(PMUBus(i),PMUNeiBus(j))+bsi(ok)) ... 
            - (V(PMUBus(i)))*(V(PMUNeiBus(j)))*(gij(PMUBus(i),PMUNeiBus(j))*sin(teta(PMUBus(i))-teta(PMUNeiBus(j)))-bij(PMUBus(i),PMUNeiBus(j))*cos(teta(PMUBus(i))-teta(PMUNeiBus(j))));
            P = [P;pt];      
            Q = [Q;qt];     
        end      
      end
  end
  h = [P;Q]*100;
end