function varargout = spectacles_lpp_classification(varargin)
% SPECTACLES_LPP_CLASSIFICATION MATLAB code for spectacles_lpp_classification.fig
%      SPECTACLES_LPP_CLASSIFICATION, by itself, creates a new SPECTACLES_LPP_CLASSIFICATION or raises the existing
%      singleton*.
%
%      H = SPECTACLES_LPP_CLASSIFICATION returns the handle to a new SPECTACLES_LPP_CLASSIFICATION or the handle to
%      the existing singleton*.
%
%      SPECTACLES_LPP_CLASSIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPECTACLES_LPP_CLASSIFICATION.M with the given input arguments.
%
%      SPECTACLES_LPP_CLASSIFICATION('Property','Value',...) creates a new SPECTACLES_LPP_CLASSIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before spectacles_lpp_classification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to spectacles_lpp_classification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help spectacles_lpp_classification

% Last Modified by GUIDE v2.5 25-Nov-2011 21:40:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @spectacles_lpp_classification_OpeningFcn, ...
                   'gui_OutputFcn',  @spectacles_lpp_classification_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before spectacles_lpp_classification is made visible.
function spectacles_lpp_classification_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to spectacles_lpp_classification (see VARARGIN)

% Choose default command line output for spectacles_lpp_classification
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes spectacles_lpp_classification wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = spectacles_lpp_classification_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lstPositive.
function lstPositive_Callback(hObject, eventdata, handles)
% hObject    handle to lstPositive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lstPositive contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstPositive
displayCurrentItem(hObject,handles)

% --- Executes during object creation, after setting all properties.
function lstPositive_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstPositive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function decision = getDecision(current_image)
global projected_data Positive_mean sgn;

for i = 1:length(current_image)
    decision(i) = (sgn(Positive_mean(1),Positive_mean(2))* ...
        sgn(projected_data(current_image(i),1),projected_data( ...
        current_image(i),2))>0);
end

function displayCurrentItem(hObject,handles)
global dat_a_ height width projected_data;

contents = cellstr(get(hObject,'String'));
current_image = str2double(contents{get(hObject,'Value')});
datalet = dat_a_(current_image,1:end-1);
img = uint8(reshape(datalet,height,width));
imshow(img,'Parent',handles.plotArea2);

if (~isempty(projected_data))
    h = get(handles.plotArea1,'Children');
    allAvailableTypes = get(h,'type');
    [tf,loc]=ismember('text',allAvailableTypes);
    if(~tf)
        text(projected_data(current_image,1), ...
            projected_data(current_image,2), num2str(current_image), ...
            'Parent',handles.plotArea1,'FontWeight','bold');
    else
        set(h(loc),'Position',[projected_data(current_image,1), ...
            projected_data(current_image,2)],'String', ...
            num2str(current_image));
    end
    
    if(getDecision(current_image))
        set(handles.result,'String','With Spectacles');
    else
        set(handles.result,'String','Without Spectacles');
    end
end

% --- Executes on selection change in lstTest.
function lstTest_Callback(hObject, eventdata, handles)
% hObject    handle to lstTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lstTest contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstTest
displayCurrentItem(hObject,handles)


% --- Executes during object creation, after setting all properties.
function lstTest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dat_a_ Name_Database height width projected_data;

dat_a_=[];
Name_Database=[];
height=[];
width=[];
projected_data=[];

% Loading the database file
filename = uigetfile('*.mat', 'Select database file');
load(filename);
dat_a_ = data;

%Check if it is loaded correctly
if exist('Database_name','var')
    Name_Database = Database_name;
    
    % Get the number of elements loaded
    m = size(dat_a_,1);
    pos_count = sum(dat_a_(:,end));
    neg_count = m - pos_count;
    
    % Show a notification of how many elements are loaded
    set(handles.txtloadPrompt,'String',sprintf('%d items loaded',m));
    
    % Calculating amount of training data
    % The rule of selection: See whether the positive or the
    % negative samples are fewer in amount. Take half of the data from the
    % fewer class and an equal number of data from the other class. So,
    % the total number of training data = 2 * (1/2) * min(amount of data in
    % class with sunglass, amount of data in class without sunglass)
    training_size = min(pos_count,neg_count);
    test_size = m - training_size;
    set(handles.txtSizeTraining,'String',num2str(training_size));
    set(handles.txtSizeTesting,'String',num2str(test_size));
