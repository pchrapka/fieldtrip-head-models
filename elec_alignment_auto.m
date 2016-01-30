function elec_alignment_auto(cfg)

% Refer to http://fieldtrip.fcdonders.nl/tutorial/headmodel_eeg

%% Load MRI data
mri = ft_read_mri(cfg.mri_file);

%% Load electrode data
elec = ft_read_sens(cfg.elec_file);

% Ensure electrode coordinates are in mm
elec = ft_convert_units(elec, 'mm'); % should be the same unit as MRI

%% Get landmark coordinates
nas=mri.hdr.fiducial.mri.nas;
lpa=mri.hdr.fiducial.mri.lpa;
rpa=mri.hdr.fiducial.mri.rpa;
 
transm=mri.transform;
 
nas=ft_warp_apply(transm,nas, 'homogenous');
lpa=ft_warp_apply(transm,lpa, 'homogenous');
rpa=ft_warp_apply(transm,rpa, 'homogenous');

% create a structure similar to a template set of electrodes
fid.chanpos       = [nas; lpa; rpa];       % ctf-coordinates of fiducials
fid.label         = {'FidNz','FidT9','FidT10'};    % same labels as in elec 
fid.unit          = 'mm';                  % same units as mri
 
%% Alignment
cfg1               = [];
cfg1.method        = 'fiducial';            
cfg1.template      = fid;                   % see above
cfg1.elec          = elec;
cfg1.fiducial      = {'FidNz','FidT9','FidT10'};  % labels of fiducials in fid and in elec
elec_aligned      = ft_electroderealign(cfg1);

outfile = [cfg.out_dir filesep 'elec_aligned.mat'];
save(outfile, 'elec_aligned');

end