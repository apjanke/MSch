function initMSch
%initMSch Initialize the MSch library
%
% This function must be called before using any MSch functionality.
%
% It is safe to call this function multiple times.

% Get our required Java libs on the path

thisDir = fileparts(mfilename('fullpath'));
tbxRootDir = fileparts(fileparts(thisDir));
javaLibDir = fullfile(tbxRootDir, 'lib', 'java');

jars = {
  'jsch-0.1.55.jar'
  };
jarPaths = cellfun(@(x) {fullfile(javaLibDir, x)}, jars);
currentJavaPath = [javaclasspath; javaclasspath('-static')];
needToAdd = setdiff(jarPaths, currentJavaPath);
if ~isempty(needToAdd)
  javaaddpath(needToAdd);
end

end