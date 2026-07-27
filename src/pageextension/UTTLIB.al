codeunit 67016 UTTLib

{
    permissions = tabledata "Purch. Inv. Header" = RM,
    tabledata "Purch. Cr. Memo Hdr." = RM,
    tabledata "Detailed Vendor Ledg. Entry" = RM,
    tabledata "VAT Entry" = RM,
    tabledata "G/L Entry" = RM;

    trigger OnRun()
    begin

    end;

    procedure IsUserHasPermission(RoleID: Code[50]): Boolean
    var
        AccessControl: Record "Access Control";
        LblUsermissingPerm: Label 'you are not allowed to run this function, please ask your admion for more details';
    begin

        AccessControl.Reset();
        AccessControl.SetRange("User Security ID", UserSecurityId());
        AccessControl.SetRange("Role ID", RoleID);
        AccessControl.SetFilter("Company Name", '%1|%2', '', CompanyName);
        if AccessControl.FindFirst() then
            exit(true)
        else
            error(LblUsermissingPerm);


    end;

    procedure DeleteFiscalFolio(var purchInvHeader: Record "Purch. Inv. Header")
    var

        vendLedgerEntry: Record "Vendor Ledger Entry";
        DetailVendLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        VatEntry: Record "VAT Entry";
        GLEntry: Record "G/L Entry";
        ConfirmDeleteUUId: Label 'this will delete the Fiscal folio from all of related data, are you sure to proceed ?';
        MsgUUIDisdeleted: Label 'the Fiscal folio is successfully deleted';
        SalesSetup: Record "Sales & Receivables Setup";
        PurchCreditMemo: Record "Purch. Cr. Memo Hdr.";
        OldUUID: Text;



    begin
        if not Confirm(ConfirmDeleteUUId, false, false) then
            exit;
        SalesSetup.get();
        SalesSetup.TestField(UTTDeleteFolio);

        if IsUserHasPermission(SalesSetup.UTTDeleteFolio) then begin
            IF purchInvHeader."Fiscal Invoice Number Pac" <> '' THEN BEGIN
                OldUUID := purchInvHeader."Fiscal Invoice Number PAC";
                purchInvHeader."Fiscal Invoice Number Pac" := '';
                purchInvHeader.MODIFY();


                vendLedgerEntry.Reset();
                vendLedgerEntry.SetRange("Document No.", purchInvHeader."No.");
                vendLedgerEntry.ModifyAll("Fiscal Invoice Number PAC", '');

                DetailVendLedgerEntry.Reset();
                DetailVendLedgerEntry.SetRange("Document No.", purchInvHeader."No.");
                DetailVendLedgerEntry.ModifyAll("Fiscal Invoice Number PAC", '');

                VatEntry.Reset();
                VatEntry.SetRange("Document No.", purchInvHeader."No.");
                VatEntry.ModifyAll("Fiscal Invoice Number PAC", '');

                GLEntry.Reset();
                GLEntry.SetRange("Document No.", purchInvHeader."No.");
                GLEntry.ModifyAll("Fiscal Invoice Number PAC", '');
            end;

            PurchCreditMemo.Reset();
            PurchCreditMemo.SetRange("Fiscal Invoice Number PAC", OldUUID);
            if PurchCreditMemo.FindFirst() then begin
                PurchCreditMemo."Fiscal Invoice Number PAC" := '';
                PurchCreditMemo.Modify();



                vendLedgerEntry.Reset();
                vendLedgerEntry.SetRange("Document No.", PurchCreditMemo."No.");
                vendLedgerEntry.ModifyAll("Fiscal Invoice Number PAC", '');

                DetailVendLedgerEntry.Reset();
                DetailVendLedgerEntry.SetRange("Document No.", PurchCreditMemo."No.");
                DetailVendLedgerEntry.ModifyAll("Fiscal Invoice Number PAC", '');

                VatEntry.Reset();
                VatEntry.SetRange("Document No.", PurchCreditMemo."No.");
                VatEntry.ModifyAll("Fiscal Invoice Number PAC", '');

                GLEntry.Reset();
                GLEntry.SetRange("Document No.", PurchCreditMemo."No.");
                GLEntry.ModifyAll("Fiscal Invoice Number PAC", '');
            end;





            Message(MsgUUIDisdeleted);



        end;

    end;



    var
        myInt: Integer;
}