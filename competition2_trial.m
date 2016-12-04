given_labels = csvread('labels.csv');
observations = csvread('observations.csv');
clusters = csvread('cluster_file.csv');

bot1_obs = observations(clusters==1,:);
bot2_obs = observations(clusters==2,:);
bot3_obs = observations(clusters==3,:);

disp('got bots separated');

bot1_converted_array = arrayfun(@convert_dist_to_int,bot1_obs);
bot2_converted_array = arrayfun(@convert_dist_to_int,bot2_obs);
bot3_converted_array = arrayfun(@convert_dist_to_int,bot3_obs);

disp('converted the arrays');

[bot1_est_transitions,bot1_est_emissions] = setup_and_train_hmm(bot1_converted_array);
disp('bot1 hmm done');

[bot2_est_transitions,bot2_est_emissions] = setup_and_train_hmm(bot2_converted_array);
disp('bot2 hmm done');

[bot3_est_transitions,bot3_est_emissions] = setup_and_train_hmm(bot3_converted_array);
disp('bot3 hmm done');


final_state_predictions = ones(3000,1)*-1;

cluster_indices = find(clusters==1);
for i = 1:size(bot1_converted_array,1)
    pstates = hmmdecode(bot1_converted_array(i,:),bot1_est_transitions,bot1_est_emissions);
    [~,final_state_predictions(cluster_indices(i))] = max(pstates(:,100));
end

cluster_indices = find(clusters==2);
for i = 1:size(bot2_converted_array,1)
    pstates = hmmdecode(bot2_converted_array(i,:),bot2_est_transitions,bot2_est_emissions);
    [~,final_state_predictions(cluster_indices(i))] = max(pstates(:,100));
end

cluster_indices = find(clusters==3);
for i = 1:size(bot3_converted_array,1)
    pstates = hmmdecode(bot3_converted_array(i,:),bot3_est_transitions,bot3_est_emissions);
    [~,final_state_predictions(cluster_indices(i))] = max(pstates(:,100));
end

num_correct = 0;


f = final_state_predictions;

f_copy = f(find(clusters==1),:);
f_copy(f_copy==16) = 8;
f_copy(f_copy==17) = 13;
f(find(clusters==1),:) = f_copy;


f_copy = f(find(clusters==2),:);
f_copy(f_copy==11) = 7;
f_copy(f_copy==13) = 17;
f_copy(f_copy==23) = 19;
f_copy(f_copy==5) = 19;
f(find(clusters==2),:) = f_copy;


f_copy = f(find(clusters==3),:);
f_copy(f_copy==11) = 7;
f_copy(f_copy==13) = 17;
f_copy(f_copy==23) = 19;
f_copy(f_copy==5) = 19;
f_copy(f_copy==22) = 14;
f_copy(f_copy==21) = 9;
f_copy(f_copy==16) = 8;
f(find(clusters==3),:) = f_copy;


for i = 1:size(given_labels)
   if f(i) == given_labels(i)
       num_correct = num_correct + 1;
   else
      [clusters(i) f(i) given_labels(i)] 
   end
end

cfinal = [linspace(1,2800,2800)' f(201:3000,:)];
csvwrite('hmm_predictions.csv',cfinal);

accuracy = num_correct / 200

% colormap('hot')
% subplot(1,3,1)
% imagesc(bot1_est_transitions)
% subplot(1,3,2)
% imagesc(bot2_est_transitions)
% subplot(1,3,3)
% imagesc(bot3_est_transitions)
% colorbar


% csvwrite('clusters.csv',clusters);
% csvwrite('bot1_est_emissions.csv',bot1_est_emissions);
% csvwrite('bot2_est_emissions.csv',bot2_est_emissions);
% csvwrite('bot3_est_emissions.csv',bot3_est_emissions);
% csvwrite('bot1_est_transitions.csv',bot1_est_transitions);
% csvwrite('bot2_est_transitions.csv',bot2_est_transitions);
% csvwrite('bot3_est_transitions.csv',bot3_est_transitions);