%% script_head_model_elec256_dipoli.m
% Generates everything to create a head model
%   Electrode file:  GSN-HydroCel-256.sfp       (template/electrode)
%   MRI file:        Subject01/Subject01.mri    (from FieldTrip site)
%   Method:          BEM - dipoli

%% Set up vars for script

cfg = [];

% choose electrode
cfg.elec_file = 'GSN-HydroCel-256.sfp';

% choose mri
cfg.mri_file = fullfile('Subject01','Subject01.mri');
cfg.mri_dir = 'mri';
if ~exist(cfg.mri_dir,'dir')
    mkdir(cfg.mri_dir);
end

% choose output directory
cfg.out_dir = 'elec256_dipoli';

% Create the output directory if it doesn't exist
if ~exist(cfg.out_dir, 'dir')
    mkdir(cfg.out_dir);
end

%% Segment the MRI
outfile = fullfile(cfg.mri_dir,'mri_segmented.mat');
if ~exist(outfile, 'file')
    % Get the MRI
    mri = ft_read_mri(cfg.mri_file);
    % Segment the MRI data
    cfgtemp          = [];
    cfgtemp.output   = {'scalp', 'skull', 'brain'};
    mri_segmented = ft_volumesegment(cfgtemp, mri);
    save(outfile, 'mri_segmented');
else
    data_in = load(outfile);
    mri_segmented = data_in.mri_segmented;
end

%% Create the head model from the segmented data
cfgtemp = [];
cfgtemp.out_dir = cfg.out_dir;
cfgtemp.data = mri_segmented;
cfgtemp.cfg_headmodel = [];
cfgtemp.cfg_headmodel.method = 'dipoli';
cfgtemp.cfg_headmodel.tissue = {'scalp', 'skull', 'brain'};
cfgtemp.cfg_headmodel.conductivity = [1 1/80 1] * 0.33; % scalp skull brain
create_head_model(cfgtemp);

%% Load the electrodes
% cfg.elec_file = [fieldtrip_path filesep 'template' filesep 'electrode' ...
%     filesep 'GSN-HydroCel-256.sfp'];
cfg.elec_file = 'GSN-HydroCel-256.sfp';

%% Automatic alignment
% Refer to http://fieldtrip.fcdonders.nl/tutorial/headmodel_eeg
cfgtemp = [];
cfgtemp.out_dir = cfg.out_dir;
cfgtemp.mri_file = cfg.mri_file;
cfgtemp.elec_file = cfg.elec_file;
elec_alignment_auto(cfgtemp);

%% Visualization - check alignment
figure;
cfgtemp = [];
cfgtemp.out_dir = cfg.out_dir;
vis_check_alignment(cfgtemp);

%% Interactive alignment
% Refer to http://fieldtrip.fcdonders.nl/tutorial/headmodel_eeg
cfgtemp = [];
cfgtemp.out_dir = cfg.out_dir;
data_in = load(fullfile(cfg.out_dir,'vol.mat'));
cfgtemp.vol = data_in.vol;
data_in = load(fullfile(cfg.out_dir,'elec_aligned.mat'));
cfgtemp.elec = data_in.elec_aligned;
elec_alignment_interactive(cfgtemp)

%% Visualization - check alignment
figure;
cfgtemp = [];
cfgtemp.out_dir = cfg.out_dir;
vis_check_alignment(cfgtemp);
