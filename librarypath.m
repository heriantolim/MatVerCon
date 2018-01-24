function Path=librarypath

if isunix
	Path=fullfile(filesep,'home','herianto');
elseif ismac
	Path=fullfile(filesep,'Users','Herianto');
elseif ispc
	Path=fullfile('C:','Users','Herianto');
else
	error('MatlabVerCon:librarypath:UnexpectedCase',...
		'Platform not supported.');
end

Path=fullfile(Path,'Documents','MATLAB');

end