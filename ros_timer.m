%% Global Variables
global x; global y; global z;
global flag; global cnt;
global pos_pub; global vel_pub; global pos_sub;
global x; global y; global z;
global timer_t; global cnt_t;
global data_saved_x; global data_saved_y; global data_saved_z;
cnt_t = 0;
timer_t = 0.01;
re_f=0;
flag=0;
%% Connect Through Wifi
rosshutdown;
% ros UDP 접속을 위한 상대 companion computer ip
rosinit('192.168.0.17');


%% Publisher

% rospublisher( node이름 , 사용할msg객체 )
% pos_pub = rospublisher('drone1/command/pose','geometry_msgs/PoseStamped');
vel_pub = rospublisher('drone1/cmd_vel','geometry_msgs/Twist');
% pub = rospublisher('drone1/cmd_vel','geometry_msgs/Vector3Stamped');
% command = rospublisher('ros/attitude_command','geometry_msgs/Quaternion');

x=0; y=0; z=0;


%%
t1 = timer;
t1.TimerFcn = 'ros_drone';
t1.Period = timer_t;
t1.ExecutionMode = 'fixedSpacing';
% t.ExecutionMode = 'fixedRate';
% t.ExecutionMode = 'fixedDelay';

start(t1);