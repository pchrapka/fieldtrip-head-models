function elec_alignment_interactive(cfg)

% Refer to http://fieldtrip.fcdonders.nl/tutorial/headmodel_eeg

%% Interactive alignment
cfg1           = [];
cfg1.method    = 'interactive';
cfg1.elec      = cfg.elec;
if isfield(cfg.vol, 'skin_surface')
    cfg1.headshape = cfg.vol.bnd(cfg.vol.skin_surface);
else
    cfg1.headshape = cfg.vol.bnd(1);
end
elec_aligned  = ft_electroderealign(cfg1);

outfile = [cfg.out_dir filesep 'elec_aligned.mat'];
save(outfile, 'elec_aligned');

end