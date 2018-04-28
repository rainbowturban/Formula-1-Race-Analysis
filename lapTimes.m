load lapFinal.mat
unique_raceId = unique(raceId);
unique_driverId = unique(driverId);
res = zeros(length(unique_driverId), length(unique_raceId));
% indCol = 1;
% indRow = 1;
count = 1;
tempAvg = milliseconds1(1);
curr_race = raceId(1);
curr_driver = driverId(1);

for i = 2:length(raceId)
    if raceId(i) == curr_race
        if driverId(i) == curr_driver
            tempAvg = tempAvg + milliseconds1(i);
            count = count + 1;
        else
            tempAvg = tempAvg/count;
            indRow = find(unique_driverId==curr_driver);
            indCol = find(unique_raceId==curr_race);
            res(indRow,indCol) = tempAvg;
            
            % Reset -> new Driver
            tempAvg = milliseconds1(i);
            count = 1;
            curr_driver = driverId(i);
%             indRow = indRow + 1;
        end
    else
        tempAvg = tempAvg/count;
        indRow = find(unique_driverId==curr_driver);
        indCol = find(unique_raceId==curr_race);
        res(indRow,indCol) = tempAvg;
        
        % Reset -> new Race
        tempAvg = milliseconds1(i);
        count = 1;
        curr_driver = driverId(i);
        curr_race = raceId(i);
%         indRow = 1;
%         indCol = indCol + 1;
    end
end

%% Integrate lapTimes and pitStops
% lapTimes: #driver=123, #race=395
% pitStops: #driver=56, #race=137
load stopFinal.mat
raceId1_stop = raceId1_stop(2:end);
milliseconds2_stop = milliseconds2_stop(2:end);
driverId1_stop = driverId1_stop(2:end);
stop = stop(2:end);

unique_raceId_stop = unique(raceId1_stop);
unique_driverId_stop = unique(driverId1_stop);
res_reduced = zeros(length(unique_driverId_stop), length(unique_raceId_stop));

% Reduce lapTimes result to only drivers and race that exist in pitStop
for i = 1:length(unique_driverId_stop)
    tempDriver = find(unique_driverId == unique_driverId_stop(i));
    res_reduced(i,:) = res(tempDriver,259:end);     % lap times
end

i = 1;
ind = 1;
while i <= length(unique_raceId_stop)
    res_vector(ind:ind+55,1) = res_reduced(:,i);
    ind = ind+56;
    i = i + 1;
end

%% pitStops
count = 1;
curr_race = raceId1_stop(1);
% curr_driver = driverId1_stop(1);
res_stop = zeros(length(unique_driverId_stop), length(unique_raceId_stop));
res_raceId = zeros(length(raceId1_stop),1);
res_driverId = zeros(length(raceId1_stop),1);

for i = 2:length(raceId1_stop)
    if raceId1_stop(i) == curr_race
        indRow = find(unique_driverId_stop==driverId1_stop(i));
        indCol = find(unique_raceId_stop==curr_race);
        res_stop(indRow,indCol) = stop(i);
    else
        indRow = find(unique_driverId_stop==driverId1_stop(i));
        indCol = find(unique_raceId_stop==curr_race);
        res_stop(indRow,indCol) = stop(i);
        
        % Reset -> new Race
        curr_race = raceId1_stop(i);
    end
end

i = 1;
ind = 1;
while i <= length(unique_raceId_stop)
    res_stop_vector(ind:ind+55,1) = res_stop(:,i);
    ind = ind+56;
    i = i + 1;
end

%%
ind = 1;
for i = 1:137
    res_driverId(ind:ind+55,1) = unique_driverId_stop;
    res_raceId(ind:ind+55,1) = unique_raceId_stop(i,1)*ones(56,1);
    ind = ind + 56;
end