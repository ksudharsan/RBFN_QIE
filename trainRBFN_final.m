function [F_no,F_centers,F_betas,F_theta,F_m,F_wrong,Category]=trainRBFN_final(X,y,no_classes)

  Iteration=1;
  maxIteration=5;

  [Category]=init_center_quantum(X,y);  
  init_m_quantum();
  F_no=0;
  F_centers=zeros(size(Category,1),size(X,2));
  F_m=0;
  F_wrong=[];
  delta=1e-4;
  
  while (Iteration<=maxIteration)
    
    bool=0;
    [m]=get_m();
    [Centers]=InitCentersUsingQ(X,y,Category);
    prev_centers=Centers;
    #while(1)
      [kernel_mat]=get_kmat(X,Centers);
      [Memberships]=get_mem_mat(kernel_mat,X,Centers,m);
      [Centers]=GetCenters(kernel_mat,Memberships,X,Centers,m);
      #if(max(max(abs(prev_centers-Centers)))<delta)
      #  break;
      #end
      #prev_centers=Centers;
    #end
    [Betas]=get_betas(X,Centers,Memberships);
    [Theta]=getTheta(Centers,Betas,X,y,no_classes);
    [accuracy,numRight,total,wrong] = get_accuracy(X,y,Centers,Theta,Betas,Category);
    fprintf('Iteration_no = %d Training accuracy: %d / %d, %.1f%%\n',Iteration, numRight, total, accuracy);
    
    centers_01=xlsread("center_bits.xlsx");
    m_01=xlsread("m_bits.xlsx");
    
    if(F_no<numRight)
      F_no=numRight;
      F_centers=[Centers];
      F_betas=[Betas];
      F_theta=[Theta];
      F_m=m;
      fb_c=centers_01;
      fb_m=m_01;
      F_wrong=wrong;
      bool=1;
      if(F_no==size(X,1))
        break;
      end
    end
    
    CentersQ=xlsread("center_quantum.xlsx");
    MQ=xlsread("m_quantum.xlsx");
    
    if(Iteration==1)
      Q=0.03*pi ;
      CentersNewQ=zeros(size(CentersQ));
      MNewQ=zeros(size(MQ));
      for i=1:size(CentersQ,1)
        for j=1:size(CentersQ,2)
          CentersNewQ(i,j)=cos(Q)*CentersQ(i,j)-sin(Q)*sqrt(1-CentersQ(i,j)^2);
        end
      end
      MNewQ(1,1)=cos(Q)*MQ(1,1)-sin(Q)*sqrt(1-MQ(1,1)^2);
      MNewQ(2,1)=cos(Q)*MQ(2,1)-sin(Q)*sqrt(1-MQ(2,1)^2);
    else
      CentersNewQ=zeros(size(CentersQ));
      MNewQ=zeros(size(MQ));
      for i=1:size(CentersQ,1)
        for j=1:size(CentersQ,2)
          [Q]=lookup_table(centers_01(i,j),fb_c(i,j),bool);
          CentersNewQ(i,j)=cos(Q)*CentersQ(i,j)-sin(Q)*sqrt(1-CentersQ(i,j)^2);
        end
      end
      for i=1:size(MQ,1)
        for j=1:size(MQ,2)
          [Q]=lookup_table(m_01(i,j),fb_m(i,j),bool);
          MNewQ(i,j)=cos(Q)*MQ(i,j)-sin(Q)*sqrt(1-MQ(i,j)^2);
        end
      end
    end
    
    xlswrite("center_quantum.xlsx",CentersNewQ);
    xlswrite("m_quantum.xlsx",MNewQ);
    
    Iteration=Iteration+1;
    
  end
    
end

