<%-- 
    Document   : InvoiceScreen.jsp
    Created on : Nov 9, 2014, 4:26:35 PM
    Author     : Gord
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"  import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.lang.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>CSE | Invoice Screen</title>
<link href="styles/blogPostStyle.css" rel="stylesheet" type="text/css">
<!--The following script tag downloads a font from the Adobe Edge Web Fonts server for use within the web page. We recommend that you do not modify it.--><script>var __adobewebfontsappname__="dreamweaver"</script><script src="http://use.edgefonts.net/source-sans-pro:n2,n4:default.js" type="text/javascript"></script>
<%!

/**
 * Format the phone number to ###-###-####
 * returns a string containing the formatted phone
 * @param   s       the phone number
 */
private String formatPhone(String s)
{
    String sPhone = "";
    for(int i=0; i < s.length();i++)
    {
        try
        {
            if(i < s.length()-1)
            {
                sPhone = sPhone + s.substring(i, i+1);
            }
            else
            {
                sPhone = sPhone + s.substring(i);
            }
        }
        catch(NumberFormatException e)
        {
            
        }
    }
    sPhone = "("+sPhone.substring(0,3)+")-"+sPhone.substring(3,6)+"-"+sPhone.substring(6);
    return sPhone;
}
/**
 * Get the month in string format
 * returns a string containing the month in a 3 letter format
 * @param   s       The month number in string format
 */
private String getStringMonth(String s)
{
    String sRet = "";
    if(s.equals("01"))
    {
        sRet = "Jan";
    }
    if(s.equals("02"))
    {
        sRet = "Feb";
    }
    if(s.equals("03"))
    {
        sRet = "Mar";
    }
    if(s.equals("04"))
    {
        sRet = "Apr";
    }
    if(s.equals("05"))
    {
        sRet = "May";
    }
    if(s.equals("06"))
    {
        sRet = "Jun";
    }
    if(s.equals("07"))
    {
        sRet = "Jul";
    }
    if(s.equals("08"))
    {
        sRet = "Aug";
    }
    if(s.equals("09"))
    {
        sRet = "Sep";
    }
    if(s.equals("10"))
    {
        sRet = "Oct";
    }
    if(s.equals("11"))
    {
        sRet = "Nov";
    }
    if(s.equals("12"))
    {
        sRet = "Dec";
    }
    
    return sRet;
}
/**
 * create the invoice and send the email
 * returns a string containing a message to show whether the email was sent or not
 * @param   sClient     the client id
 * @param   sInvoice    the invoice id
 * @param   sUrl        the url of the page
 */
