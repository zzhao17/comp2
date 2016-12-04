function [est_transitions,est_emissions] = setup_and_train_hmm(input_array)

[transition] = create_initial_transition();
[emission] = create_initial_emissions();

csvwrite('initial_transition.csv',transition);
csvwrite('initial_emission.csv',emission);

[est_transitions,est_emissions] = hmmtrain(input_array,transition,emission,'Verbose',true,'Tolerance',0.0001,'Maxiterations',100);

end





function [emission] = create_initial_emissions()
    emission = zeros(25,18)+0.001;
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
    
    emission = bsxfun(@rdivide, emission, sum(emission,2));
end



function [transition] = create_initial_transition()
    transition = zeros(25,25)+0.001;
    
    for i=1:25
       if mod(i,5) == 1
           if i < 5 || i > 20
              transition(i,i+1) = 0.5;
              
               if i < 5
                   transition(i,i+5) = 0.5;
               elseif i > 20
                   transition(i,i-5) = 0.5;
               end
           
           else
              transition(i,i+1) = 1/3;
              transition(i,i-5) = 1/3;
              transition(i,i+5) = 1/3; 
           end
           
       elseif mod(i,5) == 0
           if i == 5 || i == 25
              transition(i,i-1) = 0.5;
              
               if i == 5
                   transition(i,i+5) = 0.5;
               elseif i == 25
                   transition(i,i-5) = 0.5;
               end
           
           else
              transition(i,i-1) = 1/3;
              transition(i,i-5) = 1/3;
              transition(i,i+5) = 1/3; 
           end
           
       elseif i < 5
          transition(i,i-1) = 1/3;
          transition(i,i+1) = 1/3;
          transition(i,i+5) = 1/3;
          
       elseif i > 20
          transition(i,i-1) = 1/3;
          transition(i,i+1) = 1/3;
          transition(i,i-5) = 1/3;
          
       else
          transition(i,i-1) = 1/4;
          transition(i,i+1) = 1/4;
          transition(i,i-5) = 1/4;
          transition(i,i+5) = 1/4; 
       end
    end
    
    
    transition = bsxfun(@rdivide, transition, sum(transition,2));
end


