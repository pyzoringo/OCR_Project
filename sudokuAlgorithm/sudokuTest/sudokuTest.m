preLib(:,:,1) = one(:,:,1);
preLib(:,:,2) = two(:,:,1);
preLib(:,:,3) = three(:,:,1);
preLib(:,:,4) = four(:,:,1);
preLib(:,:,5) = five(:,:,1);
preLib(:,:,6) = six(:,:,1);
preLib(:,:,7) = seven(:,:,1);
preLib(:,:,8) = eight(:,:,1);
preLib(:,:,9) = nine(:,:,1);
preLib(:,:,10) = zero(:,:,1);

BigPreLib = increaseResolution(preLib,5);
%%
figure(1)
for i = 1:10
    BigPreLib(:,:,i) = reCenter(BigPreLib(:,:,i));
    subplot(2,5,i); imshow(BigPreLib(:,:,i),[]);
end

%%
sudokuLib = zeros(9,10);
for i = 1:10
    sudokuLib(:,i) = imgToSudokuArray(BigPreLib(:,:,i));
end