private String sendEmail(String sClient, String sInvoice, String sUrl)
{
    
    String sWasSent = "";
    String sRecip = "";
    String sSender = "";
    String sHost = "";
    Properties pProp = System.getProperties();
    
    String sBody = "";
    
    sBody = sBody + "<font face=\"verdana\">";
    sBody = sBody + "<table width=\"100%\">";
    sBody = sBody + "<tr>";
    sBody = sBody + "<td width=\"25%\" align=\"left\">";
    sBody = sBody + "<img src=\""+sUrl+"images/logo.png\" width=\"100%\" />";
    sBody = sBody + "</td>";
    sBody = sBody + "<td width=\"28%\" align=\"left\" valign=\"top\">";
    
    String sTaxRate = "";
    Connection con2 = null;
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
        Statement st = con2.createStatement();
        String sql = "SELECT * FROM config";
        ResultSet rs = st.executeQuery(sql);
        int recCount = 0;
        while(rs.next())
        {
            sBody = sBody + rs.getString("Address1")+", "+rs.getString("Address2")+"<br>";
            sBody = sBody + rs.getString("City")+", "+rs.getString("Prov")+" "+rs.getString("Postal")+"<br>";
            sBody = sBody + "Tel: "+rs.getString("Phone")+" Fax: "+rs.getString("Fax")+"<br>";
            sBody = sBody + rs.getString("Email");
            sTaxRate = rs.getString("HSTRate");
            sSender = rs.getString("Email");
            sHost = rs.getString("SMTPHost");
        }
        rs.close();
        con2.close();
    }
    catch(SQLException e)
    {
    }
    catch(ClassNotFoundException e)
    {
    }
    
    sBody = sBody + "</td>";
    sBody = sBody + "<td width=\"17%\" align=\"right\">";
    sBody = sBody + "<img src=\""+sUrl+"images/microsoft.gif\" width=\"100%\"/>";
    sBody = sBody + "</td>";
    sBody = sBody + "<td width=\"20%\" align=\"right\">";
    sBody = sBody + "<img src=\""+sUrl+"images/ibm.gif\" width=\"100%\"/>";
    sBody = sBody + "</td>";
    sBody = sBody + "</tr>";
    sBody = sBody + "</table>";
    sBody = sBody + "<center><h1>Invoice</h1></center>";
    sBody = sBody + "<table width=\"100%\">";
    sBody = sBody + "<tr>";
    sBody = sBody + "<td width =\"75%\">";
    
    sBody = sBody + getField2("clients","clientname","clientid",sClient)+"<br>";
    sBody = sBody + getField2("clients","address1","clientid",sClient)+" "+getField2("clients","address2","clientid",sClient)+"<br>";
    sBody = sBody + getField2("clients","city","clientid",sClient)+", "+getField2("clients","prov","clientid",sClient)+"<br>";
    sBody = sBody + getField2("clients","postal","clientid",sClient)+"<br>";
    String sPhone = getField2("clients","phone","clientid",sClient);
    sPhone = formatPhone(sPhone);
    sBody = sBody + "Tel: "+sPhone+"<br>";
    String sFax = getField2("clients","fax","clientid",sClient);
    sFax = formatPhone(sFax);
    sBody = sBody + "Fax: "+sFax+"<br>";
    sBody = sBody + "Attn: "+getField2("clients","contactperson","clientid",sClient)+"<br>";
    sBody = sBody + getField2("clients","email","clientid",sClient);
    sRecip = getField2("clients","email","clientid",sClient);
    
    sBody = sBody + "</td>";
    sBody = sBody + "<td width=\"25%\" valign=\"top\">";
    sBody = sBody + "<table width=\"100%\">";
    sBody = sBody + "<tr>";
    sBody = sBody + "<td width=\"50%\" align=\"left\">";
    sBody = sBody + "<b>Date:</b>";
    sBody = sBody + "</td>";
    sBody = sBody + "<td width=\"50%\" align=\"right\">";
    sBody = sBody + "<b>";
    
    String sDate = getField2("invoices","invoicedate","invoiceID",sInvoice);
    sDate = sDate.substring(6,8)+"-"+getStringMonth(sDate.substring(4,6))+"-"+sDate.substring(2,4);
    sBody = sBody + sDate;
    
    sBody = sBody + "</b>";
    sBody = sBody + "</td>";
    sBody = sBody + "</tr>";
    sBody = sBody + "<tr>";
    sBody = sBody + "<td width=\"50%\" align=\"left\">";
    sBody = sBody + "<b>Invoice#:</b>";
    sBody = sBody + "</td>";
    sBody = sBody + "<td width=\"50%\" align=\"right\">";
    sBody = sBody + "<b>";
    sBody = sBody + sInvoice;
    
    sBody = sBody + "</b>";
    sBody = sBody + "</td>";
    sBody = sBody + "</tr>";
    sBody = sBody + "<tr>";
    sBody = sBody + "<td width=\"50%\" align=\"left\">";
    sBody = sBody + "<b>Cust#:</b>";
    sBody = sBody + "</td>";
    sBody = sBody + "<td width=\"50%\" align=\"right\">";
    sBody = sBody + "<b>";
    sBody = sBody + sClient;
    sBody = sBody + "</b>";
    sBody = sBody + "</td>";
    sBody = sBody + "</tr>";
    sBody = sBody + "</table>";
    sBody = sBody + "</td>";
    sBody = sBody + "</tr>";
    sBody = sBody + "</table>";
    sBody = sBody + "<table width=\"100%\">";
    sBody = sBody + "<tr bgcolor=\"#C0C0C0\" cellspacing=\"0\">";
    sBody = sBody + "<td width=\"10%\" align=\"left\">";
    sBody = sBody + "<b>Item #</b>";
    sBody = sBody + "</td>";
    sBody = sBody + "<td width=\"40%\" align=\"left\">";
    sBody = sBody + "<b>Description</b>";
    sBody = sBody + "</td>";
    sBody = sBody + "<td width=\"10%\" align=\"center\">";
    sBody = sBody + "<b>Qty</b>";
    sBody = sBody + "</td>";
    sBody = sBody + "<td width=\"10%\" align=\"right\">";
    sBody = sBody + "<b>Price/Unit</b>";
    sBody = sBody + "</td>";
    sBody = sBody + "<td width=\"10%\" align=\"right\">";
    sBody = sBody + "<b>Amount</b>";
    sBody = sBody + "</td>";
    sBody = sBody + "<td width=\"10%\" align=\"right\">";
    sBody = sBody + "<b>Tax</b>";
    sBody = sBody + "</td>";
    sBody = sBody + "<td width=\"10%\" align=\"right\">";
    sBody = sBody + "<b>Cost</b>";
    sBody = sBody + "</td>";
    sBody = sBody + "</tr>";
    
    double dTAmount = 0;
    double dTTax = 0;
    double dTCost = 0;
    Connection con = null;
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
        Statement st = con.createStatement();
        String sql = "SELECT * FROM invoicedata WHERE invoice='"+sInvoice+"'";
        ResultSet rs = st.executeQuery(sql);
        int recCount = 0;
        while(rs.next())
        {
            double dAmount = 0;
            try
            {
                dAmount = Double.parseDouble(rs.getString("quantity"))*Double.parseDouble(rs.getString("price"));
            }
            catch(NumberFormatException e)
            {
                dAmount = 0;
            }
            if(dAmount > 0)
            {
                recCount = recCount + 1;
            }
            dAmount = Double.parseDouble(toTwoDec(Double.toString(roundToDecimal(dAmount,2))));
            sBody = sBody + "<tr>";
            sBody = sBody + "<td width=\"10%\" align=\"center\">"+Integer.toString(recCount)+"</td>";
            sBody = sBody + "<td width=\"40%\" align=\"left\">"+rs.getString("description")+"</td>";
            sBody = sBody + "<td width=\"10%\" align=\"right\">"+rs.getString("quantity")+"</td>";
            sBody = sBody + "<td width=\"10%\" align=\"right\">";
            if(dAmount > 0)
            {
                sBody = sBody + toTwoDec(rs.getString("price"))+"/"+rs.getString("unit");
            }
            sBody = sBody + "</td>";
            sBody = sBody + "<td width=\"10%\" align=\"right\">";

            if(dAmount > 0)
            {
                sBody = sBody + toTwoDec(Double.toString(roundToDecimal(dAmount,2)));
                dTAmount = dTAmount + dAmount;
            }
            sBody = sBody + "</td>";
            sBody = sBody + "<td width=\"10%\" align=\"right\">";
            double dTax = 0;
            dTax = dAmount * (Double.parseDouble(sTaxRate)/100);
            dTax = Double.parseDouble(toTwoDec(Double.toString(roundToDecimal(dTax,2))));
            if(!rs.getString("taxable").equalsIgnoreCase("Yes"))
            {
                dTax = 0; 
            }
            if(dAmount > 0)
            {
                sBody = sBody + toTwoDec(Double.toString(roundToDecimal(dTax,2)));
                dTTax = dTTax + dTax;
            }
            sBody = sBody + "</td>";
            sBody = sBody + "<td width=\"10%\" align=\"right\">";
            double dCost = dAmount + dTax;
            if(dAmount > 0)
            {
                sBody = sBody + toTwoDec(Double.toString(dCost));
                dTCost = dTCost + dCost;
            }
            sBody = sBody + "</td>";
            sBody = sBody + "</tr>";
        }
        rs.close();
        con.close();
    }
    catch(SQLException e)
    {
    }
    catch(ClassNotFoundException e)
    {
    }
    sBody = sBody + "<tr>";
    sBody = sBody + "<td colspan=\"4\" align=\"right\"><b>Total: </b></td>";
    sBody = sBody + "<td align=\"right\">"+toTwoDec(Double.toString(dTAmount))+"</td>";
    sBody = sBody + "<td align=\"right\">"+toTwoDec(Double.toString(dTTax))+"</td>";
    sBody = sBody + "<td align=\"right\">"+toTwoDec(Double.toString(dTCost))+"</td>";
    sBody = sBody + "</tr>";
    
    
    sBody = sBody + "<tr>";
    sBody = sBody + "<td colspan=\"2\" align=\"right\">";
    sBody = sBody + "<br><br>";
    sBody = sBody + "Approval:&nbsp;_____________________________________________";
    sBody = sBody + "</td>";
    sBody = sBody + "<td colspan=\"3\" align=\"left\">";
    sBody = sBody + "<br><br>";
    sBody = sBody + "Date:&nbsp;<u>____/____/________</u>";
    sBody = sBody + "</td>";
    sBody = sBody + "</tr>";
    sBody = sBody + "</table>";
    sBody = sBody + "</font>";
    
    pProp.setProperty("mail.smtp.host", sHost);
    
    Session sesMailSession = Session.getDefaultInstance(pProp);
    try
    {
        MimeMessage mMailQuote = new MimeMessage(sesMailSession);
        mMailQuote.setFrom(new InternetAddress(sSender));
        mMailQuote.addRecipient(Message.RecipientType.TO,new InternetAddress(sRecip));
        mMailQuote.setSubject("Invoice");
        mMailQuote.setContent(sBody,"text/html");
        Transport.send(mMailQuote);
        sWasSent = "Yes";
    }
    catch (MessagingException e) 
    {
        sWasSent = "Email Not Sent: "+e.getMessage();
    }
    return sWasSent;
}
/**
* When doing a search, get the first search result that matches a certain field
* Returns the first key field from the record that matches the search criteria
* @param    sTable      the table to get the record from
* @param    sField      the field to be used for the search
* @param    sSearch     the search criteria
 */
