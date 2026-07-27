codeunit 67017 "UTTMXBridgeUpgrade"
{

    Subtype = Install;
    trigger OnInstallAppPerCompany()
    var
        myAppInfo: ModuleInfo;
    begin

        // Get info about the currently executing module
        NavApp.GetCurrentModuleInfo(myAppInfo);

        // A 'DataVersion' of 0.0.0.0 indicates a 'fresh/new' install
        if myAppInfo.DataVersion = Version.Create(0, 0, 0, 0) then
            HandleFreshInstall
        else
            // If not a fresh install, then we are Re-installing the same version of the extension
            HandleReinstall;
    end;

    local procedure HandleFreshInstall()
    begin
        // Do work needed the first time this extension is ever installed for this tenant.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was installed
        // - Initial data setup for use
    end;

    local procedure HandleReinstall()
    begin
        // Do work needed when reinstalling the same version of this extension back on this tenant.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was reinstalled
        // - Data 'patchup' work, for example, detecting if new 'base' records have been
        //   changed while you have been working 'offline'.
        // - Setup 'welcome back' messaging for next user access. 
        InstallUpgradeMgt.CreatePermission('UTTDELETEUUID');
        InstallUpgradeMgt.AddSalesStpPermissionID('UTTDELETEUUID');







    end;


    var
        InstallUpgradeMgt: Codeunit UTTMXBridgeInstallUpgradeMgt;
}