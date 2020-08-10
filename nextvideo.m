 function [backgroundvid] = nextvideo(VideoPath,FramesFolder)
       
%Read the chosen video
   v= VideoReader(VideoPath);
   backgroundvid  = [];
   %Loops the video as many times as possible so that it exceeds the number
   %of to-be rendered frames
   while hasFrame(v)
      img = readFrame(v);
      img = imresize(img,[600 800]);
      backgroundvid = cat(4,backgroundvid,img);
   end 
   [~,~,~,l]=size(backgroundvid);
   while l<FramesFolder
       backgroundvid = cat(4,backgroundvid,backgroundvid);
       [~,~,~,l]=size(backgroundvid);
   end 
   
   
 end 
       
