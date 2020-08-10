classdef  ImageReader
    % Add class description here
    
    
    %Creating Properties
    properties
        N ;
        L ;
        R  ;
        src ;
        start ;
        L_Frames;
        R_Frames;
        
    end
    
    methods
        
        % Image Reader function
        
        function obj = ImageReader(src, L, R, start, N)
            obj.N = N;
            obj.L = L;
            obj.R = R;
            obj.src = src;
            
            %Was start given as input? No -> start = 0
            if nargin == 4 || start == 0 
                start = 1;
            end
        
            obj.start = start;
            %create path for folders containing the wanted stream
            
            addpath(genpath(src));
            addpath(pwd);
            if ispc
                Stream = regexp(src, '\', 'split');
                Left_Stream  = strcat(src ,'\', Stream(end),'_C', num2str(L));
                Left_Stream = Left_Stream{1};
                Right_Stream = strcat(src ,'\', Stream(end),'_C', num2str(R));
                Right_Stream = Right_Stream{1};
            elseif isunix
                Stream = regexp(src, '/', 'split');
                Left_Stream  = strcat(src ,'/', Stream(end),'_C', num2str(L));
                Left_Stream = Left_Stream{1};
                Right_Stream = strcat(src ,'/', Stream(end),'_C', num2str(R));
                Right_Stream = Right_Stream{1};
            end
            
            
            %Search for the Left Camera's frames
            cd (Left_Stream);
            obj.L_Frames = dir('*.jpg');
            
            
            %Search for the right Camera'S frames
            cd (Right_Stream);
            obj.R_Frames = dir('*.jpg');
            
            cd(pwd);
            
        end
        
        function [left,right,loop] = next(obj)
            
            %Initiate Loop, Left and Right
            left  = [];
            right = [];
            %Check if Start+N+1 exceeds the number of frames
            
            if  obj.start+obj.N >= length(obj.L_Frames)
                loop = 1;
            end
            
            if not(exist('loop','var'))
                loop = 0;
            end
            
            % concatenate N+1 Frame we need from the Left Camera
            
            counter = loop;
            j = obj.start;
            for i=obj.start:obj.start+obj.N
                %Check if loop exceeds 1
                if counter  ~= 0 && j == length(obj.L_Frames)+ 1
                    counter = counter -1;
                    j=1;
                end
                Image = imread(obj.L_Frames(j).name);
                left = cat(4,left,Image);
                j = j+1;
            end
            
            
            % concatenate N+1 Frame we need from the Right Camera
            
            counter = loop;
            j = obj.start;
            for i=obj.start:obj.start+obj.N
                %Check if loop exceeds 1
                if counter  ~= 0 && j == length(obj.L_Frames) + 1
                    counter = counter -1;
                    j=1;
                end
                Image = imread(obj.R_Frames(j).name);
                right = cat(4,right,Image);
                j = j+1;
            end
            
            
        end
    end
    
    
end