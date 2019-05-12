% i=0;
% m=[];
% v=[];
% LS=[];
% for x0  = 0 : 0.1 :3-1.3   %luas ruangan - lebar j
L=[];
L=addLine();
L=addLine(L,0,0,4.7,0); 
L=addLine(L,4.7,0,4.7,11.5);  
L=addLine(L,4.7,11.5,0,11.5);
L=addLine(L,0,11.5,0,0);

L=addLine(L,2.5,0,2.6,2.5); 
L=addLine(L,2.5,0,2.6,2.5);

L=addLine(L,0,3.5,3.58,3.5); 
L=addLine(L,0,3.5,3.58,3.5);
L=addLine(L,3.58,3.5,5.6,3.58); 
L=addLine(L,3.58,3.5,5.6,3.58);
L=addLine(L,0,6.5,3.58,6.5); 
L=addLine(L,0,6.5,3.58,6.5);

L=addLine(L,6.5,2,9.5,2); 
L=addLine(L,6.5,2,9.5,2);
L=addLine(L,0,9.5,9.5,2); 
L=addLine(L,0,9.5,9.5,2);

L=addLine(L,3.3,9.5,3.8,9.5); 
L=addLine(L,3.3,9.5,3.8,9.5);
L=addLine(L,3.3,9.5,11.5,3.3); 
L=addLine(L,3.3,9.5,11.5,3.3);





stg = 0.1;
L=AddJendela(L);
L=AddJendela(L,1,0,0.75,1,1.5);   %posisi dinding, posisi jendela, posisi tinggi, lebar j, tinggi j 
L=AddJendela(L,4,6.3,0.75,1,1.5);   %posisi dinding, posisi jendela, posisi tinggi, lebar j, tinggi j 
L=AddJendela(L,2,6.3,0.75,2,1.5);   %posisi dinding, posisi jendela, posisi tinggi, lebar j, tinggi j 
L=SetMode(L,1,0.1);
L=Execute(L,0:stg:4.7,0:stg:11.5);

% dt = (L.inRoom)>0;
% dL = L.dL(dt);

% i = i + 1;
% LS(i).dL=L.dL;
% LS(i).wr=L.wr;
% m(i) = mean(dL(:));
% v(i) = var(dL(:));

% end

% figure(1)
% plot([m' v'])
% title('Distribution daylight in Room size 3x4 (1.3)')
% xlabel('windows potition') % x-axis label
% ylabel('distibustion daylight') % y-axis label
% legend('varian','mean')
% grid on



% filename = 'cobadata.xlsx';
% xlswrite(filename,A,1,'E1:I5')
% xlswrite (filename',jendela0, 1, 'D5') ;

data1 = imtool(flipud(L.wr));
% imsave(data1)

figure( 1 )
data2 = mesh(L.dL);
% saveas(data2,data2.png)

figure( 2 )
data3 = mesh(L.inRoom);
% saveas(data3,data3.png)
% 
% 
dt = (L.inRoom)>0;
dL = L.dL(dt);



