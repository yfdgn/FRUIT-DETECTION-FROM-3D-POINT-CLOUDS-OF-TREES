
gt_apple_number = size(clusters_Limits);
gt_apple_number = gt_apple_number(1);

algo_apple_number = size(clusters_XYZ_Limits);
algo_apple_number = algo_apple_number(1);

TP = 0; % elma tespit ettim ve elma çıktı
FP = 0; % elma tespit ettim ama elma çıkmadı

indices_TP=[];
indices_FP=[];
templist_true = 1;
templist_neg = 0;

indice_exact_True = []
indice_exact_False = []

indice_founded_apples_inOurAlgo = []

for  i = 1 : gt_apple_number
    a= [];
    
    gt_Xmin = clusters_Limits(i,1);
    gt_Xmax = clusters_Limits(i,2);
    gt_Ymin = clusters_Limits(i,3);
    gt_Ymax = clusters_Limits(i,4);
    gt_Zmin = clusters_Limits(i,5);
    gt_Zmax = clusters_Limits(i,6);
    
    for j = 1 : algo_apple_number
        
        algo_Xmin = clusters_XYZ_Limits(j,1);
        algo_Xmax = clusters_XYZ_Limits(j,2);
        algo_Ymin = clusters_XYZ_Limits(j,3);
        algo_Ymax = clusters_XYZ_Limits(j,4);
        algo_Zmin = clusters_XYZ_Limits(j,5);
        algo_Zmax = clusters_XYZ_Limits(j,6);
        
        iou = calculateIOU3D([algo_Xmin,algo_Ymin,algo_Zmin,algo_Xmax,algo_Ymax,algo_Zmax], [gt_Xmin,gt_Ymin,gt_Zmin,gt_Xmax,gt_Ymax,gt_Zmax]);      
        list = [iou];
        a = [a;list];
                
    end
 
    if max(a)>0
        
        fprintf('apple %d- iout = %f\n',i,max(a))
        indices_TP = [indices_TP,templist_true];
        indices_FP = [indices_FP,templist_neg];
        %fprintf('GT_apple_%d: cluster:%d \n\n',i,find(a == max(a)))
        indice_exact_True = [indice_exact_True,i];
        
        indice_founded_apples_inOurAlgo =[indice_founded_apples_inOurAlgo,find(a == max(a))];
        
    elseif max(a)==0
        indices_TP = [indices_TP,templist_neg];
        indices_FP = [indices_FP,templist_true];
       % fprintf('GT_apple_%d: apple not found in algo\n\n',i)
        indice_exact_False = [indice_exact_False,i];
    end
    
    
end

for i = 1 : gt_apple_number
    if indices_TP(i)==1
        TP = TP+1;
    else
        FP = FP+1;
    end
end

figureNeww = figure
pcshow(yedek_remove_tree)

indice_exact_True;
indice_exact_False;

FN = algo_apple_number - TP
Precision = TP/ gt_apple_number*100
Recall = TP / algo_apple_number*100


for k = 1: length(indice_exact_True)
    
    title_str = sprintf('Precision:%.2f, Recall:%.2f, Algo apple:%d GT Apple:%d , TP:%d , FP:%d, FN:%d',Precision,Recall,algo_apple_number, gt_apple_number,TP,FP,FN);
    title(title_str)
    figure(figureNeww)
    xmin = clusters_Limits(indice_exact_True(k),1);
    ymin = clusters_Limits(indice_exact_True(k),3);
    zmin = clusters_Limits(indice_exact_True(k),5);
    xmax = clusters_Limits(indice_exact_True(k),2);
    ymax = clusters_Limits(indice_exact_True(k),4);
    zmax = clusters_Limits(indice_exact_True(k),6);

    cuboid = images.roi.Cuboid(gca, 'Position', [xmin, ymin, zmin, xmax-xmin, ymax-ymin, zmax-zmin]);
    cuboid.FaceAlpha = 0.3; % Küpün yüzeyine şeffaflık eklemek için
    cuboid.EdgeColor = 'g'; % Küpün kenar rengini yeşil yapmak için
end



for k = 1: length(indice_founded_apples_inOurAlgo)
    
    title_str = sprintf('Precision:%.2f, Recall:%.2f, Algo apple:%d GT Apple:%d , TP:%d , FP:%d, FN:%d',Precision,Recall,algo_apple_number, gt_apple_number,TP,FP,FN);
    title(title_str)
    figure(figureNeww)
    xmin = clusters_XYZ_Limits(indice_founded_apples_inOurAlgo(k),1);
    ymin = clusters_XYZ_Limits(indice_founded_apples_inOurAlgo(k),3);
    zmin = clusters_XYZ_Limits(indice_founded_apples_inOurAlgo(k),5);
    xmax = clusters_XYZ_Limits(indice_founded_apples_inOurAlgo(k),2);
    ymax = clusters_XYZ_Limits(indice_founded_apples_inOurAlgo(k),4);
    zmax = clusters_XYZ_Limits(indice_founded_apples_inOurAlgo(k),6);

    cuboid = images.roi.Cuboid(gca, 'Position', [xmin, ymin, zmin, xmax-xmin, ymax-ymin, zmax-zmin]);
    cuboid.FaceAlpha = 0.3; % Küpün yüzeyine şeffaflık eklemek için
    cuboid.EdgeColor = 'b'; % Küpün kenar rengini mavi yapmak için
end

for k = 1: length(indice_exact_False)
    
    title_str = sprintf('Precision:%.2f, Recall:%.2f, Algo apple:%d GT Apple:%d , TP:%d , FP:%d, FN:%d',Precision,Recall,algo_apple_number, gt_apple_number,TP,FP,FN);
    title(title_str)
    figure(figureNeww)
    xmin = clusters_Limits(indice_exact_False(k),1);
    ymin = clusters_Limits(indice_exact_False(k),3);
    zmin = clusters_Limits(indice_exact_False(k),5);
    xmax = clusters_Limits(indice_exact_False(k),2);
    ymax = clusters_Limits(indice_exact_False(k),4);
    zmax = clusters_Limits(indice_exact_False(k),6);

    cuboid = images.roi.Cuboid(gca, 'Position', [xmin, ymin, zmin, xmax-xmin, ymax-ymin, zmax-zmin]);
    cuboid.FaceAlpha = 0.3; % Küpün yüzeyine şeffaflık eklemek için
    cuboid.EdgeColor = 'r'; % Küpün kenar rengini kırmızı yapmak için
end


