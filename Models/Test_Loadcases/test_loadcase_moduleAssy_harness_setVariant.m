function test_loadcase_moduleAssy_harness_setVariant(mdl,variantName)

ModuleVnt = [];
switch (variantName)
    case('Lumped BCs')
        ModuleVnt = 'Lumped';
        PlateVnt = 'Lumped_BCs';
    case('Lumped Plate')
        ModuleVnt = 'Lumped';
        PlateVnt = 'Lumped_Plate';
    case('Edge')
        ModuleVnt = 'Edge';
        PlateVnt = 'Edge_Plate';
    case('Edge_Detail')
        ModuleVnt = 'Edge_Detail';
        PlateVnt = 'Edge_Detail_Plate';
    case('Detailled')
        ModuleVnt = 'Detailled';
        PlateVnt = 'Detailled_Plate';
end
        
if(~isempty(ModuleVnt))
    set_param([mdl '/ModuleAssembly1'],...
            'LabelModeActiveChoice',ModuleVnt)
    set_param([mdl '/Cooling Plate'],...
            'LabelModeActiveChoice',PlateVnt)
end
