%% Global Variables
global r; global wn;
global x; global y; global z;
global flag; global cnt;
global pub; global command; global re_f;
global timer_t; global cnt_t;
cnt_t = 0;
timer_t = 0.01;
re_f=0;
flag=0;
%% Connect Through Wifi
rosshutdown;
% ros UDP 접속을 위한 상대 companion computer ip
rosinit('192.168.0.25');

%% Subscriber
%obj.namespace = namespace;
%obj.px_pos = rossubscriber('/mavros/global_position/local', @sub_globalpoint_callback); % @ = 주소
%obj.px_local_vel = rossubscriber('/mravros/local_position/velocity_local', @sub_localvelocity_callback); % @ = 주소


%% Publisher

% rospublisher( node이름 , 사용할msg객체 )
pub = rospublisher('ros/state','geometry_msgs/Vector3Stamped');
command = rospublisher('ros/attitude_command','geometry_msgs/Quaternion');



%%
t1 = timer;
t1.TimerFcn = 'rosmat2';
t1.Period = timer_t;
t1.ExecutionMode = 'fixedSpacing';
% t.ExecutionMode = 'fixedRate';
% t.ExecutionMode = 'fixedDelay';

start(t1);

%function sub_globalpoint_callback(src, msg)
%     disp(msg.Pose.Pose.Position);
%     %disp(msg.Orientation);
%     %disp(msg.AngularVelocity);
%     %disp(msg.LinearAcceleration);
%     %disp(msg.OrientationCovariance)
%end 

%function sub_localvelocity_callback(src, msg)
%    disp(msg.Twist.Linear);
%end