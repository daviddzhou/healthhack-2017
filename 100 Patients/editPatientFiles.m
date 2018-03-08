function editPatientFiles( patientfile )
%takes in original file format and removes the time stamp and the
%population below poverty data for the new textfile called the original
%patient file with 'NEW.txt.'
%   Detailed explanation goes here

fh_old = fopen(patientfile);
fh_new = fopen([patientfile(1:end-4) 'NEW.txt'], 'w');
line = fgetl(fh_old);
line = fgetl(fh_old);
while ischar(line)
    [id, rest] = strtok(line);
    [gender, rest] = strtok(rest);
    [dob, rest] = strtok(rest); 
    [~, rest] = strtok(rest);%removing data
    [race, rest] = strtok(rest);
    [married, rest] = strtok(rest);
    [language, ~] = strtok(rest);
    password = createPassword();
    fprintf(fh_new, [id ' ' gender ' ' dob ' ' race ' ' married ' ' language ' ' password '\n']);
    
    line = fgetl(fh_old);
end

fclose(fh_old);
fclose(fh_new);

end

