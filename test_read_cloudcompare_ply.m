


figure_apple = figure

labeled_ply_filename = 'ptCloud_ROI_234_s.ply';
ptcloud = pcread(labeled_ply_filename);
pcshow(ptcloud)
C = read_label(labeled_ply_filename);
C = C+1;   % En küçük label 1 olsun
%figure
%colormap(hsv(max(C)))
%pcshow(ptcloud.Location,C)


counter = 0;


remove_tree = select(ptcloud,C~=max(C));

clusters_Limits= []
yedek_remove_tree = remove_tree
figureNew= figure
pcshow(remove_tree)

for i = min(C):max(C)-1
    apple = select(ptcloud,C==i);
    
    counter = counter + 1;
    title_str = sprintf('Ground Truth data has %d Apples', counter);
    title(title_str);
    figure(figureNew)
    
    
    
    apple;
    
    cluster_Limits = [apple.XLimits(1),apple.XLimits(2),apple.YLimits(1), apple.YLimits(2),apple.ZLimits(1),apple.ZLimits(2)];

    clusters_Limits = [clusters_Limits; cluster_Limits]; % Alt listeyi ana liste ile birleştir
    
    xmin = apple.XLimits(1);
    ymin = apple.YLimits(1);
    zmin = apple.ZLimits(1);
    xmax = apple.XLimits(2);
    ymax = apple.YLimits(2);
    zmax = apple.ZLimits(2);


    cuboid = images.roi.Cuboid(gca, 'Position', [xmin, ymin, zmin, xmax-xmin, ymax-ymin, zmax-zmin]);
    cuboid.FaceAlpha = 0.3; % Küpün yüzeyine şeffaflık eklemek için
    cuboid.EdgeColor = 'b'; % Küpün kenar rengini kırmızı yapmak için
    
    %x = apple.Location;
    %plot3(x(:,1),x(:,2),x(:,3),'g.','MarkerSize',20)
    

end
