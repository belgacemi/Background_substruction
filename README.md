# Background_substruction
Background substruction using a Gaussian Mixure Model
There are 2 ways to use this program:

First method: Simply directly start the challenge.m file. When the program is used this way it will use the config file automatically.
The scene path "src" is set to use the \P1E_S1 folder. So if the user choose the use the default values with config please have the folder
\P1E_S1 set in the G58 folder (the one that contains the matlab program).

Second method: Type the command start_gui which will summon the gui
In here you need to input:

>The scenes path that contains the folder that contains the camera folders with the picture

>The film path which dictates where video should be saved. example : Desktop/Myfolderwherethevideoshouldbesaved (you dont write the video names in the path just the folder)

>the backgrounds path that either contains a video or a picture which dictates what should be put in the background when choosing substitute as a rendering mode
(the program would act differently wether you choose a video or picture as a background)

>the starting frame

>the rendering mode

>which camera should be used

(The paths in the gui need to be given without " marks example C:\UsersMyPC\Desktop\G58)
Afterwards the program would launch the challenge.m skript and work accordingly.
(the challemge.m is called with evalin so when you dont get the || pause symbol on the top of matlab the program is working in the background don't worry)
