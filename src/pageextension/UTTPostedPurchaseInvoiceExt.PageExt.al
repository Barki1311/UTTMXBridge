pageextension 67070 UTTPostedPurchaseInvoiceExt extends "Posted Purchase Invoice"
{
    actions
    {
        modify(DeleteFiscalFolio)
        {
            Visible = false;
        }
        // Add changes to page actions here
        addlast(Processing)
        {
            group("UTT APP")
            {
                action(UTTDeleteFiscalFolio)
                {
                    Description = 'CE';
                    CaptionML = ENU = 'UTT Delete Fiscal Folio', ESM = 'UTT Eliminar folio fiscal';
                    Visible = true;
                    Image = DeleteXML;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        UTTLib: Codeunit UTTLib;
                    Begin
                        UTTLib.DeleteFiscalFolio(Rec);

                    End;
                }

            }
        }
    }
}
