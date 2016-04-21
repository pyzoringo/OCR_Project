matFiles = dir...
    ('/Users/Pyzo/Dropbox/UM/M/2016Spring/OCR_Project/*.mat');
for i = 1:length(matFiles)
    load(strcat(...
        '/Users/Pyzo/Dropbox/UM/M/2016Spring/OCR_Project/',...
        matFiles(i).name));
end

onebuffer = 1 - squeeze(all(~(1-all(~one))));
one = one(:,:,1:length(onebuffer(onebuffer~=0)));
twobuffer = 1 - squeeze(all(~(1-all(~two))));
two = two(:,:,1:length(twobuffer(twobuffer~=0)));
threebuffer = 1 - squeeze(all(~(1-all(~three))));
three = three(:,:,1:length(threebuffer(threebuffer~=0)));
fourbuffer = 1 - squeeze(all(~(1-all(~four))));
four = four(:,:,1:length(fourbuffer(fourbuffer~=0)));
fivebuffer = 1 - squeeze(all(~(1-all(~five))));
five = five(:,:,1:length(fivebuffer(fivebuffer~=0)));
sixbuffer = 1 - squeeze(all(~(1-all(~six))));
six = six(:,:,1:length(sixbuffer(sixbuffer~=0)));
sevenbuffer = 1 - squeeze(all(~(1-all(~seven))));
seven = seven(:,:,1:length(sevenbuffer(sevenbuffer~=0)));
eightbuffer = 1 - squeeze(all(~(1-all(~eight))));
eight = eight(:,:,1:length(eightbuffer(eightbuffer~=0)));
ninebuffer = 1 - squeeze(all(~(1-all(~nine))));
nine = nine(:,:,1:length(ninebuffer(ninebuffer~=0)));
zerobuffer = 1 - squeeze(all(~(1-all(~zero))));
zero = zero(:,:,1:length(zerobuffer(zerobuffer~=0)));

%% normalize these samples
for i = 1:size(one,3)
    one(:,:,i) = one(:,:,i)/sum(sum(one(:,:,i)))/size(one,3);
end

for i = 1:size(two,3)
    two(:,:,i) = two(:,:,i)/sum(sum(two(:,:,i)))/size(two,3);
end
for i = 1:size(three,3)
    three(:,:,i) = three(:,:,i)/sum(sum(three(:,:,i)))/size(three,3);
end
for i = 1:size(four,3)
    four(:,:,i) = four(:,:,i)/sum(sum(four(:,:,i)))/size(four,3);
end
for i = 1:size(five,3)
    five(:,:,i) = five(:,:,i)/sum(sum(five(:,:,i)))/size(five,3);
end
for i = 1:size(six,3)
    six(:,:,i) = six(:,:,i)/sum(sum(six(:,:,i)))/size(six,3);
end
for i = 1:size(seven,3)
    seven(:,:,i) = seven(:,:,i)/sum(sum(seven(:,:,i)))/size(seven,3);
end
for i = 1:size(eight,3)
    eight(:,:,i) = eight(:,:,i)/sum(sum(eight(:,:,i)))/size(eight,3);
end
for i = 1:size(nine,3)
    nine(:,:,i) = nine(:,:,i)/sum(sum(nine(:,:,i)))/size(nine,3);
end
for i = 1:size(zero,3)
    zero(:,:,i) = zero(:,:,i)/sum(sum(zero(:,:,i)))/size(zero,3);
end
%%
figure(123);
subplot(2,5,1), imshow(sum(one,3),[]);
subplot(2,5,2), imshow(sum(two,3),[]);
subplot(2,5,3), imshow(sum(three,3),[]);
subplot(2,5,4), imshow(sum(four,3),[]);
subplot(2,5,5), imshow(sum(five,3),[]);
subplot(2,5,6), imshow(sum(six,3),[]);
subplot(2,5,7), imshow(sum(seven,3),[]);
subplot(2,5,8), imshow(sum(eight,3),[]);
subplot(2,5,9), imshow(sum(nine,3),[]);
subplot(2,5,10), imshow(sum(zero,3),[]);

%% match
sample = one(:,:,randi([1, size(one,3)]));
sample = sample/(sum(sum(sample)));
corStem = zeros(10,106);
corStem(1,1:106) = matchNumberArray(sample, one);
corStem(2,1:17) = matchNumberArray(sample, two);
corStem(3,1:28) = matchNumberArray(sample, three);
corStem(4,1:24) = matchNumberArray(sample, four);
corStem(5,1:31) = matchNumberArray(sample, five);
corStem(6,1:16) = matchNumberArray(sample, six);
corStem(7,1:17) = matchNumberArray(sample, seven);
corStem(8,1:13) = matchNumberArray(sample, eight);
corStem(9,1:13) = matchNumberArray(sample, nine);
corStem(10,1:12) = matchNumberArray(sample, zero);

figure(1); 
subplot(1,2,1);imshow(sample,[]);
subplot(1,2,2);stem(sum(corStem'));
figure(2);
for i = 1:10
    subplot(10,1,i); stem(1000*corStem(i,:));%axis([0,106,0,4]);
end
% %%
% for i = 1: 16
%     figure(789);
%     subplot(4,4,i);imshow(six(:,:,i),[])
% end
