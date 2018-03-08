function [ struct, test, table ] = patientsData(patientfileNEW, adminfile, diagfile)
%makes a single structure containing patients data

%patient file to cell
patientfh = fopen(patientfileNEW);
line = fgetl(patientfh);
while ischar(line)
    [id, rest] = strtok(line);
    id = id(id ~= '-');
    id = ['P' id];% TO ENSURE AN ACTUAL FIELD NAME
    [gender, rest] = strtok(rest);
    [dob, rest] = strtok(rest);
    [race, rest] = strtok(rest);
    [married, rest] = strtok(rest);
    [language, rest] = strtok(rest);
    [password, ~] = strtok(rest);
    
    struct.(id).General.Gender = gender;
    struct.(id).General.DOB = dob;
    struct.(id).General.Race = race;
    struct.(id).General.MaritalStatus = married;
    struct.(id).General.Language = language;
    struct.(id).Password = password;
    
    line = fgetl(patientfh);
end
fclose(patientfh);
%admin file to cell
adminfh = fopen(adminfile);
line = fgetl(adminfh);
line = fgetl(adminfh);
while ischar(line)
    [id, rest] = strtok(line);
    id = id(id ~= '-');
    id = ['P' id];
    [adminID, rest] = strtok(rest);
    adminID = ['Visit' adminID];% TO ENSURE VALID FIELD NAME
    [start1, rest] = strtok(rest);
    [start2, rest] = strtok(rest);
    [last, rest] = strtok(rest);
    last = [last rest];
    start = [start1 ' ' start2];
    
    struct.(id).Administration.(adminID).StartDate = start;
    struct.(id).Administration.(adminID).EndDate = last;
    line = fgetl(adminfh);
end
fclose(adminfh);
%diagnosis file to cell
diagfh = fopen(diagfile);
line = fgetl(diagfh);
line = fgetl(diagfh);
while ischar(line)
    [id, rest] = strtok(line);
    id = id(id ~= '-');
    id = ['P' id];
    [adminID, rest] = strtok(rest);
    adminID = ['Visit' adminID];
    [code, rest] = strtok(rest);
    [descrip, rest] = strtok(rest);
    descrip = [descrip rest];
    descrip(descrip == '/') = '\';
    
    struct.(id).Administration.(adminID).PrimaryDiagnosisCode = code;
    struct.(id).Administration.(adminID).PrimaryDiagnosisDescription = descrip;    
    line = fgetl(diagfh);
end
fclose(diagfh);

test = jsonencode(struct);
table = struct2table(struct);

end

