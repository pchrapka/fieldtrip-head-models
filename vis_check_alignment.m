function vis_check_alignment(cfg)

load([cfg.out_dir filesep 'elec_aligned.mat']);
load([cfg.out_dir filesep 'vol.mat']);

% Plot the scalp
if isfield(vol, 'bnd')
    switch vol.type
        case 'bemcp'
            ft_plot_mesh(vol.bnd(3),...
                'edgecolor','none',...
                'facealpha',0.8,...
                'facecolor',[0.6 0.6 0.8]);
        case 'dipoli'
            ft_plot_mesh(vol.bnd(1),...
                'edgecolor','none',...
                'facealpha',0.8,...
                'facecolor',[0.6 0.6 0.8]);
        otherwise
            error('hm:vis_check_alignment',...
                'Which one is the scalp?');
    end
elseif isfield(vol, 'r')
    ft_plot_vol(vol,...
        'facecolor', 'none',...
        'faceindex', false,...
        'vertexindex', false);
end
    
hold on;

% Plot electrodes
ft_plot_sens(elec_aligned,...
    'style', 'sk',...
    'coil', true);  

end

