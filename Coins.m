A=imread('s-l300.jpg');
A1=rgb2gray(A);
B=im2bw(A1);
C=bwareaopen(B,8);
D=imfill(C,'holes');
figure,imshow(D);
label=bwlabel(D);
j=max(max(label));
c5=0;
c2=0;
c1=0;
c05=0;
c10=0;
figure,imshow(A);title('The IMAGE is');
figure,imshow(A1);title('the converted binary image');
figure,imshow(D);title('after filling holes');
K=regionprops(D,'Area','Image','MajorAxisLength');
for i= 1:10
    figure,imshow(imresize(K(i).Image,2));
    title(K(i).MajorAxisLength/2);
end
for n=1:j
    [row,col]=find(label==n);
    len=max(row)-min(row)+2;
     breadth=max(col)-min(col)+2;
     target=uint8(zeros([len breadth]));
     sy=min(col)-1;
     sx=min(row)-1;
     for i=1:size(row,1)
         x=row(i,1)-sx;
         y=col(i,1)-sy;
         target(x,y)=A1(row(i,1),col(i,1));
     end
     mytitle=strcat('object number:',num2str(n));
     figure,imshow(imresize(target,2));title(mytitle);
end

for i=1:j
    if (K(i).MajorAxisLength/2>15&&K(i).MajorAxisLength/2<18)
        c1=c1+1;
    elseif (K(i).MajorAxisLength/2>21&&K(i).MajorAxisLength/2<25)
         c2=c2+1;
    elseif (K(i).MajorAxisLength/2>25&&K(i).MajorAxisLength/2<27)
         c2=c2+2;
    elseif (K(i).MajorAxisLength/2>10&&K(i).MajorAxisLength/2<13)
         c5=c5+1;
    elseif (K(i).MajorAxisLength/2>35&&K(i).MajorAxisLength/2<40)
         c10=c10+1;
    elseif (K(i).MajorAxisLength/2>5&&K(i).MajorAxisLength/2<8)
         c05=c05+1;   
     end
     
end
fprintf('the no of coins  : %d\n', max(max(label)) );
fprintf('0.5 rupee coins are : %d\n', c05 );
fprintf('1 rupee coins are : %d\n', c1);
fprintf('2 rupee coins are : %d\n', c2 );
fprintf('10 rupee coins are : %d\n', c10 );
fprintf(' 5 rupee coins are : %d\n', c5 );
fprintf('*****************************\n' );
fprintf('total money in image is : %d\n', c05.*0.5+c5.*5+c10.*10+c1+c2.*2);
    