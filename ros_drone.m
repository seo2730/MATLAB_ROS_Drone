%% Connect Through Wifi
% rosshutdown;
% ros UDP 접속을 위한 상대 companion computer ip
% rosinit('192.168.0.35');

%% Global Variables
global ref_x; global ref_y; global ref_z;
global vel_pub; global pos_sub
global ref_x; global ref_y; global ref_z;
global x; global y; global z;

global x; global y; global z;
global data_saved_x; global data_saved_y; global data_saved_z;
global err_pre_x; global err_pre_y; global err_pre_z;
global cnt_t;

global position_controller_x;
global position_controller_y;
global position_controller_z;

global tstart; global tend;

global timer_t;

%% Subscriber
% pos_sub = rossubscriber('drone1/ground_truth_to_tf/pose','geometry_msgs/PoseStamped',@sub_test_callback);
pos_sub = rossubscriber('drone1/ground_truth_to_tf/pose','geometry_msgs/PoseStamped');
tstart = tic;
pause(1);
    
msg2 = receive(pos_sub,10);
x = msg2.Pose.Position.X;
y = msg2.Pose.Position.Y;
z = msg2.Pose.Position.Z;

cnt_t=cnt_t+1;
data_saved_x(cnt_t,:) = x;
data_saved_y(cnt_t,:) = y;
data_saved_z(cnt_t,:) = z;

%% SetPoint Command
ref_x = 4;
ref_y = 4;
ref_z = 6;

position_controller_x = (ref_x-x);
position_controller_y = (ref_y-y);
position_controller_z = (ref_z-z);

% position_controller_x = 2*(ref_x-x) + (ref_x-x-err_pre_x)/timer_t;
% position_controller_y = 2*(ref_y-y) + (ref_y-y-err_pre_y)/timer_t;
% position_controller_z = (ref_z-z) + (ref_z-z-err_pre_z)/timer_t;

% 지정한 변수값들을 Vector3Stamped message에 넣어주는 코드
vel = rosmessage(vel_pub);
   
vel.Linear.X = position_controller_x;  
vel.Linear.Y = position_controller_y;   
vel.Linear.Z = position_controller_z;

err_pre_x = ref_x-x;
err_pre_y = ref_y-y;
err_pre_z = ref_z-z;
%% Send Setpoint
send(vel_pub,vel);
tend = toc(tstart);
%% Callback function
% function sub_test_callback(~,msg2)
%     global x; global y; global z;
%     global data_saved_x; global data_saved_y; global data_saved_z;
%     global cnt_t;
%     x = msg2.Pose.Position.X;
%     y = msg2.Pose.Position.Y;
%     z = msg2.Pose.Position.Z;
%     
%     cnt_t=cnt_t+1;
%     data_saved_x(cnt_t,:) = x;
%     data_saved_y(cnt_t,:) = y;
%     data_saved_z(cnt_t,:) = z;
% end


