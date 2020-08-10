function [result] = render(frame,mask,bg,render_mode)
% This function renders the given frame according to the selected
% render_mode
switch render_mode
    case 'foreground'
        
        %in Foreground mode only the foreground will be displayed
        result = bsxfun(@times, frame, cast(mask,'like',frame));
        
    case 'background'
        
        %in background mode only the background will be displayed
        result = bsxfun(@times, frame, cast(not(mask), 'like', frame));
        
    case 'overlay'
        
        %in overlay mode the Foreground will be red and the background blue
        
        %set the red/blue channel of the current frame for foreground/background
        % to 255(maximal intensity) to color it red/blue

        fg=frame;
        fg(:,:,1)=255;
        fg = bsxfun(@times,  fg, cast(mask, 'like',  fg));
        
        bg=frame;
        bg(:,:,3)=255;
        bg = bsxfun(@times, bg, cast(not(mask), 'like', bg));
        
        result=imadd(bg,fg,'uint8');
        
    case 'substitute'
        %in substitute mode the foreground stays the same but background
        %is replaced by a background image
        fg = bsxfun(@times,  frame, cast(mask, 'like',  frame));
        bg = bsxfun(@times, bg, cast(not(mask), 'like', bg));
        result=imadd(bg,fg,'uint8');
       
    otherwise
        
end

end