private String getFirstSearchResult(String sTable, String sField, String sSearch)
{
    Connection con = null;
    String sSrch = "";
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
        Statement st = con.createStatement();
        String sql = "SELECT * FROM "+sTable+" WHERE "+sField+" LIKE '"+sSearch+"%'";
        ResultSet rs = st.executeQuery(sql);
        while(rs.next())
        {
            sSrch = rs.getString("clientID");
        }
        rs.close();
        con.close();
    }
    catch(SQLException e)
    {
        sSrch = e.getMessage();
    }
    catch(ClassNotFoundException e)
    {
        sSrch = e.getMessage();
    }
    return sSrch;
}
/**
 * Get a specific field from the client table
 * returns a string value containing the data from the requested field
 * @param   sTable      the table containing the data
 * @param   sField      the field to get the data from
 * @param   keyField    the key field
 * @param   keyVal      the key value
 */
private String getField2(String sTable, String sField, String keyField, String KeyVal)
{
    String sData = "";
    Connection con = null;
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
        Statement st = con.createStatement();
        String sql = "SELECT "+sField+" FROM "+sTable+" WHERE "+keyField+"='"+KeyVal+"'";
        ResultSet rs = st.executeQuery(sql);
        int recCount = 0;
        while(rs.next())
        {
            sData = rs.getString(sField);
        }
        rs.close();
        con.close();
    }
    catch(SQLException e)
    {
        sData = e.getMessage();
    }
    catch(ClassNotFoundException e)
    {
        sData = e.getMessage();
    }
    return sData;
}
/**
 * Get the comments for an invoice
 * returns an string containing the comments for an invoice
 * @param   sInvoiceID     the invoice ID
 */
private String getComments(String sInvoiceID)
{
    String sNotes = "";
    Connection con = null;
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
        Statement st = con.createStatement();
        String sql = "SELECT * FROM invoices WHERE invoiceID='"+sInvoiceID+"'";
        ResultSet rs = st.executeQuery(sql);
        while(rs.next())
        {
            sNotes = rs.getString("comments");
        }
        rs.close();
        con.close();
    }
    catch(SQLException e)
    {
        sNotes = e.getMessage();
    }
    catch(ClassNotFoundException e)
    {
        sNotes = e.getMessage();
    }
    return sNotes;
}
/**
 * Round to a certain decimal place
 * returns a double with the number rounded to the specified decimal place
 * @param   dNum        the number to be rounded
 * @param   nPlace      the number of decimal places to round to.
 */
public double roundToDecimal(double dNum, int nPlace)
{
    double dRet = dNum * Math.pow(10, nPlace);
    dRet = Math.round(dRet);
    dRet = dRet/100;
    return dRet;
}
/**
 * get the next ID value
 * returns an int containing the next record number
 * @param   sTable      the table
 * @param   sField      the field
 */
private int getNextID(String sTable, String sField)
{
    int nRet = 0;
    String sID = "0";
    Connection con = null;
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
        Statement st = con.createStatement();
        String sql = "SELECT * FROM "+sTable+" ORDER BY "+sField;
        ResultSet rs = st.executeQuery(sql);
        while(rs.next())
        {
            sID = rs.getString(sField);
            if(sID.trim().equals(""))
            {
                sID = "0";
            }
            nRet = Integer.parseInt(sID)+1;
        }
        rs.close();
        con.close();
    }
    catch(SQLException e)
    {
        nRet = 0;
    }
    catch(ClassNotFoundException e)
    {
        nRet = 0;
    }
    
    return nRet;
}
/**
 * Convert a string to two decimal places
 * Converts a number in string format to two decimal places
 * Returns a string with the formatted number
 * @param   sNum        the number in string format
 */
private String toTwoDec(String sNum)
{
    boolean bIsDec = false;
    for(int i=0; i < sNum.length();i++)
    {
        if(i < sNum.length()-1)
        {
            if(sNum.substring(i,i+1).equals("."))
            {
                bIsDec = true;
            }
        }
        else
        {
            if(sNum.substring(i).equals("."))
            {
                bIsDec = true;
            }
        }
    }
    if(!bIsDec)
    {
        sNum = sNum + ".";
    }
    sNum = sNum + "00";
    String[] sNumParts = sNum.split("\\.");
    return sNumParts[0]+"."+sNumParts[1].substring(0,2);
}
/**
 * update a record with a string value
 * @param   sTable      the table to do the update on
 * @param   sField      the specific field to update
 * @param   sNewValue   the new value to be stored
 * @param   sKeyField   the key vield to check
 * @param   sKeyValue   the key value to check
 */
private void updateSRecord(String sTable, String sField, String sNewValue, String sKeyField, String sKeyValue)
{
    String sUpdate = "UPDATE "+sTable+" SET "+sField+" = '"+sNewValue+"' WHERE "+sKeyField+" = '"+sKeyValue+"'";
    doNonQuery(sUpdate);
}
/**
 * update a record with a numeric value
 * @param   sTable      the table to do the update on
 * @param   sField      the specific field to update
 * @param   sNewValue   the new value to be stored
 * @param   sKeyField   the key vield to check
 * @param   sKeyValue   the key value to check
 */
private void updateNRecord(String sTable, String sField, String sNewValue, String sKeyField, String sKeyValue)
{
    String sUpdate = "UPDATE "+sTable+" SET "+sField+" = "+sNewValue+" WHERE "+sKeyField+" = '"+sKeyValue+"'";
    doNonQuery(sUpdate);
}
/**
 * do a non query (Insert/Update)
 * @param   sSQL        the SQL statement
 */
private void doNonQuery(String sSQL)
{
    Connection con = null;
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
        Statement st = con.createStatement();
        st.executeUpdate(sSQL);
        con.close();
    }
    catch(SQLException e)
    {
    }
    catch(ClassNotFoundException e)
    {
    }
}
/**
 * Make the ID a unique one
 * returns a string that makes the ID passed a unique one
 * @param   sID     the new ID value
 * @param   sID_2   the old ID value
 */
