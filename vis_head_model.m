%% Choose a head model file
head_model_file = ['head_models' filesep 'elec256_mri'...
    filesep 'mri_vol.mat'];

load(head_model_file);

%% Separate plots
figure;
ft_plot_mesh(vol.bnd(3),'facecolor','none'); %scalp
figure;
ft_plot_mesh(vol.bnd(1),'facecolor','none'); %skull
figure;
ft_plot_mesh(vol.bnd(2),'facecolor','none'); %brain

%% Overlapping
figure;
ft_plot_mesh(vol.bnd(3), 'facecolor',[0.2 0.2 0.2], 'facealpha', 0.3, 'edgecolor', [1 1 1], 'edgealpha', 0.05);
hold on;
ft_plot_mesh(vol.bnd(2),'edgecolor','none','facealpha',0.4);
hold on;
ft_plot_mesh(vol.bnd(1),'edgecolor','none','facecolor',[0.4 0.6 0.4]);

%% Plot electrodes

elec_file = [fieldtrip_dir filesep 'template' filesep 'electrode' ...
    filesep 'GSN-HydroCel-256.sfp'];
% elec_file = [fieldtrip_dir filesep 'template' filesep 'electrode' ...
%     filesep 'standard_1020.elc'];
elec = ft_read_sens(elec_file);

figure;
ft_plot_mesh(vol.bnd(3), 'edgecolor','none','facealpha',0.8,'facecolor',[0.6 0.6 0.8]); 
hold on;
% electrodes
ft_plot_sens(elec,'style', 'sk');  