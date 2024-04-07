
fig_apple = figure
ptCloudRedSegmented = pcread('ptCloud_ROI_234_s_SEGMENTED.ply');
pcshow(ptCloudRedSegmented);

distE = 10;
L = pcsegdist(ptCloudRedSegmented,distE);
counter = 0;

clusters_XYZ_Limits=[]

for i = min(L): max(L)
    apple = select(ptCloudRedSegmented,L==i); 
    
    title_str = sprintf("Algoritm has found %d Apples", counter);
    title(title_str);
    figure(fig_apple)
 
    %hold on
    if apple.Count > 50
        counter = counter + 1;
        apple;
        
        cluster_XYZ_Limits=[apple.XLimits(1),apple.XLimits(2),apple.YLimits(1), apple.YLimits(2),apple.ZLimits(1),apple.ZLimits(2)];
             
        clusters_XYZ_Limits = [clusters_XYZ_Limits; cluster_XYZ_Limits]; % Alt listeyi ana liste ile birleştir
        
        xmin = apple.XLimits(1);
        ymin = apple.YLimits(1);
        zmin = apple.ZLimits(1);
        xmax = apple.XLimits(2);
        ymax = apple.YLimits(2);
        zmax = apple.ZLimits(2);
    
        
        cuboid = images.roi.Cuboid(gca, 'Position', [xmin, ymin, zmin, xmax-xmin, ymax-ymin, zmax-zmin]);
        cuboid.FaceAlpha = 0.3; % Küpün yüzeyine şeffaflık eklemek için
        cuboid.EdgeColor = 'B'; % Küpün kenar rengini kırmızı yapmak için
        
%         x = apple.Location;
%         plot3(x(:,1),x(:,2),x(:,3),'g.','MarkerSize',30)
       % pause
        
        
        
    else
        continue
    end
end

 