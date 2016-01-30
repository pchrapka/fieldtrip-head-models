%% startup
% add packages to the path

% Get the user's Matlab directory
matlab_dir = userpath;
matlab_dir = matlab_dir(1:end-1);

%add fieldtrip package
fieldtrip_path = [matlab_dir filesep 'fieldtrip-20160128'];
if exist(fieldtrip_path, 'dir') ~= 7
    warning('STARTUP:CheckPackages',...
            ['Missing fieldtrip package %s.\nDownload and install from ' ...
             'ftp://ftp.fcdonders.nl/pub/fieldtrip/ See README'],...
             fieldtrip_path);
else
    addpath(fieldtrip_path);
    ft_defaults
end
