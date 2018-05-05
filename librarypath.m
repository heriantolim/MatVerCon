function Path=librarypath
%% Library Path
%  This function returns the path to the user's MATLAB package library.
%
% Copyright: Herianto Lim (http://heriantolim.com)
% Licensing: GNU General Public License v3.0
% First created: 04/04/2013
% Last modified: 04/04/2013

% Replace `Herianto` with the username you use in your computer
if isunix
	Path=fullfile(filesep,'home','herianto');
elseif ismac
	Path=fullfile(filesep,'Users','Herianto');
elseif ispc
	Path=fullfile('C:','Users','Herianto');
else
	error('MatVerCon:librarypath:UnexpectedCase',...
		'Platform not supported.');
end

% Ensure that this gives the path to your MATLAB package library
Path=fullfile(Path,'Documents','MATLAB','Packages');

end