function [Q] = lookup_table(x_current,b,bool)

  Q=0;
  if(x_current==0 && b == 1 && bool == 1)
    Q=0.03*pi;
  elseif(x_current==1 && b == 0 && bool == 1)
    Q=-0.03*pi;
  end
  
end

