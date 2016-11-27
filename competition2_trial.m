% given_labels = csvread('labels.csv');
% observations = csvread('observations.csv');
% 
% clusters = kmeans(observations,3);
% 
% bot1_obs = observations(clusters==1,:);
% bot2_obs = observations(clusters==2,:);
% bot3_obs = observations(clusters==3,:);
% 
% disp('got bots separated');
% 
% bot1_converted_array = arrayfun(@convert_dist_to_int,bot1_obs);
% bot2_converted_array = arrayfun(@convert_dist_to_int,bot2_obs);
% bot3_converted_array = arrayfun(@convert_dist_to_int,bot3_obs);
% 
% disp('converted the arrays');
% 
% [bot1_est_transitions,bot1_est_emissions] = setup_and_train_hmm(bot1_converted_array);
% disp('bot1 hmm done');

% [bot2_est_transitions,bot2_1est_emissions] = setup_and_train_hmm(bot2_converted_array);
% disp('bot2 hmm done');
% 
% [bot3_est_transitions,bot3_1est_emissions] = setup_and_train_hmm(bot3_converted_array);
% disp('bot3 hmm done');

% final_state_predictions = ones(3000,1);
% for i = 1:3000
    pstates = hmmdecode(bot1_converted_array(2,:),bot1_est_transitions,bot1_est_emissions);
    final_state_predictions

[M,I] = max(bot1_est_emissions,[],2);

[max_probability, state_index] = max(pstates(:,100))
