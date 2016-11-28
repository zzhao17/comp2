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

for i = 1:size(given_labels)
   if final_state_predictions(i) == given_labels(i)
       num_correct = num_correct + 1;
   else
      [final_state_predictions(i) given_labels(i)] 
   end
end

cfinal = [linspace(1,2800,2800)' final_state_predictions(201:3000,:)];
csvwrite('hmm_predictions.csv',cfinal);

accuracy = num_correct / 200

% [M,I] = max(bot1_est_emissions,[],2);
% 
% [max_probability, state_index] = max(pstates(:,100))