else
    msgbox('The database could not be loaded');
    
end




function txtSizeTraining_Callback(hObject, eventdata, handles)
% hObject    handle to txtSizeTraining (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSizeTraining as text
%        str2double(get(hObject,'String')) returns contents of txtSizeTraining as a double
global dat_a_;
m = size(dat_a_,1);
m_n = str2double(get(hObject, 'String'));
set(handles.txtSizeTesting,'String',m - m_n);


% --- Executes during object creation, after setting all properties.
function txtSizeTraining_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSizeTraining (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtSizeTesting_Callback(hObject, eventdata, handles)
% hObject    handle to txtSizeTesting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSizeTesting as text
%        str2double(get(hObject,'String')) returns contents of txtSizeTesting as a double


% --- Executes during object creation, after setting all properties.
function txtSizeTesting_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSizeTesting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lstNegative.
function lstNegative_Callback(hObject, eventdata, handles)
% hObject    handle to lstNegative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lstNegative contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstNegative
displayCurrentItem(hObject,handles)


% --- Executes during object creation, after setting all properties.
function lstNegative_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstNegative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% This function will return a set of unique integer uniform random numbers
% within the interval 1:rangeEnd. Number of elements of the set is
% determined by NumberofItems. It will return -1 if NumberofItems>rangeEnd
% Donot pass anything into the third component. it is for internal use.
function z = UniqueIntRand(rangeEnd,NumberofItems,z1)
z=[];
NumberofItems = floor(NumberofItems);
if exist('z1','var') 
    z=z1;
end
if(rangeEnd<NumberofItems)
    z = -1;
    return;
end

z = unique(union(z,randi(rangeEnd,1,NumberofItems-length(z))));
if(length(z)>=NumberofItems)
    return;
else
    z = UniqueIntRand(rangeEnd,NumberofItems,z);
end
    

% --- Executes on button press in btnSelectData.
function btnSelectData_Callback(hObject, eventdata, handles)
% hObject    handle to btnSelectData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dat_a_;

% Reading the number of training and test data
training_size = str2double(get(handles.txtSizeTraining,'String'));
test_size = str2double(get(handles.txtSizeTesting,'String'));
total = training_size+test_size;

% Find positive and negative classes
pos_class_indeces = find(dat_a_(:,end)==1);
neg_class_indeces = find(dat_a_(:,end)==0);

% Randomly get half of the training samples from the positive class
positive_training_samples = pos_class_indeces(UniqueIntRand(length( ...
    pos_class_indeces),training_size/2));

% Randomly get half of the training samples from the negative class
negative_training_samples = neg_class_indeces(UniqueIntRand(length( ...
    neg_class_indeces),training_size/2));

% All the rest are testing samples
test_samples = setdiff(1:total, union(positive_training_samples, ...
    negative_training_samples));

% Loading the training and test samples into appropriate listboxes
set(handles.lstPositive,'String',num2cell(sort(positive_training_samples)));
set(handles.lstNegative,'String',num2cell(sort(negative_training_samples)));
set(handles.lstTest,'String',num2cell(sort(test_samples)));


% --- Executes on button press in btnBuild.
function btnBuild_Callback(hObject, eventdata, handles)
% hObject    handle to btnBuild (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dat_a_ eigvec eigval projected_data Positive_mean Negative_mean ...
    height width sgn;
Positive_idx = str2num(char(get(handles.lstPositive,'String')));
Negative_idx = str2num(char(get(handles.lstNegative,'String')));
training_idx = union(Positive_idx,Negative_idx);

% Getting the training Data and Labels
TrainingData = dat_a_(training_idx,1:end-1);
TrainingLabel = dat_a_(training_idx,end);

% Building the adjacency matrix based on the state of the checkbox
sup_chk_state = get(handles.chkSupOnly,'Value');
hk_chk_state = get(handles.chkHK,'Value');

if((sup_chk_state==1) && (hk_chk_state==0))
    % Constructing the adjacency Matrix based on human perception
    options = [];
    options.Metric = 'Euclidean';
    options.NeighborMode = 'Supervised';
    options.gnd = TrainingLabel+1;
    options.bLDA = 0;
    W = constructW(TrainingData,options);
    options.PCARatio = 0.99;
elseif ((sup_chk_state==0) && (hk_chk_state==1))
    % Constructing the adjacency Matrix based heat kernel weighting
    options = [];
    options.Metric = 'Euclidean';
    %options.NeighborMode = 'Supervised';
    options.NeighborMode = 'knn';
    %options.gnd = TrainingLabel+1;
    options.k = 10;
    options.WeightMode = 'HeatKernel';
    options.t = 1e4;
    W = constructW(TrainingData,options);
    options.PCARatio = 0.99;
    
else 
    % Constructing the adjacency Matrix based heat kernel weighting
    % and supervised weighting
    options = [];
    options.Metric = 'Euclidean';
    options.NeighborMode = 'Supervised';
    %options.NeighborMode = 'knn';
    options.gnd = TrainingLabel+1;
    %options.k = 10;
    options.WeightMode = 'HeatKernel';
    options.t = 1e4;
    W = constructW(TrainingData,options);
    options.PCARatio = 0.99;    
end

% Applying the Locality Preserving Projection
[eigvec,eigval] = LPP(W,[],TrainingData);

% Displaying the Eigenvectors if the checkbox is on
if (get(handles.showEigen,'Value')==1)
    img1 = (reshape(eigvec(:,1),height,width));
    img2 = (reshape(eigvec(:,2),height,width));
    img1 = (log(img1)-min(min(log(img1))))/max(max(log(img1)));
    img2 = (log(img2)-min(min(log(img2))))/max(max(log(img2)));
    figure;
    subplot(121);imshow(img1);title('Eigenvector 1');
    subplot(122);imshow(img2);title('Eigenvector 2');
end
% Projecting the data in 2D LPP space
projected_data =  (dat_a_(:,1:end-1)*eigvec(:,1:2));

%Plotting the positive samples in blue and negative samples in red
posin = find(dat_a_(:,end)==1);
negin = find(dat_a_(:,end)==0);
scatter(handles.plotArea1,projected_data(posin,1), ...
    projected_data(posin,2),'b.');
hold(handles.plotArea1,'on');
scatter(handles.plotArea1,projected_data(negin,1), ...
    projected_data(negin,2),'r.');
hold(handles.plotArea1,'off');
xlabel(handles.plotArea1,'Projection on Primary Eigenvector')
ylabel(handles.plotArea1,'Projection on Secondary Eigenvector')
legend(handles.plotArea1,'Positive','Negative');
title(handles.plotArea1, 'Projection Map');

% Building the Maximum Marzin Classifier 

Positive_mean = mean(projected_data(Positive_idx,:));
Negative_mean = mean(projected_data(Negative_idx,:));
midpoint = (Positive_mean + Negative_mean)/2;


x1 = Positive_mean(1); y1 = Positive_mean(2);
x2 = Negative_mean(1); y2 = Negative_mean(2);
x3 = midpoint(1); y3 = midpoint(2);

% Equation of the decision boundary
sgn = @(x,y) (y2-y1)/(x1-x2)*(y + y3) + x3 - x;

% Drawing the decision boundary
chkSup_state = (get(handles.chkSupOnly,'Value'));
chkHK_state = (get(handles.chkHK,'Value'));

if(chkSup_state==1 && chkHK_state==0)
    y_max = max(projected_data(:,2)); y_min = min(projected_data(:,2));
    line('X',[sgn(0,y_min),sgn(0,y_max)],'Y', ...
        [y_min,y_max],'Parent',handles.plotArea1);
end

% Getting actual data label for calculating accuracy
label = logical(dat_a_(:,end));

% Getting classifier decision for calculating accuracy
decision = getDecision(1:size(dat_a_,1))';

% Calculating Accuracy and display
if(chkSup_state==1 && chkHK_state==0)
    accur = sum(double(~xor(label,decision)))/size(dat_a_,1) * 100;
    set(handles.Accur, 'String', num2str(accur));
else
    set(handles.Accur, 'String', '');
end


% --- Executes on button press in chkSupOnly.
function chkSupOnly_Callback(hObject, eventdata, handles)
% hObject    handle to chkSupOnly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkSupOnly


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over txtSizeTraining.
function txtSizeTraining_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to txtSizeTraining (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over txtSizeTesting.
function txtSizeTesting_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to txtSizeTesting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
clear global;


% --- Executes on button press in showEigen.
function showEigen_Callback(hObject, eventdata, handles)
% hObject    handle to showEigen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showEigen


% --- Executes on button press in chkHK.
function chkHK_Callback(hObject, eventdata, handles)
% hObject    handle to chkHK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkHK
