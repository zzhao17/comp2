function [est_transitions,est_emissions] = setup_and_train_hmm(input_array)

transition = normr(rand(25,25));
[emission] = create_initial_emissions();

[est_transitions,est_emissions] = hmmtrain(input_array,transition,emission,'Verbose',true,'Tolerance',0.01,'Maxiterations',20);

end





function [emission] = create_initial_emissions()
    emission = rand(25,18)*0.1;
    emission(1,1) = 1;
    emission(2,2) = 1;
    emission(3,3) = 1;
    emission(4,4) = 1;
    emission(5,5) = 1;
    emission(6,6) = 1;
    emission(7,7) = 1;
    emission(8,8) = 1;
    emission(9,9) = 1;
    emission(10,10) = 1;
    emission(11,7) = 1;
    emission(12,11) = 1;
    emission(13,12) = 1;
    emission(14,13) = 1;
    emission(15,14) = 1;
    emission(16,8) = 1;
    emission(17,12) = 1;
    emission(18,15) = 1;
    emission(19,5) = 1;
    emission(20,16) = 1;
    emission(21,9) = 1;
    emission(22,13) = 1;
    emission(23,5) = 1;
    emission(24,17) = 1;
    emission(25,18) = 1;
    emission = normr(emission);
end