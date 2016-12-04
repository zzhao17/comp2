% hmm is kaggle submission file, 2800 entries
function setCertain(hmm_prediction)
hmm= hmm_prediction(:,2)
identicalRowMatrix= idendicalRowMatrix();
labels= csvread('labels.csv');
observations= csvread('observations.csv');
observations2= round(observations,2);
y= [linspace(1,3000,3000)' zeros(3000,1)];
for i=1:200
    idxArray= find(identicalRowMatrix(i,:));
    idx_length= length(idxArray);
    for j= 1: idx_length
        y(idxArray(j),2)= labels(i,1);
    end
end


for k= 201:3000
    if (observations2(k,100)==1.00)
        y(k,2)=1;
    end
    if (observations2(k,100)==2.00)
        y(k,2)=2;
    end
    if (observations2(k,100)==3.00)
        y(k,2)=3;
    end
    if (observations2(k,100)==4.00)
        y(k,2)=4;
    end
    if (observations2(k,100)==1.41)
        y(k,2)=6;
    end
    if (observations2(k,100)==5.10)
        y(k,2)=10;
    end
    if (observations2(k,100)==2.83)
        y(k,2)=12;
    end
    if (observations2(k,100)==5.39)
        y(k,2)=15;
    end
    if (observations2(k,100)==4.24)
        y(k,2)=18;
    end
    if (observations2(k,100)==5.83)
        y(k,2)=20;
    end
    if (observations2(k,100)==5.66)
        y(k,2)=24;
    end
    if (observations2(k,100)==6.40)
        y(k,2)=25;
    end
end
certainY= y(201:3000,:);
idx= find(certain);
for i=1: size(idx);
    hmm(idx(i))=certain(idx(i))
end

function [identicalRowlMatrix]=idendicalRowMatrix()
% Returns a 3000*3000 matrix m, if the row i and row j in observations.csv
% file are the same
% m(i,j)=m(j,i)= 1;
observations= csvread('observations.csv');
[nr,nc]= size(observations);
identicalRowlMatrix= zeros(nr,nr);
for i= 1:nr
    for j= i:nr
        if (observations(i,:) == observations(j,:))
            identicalRowlMatrix(i,j)= 1;
            identicalRowlMatrix(j,i)= 1;
        end
    end
end


