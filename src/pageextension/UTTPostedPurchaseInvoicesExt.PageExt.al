pageextension 67072 UTTPostedPurchaseInvoicesExt extends "Posted Purchase Invoices"
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
                action("UTT UTTDeleteFiscalFolio")
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
