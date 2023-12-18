
% Clean and rebuild libraries
cd(curr_proj.RootFolder)
bdclose all
cd(['Workflow' filesep 'Pack_Builder'])
packLib_list = dir('+pack*');
for i = 1:length(packLib_list)
    libname = packLib_list(i).name;
    rmdir(libname,'s')
    rootName = [pwd filesep libname(2:end)];
    slxName = [rootName '.slx'];
    libName = [rootName '_lib.slx'];
    matName = [rootName '.mat'];
    parName = [rootName '_param.m'];
    if(exist(libName,'file'))
        delete(slxName)
        delete(libName)
        delete(matName)
        delete(parName)
    end
end

%%
createLib_list = dir('CreatePack*.m');
for i = 1:length(createLib_list)
    createLibname = createLib_list(i).name;
    run(createLibname)
end
close all
%%
