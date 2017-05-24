 classdef TSPExecution < handle
    properties
        m = []
        sz = 20
    end
    methods 
        
        function out = calc (this) 
            cnt = 0;
            A = [];
            B = [];
            C = [];
            id = [];
            for i = 1 : this.sz
                id(i) = i; % assigning id to each cell
                for j = i + 1 : this.sz
                    x1 = this.m(i,1);%getting first x1
           
                    y1 = this.m(i,2); %getting first y1
                    x2 = this.m(j,1);%getting cordinate x2
                    y2 = this.m(j,2);%cordinate y2
                    cnt = cnt + 1;%increasing size of array
                    A(cnt) = ((x1 - x2) ^ 2 + (y1 - y2) ^ 2)^0.5;% euclid distance btw 2 points
                    B(cnt) = i;%vertex i
                    C(cnt) = j;%vertex j
                end
            end
            %sorting all edges by it distances from lower to higher
            for i = 1 : cnt
                for j = i + 1 : cnt
                    if A(i) > A(j)
                        curAi = A(i);
                        curAj = A(j);
                        curBi = B(i);
                        curBj = B(j);
                        curCi = C(i);
                        curCj = C(j);
                        A(i) = curAj;
                        A(j) = curAi;
                        B(i) = curBj;
                        B(j) = curBi;
                        C(i) = curCj;
                        C(j) = curCi;
                    end
                end
            end
            res = 0; 
            %going through sorted list
            for i = 1: cnt
                l = A(i);
                a = B(i);
                b = C(i);
                if (id(a) ~= id (b)) %if ids not equal
                   res = res + l; %adding cost to the cur length
                   ol = id (b);
                   ne = id (a);
                   for j = 1:this.sz
                       if (id (j) == ol) %colloring second component to new one
                           id (j) = ne;
                       end
                   end
                end
            end
            out = res;
        end
        function this = printFunc(this)   
            disp ('Distance : ');
            disp (this.calc); %printing answer
        end
        function this = TSPExecution (this)
            this.m = xlsread('input.xlsx'); %getting data from 'input.xlsx'
            this.printFunc;%this function prints our result
        end
    end
 end
    