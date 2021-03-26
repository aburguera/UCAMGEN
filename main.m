% Name        : main
% Description : Basic code to create a dataset.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es

% Get the parameters. Code a function for each dataset to create.
theParams=dat_getsampleparams();

% Initialize the dataset
dataSet=dat_init(theParams);

% Build the dataset
dataSet=dat_build(dataSet);

% Export the dataset
dataSet=dat_export(dataSet);

% Plot part of the exported dataset
dat_plot_exported(dataSet);