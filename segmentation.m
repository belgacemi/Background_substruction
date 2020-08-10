
function [mask] = segmentation(left,~)
% This function takes two tensors as an input and outputs a mask selecting
% the fore and background for the first frame.

%disk shaped matrix to close the gaps with imclose
se = strel('disk',30) ;

%load the foreground detector object from the workspace
fdetector=evalin('base', 'fdetector');

%Call of the Foreground Detector Object
mask = fdetector(rgb2gray(left(:,:,:,1)));

%load the cascade object detector from the workspace
pdetector=evalin('base','pdetector');

%Call of the cascade object detector
bbox = pdetector(rgb2gray(left(:,:,:,1)));

%Form a with the result of the cascade object detector
bbmask = constructBbmask(bbox);

%use imclose to fill the holes in the mask
mask = imclose(mask,se);

%combine the two masks to delete features not belonging to a person
mask = mask.*bbmask;

    function bbmask =constructBbmask(bbox)
        %This function forms a mask that deletes pixels not belonging to
        %the detected people.
        si = size(bbox);
        
        %initialization;
        bbmask = zeros(600,800,'uint8') ;
        if si(1) == 0
            % the Cascade Object Detector detects nothing, so nothing is
            % deleted.
            bbmask = ones(600,800,1,'uint8') ;
        else
            for i=1:si(1)
                a = bbox(i,1)+bbox(i,3)-1 ;
                bbmask(bbox(i,2):600,bbox(i,1):a,:) = 1;
            end
        end
        bbmask=logical(bbmask);
    end
end
