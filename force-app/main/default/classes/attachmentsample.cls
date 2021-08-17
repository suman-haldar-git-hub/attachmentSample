public class attachmentsample 
{
    public Candidate__c cand;
    public String Cid;
    public attachmentsample(ApexPages.StandardController controller) 
    {
       // c = (Candidate__c)controller.getRecord();
       this.cand= (Candidate__c)controller.getRecord();
       Cid = ApexPages.currentPage().getParameters().get('id');
       system.debug('@@@@@Cid'+Cid); 
    }
    Public Attachment myfile;
    Public Attachment getmyfile()
    {
        myfile = new Attachment();
        
        return myfile;
    }
    Public Pagereference Savedoc()
    {
        system.debug('^^^^^^^^myfile'+myfile);
        Attachment a = new Attachment(parentId = Cid, name = myfile.name, body = myfile.body);
         /* insert the attachment */
        insert a;
        
        Cand.HiddenCheckBox__c = true;
        update cand;
        
       if(cand.HiddenCheckBox__c == true)
        {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {'c_sarkar@qualcomm.com'}; 
            mail.setToAddresses(toAddresses);
            mail.setSenderDisplayName('Salesforce');
            mail.setSubject('Candidate Confirmation');
            //mail.setPlainTextBody('Your Candidature Id ' + Cid +' has been created');
            system.debug('---------------------------'+toAddresses);
            mail.setHtmlBody('Your Candidature:<b> ' + Cid +' </b>has been created<p>'+' View case <a href=https://na1.salesforce.com/'+Cid+'>click here</a>');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        
        PageReference pgref = new PageReference('/apex/AttachmentSuccessfulPage?id='+Cid);
        pgref.setRedirect(true);
        return pgref ;
        
        
        
    }   
}