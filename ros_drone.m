%% Connect Through Wifi
% rosshutdown;
% ros UDP 접속을 위한 상대 companion computer ip
% rosinit('192.168.0.35');

%% Global Variables
global r; global wn;
global x; global y; global z;
global flag; global cnt;
global pos_pub; global vel_pub; global pos_sub
global ref_x; global ref_y; global ref_z;
global x; global y; global z;
global data_saved_x; global data_saved_y; global data_saved_z;

%% Subscriber
pos_sub = rossubscriber('drone1/ground_truth_to_tf/pose','geometry_msgs/PoseStamped',@sub_test_callback);

msg2 = receive(pos_sub,10);

%% SetPoint Command
% pos = rosmessage(pos_pub);
% pos.Pose.Position.X = 10;
% pos.Pose.Position.Y = 10;
% pos.Pose.Position.Z = 10;

x = -10;
y = -10;
z = 10;

% 지정한 변수값들을 Vector3Stamped message에 넣어주는 코드
vel = rosmessage(vel_pub);
vel.Linear.X = 2*(x-ref_x);
vel.Linear.Y = 2*(y-ref_y);
vel.Linear.Z = (z-ref_z);

%% Send Setpoint
%while(1)
%sp.Vector.X = sp.Vector.X + 1;
%sp.Vector.Y = sp.Vector.Y + 1;

% send(pos_pub,pos);
send(vel_pub,vel);



% send(command,sc);
%% Callback function
function sub_test_callback(src,msg2)
    global ref_x; global ref_y; global ref_z;
    global data_saved_x; global data_saved_y; global data_saved_z;
    global cnt_t;
    ref_x = msg2.Pose.Position.X;
    ref_y = msg2.Pose.Position.Y;
    ref_z = msg2.Pose.Position.Z;
    
    cnt_t=cnt_t+1;
    data_saved_x(cnt_t,:) = ref_x;
    data_saved_y(cnt_t,:) = ref_y;
    data_saved_z(cnt_t,:) = ref_z;
end