private String makeUnique(String sID, String sID_2)
{
    int nUniqueness = 1;
    int nCount = 0;
    while(nUniqueness != 0)
    {
        nUniqueness = getExistence(sID);
        sID = sID_2;
        if(nUniqueness != 0)
        {
            nCount = nCount + 1;
            sID = sID + "_"+Integer.toString(nCount);
        }
    }
    String sID_ret = sID_2;
    if(nCount > 0)
    {
        sID_ret = sID_ret+ "_"+Integer.toString(nCount);
    }
    return sID_ret;
}
/**
 * Get the existence of a client
 * returns an int to show whether or not the client exists
 * @param   sID     the ID to check the existence for
 */
private int getExistence(String sID)
{
    int nRet = 0;
    
    Connection con = null;
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
        Statement st = con.createStatement();
        String sql = "SELECT * FROM clients WHERE clientID='"+sID+"'";
        ResultSet rs = st.executeQuery(sql);
        while(rs.next())
        {
            nRet = nRet + 1;
        }
        rs.close();
        con.close();
    }
    catch(SQLException e)
    {
        nRet = 1;
    }
    catch(ClassNotFoundException e)
    {
        nRet = 1;
    }
    
    return nRet;
}
/**
 * Get the employees and set the selected option on one of them
 * returns a string containing the employees in an option value of a select object
 * @param   sEmployee       the employee that will be selected
 */
private String getSelectOptions(String sEmployee)
{
    String sOpts = "";
    Connection con = null;
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
        Statement st = con.createStatement();
        String sql = "SELECT * FROM user WHERE active=1 ORDER BY lname";
        ResultSet rs = st.executeQuery(sql);
        int recCount = 0;
        sOpts = sOpts + "<option value=\"\"></option>";
        while(rs.next())
        {
            sOpts = sOpts + "<option ";
            if(rs.getString("userid").equals(sEmployee))
            {
                sOpts = sOpts + "selected ";
            }
            sOpts = sOpts + "value = \""+rs.getString("userID")+"\">"+rs.getString("fname")+" "+rs.getString("lname")+"</option>";
        }
        rs.close();
        con.close();
    }
    catch(SQLException e)
    {
        sOpts = e.getMessage();
    }
    catch(ClassNotFoundException e)
    {
        sOpts = e.getMessage();
    }
    return sOpts;
}
/**
 * Get the number of records in a table
 * Returns an int containing the number of records in the desired table
 * @param   sTable      the table
 */
private int getNumOfRecords(String sTable)
{
    Connection con = null;
    int nRet = 0;
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
        Statement st = con.createStatement();
        String sql = "SELECT * FROM "+sTable;
        ResultSet rs = st.executeQuery(sql);
        while(rs.next())
        {
            nRet = nRet + 1;
        }
        rs.close();
        con.close();
    }
    catch(SQLException e)
    {
        nRet = 0;
    }
    catch(ClassNotFoundException e)
    {
        nRet = 0;
    }
    return nRet;
}
/**
 * Get a specific field from the client table
 * returns a string value containing the data from the requested field
 * @param   sTable      the table containing the data
 * @param   sField      the field to get the data from
 * @param   recNo       at what record position
 */
private String getField(String sTable, String sField, int recNo)
{
    String sData = "";
    Connection con = null;
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
        Statement st = con.createStatement();
        String sql = "SELECT "+sField+",clientname FROM "+sTable+" ORDER BY clientname,clientID";
        if(sField.equals("clientname"))
        {
            sql = "SELECT "+sField+" FROM "+sTable+" ORDER BY clientname,clientID";
        }
        ResultSet rs = st.executeQuery(sql);
        int recCount = 0;
        while(rs.next())
        {
            if(recCount < recNo+1)
            {
                sData = rs.getString(sField);
            }
            recCount = recCount + 1;
        }
        rs.close();
        con.close();
    }
    catch(SQLException e)
    {
        sData = e.getMessage();
    }
    catch(ClassNotFoundException e)
    {
        sData = e.getMessage();
    }
    return sData;
}
/**
 * Get the first invoice for a client
 * returns a string which contains the first invoice id for a client
 * @param   sClient     the client
*/
private String getFirstRecord(String sClient)
{
    String sRet = "";
    Connection con = null;
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
        Statement st = con.createStatement();
        String sql = "SELECT * FROM invoices WHERE client='"+sClient+"' ORDER BY invoiceDate DESC";
        ResultSet rs = st.executeQuery(sql);
        boolean found = false;
        while(rs.next())
        {
            if(!found)
            {
                sRet = rs.getString("invoiceid");
                found = true;
            }
        }
        rs.close();
        con.close();
    }
    catch(SQLException e)
    {
        sRet = e.getMessage();
    }
    catch(ClassNotFoundException e)
    {
        sRet = e.getMessage();
    }
    return sRet;
}
/**
 * Get the number of invoices
 * returns an int containing the number of invoices for a certain client
 * @param   sClient     the client
 */
private int getNumOfInvoices(String sClient)
{
    int nRet = 0;
    Connection con = null;
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
        Statement st = con.createStatement();
        String sql = "SELECT * FROM invoices WHERE client='"+sClient+"'";
        ResultSet rs = st.executeQuery(sql);
        while(rs.next())
        {
            nRet = nRet + 1;
        }
        rs.close();
        con.close();
    }
    catch(SQLException e)
    {
        nRet = 0;
    }
    catch(ClassNotFoundException e)
    {
        nRet = 0;
    }
    return nRet;
}
/**
 * Get the Current Invoice
 * returns a string containing the invoice ID
 * @param   sClient         the client
 * @param   currentRecord   the current record
 */
private String getCurrentInvoice(String sClient, int currentRecord)
{
    String sRet = "";
    Connection con = null;
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
        Statement st = con.createStatement();
        String sql = "SELECT * FROM invoices WHERE client='"+sClient+"' ORDER BY invoicedate DESC";
        ResultSet rs = st.executeQuery(sql);
        int recCt = 0;
        while(rs.next())
        {
            if(recCt == currentRecord)
            {
                sRet = rs.getString("invoiceID");
            }
            recCt = recCt + 1;
        }
        rs.close();
        con.close();
    }
    catch(SQLException e)
    {
        sRet = e.getMessage();
    }
    catch(ClassNotFoundException e)
    {
        sRet = e.getMessage();
    }
    return sRet;
}
%>
</head>
<%
//get the current record
int currentRecord = 0;
int currentInvoiceRecord = 0;

try
{
    currentInvoiceRecord = Integer.parseInt(request.getParameter("InvoiceRecordNo"));
}
catch(NumberFormatException e)
{
    currentInvoiceRecord = 0;
}

try
{
    currentRecord = Integer.parseInt(request.getParameter("RecordNo"));
}
catch(NumberFormatException e)
{
    currentRecord = 0;
}
boolean isInvoiceUpdate = false;

