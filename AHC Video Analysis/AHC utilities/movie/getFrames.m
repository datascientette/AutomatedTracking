function movieFrames = getFrames(movieInfo, structNum, trialNum, numToLoad)
%movieInfo from getMovies
%align to 2nd tap

ROWS = 416;
COLS = 320;
% numBeforeTap = 100;
% numAfterTap = 75;
numBeforeTap = numToLoad(1);
numAfterTap = numToLoad(2);
crop1 = 1:ROWS;
crop2 = 1:COLS;


numOfFrames = numBeforeTap + numAfterTap + 1;
movieFrames = struct('frames',[],'width',[],'heigth',[],'nrFramesTotal',[],'rate',[]);

tapFrames = movieInfo(structNum).trials{trialNum};
% secondTapFrame = tapFrames(2);
secondTapFrame = tapFrames(1);
infoFileName = movieInfo(structNum).fileName;
movieFileName = [infoFileName(1:end-10) 'movie.raw'];

fid = fopen(movieFileName, 'r');
startFrame = secondTapFrame - numBeforeTap;
fseek(fid, ROWS*COLS*startFrame, 'bof');

for m = 1:numOfFrames
    currentFrame = fread(fid, [ROWS, COLS], 'uint8=>uint8');
    movieFrames.frames(m).cdata(:,:,1) = currentFrame;
    movieFrames.frames(m).cdata(:,:,2) = currentFrame;
    movieFrames.frames(m).cdata(:,:,3) = currentFrame;
end

movieFrames.width=size(movieFrames.frames(1).cdata(:,:,1),2);
movieFrames.height=size(movieFrames.frames(1).cdata(:,:,1),1);
movieFrames.nrFramesTotal=numOfFrames;
movieFrames.rate=60;

fclose(fid);