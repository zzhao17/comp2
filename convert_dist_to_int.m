function [x] = convert_dist_to_int(dist)

   dist = round(dist,2);
   switch dist
       case 1
           x=1;
       case 2
           x=2;
       case 3
           x=3;
       case 4
           x=4;
       case 5
           x=5;
       case 1.41
           x=6;
       case 2.24
           x=7;
       case 3.16
           x=8;
       case 4.12
           x=9;
       case 5.10
           x=10;
       case 2.83
           x=11;
       case 3.61
           x=12;
       case 4.47
           x=13;
       case 5.39
           x=14;
       case 4.24
           x=15;
       case 5.83
           x=16;
       case 5.66
           x=17;
       case 6.40
           x=18;
       otherwise
           x=-1;
   end
end