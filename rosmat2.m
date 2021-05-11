%% Connect Through Wifi
% rosshutdown;
% ros UDP 접속을 위한 상대 companion computer ip
% rosinit('192.168.0.35');

%% Global Variables
global r; global wn;
global x; global y; global z;
global flag; global cnt;
global pub; global command;  global re_f;

abc  =1;
%% SetPoint
% setpoint로 전달 해줄 변수
% wn : 각속도
% r : 원 반지름
% z : 고도

if flag == 0
    r=0; wn=0;
    x =0; y=0; z=6; cnt=0;
end
% rospublisher( node이름 , 사용할msg객체 )
%pub = rospublisher('ros/state','geometry_msgs/Vector3Stamped');

%% SetPoint Command
% 지정한 변수값들을 Vector3Stamped message에 넣어주는 코드
sp = rosmessage(pub);
sp.Vector.X = x;
sp.Vector.Y = y;
sp.Vector.Z = z;

sc = rosmessage(command);
sc.X =0;
sc.Y =0;
sc.Z = 0;
sc.W = 0;


%% Send Setpoint
%while(1)
%sp.Vector.X = sp.Vector.X + 1;
%sp.Vector.Y = sp.Vector.Y + 1;
send(pub,sp);
send(command,sc);
    %pause(1);
    %disp(ct);
    
%end
flag = flag+1;
flag;
if flag == 10000
    flag = 1;
end
  
r=3;
wn = 1/5;

bound = 2/wn;
inc_unit =0.5;
% if re_f==0
%     x =1; %cnt; % r*sin(wn*cnt*0.05);
%     y =0; %r*sin(wn*cnt*pi); % r*cos(wn*cnt*0.05); % sin 경로를 trajectory로 input한다.
%     z = 1;
%     cnt = cnt+inc_unit;
%     if cnt >= bound
%         re_f=5;
%         cnt = cnt-inc_unit;
%     end
% else
%     x =1; %cnt; % r*sin(wn*cnt*0.05);
%     y =0 ;%r*sin(wn*cnt*pi); % r*cos(wn*cnt*0.05);
%     z = 1;
%     cnt = cnt-inc_unit;
%     if cnt <= 0
%         re_f=0;
%         cnt = cnt-inc_unit;
%     end
% end

x = 0;
y = 0;

%% Subscriber
px_pos = rossubscriber('/mavros/global_position/local', 'nav_msgs/Odometry'); % @ = 주소
px_local_vel = rossubscriber('/mavros/local_position/velocity_local', 'geometry_msgs/TwistStamped'); % @ = 주소
px_ang_vel = rossubscriber('/mavros/imu/data','sensor_msgs/Imu');


