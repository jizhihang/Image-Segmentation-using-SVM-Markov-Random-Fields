 function [] = displayimages(i,varargin)
% if(numel(varargin)==0)
%     figure,imshow(i,[]);
% elseif(numel(varargin)==1)
%     selected_pixels=varargin{1,1};
%     %     i([selected_pixels(1,:)],[selected_pixels(2,:)],[1,3])=255;
%     for t=1: numel(selected_pixels)/2
%         i(selected_pixels(1,t),selected_pixels(2,t),[1,3])=255;
%     end
%     figure,imshow(i);
% else
%     m= varargin{1,2};
%     n= varargin{1,3};
%     bbc=varargin{1,1};
%     if(numel(bbc)~=0)
%         mask=uint8(zeros(m,n));
%         mask(bbc(1):bbc(2),bbc(3):bbc(4))=1;
%         pr(:,:,1) = mask.* i(:,:,1);
%         pr(:,:,2) = mask.* i(:,:,2);
%         pr(:,:,3) = mask.* i(:,:,3);
%         figure,imshow(pr,[]);
%     end
% end
