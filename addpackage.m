function addpackage(varargin)
%% Add Packages
%  Add packages from the library to the search path. Inputs are either a single
%  string vector or many string scalars that correspond to the package names and
%  their versions. A valid string scalar input has the format:
%  <packagename>_v<versionnumber>, where packagename is a string consisting of
%  [a-zA-Z0-9] chars, and versionnumber is a string of three integers delimited
%  by a period.
%
%  Whenever a package is added, any package in the search path with the same
%  name will be removed first. This prevents coexistence of two different
%  versions of the same package.
%
% Syntax:
%  addpackage(packagename,...) adds package with a name packagename and a
%    version of the latest available version in the library.
%
%  addpackage(packagename_v1.2.3,...) adds package with a name packagename
%    and a version of 1.2.3.
%
% Examples:
%  addpackage('MatCommon_v1.0.3','research','asdf_v1.0.21') adds the package
%    'common' with version '1.0.3', 'research' with the latest available
%    version, and asdf with version '1.0.21'.
%
% See also: rmpackage.
%
% Copyright: Herianto Lim (http://heriantolim.com)
% Licensing: GNU General Public License v3.0
% First created: 04/04/2013
% Last modified: 08/02/2016

numPackages=nargin;
if numPackages==0
	return
end
assert(all(cellfun(@ischar,varargin) & cellfun(@isrow,varargin)),...
	'MatVerCon:addpackage:InvalidInput',...
	'All inputs must be a string scalar.');

for i=1:numPackages
	% Read package name
	package=regexp(varargin{i},...
		'^([a-zA-Z0-9]+)(?:_v[1-9][0-9]*\.[0-9]+\.[0-9]+)?$','tokens');
	if isempty(package)
		error('MatVerCon:addpackage:InvalidInput',...
			'The input strings must follow the required format.');
	else
		package=package{1}{1};
	end
	
	% Check package availability
	listing=dir(fullfile(librarypath,package));
	numListings=numel(listing);
	if numListings==0
		warning('MatVerCon:addpackage:PackageNotFound',...
			'The package %s does not exist.',package);
		continue
	end
	
	% Read version number
	version=regexp(varargin{i},...
		'^[a-zA-Z0-9]+_(v[1-9][0-9]*\.[0-9]+\.[0-9]+)$','tokens');
	if isempty(version)
		% Look for the latest version
		k=0;
		availableVersion={};
		for j=1:numListings
			version=regexp(listing(j).name,...
			'^(v[1-9][0-9]*\.[0-9]+\.[0-9]+)$','tokens');
			if ~isempty(version)
				k=k+1;
				availableVersion(k)=version{1}; %#ok<AGROW>
			end
		end
		if k==0
			warning('MatVerCon:addpackage:MissingVersion',...
				'The package %s does not contain any versioned subfolder.',package);
			continue
		end
		availableVersion=sort(availableVersion);
		version=availableVersion{k};
	else
		version=version{1}{1};
	end
	
	% Remove all versions of the same package from path
	rmpackage(package);
	
	% Add the requested version of the package into path
	addpath(genpath(fullfile(librarypath,package,version)));
end

end