try
{
    //email invoice
    if(request.getParameter("hdnAction").equals("E"))
    {
        String sUrl  = request.getRequestURL().toString().replace("InvoiceScreen.jsp", "");
        out.println(sendEmail(request.getParameter("Client"),request.getParameter("Invoice"),sUrl));
    }
}
catch(NullPointerException e)
{
    
}


try
{
    //search
    if(request.getParameter("hdnAction").equals("S"))
    {
        String sSearch = request.getParameter("txtSearch");
        String sFirst = getFirstSearchResult("clients","clientname",sSearch);
        Connection con = null;
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
            Statement st = con.createStatement();
            String sql = "SELECT * FROM clients ORDER BY clientname,clientID";
            ResultSet rs = st.executeQuery(sql);
            int recCt = 0;
            while(rs.next())
            {
                if(rs.getString("clientID").equalsIgnoreCase(sFirst))
                {
                    currentRecord = recCt;
                }
                recCt = recCt + 1;
            }
            rs.close();
            con.close();
        }
        catch(SQLException e)
        {
            currentRecord = 0;
        }
        catch(ClassNotFoundException e)
        {
            currentRecord = 0;
        }
    }
}
catch(NullPointerException e)
{
    
}

try
{
    //invoice insert
    if(request.getParameter("hdnAction").equals("II"))
    {
        int nInvoiceID = getNextID("invoices","invoiceID");
        String sInvoiceID = Integer.toString(nInvoiceID);
        String sToday = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(java.util.Calendar.getInstance().getTime());
        String sInsert = "INSERT INTO invoices VALUES('"+sInvoiceID+"','"+sToday+"','"+request.getParameter("Client")+"','','')";
        doNonQuery(sInsert);
        Connection con = null;
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
            Statement st = con.createStatement();
            String sql = "SELECT * FROM clients ORDER BY clientname,clientID";
            ResultSet rs = st.executeQuery(sql);
            int recCt = 0;
            while(rs.next())
            {
                if(rs.getString("clientID").equalsIgnoreCase(request.getParameter("Client")))
                {
                    currentInvoiceRecord = recCt;
                }
                recCt = recCt + 1;
            }
            rs.close();
            con.close();
        }
        catch(SQLException e)
        {
            //currentRecord = 0;
        }
        catch(ClassNotFoundException e)
        {
            //currentRecord = 0;
        }
    }
}
catch(NullPointerException e)
{
    isInvoiceUpdate = false;
}



try
{
    if(request.getParameter("hdnAction").equals("IU"))
    {
        isInvoiceUpdate = true;   
    }
}
catch(NullPointerException e)
{
    isInvoiceUpdate = false;
}
if(isInvoiceUpdate)
{
    //invoice update
    boolean endLoop = false;
    int nIndex = 0;
    while(!endLoop)
    {
        try
        {
            String sParam = request.getParameter("qInfoCode["+Integer.toString(nIndex)+"]");
            if(sParam.equals("NEW"))
            {
                String sCode = request.getParameter("qCode["+Integer.toString(nIndex)+"]");
                String sDesc = request.getParameter("qDesc["+Integer.toString(nIndex)+"]");
                if( (!sCode.trim().equals(""))||(!sDesc.trim().equals("")) )
                {
                    String sMaster = request.getParameter("MasterInvoice");
                    if(sMaster.trim().equals(""))
                    {
                        int nInvoiceID = getNextID("invoices","invoiceID");
                        String sToday = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(java.util.Calendar.getInstance().getTime());
                        sMaster = Integer.toString(nInvoiceID);
                        String sNewInvoice = "INSERT INTO invoices VALUES('"+sMaster+"','"+sToday+"','"+request.getParameter("CurrentClient")+"','','')";
                        doNonQuery(sNewInvoice);
                    }
                    int nID = getNextID("invoicedata","invoiceDataID");
                    String sInsert = "INSERT INTO invoicedata VALUES('"+Integer.toString(nID)+"','"+sMaster+"','"+sCode+"','"+sDesc+"',"+request.getParameter("qQty["+Integer.toString(nIndex)+"]")+","+request.getParameter("qPrice["+Integer.toString(nIndex)+"]")+",'"+request.getParameter("qUnit["+Integer.toString(nIndex)+"]")+"','"+request.getParameter("qTaxable["+Integer.toString(nIndex)+"]")+"')";
                    doNonQuery(sInsert);
                }
                
                endLoop = true;
            }
            else
            {
                
                String sPaid = request.getParameter("chkPaid")+"_a";
                String sPaidValue = "false";
                if(sPaid.equalsIgnoreCase("on_a"))
                {
                    sPaidValue = "true";
                }
                if(sPaidValue.equals("false"))
                {
                    updateSRecord("invoicedata","code",request.getParameter("qCode["+Integer.toString(nIndex)+"]"),"invoiceDataID",request.getParameter("qInfoCode["+Integer.toString(nIndex)+"]"));
                    updateSRecord("invoicedata","description",request.getParameter("qDesc["+Integer.toString(nIndex)+"]"),"InvoiceDataID",request.getParameter("qInfoCode["+Integer.toString(nIndex)+"]"));
                    updateNRecord("invoicedata","quantity",request.getParameter("qQty["+Integer.toString(nIndex)+"]"),"InvoiceDataID",request.getParameter("qInfoCode["+Integer.toString(nIndex)+"]"));
                    updateNRecord("invoicedata","price",request.getParameter("qPrice["+Integer.toString(nIndex)+"]"),"InvoiceDataID",request.getParameter("qInfoCode["+Integer.toString(nIndex)+"]"));
                    updateSRecord("invoicedata","unit",request.getParameter("qUnit["+Integer.toString(nIndex)+"]"),"InvoiceDataID",request.getParameter("qInfoCode["+Integer.toString(nIndex)+"]"));
                    updateSRecord("invoicedata","taxable",request.getParameter("qTaxable["+Integer.toString(nIndex)+"]"),"InvoiceDataID",request.getParameter("qInfoCode["+Integer.toString(nIndex)+"]"));
                    String sToday = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(java.util.Calendar.getInstance().getTime());
                    updateSRecord("invoices","invoicedate",sToday,"invoiceID",request.getParameter("MasterInvoice"));
                }
                updateSRecord("invoices","paid",sPaidValue,"invoiceID",request.getParameter("MasterInvoice"));
            }
            nIndex = nIndex + 1;
        }
        catch(NullPointerException e)
        {
            endLoop = true;
        }
    }
}

try
{
    //update invoice comments
    if(request.getParameter("hdnAction").equals("IUC"))
    {
         String sToday = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(java.util.Calendar.getInstance().getTime());
         updateSRecord("invoices","invoicedate",sToday,"invoiceID",request.getParameter("Invoice"));
         updateSRecord("invoices","comments",request.getParameter("mmoComments"),"invoiceID",request.getParameter("Invoice"));
    }
}
catch(NullPointerException e)
{
    
}


