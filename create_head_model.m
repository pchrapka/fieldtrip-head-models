function [out] = create_head_model(cfg)

% Create the output directory if it doesn't exist
if ~exist(cfg.out_dir, 'dir')
    mkdir(cfg.out_dir);
end

%% Head model
outfile = [cfg.out_dir filesep 'vol.mat'];
if ~exist(outfile, 'file')
    vol = ft_prepare_headmodel(cfg.cfg_headmodel, cfg.data);
    save(outfile, 'vol');
end

end