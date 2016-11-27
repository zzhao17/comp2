% Returns graph showing the line graph for each 3000 run
% Every line is the movement path for a certain bot 

observations= csvread('observations.csv');
[nr, nc]= size(observations);
figure
for i= 1:nr-1
plot(observations(i,:));
hold on 
plot(observations(i+1,:));
end

