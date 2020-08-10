%% Computer Vision Challenge 2020 config.m

%% Generall Settings
% Group number:
group_number = 58;

% Group members:
members = {'Belgacem, Iheb','Ben Ammar, Hassen','Achraf, El Euch','Raupach, Andreas','Souit, Abdelhakim'};

% Email-Address (from Moodle!):
mail = {'iheb.belgacem@tum.de','ga92jil@tum.de','achraf.el-euch@tum.de','andreas.raupach@tum.de','ga94bew@tum.de'};


%% Setup Image Reader
% Specify Scene Folder
filepath = fileparts(mfilename('fullpath'));
src = strcat(filepath,'\','P1E_S1');

% Select Cameras
L = 1;
R = 2;

% Choose a start point
start = 2200;

% Choose the number of succeeding frames loaded by the image reader
N = 5;

% Load Virtual Background
bg = "vid.mp4";

% Select rendering mode
mode = "overlay";

%% Output Settings
% Output Path    
dst = "Generated_video.avi";
dst = strcat(filepath,'\',dst);

% Store Output?
store = true;
