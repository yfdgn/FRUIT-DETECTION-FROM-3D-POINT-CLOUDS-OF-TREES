function iou = calculateIOU3D(bbox1, bbox2)
    % bbox1 ve bbox2 formatı: [xmin ymin zzmin xmax ymax zmax]

    % Bbox1 koordinatları
    x1 = bbox1(1);
    y1 = bbox1(2);
    z1 = bbox1(3);
    x1max = bbox1(4);
    y1max = bbox1(5);
    z1max = bbox1(6);

    % Bbox2 koordinatları
    x2 = bbox2(1);
    y2 = bbox2(2);
    z2 = bbox2(3);
    x2max = bbox2(4);
    y2max = bbox2(5);
    z2max = bbox2(6);

    % Bbox1'in koordinatlarına göre köşe noktalarını hesapla
    bbox1_top_left = [x1, y1, z1];
    bbox1_bottom_right = [x1max , y1max , z1max];
    
    % Bbox2'nin koordinatlarına göre köşe noktalarını hesapla
    bbox2_top_left = [x2, y2, z2];
    bbox2_bottom_right = [x2max, y2max , z2max];

    % Kesişim alanının köşe noktalarını hesapla
    intersection_top_left = max(bbox1_top_left, bbox2_top_left);
    intersection_bottom_right = min(bbox1_bottom_right, bbox2_bottom_right);

    % Kesişim alanının genişlik, yükseklik ve derinliğini hesapla
    intersection_width = intersection_bottom_right(1) - intersection_top_left(1);
    intersection_height = intersection_bottom_right(2) - intersection_top_left(2);
    intersection_depth = intersection_bottom_right(3) - intersection_top_left(3);

    % Kesişim alanının negatif değerleri kontrol et
    if intersection_width <= 0 || intersection_height <= 0 || intersection_depth <= 0
        iou = 0; % Kesişim alanı yok
        return;
    end

    % Kesişim alanını hesapla
    intersection_volume = intersection_width * intersection_height * intersection_depth;

    % Bbox1 ve bbox2 hacimlerini hesapla
    bbox1_volume = (x1max-x1) * (y1max-y1) * (z1max-z1);
    bbox2_volume = (x2max-x2) * (y2max-y2) * (z2max-z2);

    % Birleşim hacmini hesapla
    union_volume = bbox1_volume + bbox2_volume - intersection_volume;

    % IOU'yu hesapla
    iou = (intersection_volume / union_volume)*100;
end
