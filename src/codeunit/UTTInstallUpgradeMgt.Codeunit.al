codeunit 67015 "UTTMXBridgeInstallUpgradeMgt"
{

    trigger OnRun()
    begin

    end;

    internal procedure CreatePermission(PermissionRoleID: Code[20])
    var
        Permission: Record "tenant Permission";
        PermissionSetRec: Record "tenant Permission Set";
        ModulInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(ModulInfo);
        // Permission.SetRange("App ID", ModulInfo.Id());
        // Permission.SetRange("Role ID", PermissionRoleID);
        // Permission.DeleteAll();

        // Permission.init();
        // Permission."App ID" := ModulInfo.Id();
        // Permission."Role ID" := PermissionRoleID;
        // Permission."Role Name" := PermissionRoleID;
        // Permission.Insert;

        if PermissionSetRec.get(ModulInfo.Id(), PermissionRoleID) then
            PermissionSetRec.DeleteAll();

        PermissionSetRec.Init();
        PermissionSetRec."App ID" := ModulInfo.Id();
        PermissionSetRec."Role ID" := PermissionRoleID;

        PermissionSetRec.Insert();
    end;

    procedure AddSalesStpPermissionID(PermissionRoleID: Code[20])
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.get();
        SalesSetup.UTTDeleteFolio := PermissionRoleID;
        SalesSetup.Modify();

    end;


    var

        blankGUID: Guid;


}