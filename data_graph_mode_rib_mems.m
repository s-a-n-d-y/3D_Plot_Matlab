%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: /Users/Sandipan/Desktop/Test/Final.xlsx
%    Worksheet: mems-1
%
% To extend the code for use with different selected data or a different
% spreadsheet, generate a function instead of a script.

% Auto-generated by MATLAB on 2016/04/09 15:13:45

%% Import the data
[~, ~, raw1] = xlsread('/Users/Sandipan/Desktop/Test/Final.xlsx','mems-1-rib-slab');
raw1 = raw1(2:end,[1:2,end]);

[~, ~, raw2] = xlsread('/Users/Sandipan/Desktop/Test/Final.xlsx','mems-2-rib-slab');
raw2 = raw2(2:end,[1:2,end]);

[~, ~, raw3] = xlsread('/Users/Sandipan/Desktop/Test/Final.xlsx','mems-3-rib-slab');
raw3 = raw3(2:end,[1:2,end]);

[~, ~, raw4] = xlsread('/Users/Sandipan/Desktop/Test/Final.xlsx','mems-4-rib-slab');
raw4 = raw4(2:end,[1:2,end]);

%% Create output variable
data1 = reshape([raw1{:}],size(raw1));
data2 = reshape([raw2{:}],size(raw2));
data3 = reshape([raw3{:}],size(raw3));
data4 = reshape([raw4{:}],size(raw4));

%% Allocate imported array to column variable names
w_beam1 = data1(:,1);
w_mems1 = data1(:,2);
absreallog10rp1 = data1(:,3);

w_beam2 = data2(:,1);
w_mems2 = data2(:,2);
absreallog10rp2 = data2(:,3);

w_beam3 = data3(:,1);
w_mems3 = data3(:,2);
absreallog10rp3 = data3(:,3);

w_beam4 = data4(:,1);
w_mems4 = data4(:,2);
absreallog10rp4 = data4(:,3);

%% Calculations
%w_abs_mode12 = abs(absreallog10rp1) + abs(absreallog10rp2);
w_abs_mode12 = abs(absreallog10rp3) + abs(absreallog10rp4);

%% Draw graph
hold on

matrix = [w_beam1 w_mems1 w_abs_mode12];
tri = delaunay(matrix(:,1),matrix(:,2));
trisurf(tri,matrix(:,1),matrix(:,2),matrix(:,3))
shading faceted
%stem3(w_beam1,w_mems1,absreallog10rp1,'MarkerFaceColor','b')
%stem3(w_beam2,w_mems2,absreallog10rp2,'MarkerFaceColor','c')
%stem3(w_beam3,w_mems3,absreallog10rp3,'MarkerFaceColor','b')
%stem3(w_beam4,w_mems4,absreallog10rp4,'MarkerFaceColor','c')
hold off

%%Draw 3 max on graph
hold on
N = 3;
[sortedX, sortedInds] = sort(w_abs_mode12(:),'descend');
topN = sortedInds(1:N);
[i] = ind2sub(size(w_abs_mode12), topN);

%[~,i] = max(w_abs_mode12(:));

h = scatter3(w_beam1(i),w_mems1(i),w_abs_mode12(i),'filled', 'MarkerFaceColor','red');
h.SizeData = 100;

%text(w_beam1(i),w_mems1(i), w_abs_mode12(i),strcat('(',num2str(w_beam1(i)),num2str(w_mems1(i)),')'),'HorizontalAlignment','left', 'Color', 'red', 'FontSize', 12)
hold off

%% Labels
xlabel('Rib width in \mum', 'FontSize',18,'FontWeight','bold','Color','black')
ylabel('Slab width in \mum', 'FontSize',18,'FontWeight','bold','Color','black')

zlabel_eq = '$$\sum_{mode}{abs\left(log \frac{E_{x_{mode}}}{E_{y_{mode}}}\right)}$$';
zlabel(strcat('Log ratio of E-field = ', zlabel_eq), 'FontSize',22,'FontWeight','bold','Color','black','Interpreter','latex')


%% Clear temporary variables
clearvars data raw;