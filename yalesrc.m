% Usage
%    src = UMD_SRC(directory)
% Input
%    directory: The directory containing the UMD Texture dataset.
% Output
%    src: The UMD source.

function src = yalesrc(directory)
	if (nargin<1)
		directory = 'C:\Users\MUMBAI\Desktop\Yale\YALE_Processed\centered'; 
	end
	src = create_src(directory, @yale_extract_objects_fun);
end

function [objects, class] = yale_extract_objects_fun(file)
	objects.u1 = [1, 1];
	objects.u2 = [195, 231];
	[path_str, name]  = fileparts(file);
	class = {name(8:9)};
end
