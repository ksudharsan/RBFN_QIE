function [m]=get_m()
  
  m_max=2.5;
  m_min=1.5;
  m_avg=m_max.-m_min;
  m_avg=m_avg./4;
  
  m_quantum=xlsread("m_quantum.xlsx");
  m_bits=zeros(size(m_quantum));

  decimal=1;
  rand_val=rand(1,1);
  if(rand_val<m_quantum(1,1)^2)
        decimal=decimal+2;
        m_bits(1,1)=1;
  end
  if(rand_val<m_quantum(2,1)^2)
        decimal=decimal+1;
        m_bits(1,2)=1;
  end
  
  m=m_min+m_avg*(decimal-1+rand(1,1));
  xlswrite("m_bits.xlsx",m_bits);
      
end