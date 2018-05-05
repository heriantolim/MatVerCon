function rmpackage(varargin)
%% Remove Packages
%  Remove packages from the search path. Inputs are either a single string
%  vector or many string scalars that correspond to the package names and their
%  versions. A valid string scalar input has the format:
%  <packagename>_v<versionnumber>, where packagename is a string consisting of
%  [a-zA-Z0-9] chars, and versionnumber is a string of three integers delimited
%  by a period.
%
%  If the package requested to be removed is not in the search path, then a
%  warning will be generated, without an error.
%
% Syntax:
%  rmpackage() removes all added packages from the search path.
%
%  rmpackage(packagename,...) removes any version of the package packagename.
%
%  rmpackage(packagename_v1.2.3,...) removes a specific version of the package
%    packagename.
%
% Examples:
%  rmpackage('MatCommon_v1.0.3','research','asdf_v1.0.21') removes the package
%    'common' with version '1.0.3', 'research' with any version, and 'asdf'
%    with version '1.0.21'.
%
% See also: addpackage.
%
% Copyright: Herianto Lim (http://heriantolim.com)
% Licensing: GNU General Public License v3.0
% First created: 04/04/2013
% Last modified: 05/04/2013

numPackages=nargin;
if numPackages==0
	% Remove all packages from the search path
	pathToRemove=regexp(path,[regexptranslate('escape',...
		librarypath),'[^;]+;'],'match');
	N=numel(pathToRemove);
	for j=1:N
		rmpath(pathToRemove{j});
	end
else
	assert(all(cellfun(@ischar,varargin) & cellfun(@isrow,varargin)),...
		'MatVerCon:rmpackage:InvalidInput',...
		'All inputs must be a string scalar.');
	for i=1:numPackages
		% Read package name
		package=regexp(varargin{i},...
			'^([a-zA-Z0-9]+)(?:_v[1-9][0-9]*\.?[0-9]*\.?[0-9]*)?$','tokens');
		if isempty(package)
			error('MatVerCon:rmpackage:InvalidInput',...
				'The input strings must follow the required format.');
		else
			package=package{1}{1};
		end
		
		% Read version number
		version=regexp(varargin{i},...
			'^[a-zA-Z0-9]+_(v[1-9][0-9]*\.?[0-9]*\.?[0-9]*)$','tokens');
		if isempty(version)
			version='';
		else
			version=version{1}{1};
		end
		
		% Remove the specific package from the search path
		pathToRemove=regexp(path,[regexptranslate('escape',...
			fullfile(librarypath,package,version)),'[^;]+;'],'match');
		N=numel(pathToRemove);
		for j=1:N
			rmpath(pathToRemove{j});
		end
	end
end

end