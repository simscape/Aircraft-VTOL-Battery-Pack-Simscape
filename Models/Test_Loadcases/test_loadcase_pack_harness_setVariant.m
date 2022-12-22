function test_loadcase_pack_harness_setVariant(mdl,variantName)

PackVnt = [];
switch (variantName)
    case('Lumped_BCs')
        PackVnt = 'Lumped_BCs';
    case('Lumped_Plate')
        PackVnt = 'Lumped_Plate';
    case('Edge_Plate')
        PackVnt = 'Edge_Plate';
    case('Edge_Detail_Plate')
        PackVnt = 'Edge_Detail_Plate';
end
        
if(~isempty(PackVnt))
    set_param([mdl '/Pack'],...
            'LabelModeActiveChoice',PackVnt)
end
