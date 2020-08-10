%Check if program was launched with Gui if not config will be loaded
if not(exist('truth','var'))
     config;
end

%% Start timer here
tic

%%init
%counter that will be used for processing every frame
frameCounter = 1;

%define possible video formats
videoformats=["avi","wmv","mpg","mov","flv","swf","mp4"];
%check if the background is a video or an image
endpath=extractAfter(bg,'.');
video=ismember(endpath,videoformats);

%initialize the ImageReader 
ir = ImageReader(src, L, R, start, N);
m = length(ir.L_Frames)-start+1;

movie  = zeros(600,800,3,m,'uint8');

%Read the video/picture for the backrgound resize them
if video
    backgroundvid = nextvideo(bg,m);
else
    bg=imread(bg);
    bg = imresize(bg,[600 800]);
end

%Generating the ForegroundDetector object and assign it to the base workspace  
fdetector = vision.ForegroundDetector(...
    'NumTrainingFrames', 30, ...
    'MinimumBackgroundRatio', 0.6, ...
    'LearningRate',0.010, ...
    'NumGaussians', 5,...
    'InitialVariance',35^2);
assignin('base','fdetector',fdetector);

%Generating a CascadeObjectDetector Object and assign it to the base
%workspace
pdetector = vision.CascadeObjectDetector('UpperBody');
pdetector.MinSize = [60 60];
pdetector.MergeThreshold = 10;
assignin('base','pdetector',pdetector);

%initialize the loop variable. if all frames are processed image reader
%sets it to 1
loop = 0;

while loop ~= 1
    %This loop is called for each frame
    
    % Get next image tensors
    [left,right,loop]= ir.next;
    %setting the starting frame for the next loop
    ir.start=ir.start + 1;
    
    % Generate binary mask
    mask=segmentation(left,right);
    
    % Render new frame
    if video
        %rendering for video as background
        result =render(left(:,:,:,1),mask,backgroundvid(:,:,:,frameCounter),mode);
    else
        %rendering for a picture as background
        result =render(left(:,:,:,1),mask,bg,mode);
    end
    
    %save the current frame in movie
     movie(:,:,:,frameCounter)=result;
    %increase the frameCounter for the next frame
    frameCounter = frameCounter + 1;
end

%Play the rendered frames
implay(movie)


%% Write Movie to Disk
if store
    v = VideoWriter(dst,'Motion JPEG AVI'); 
    open(v);
    %loop to write each frame of the movie
    for i=1:size(movie,4)
        writeVideo(v,movie(:,:,:,i));
    end
    close(v);
end

clear;
%% Stop timer here
elapsed_time=toc