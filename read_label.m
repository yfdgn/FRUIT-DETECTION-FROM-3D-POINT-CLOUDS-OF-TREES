function C = read_label(filename)

fid = fopen(filename);
s = fgetl(fid);
ss = textscan(s,'%s');
ss = ss{1};

num_points = 0;

while 1

    if length(ss) == 3
        if isequal('element',ss{1}) &&  isequal('vertex',ss{2})
            num_points = str2num(ss{3});
            break
        end
    end

    s = fgetl(fid);
    ss = textscan(s,'%s');
    ss = ss{1};
    
end

C = zeros(num_points,1);


while not(isequal('end_header',s))
    s = fgetl(fid);
end

formatSpec = '%f %f %f %d %d %d %f';
sizeA = [7,Inf];
C = fscanf(fid,formatSpec,sizeA);
C = C(end,:);
C = C';

% for i = 1:num_points
%     s = fgetl(fid);
%     ss = textscan(s,'%s');
%     ss = ss{1};
%     C(i) = str2num(ss{end});
%     disp([i num_points])
% end

fclose(fid);