% change the file name each time
%%%%%%%%%%%%%%%%%%%%
imgPath = 'val/';
%%%%%%%%%%%%%%%%%%%%

classNum = size(gTruth.LabelDefinitions, 1)
gTruth1 = gTruth.LabelData;
gTruth1 = gTruth1{:,:};
[m, n] = size(gTruth1);

imgDir  = dir([imgPath '*.jpg']);

% get the size of images
imgExName = imgDir.name;
imgEx = imread([imgPath imgExName]);

[height, width, ~] = size(imgEx);

for i = 1:m
   
    % get the name of output txt
    imName = [imgPath imgDir(i).name];
    txtName = [imName(1:end-3) 'txt'];
    fid = fopen(txtName,'w');  
    
    % 3 calsses: 1-car, 2-bux, 3-truck.
    for j = 1:classNum
        vehicle = gTruth1{i,j};
        if isempty(vehicle)
            break;
        end
        [mj, nj] = size(vehicle);
        for k = 1:mj
            % this form is for YOLO
            % n (class index), x, y, w, h
            box = vehicle(k,:);
            Ybox = zeros(1,4);
            Ybox(1) = box(1)/width;
            Ybox(2) = box(2)/height;
            Ybox(3) = box(3)/width;
            Ybox(4) = box(4)/height;            
            fprintf(fid, '%d ', j-1);
            fprintf(fid, '%f %f %f %f\r\n', Ybox);
        end  
    end
    fclose(fid);
end