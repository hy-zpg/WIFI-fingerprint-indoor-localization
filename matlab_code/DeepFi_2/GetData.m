function output = GetData(filekey,foldername)

cd(foldername);
key = ['*',filekey,'*'];
namelist = ls(key);
[num, x] = size(namelist);
output = cell(3,num);
for i = 1:num
    %x(0)-y(0)-z(0)-delay(0)-span(0)-id(0)-descr(abc)-res(x)
    %直接匹配所需的文件名字，提取信息
    tmp = regexp(namelist(i,:), 'x\((-?[\.\d]*)\)-y\((-?[\.\d]*)\)-z\((-?[\.\d]*)\)-delay\((-?[\.\d]*)\)-span\((-?[\.\d]*)\)-id\((-?[\.\d]*)\)-descr\((.*)\)-res\((.*)\)','tokens');
  
    phoneId = regexp(namelist(i,:),'0(\d)\.txt','tokens');
    for tokenNo = 1:6
        if strcmp(tmp{1}{tokenNo},'')
            tmp{1}{tokenNo} = NaN;
        end
        output{1,i}(tokenNo) = str2double(tmp{1}{tokenNo});
    end
    output{1,i} = [output{1,i} 0];
    %output{1,i} = [str2num(tmp{1,1}{1,1}) str2num(tmp{1,1}{1,2})];
    tmpData = GetValue(namelist(i,:));
    output{2,i}= tmpData{1};
    output{3,i}= tmpData{2}; 
end
cd('..');
end

function output = GetValue(name)
celldata = loadData(name);
[~, b] =size(celldata);
c = length(celldata{2,1});
outputdata = zeros(c+6,b);
output = cell(1,2);
data = zeros(c,b);
for i = 2:b
    data(:,i) = celldata{2,i};
end
for ssid=2:b
    NumNotRec = numNotReceive(data(:,ssid));
    dataUsing = Ignore(data(:,ssid));
    avg = mean(dataUsing);
    StdVar = sqrt(var(dataUsing));
    maxV = max(dataUsing);
    minV = min(dataUsing);
    outputdata(1:6,ssid) = [avg;StdVar;maxV;minV;NumNotRec;c];
    outputdata(7:c+6 ,ssid) =  data(:,ssid);
end
for j=7:c+6
    outputdata(j,1)=str2double(cell2mat(celldata{2,1}(j-6)));
end

output{1} = outputdata;
output{2} = cell(1,b);
output{2} = {celldata{1,:}};

end

function output = Ignore(data)
len = length(data);
cntr = 1;
for i = 1:len
    if(data(i) ~= -120)
        a(cntr) = data(i);
        cntr = cntr + 1;
    end
end
if exist('a')
    output = a;
else 
    output = -120;
end
end

function cntr = numNotReceive(data)
len = length(data);
cntr = 0;
for i = 1:len
    if(data(i) == -120)
        cntr = cntr + 1;
    end
end
end

function output = loadData(name)
p = textread(name,'%[^\n]',1,'headerlines',1);
num = length(regexp(p{1,1},'\t','split'));
form = '%[0123456789-]';
headform = '%s';
for i = 1: num -1
    form = [form '%n'];
    headform = [headform '%s'];
end
list = cell(2,num);
[list{1,:}] = textread(name,headform,1);
[list{2,:}] = textread(name,form,'headerlines',1);
output = list;
end


