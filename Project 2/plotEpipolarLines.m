function plotEpipolarLines(F, im1, im2, pts1, pts2)
    % Plot epipolar lines for given fundamental matrix F and point correspondences
    
    % Display image 1 with points and plot epipolar lines in image 2
    figure(1); imagesc(im1); axis image; hold on;
    x1 = pts1(:, 1);
    y1 = pts1(:, 2);
    plot(x1, y1, 'g*');
    hold off;
    
    % Overlay epipolar lines on image 2 for points in image 1
    colors = 'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';
    % Correct the computation of L to ensure it has the proper 3xN dimensions
L = F * [x1'; y1'; ones(1, length(x1))];  % Ensure [x1'; y1'; ones(1, length(x1))] is 3xN
    [nr, nc, ~] = size(im2);
    figure(2); clf; imagesc(im2); axis image;
    hold on; plot(pts2(:,1), pts2(:,2), '*'); hold off
    for i = 1:length(L)
        a = L(1, i); b = L(2, i); c = L(3, i);
        if abs(a) > abs(b)
            ylo = 0; yhi = nr; 
            xlo = (-b * ylo - c) / a;
            xhi = (-b * yhi - c) / a;
            hold on;
            h = plot([xlo; xhi], [ylo; yhi]);
            set(h, 'Color', colors(i), 'LineWidth', 2);
            hold off;
            drawnow;
        else
            xlo = 0; xhi = nc; 
            ylo = (-a * xlo - c) / b;
            yhi = (-a * xhi - c) / b;
            hold on;
            h = plot([xlo; xhi], [ylo; yhi]);
            set(h, 'Color', colors(i), 'LineWidth', 2);
            hold off;
            drawnow;
        end
    end

    % Display image 2 with points and plot epipolar lines in image 1
    figure(2); imagesc(im2); axis image; hold on;
    x2 = pts2(:, 1);
    y2 = pts2(:, 2);
    plot(x2, y2, 'g*');
    hold off;

    % Overlay epipolar lines on image 1 for points in image 2
    % Correct the computation of L to ensure it has the proper 3xN dimensions
L = F * [x2'; y2'; ones(1, length(x2))];  % Ensure [x1'; y1'; ones(1, length(x1))] is 3xN
    disp(size(L));  % This should output [3, N] where N is the number of points
    [nr, nc, ~] = size(im1);
    figure(1); clf; imagesc(im1); axis image;
    hold on; plot(pts1(:,1), pts1(:,2), '*'); hold off
    for i = 1:length(L)
        a = L(1, i); b = L(2, i); c = L(3, i);
        if abs(a) > abs(b)
            ylo = 0; yhi = nr; 
            xlo = (-b * ylo - c) / a;
            xhi = (-b * yhi - c) / a;
            hold on;
            h = plot([xlo; xhi], [ylo; yhi]);
            set(h, 'Color', colors(i), 'LineWidth', 2);
            hold off;
            drawnow;
        else
            xlo = 0; xhi = nc; 
            ylo = (-a * xlo - c) / b;
            yhi = (-a * xhi - c) / b;
            hold on;
            h = plot([xlo; xhi], [ylo; yhi]);
            set(h, 'Color', colors(i), 'LineWidth', 2);
            hold off;
            drawnow;
        end
    end
end