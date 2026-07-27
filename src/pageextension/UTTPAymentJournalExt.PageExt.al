pageextension 65054 "UTT PAymentJournalExt" extends "Payment Journal"
{
    layout
    {
        addbefore("Posting Date")
        {
            field("UTT Sign Payment"; "Sign Payment")
            {
                ApplicationArea =all;
            }
        }
    }
    
    actions
    {
        // Add changes to page actions here
    }
    
  
}