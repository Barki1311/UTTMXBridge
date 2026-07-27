report 67019 "UTT Piece Pedimento"
{
    ApplicationArea = All;
    Caption = 'UTT submaquila Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layout/UTTPiecePedimento.rdlc';
    dataset
    {



        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            RequestFilterFields = "Lot No.", "Posting Date", "Location Code", "Entry Type";

            column(CompanyName; COMPANYPROPERTY.DisplayName()) { }
            column(PageCaption; PageCaptionLbl) { }
            column(ReportName; ReportnameLbl) { }

            Column(TxtPedimentoLbl; TxtPedimentoLbl) { }
            column(TxtPostingDateLbl; TxtPostingDateLbl) { }
            column(TxtClaveLbl; TxtClaveLbl) { }
            column(TxtInvoiceLbl; TxtInvoiceLbl) { }
            column(TxtItemDescLbl; TxtItemDescLbl) { }
            column(TxtQtyImportedLbl; TxtQtyImportedLbl) { }
            column(TxtProcesoLbl; TxtProcesoLbl) { }
            column(TxtPieceNoLbl; TxtPieceNoLbl) { }
            column(TxtQtyShippedLbl; TxtQtyShippedLbl) { }
            column(TxtItemLbl; TxtItemLbl) { }

            column(PedimentoTxt; PedimentoTxt) { }
            column(PostingDate; OrigInputYarnRec."Posting Date") { }
            column(Clave; 'IN') { }
            column(OrigInputYarnRec_externalDocumentNo; OrigInputYarnRec."External Document No.") { }
            column(Hilodealtatenacidad; 'Hilo de alta tenacidad') { }
            column(OrigInputYarnRec_Quantity; OrigInputYarnRec.Quantity) { }
            column(Acabadotermofijado; 'Acabado termofijado') { }
            column(OutputRec_Lot_No; OutputRec."Lot No.") { }
            column(OutputRec_Quantity; OutputRec.Quantity) { }
            column(OutputRec_Item_No; OutputRec."Item No.") { }

            trigger OnPreDataItem()
            var
            begin
                //SetFilter("Entry Type", '%1|%2', "Entry Type"::Output, "Entry Type"::"Positive Adjmt.")

            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                OutputRec.get("Entry No.");
                printLine := FALSE;
                // CLEAR(PedimentoTxt);
                OutputRec.RESET();
                OutputRec.SETCURRENTKEY("Lot No.", Open, "Item No.");
                OutputRec.SETRANGE("Lot No.", "Lot No.");
                OutputRec.SETRANGE("Entry Type", OutputRec."Entry Type"::Output);
                IF OutputRec.FINDFIRST() THEN BEGIN
                    printLine := TRUE;
                    OutputAssignedPieceRec.RESET();
                    OutputAssignedPieceRec.SETCURRENTKEY("Lot No.", Open, "Item No.");
                    OutputAssignedPieceRec.SETRANGE("Lot No.", OutputRec."KVSTEX Assigned Piece No.");
                    OutputAssignedPieceRec.SETRANGE("Entry Type", OutputAssignedPieceRec."Entry Type"::Output);
                    IF OutputAssignedPieceRec.FINDFIRST() THEN BEGIN
                        UsedYarnRec.RESET();
                        UsedYarnRec.SETRANGE("Order No.", OutputAssignedPieceRec."Order No.");
                        UsedYarnRec.SETRANGE("Order Line No.", OutputAssignedPieceRec."Order Line No.");
                        UsedYarnRec.SETRANGE("Entry Type", UsedYarnRec."Entry Type"::Consumption);
                        IF UsedYarnRec.FINDFIRST() THEN BEGIN
                            OrigInputYarnRec.RESET();
                            OrigInputYarnRec.SETCURRENTKEY("Lot No.", Open, "Item No.");
                            OrigInputYarnRec.SETRANGE("Lot No.", UsedYarnRec."Lot No.");
                            OrigInputYarnRec.SETRANGE("Entry Type", OrigInputYarnRec."Entry Type"::Purchase);
                            OrigInputYarnRec.SETRANGE("Item No.", UsedYarnRec."Item No.");
                            IF OrigInputYarnRec.FINDFIRST() THEN BEGIN

                                PedimentoTxt := OrigInputYarnRec."KVSM Pedimento No.";
                                IF PedimentoTxt = '' THEN BEGIN
                                    ValueEntry.RESET();
                                    ValueEntry.SETRANGE("Document Type", ValueEntry."Document Type"::"Purchase Invoice");
                                    ValueEntry.SETRANGE("Item Ledger Entry No.", OrigInputYarnRec."Entry No.");
                                    IF ValueEntry.FINDFIRST() THEN
                                        IF PurchInvLine.GET(ValueEntry."Document No.", ValueEntry."Document Line No.") THEN;
                                    PedimentoTxt := PurchInvLine."KVSM Pedimento No.";


                                END;
                            END;

                        END;

                    END;

                END;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        printLine: Boolean;
        PedimentoTxt: Text;
        OutputRec: Record "Item Ledger Entry";
        OutputAssignedPieceRec: Record "Item Ledger Entry";
        UsedYarnRec: Record "Item Ledger Entry";
        OrigInputYarnRec: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        PurchInvLine: Record "Purch. Inv. Line";
        TxtClave: Text;
        TxtPedimentoLbl: Label 'Pedimento';
        TxtPostingDateLbl: Label 'Posting Date';
        TxtClaveLbl: Label 'Key';
        TxtInvoiceLbl: Label 'Shipment No.';
        TxtItemDescLbl: Label 'Item Description';
        TxtQtyImportedLbl: Label 'Qty imported';
        TxtProcesoLbl: Label 'Process ';
        TxtPieceNoLbl: Label 'Piece No.';
        TxtQtyShippedLbl: Label 'Qty shipped';
        TxtItemLbl: Label 'Item No.';
        PageCaptionLbl: Label 'Page', Comment = 'DEU=Seite; DEA=Seite';
        ReportnameLbl: Label 'Submaquila Report';
}
