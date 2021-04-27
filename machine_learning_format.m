%Mengambil Dataset puncak
function [dataset] = machine_learning_format(cell_data,nilai_awal,label)
s = size(cell_data);
temp = [];
for i=1:1:s(1)
    display('Menjalankan For pertama');
    display(i);
    if i == 1
        display('nilai i adalah 1');
        for i2=nilai_awal:5:s(2)
            display('Menjalankan for kedua');
            display(i2);
            if i2 == nilai_awal
                display('nilai i2 adalah 1');
                a = cell_data{i,i2};
                a = transpose(a);
                b = size(a);
                jml_kolom = b(2)/10;

                j = 1
                for i3=1:1:jml_kolom
                    display('Menjalankan for ketiga');
                    temp(i3,:) = a(1,j:j+9);
                    j = j+10;
                end
                d = temp;
            else 
                display('nilai i2 lebih dari 1');
                a = cell_data{i,i2};
                a = transpose(a);
                b = size(a);
                jml_kolom = b(2)/10;

                j = 1
                for i3=1:1:jml_kolom
                    display('Menjalankan for ketiga');
                   temp(i3,:) = a(1,j:j+9);
                    j = j+10;
                end
                d = [d temp];
            end
        end
        e = d;
        
        
    else
        display('Nilai i for pertama lebih dari 1');
        for i2=nilai_awal:5:s(2)
            if i2 == nilai_awal
                a = cell_data{i,i2};
                a = transpose(a);
                b = size(a);
                jml_kolom = b(2)/10;

                j = 1
                for i3=1:1:jml_kolom
                   temp(i3,:) = a(1,j:j+9);
                    j = j+10;
                end
                d = temp;
            else 
                a = cell_data{i,i2};
                a = transpose(a);
                b = size(a);
                jml_kolom = b(2)/10;

                j = 1
                for i3=1:1:jml_kolom
                   temp(i3,:) = a(1,j:j+9);
                    j = j+10;
                end
                d = [d temp];
            end
        end
        e = [e;d]
    end
end      

dataset = e;
size_dataset = size(dataset);
dataset = dataset(all(dataset,2),:);
dataset(:,size_dataset(2)+1) = label;

end