try
{
    //update client
    if(request.getParameter("hdnAction").equals("U"))
    {
        String sID = request.getParameter("txtCode");
        String sID2 = sID;
        String sOrigID = request.getParameter("hdnOrigCode");
        if(!sID.equals(sOrigID))
        {
            sID = makeUnique(sID,sID2);
        }
        updateSRecord("clients","clientID",sID,"clientID",sOrigID);
        updateSRecord("quotes","client",sID,"client",sOrigID);
        updateSRecord("invoices","client",sID,"client",sOrigID);
        updateSRecord("clients","clientname",request.getParameter("txtName"),"clientID",sOrigID);
        String sCheckActive = request.getParameter("chkActive")+"_a";
        String sActiveValue = "false";
        if(sCheckActive.equalsIgnoreCase("on_a"))
        {
            sActiveValue = "true";
        }
        updateSRecord("clients","active",sActiveValue,"clientID",sOrigID);
        updateSRecord("clients","address1",request.getParameter("txtAddress1"),"clientID",sOrigID);
        updateSRecord("clients","address2",request.getParameter("txtAddress2"),"clientID",sOrigID);
        updateSRecord("clients","city",request.getParameter("txtCity"),"clientID",sOrigID);
        updateSRecord("clients","prov",request.getParameter("txtProv"),"clientID",sOrigID);
        updateSRecord("clients","postal",request.getParameter("txtPC"),"clientID",sOrigID);
        updateSRecord("clients","contactperson",request.getParameter("txtAttn"),"clientID",sOrigID);
        updateSRecord("clients","email",request.getParameter("txtEmail"),"clientID",sOrigID);
        updateSRecord("clients","phone",request.getParameter("txtTel"),"clientID",sOrigID);
        updateSRecord("clients","fax",request.getParameter("txtFax"),"clientID",sOrigID);
        updateSRecord("clients","rep",request.getParameter("cmbStaff"),"clientID",sOrigID);
        
        Connection con = null;
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
            Statement st = con.createStatement();
            String sql = "SELECT * FROM clients ORDER BY clientname,clientID";
            ResultSet rs = st.executeQuery(sql);
            int recCt = 0;
            while(rs.next())
            {
                if(rs.getString("clientID").equalsIgnoreCase(sID))
                {
                    currentRecord = recCt;
                }
                recCt = recCt + 1;
            }
            rs.close();
            con.close();
        }
        catch(SQLException e)
        {
            currentRecord = 0;
        }
        catch(ClassNotFoundException e)
        {
            currentRecord = 0;
        }
    }   
}
catch(NullPointerException e)
{
    out.println("");
}
//get max record, next record, and previous record
int maxRecord = getNumOfRecords("clients");

int nextRecord = currentRecord;
if(currentRecord < maxRecord-1)
{
    nextRecord = currentRecord + 1;
}

int prevRecord = 0;
if(currentRecord > 0)
{
    prevRecord = currentRecord - 1;
}

String sClID = getField("clients","clientID",currentRecord);
int maxInvoiceRecord = getNumOfInvoices(sClID);
int nextInvoiceRecord = currentInvoiceRecord;
if(currentInvoiceRecord < maxInvoiceRecord-1)
{
    nextInvoiceRecord = currentInvoiceRecord + 1;
}

int prevInvoiceRecord = 0;
if(currentInvoiceRecord > 0)
{
    prevInvoiceRecord = currentInvoiceRecord - 1;
}
int invoiceCt = 0;
String sInvoiceDataID = "";
if(maxInvoiceRecord == 0)
{
    sInvoiceDataID = getFirstRecord(sClID);
}
else
{
    sInvoiceDataID = getCurrentInvoice(sClID,currentInvoiceRecord);
}
//redirect if invoice update or invoice insert
if( (request.getParameter("hdnAction").equals("IU"))||(request.getParameter("hdnAction").equals("II")) )
{
    out.println("<body onload=\"window.location.href='InvoiceScreen.jsp?RecordNo="+String.valueOf(currentRecord)+"&hdnAction=V'\">");
}
else
{
    out.println("<body>");
}

%>
<div id="mainwrapper">
	<header id="top">
    	<div id="logo">Logo</div>
    		<nav id="mainnav">
            	<ul>
                	<li>Welcome, <label>Michael</label></li>
                    <li><a href="#">Logout</a></li>
                </ul>
    		</nav>
  	</header>
