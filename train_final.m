pkg load io
data = dlmread("iris.dat");
X = data(:,1:size(data,2)-1);
y = data(:,size(data,2));

Iteration=1;
no_classes=size(unique(y),1);
maxIteration=5;
tot_trained=0;
final_c=[];
final_b=[];
final_t=[];
prev_wrong=[];
X_rem=X;
y_rem=y;

while(Iteration<=maxIteration)
  [a,curr_c,curr_b,curr_t,curr_m,wrong]=trainRBFN_final(X_rem,y_rem,no_classes);
  if(size(wrong,1)==0)
    final_c=[final_c;curr_c];
    final_b=[final_b;curr_b];
    break;
  elseif(size(wrong,1)==1)
    final_c=[final_c;curr_c;X(wrong,:)];
    final_b=[final_b;curr_b;realmax];
    break;
  elseif (isequal(wrong,prev_wrong))
    for i=1:size(wrong,2)
      final_c=[final_c; X(wrong(1,i),:)];
      final_b=[final_b; realmax];
    end
    break;
  end
  tot_trained+=a;
  final_c=[final_c;curr_c];
  final_b=[final_b;curr_b];
  X_rem=X_rem(wrong,:);
  y_rem=y_rem(wrong,:);
  prev_wrong=wrong;
end