<div id="content">
	<div class="notOnDesktop">
    <!-- This search box is displayed only in mobile and tablet laouts and not in desktop layouts -->
    	<form name="form3" action="InvoiceScreen.jsp" method="GET">
            <input type="text" name = "txtSearch" placeholder="Search">
            <input type="hidden" name="hdnAction" value="S"></input>
        </form>
        <button type="button" onclick="document.form3.submit()">Search</button>
    </div>
    <section id="mainContent">
    <!--************************************************************************
    Main content starts here
    ****************************************************************************-->
		<h1><!-- Title -->Invoice Screen</h1>
      	<h3><!-- Tagline -->Client Details</h3>
        <div id="bannerImage">
        	<table border="0" width="100%">
                    <form name="form1" action = "InvoiceScreen.jsp" method="GET">
        		<tr>
        			<td colspan="4">
                                    <input type="hidden" name="hdnAction" value="U"></input>
                                    <%
                                        //set up page and get the data
                                        out.println("<input type=\"hidden\" name=\"hdnOrigCode\" value=\""+sClID+"\"></input>");
                                    %>
                                    <%
                                        out.println("<button type=\"button\" style=\"width:24%;\" onclick=\"window.location.href='InvoiceScreen.jsp?RecordNo="+String.valueOf(prevRecord)+"&hdnAction=V'\">&lt;</button>");
                                        out.println("<button type=\"button\" style=\"width:24%;\" onclick=\"window.location.href='InvoiceScreen.jsp?RecordNo="+String.valueOf(nextRecord)+"&hdnAction=V'\">&gt;</button>");
                                        out.println("<button type=\"button\" style=\"width:24%;\" onclick=\"window.open('PreviewInvoice.jsp?Client="+getField("clients","clientID",currentRecord)+"&Invoice="+sInvoiceDataID+"')\">Print Invoice</button>");
                                        out.println("<button type=\"button\" style=\"width:24%;\" onclick=\"window.location.href='InvoiceScreen.jsp?Client="+getField("clients","clientID",currentRecord)+"&Invoice="+sInvoiceDataID+"&hdnAction=E'\">Email Invoice</button>");
                                    %>
        			</td>
        		</tr>
        		<tr>
        			<td align="right"><b>Code: </b></td>
        			<td>
                                    <%
                                        out.println("<input type=\"text\" name=\"txtCode\" style=\"width:99%;\" value=\""+sClID+"\"></input>");
                                    %>
                                </td>
        			<td align="center"><b>Client Details</b></td>
        		</tr>
        		<tr>
        			<td align="right"><b>Name: </b></td>
        			<td colspan="3">
                                    <%
                                        out.println("<input type=\"text\" name=\"txtName\" style=\"width:99%;\" value = \""+getField("clients","clientName",currentRecord)+"\"></input>");
                                    %>
                                </td>
        		</tr>
        		<tr>
        			<td align="right"><b>Address: </b></td>
        			<td colspan="3">
                                    <%
                                        out.println("<input type=\"text\" name=\"txtAddress1\" style=\"width:99%;\" value=\""+getField("clients","address1",currentRecord)+"\"></input>");
                                    %>            
                                </td>
        		</tr>
        		<tr>
        			<td align="right"></td>
        			<td colspan="3">
                                    <%
                                        out.println("<input type=\"text\" name=\"txtAddress2\" style=\"width:99%;\" value=\""+getField("clients","address2",currentRecord)+"\"></input>");
                                    %>
                                </td>
        		</tr>
        		<tr>
        			<td align="right"><b>City: </b></td>
        			<td colspan="3">
        				<%
                                            out.println("<input type=\"text\" name=\"txtCity\" style=\"width:50%;\" value=\""+getField("clients","city",currentRecord)+"\"></input>");
                                        %>
        				<b><label style="width:10%">Prov: </label></b>
        				<%
                                            out.println("<input type=\"text\" name=\"txtProv\" style=\"width:10%;\" value=\""+getField("clients","prov",currentRecord)+"\"></input>");
                                        %>
        				<b><label style="width:5%">PC: </label></b>
        				<%
                                            out.println("<input type=\"text\" name=\"txtPC\" style=\"width:24%;\" value=\""+getField("clients","postal",currentRecord)+"\"></input>");
                                        %>
        			</td>
        		</tr>
				<tr>
        			<td align="right"><b>Attn: </b></td>
        			<td colspan="3">
                                    <%
                                        out.println("<input type=\"text\" name=\"txtAttn\" style=\"width:99%;\" value=\""+getField("clients","contactperson",currentRecord)+"\"></input>");
                                    %>
                                </td>
        		</tr>
				<tr>
        			<td align="right"><b>Email: </b></td>
        			<td colspan="3">
                                    <%
                                        out.println("<input type=\"email\" name=\"txtEmail\" style=\"width:69%;\" value=\""+getField("clients","email",currentRecord)+"\"></input>");
                                        out.println("<button type=\"button\" style=\"width:29%;\" onclick=\"document.location.href='mailto:"+getField("clients","email",currentRecord)+"'\">Email</button>");
                                    %>    
                                </td>
        		</tr>
				<tr>
        			<td align="right"><b>Tel: </b></td>
        			<td colspan="3">
        				<%
                                            out.println("<input type=\"tel\" name=\"txtTel\" style=\"width:49%;\" value=\""+getField("clients","phone",currentRecord)+"\"></input>");
                                        %>
        				<b><label style="width:5%">Fax: </label></b>
        				<%
                                            out.println("<input type=\"tel\" name=\"txtFax\" style=\"width:43%;\" value=\""+getField("clients","fax",currentRecord)+"\"></input>");
                                        %>
        			</td>
        		</tr>
				<tr>
        			<td align="right"><b>Staff: </b></td>
        			<td colspan="3">
        				<select name="cmbStaff" style="width:49%;">
                                            <%
                                                String sRep = getField("clients","rep",currentRecord);
                                                out.println(getSelectOptions(sRep));
                                            %>
        				</select>
                                        <%
                                            String sActive1 = "";
                                            if(getField("clients","active",currentRecord).equalsIgnoreCase("true"))
                                            {
                                                sActive1 = " checked";
                                            }
                                            out.println("<input type=\"Checkbox\" name=\"chkActive\""+sActive1+">Active</input>");
                                        %>
        				<button type="button" onclick="document.form1.submit()">Commit Change</button>
        			</td>
        		</tr>
                    </form>
        	</table>
        </div>
        	<section id="authorInfo">
      		<!-- The invoice description information is contained here -->
        		<h3>Invoice Description</h3>
                        <form name="form2" action="InvoiceScreen.jsp" method="GET">
                        <%
                            out.println("<input type=\"hidden\" name=\"RecordNo\" value=\""+Integer.toString(currentRecord)+"\"></input>");
                            out.println("<input type=\"hidden\" name=\"MasterInvoice\" value=\""+sInvoiceDataID+"\"></input>");
                            out.println("<input type=\"hidden\" name=\"CurrentClient\" value=\""+sClID+"\"></input>");
                        %>    
                        <input type="hidden" name="hdnAction" value="IU"></input>
        		<table border="0" width="100%">
        			<thead>
        				<tr>
        					<th><b>#</b></th>
        					<th><b>Code</b></th>
        					<th><b>Desc</b></th>
        					<th><b>Qty</b></th>
        					<th><b>Price</b></th>
        					<th><b>/</b></th>
                                                <th><b>Taxable</b></th>
                                                <th><b>Amount</b></th>
        				</tr>
        			</thead>
        			<tbody>
                                    <%
                                        
                                        
                                        Connection con = null;
                                        try
                                        {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
                                            Statement st = con.createStatement();
                                            String sql = "SELECT * FROM invoicedata WHERE invoice='"+sInvoiceDataID+"' ORDER BY invoiceDataID";
                                            ResultSet rs = st.executeQuery(sql);
                                            boolean found = false;
                                            while(rs.next())
                                            {
                                                out.println("<tr>");
                                                out.println("<th><b>"+Integer.toString(invoiceCt+1)+"</b><input type=\"hidden\" name=\"qInfoCode["+Integer.toString(invoiceCt)+"]\" value=\""+rs.getString("invoiceDataID")+"\"></input></th>");
                                                out.println("<td><input type=\"text\" name=\"qCode["+Integer.toString(invoiceCt)+"]\" style=\"width:99%;\" value=\""+rs.getString("code")+"\"></input></td>");
        					out.println("<td><input type=\"text\" name=\"qDesc["+Integer.toString(invoiceCt)+"]\" style=\"width:99%;\" value=\""+rs.getString("description")+"\"></input></td>");
        					out.println("<td><input type=\"number\" step=\"0.01\" min=\"0.00\" name=\"qQty["+Integer.toString(invoiceCt)+"]\" style=\"width:99%;text-align:right;\" value=\""+rs.getString("quantity")+"\"></input></td>");
        					out.println("<td><input type=\"number\" step=\"0.01\" min=\"0.00\" name=\"qPrice["+Integer.toString(invoiceCt)+"]\" style=\"width:99%;text-align:right;\" value=\""+toTwoDec(rs.getString("price"))+"\"></input></td>");
        					out.println("<td><input type=\"text\" name=\"qUnit["+Integer.toString(invoiceCt)+"]\" style=\"width:99%;\" value=\""+rs.getString("unit")+"\"></input></td>");
        					if(rs.getString("taxable").equals("Yes"))
        					{
        						out.println("<td><select name=\"qTaxable["+Integer.toString(invoiceCt)+"]\" style=\"width:99%;\"><option selected value=\"Yes\">Yes</option><option value=\"No\">No</option></select></td>");
        					}
        					else
						{
							out.println("<td><select name=\"qTaxable["+Integer.toString(invoiceCt)+"]\" style=\"width:99%;\"><option value=\"Yes\">Yes</option><option selected value=\"No\">No</option></select></td>");
        					}
                                                double dQty = 0;
                                                double dPrice = 0;
                                                try
                                                {
                                                    dQty = Double.parseDouble(rs.getString("quantity"));
                                                }
                                                catch(NumberFormatException e)
                                                {
                                                    dQty = 0;
                                                }
                                                try
                                                {
                                                    dPrice = Double.parseDouble(rs.getString("price"));
                                                }
                                                catch(NumberFormatException e)
                                                {
                                                    dPrice = 0;
                                                }
                                                double dAmount = dQty * dPrice;
        					out.println("<td style=\"text-align:right;\"><label style=\"width:99%;text-align:right;\">"+toTwoDec(Double.toString(roundToDecimal(dAmount,2)))+"</label></td>");
                                                out.println("</tr>");
                                                invoiceCt = invoiceCt + 1;
                                            }
                                            out.println("<tr>");
                                            out.println("<th><b>"+Integer.toString(invoiceCt+1)+"</b><input type=\"hidden\" name=\"qInfoCode["+Integer.toString(invoiceCt)+"]\" value=\"NEW\"></input></th>");
                                            out.println("<td><input type=\"text\" name=\"qCode["+Integer.toString(invoiceCt)+"]\" style=\"width:99%;\" value=\"\"></input></td>");
                                            out.println("<td><input type=\"text\" name=\"qDesc["+Integer.toString(invoiceCt)+"]\" style=\"width:99%;\" value=\"\"></input></td>");
                                            out.println("<td><input type=\"number\" step=\"0.01\" min=\"0.00\" name=\"qQty["+Integer.toString(invoiceCt)+"]\" style=\"width:99%;text-align:right;\" value=\"\"></input></td>");
                                            out.println("<td><input type=\"number\" step=\"0.01\" min=\"0.00\" name=\"qPrice["+Integer.toString(invoiceCt)+"]\" style=\"width:99%;text-align:right;\" value=\"\"></input></td>");
                                            out.println("<td><input type=\"text\" name=\"qUnit["+Integer.toString(invoiceCt)+"]\" style=\"width:99%;\" value=\"\"></input></td>");
                                            out.println("<td><select name=\"qTaxable["+Integer.toString(invoiceCt)+"]\" style=\"width:99%;\"><option selected value=\"Yes\">Yes</option><option value=\"No\">No</option></select></td>");
                                            out.println("</tr>");
                                            out.println("<tr>");
                                            out.println("<td colspan=\"9\">");
                                            String sPaid = "";
                                            if(getField2("invoices","paid","invoiceID",sInvoiceDataID).equalsIgnoreCase("true"))
                                            {
                                                sPaid = " checked";
                                            }

                                            out.println("<input type=\"Checkbox\" name=\"chkPaid\""+sPaid+">Paid</input>");
                                            out.println("</td>");
                                            out.println("</tr>");
                                            rs.close();
                                            con.close();
                                        }
                                        catch(SQLException e)
                                        {
                                        }
                                        catch(ClassNotFoundException e)
                                        {
                                        }

                                    %>
        				<tr>
        					<td colspan="9">
                                                    <%
                                                        out.println("<button type=\"button\" onclick=\"document.location.href='InvoiceScreen.jsp?hdnAction=V&RecordNo="+Integer.toString(currentRecord)+"&InvoiceRecordNo="+Integer.toString(prevInvoiceRecord)+"'\">&lt;</button>");
                                                        out.println("<button type=\"button\" onclick=\"document.location.href='InvoiceScreen.jsp?hdnAction=V&RecordNo="+Integer.toString(currentRecord)+"&InvoiceRecordNo="+Integer.toString(nextInvoiceRecord)+"'\">&gt;</button>");
                                                        out.println("<button type=\"button\" onclick=\"window.location.href='InvoiceScreen.jsp?hdnAction=II&InvoiceRecordNo="+Integer.toString(currentInvoiceRecord)+"&Client="+sClID+"&RecordNo="+Integer.toString(currentRecord)+"'\">New Invoice</button>");
                                                    %>
                                            <button type="button" onclick="document.form2.submit()">Commit</button></td>
                                                </td>
        				</tr>
        			</tbody>
        		</table>
                        </form>
      		</section>
    </section>
    <aside id="sidebar">
    <!--************************************************************************
    Sidebar starts here. It contains a searchbox, A1 logo image and 6 links
    ****************************************************************************-->
      	<form name="form5" action="InvoiceScreen.jsp" method="GET">
            <input type="text" name = "txtSearch" placeholder="Search">
            <input type="hidden" name="hdnAction" value="S"></input>
        </form>
        <button type="button" onclick="document.form5.submit()">Search</button>
      	<div id="adimage"><img src="images/A1 Logo.jpg" alt=""/></div>
      	<nav>
        	<ul>
          		<li><a href="ClientScreen.jsp?hdnAction=V" title="Link">Client Screen</a></li>
          		<li><a href="QuoteScreen.jsp?hdnAction=V" title="Link">Quote Screen</a></li>
        	</ul>
      	</nav>
   	</aside>
    <footer>
    <!--************************************************************************
    Footer starts here
    ****************************************************************************-->
    	<article>
          	<h3>Followup Comments</h3>
                <form name="form4" action="InvoiceScreen.jsp" method="GET">
          	<%
                    String sOut = "<textarea name=\"mmoComments\" style=\"width:99%;\" rows=10>";
                    sOut = sOut + getComments(sInvoiceDataID);
                    sOut = sOut + "</textarea>";
                    out.println(sOut);
                %>
                <input type="hidden" name="hdnAction" value="IUC"></input>
                <%
                    out.println("<input type=\"hidden\" name=\"Invoice\" value=\""+sInvoiceDataID+"\"></input>");
                    out.println("<input type=\"hidden\" name=\"Client\" value=\""+sClID+"\"></input>");
                    out.println("<input type=\"hidden\" name=\"RecordNo\" value=\""+Integer.toString(currentRecord)+"\"></input>");
                %>
                </form>
                <button type="button" onclick="document.form4.submit()">Commit</button>
        </article>
 	</footer>
</div>
	<div id="footerbar"><!-- Small footerbar at the bottom --></div>
</div>
</body>
</html>
