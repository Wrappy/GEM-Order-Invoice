<%-- 
    Document   : PreviewInvoice
    Created on : Nov 15, 2014, 10:38:53 AM
    Author     : Gord
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
<%!
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
 * Get a specific field from the client table
 * returns a string value containing the data from the requested field
 * @param   sTable      the table containing the data
 * @param   sField      the field to get the data from
 * @param   keyField    the key field
 * @param   keyVal      the key value
 */
private String getField(String sTable, String sField, String keyField, String KeyVal)
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
%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <font face="verdana">
        <table width="100%">
            <tr>
                <td width="25%" align="left">
                    <img src="images/logo.png" width="100%" />
                </td>
                <td width="28%" align="left" valign="top">
                    <%
                        //get address information and tax rate
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
                                out.println(rs.getString("Address1")+", "+rs.getString("Address2")+"<br>");
                                out.println(rs.getString("City")+", "+rs.getString("Prov")+" "+rs.getString("Postal")+"<br>");
                                out.println("Tel: "+rs.getString("Phone")+" Fax: "+rs.getString("Fax")+"<br>");
                                out.println(rs.getString("Email"));
                                sTaxRate = rs.getString("HSTRate");
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
                    %>
                </td>
                <td width="17%" align="right">
                    <img src="images/microsoft.gif" width="100%"/>
                </td>
                <td width="20%" align="right">
                    <img src="images/ibm.gif" width="100%"/>
                </td>
            </tr>
        </table>
        <center><h1>Invoice</h1></center>
        <table width="100%">
            <tr>
                <td width ="75%">
                    <%
                        //get client information
                        out.println(getField("clients","clientname","clientid",request.getParameter("Client"))+"<br>");
                        out.println(getField("clients","address1","clientid",request.getParameter("Client"))+" "+getField("clients","address2","clientid",request.getParameter("Client"))+"<br>");
                        out.println(getField("clients","city","clientid",request.getParameter("Client"))+", "+getField("clients","prov","clientid",request.getParameter("Client"))+"<br>");
                        out.println(getField("clients","postal","clientid",request.getParameter("Client"))+"<br>");
                        String sPhone = getField("clients","phone","clientid",request.getParameter("Client"));
                        sPhone = formatPhone(sPhone);
                        out.println("Tel: "+sPhone+"<br>");
                        String sFax = getField("clients","fax","clientid",request.getParameter("Client"));
                        sFax = formatPhone(sFax);
                        out.println("Fax: "+sFax+"<br>");
                        out.println("Attn: "+getField("clients","contactperson","clientid",request.getParameter("Client"))+"<br>");
                        out.println(getField("clients","email","clientid",request.getParameter("Client")));
                    %>
                </td>
                <td width="25%" valign="top">
                    <table width="100%">
                        <tr>
                            <td width="50%" align="left">
                                <b>Date: </b>
                            </td>
                            <td width="50%" align="right">
                                <b>
                                    <%
                                        //get invoice date, invoice number, and client code
                                        String sDate = getField("invoices","invoicedate","invoiceID",request.getParameter("Invoice"));
                                        sDate = sDate.substring(6,8)+"-"+getStringMonth(sDate.substring(4,6))+"-"+sDate.substring(2,4);
                                        out.println(sDate);
                                    %>
                                </b>
                            </td>
                        </tr>
                        <tr>
                            <td width="50%" align="left">
                                <b>Invoice#: </b>
                            </td>
                            <td width="50%" align="right">
                                <b>
                                    <%
                                        out.println(request.getParameter("Invoice"));
                                    %>
                                </b>
                            </td>
                        </tr>
                        <tr>
                            <td width="50%" align="left">
                                <b>Cust#: </b>
                            </td>
                            <td width="50%" align="right">
                                <b>
                                    <%
                                        out.println(request.getParameter("Client"));
                                    %>
                                </b>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table width="100%">
            <tr bgcolor="#C0C0C0" cellspacing="0">
                <td width="10%" align="left">
                    <b>Item #</b>
                </td>
                <td width="40%" align="left">
                    <b>Description</b>
                </td>
                <td width="10%" align="center">
                    <b>Qty</b>
                </td>
                <td width="10%" align="right">
                    <b>Price/Unit</b>
                </td>
                <td width="10%" align="right">
                    <b>Amount</b>
                </td>
                <td width="10%" align="right">
                    <b>Tax</b>
                </td>
                <td width="10%" align="right">
                    <b>Cost</b>
                </td>
            </tr>
            <%
                //get invoice data
                double dTAmount = 0;
                double dTTax = 0;
                double dTCost = 0;
                Connection con = null;
                try
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4fd3","root","");
                    Statement st = con.createStatement();
                    String sql = "SELECT * FROM invoicedata WHERE invoice='"+request.getParameter("Invoice")+"'";
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
                        out.println("<tr>");
                        out.println("<td width=\"10%\" align=\"center\">"+Integer.toString(recCount)+"</td>");
                        out.println("<td width=\"40%\" align=\"left\">"+rs.getString("description")+"</td>");
                        out.println("<td width=\"10%\" align=\"right\">"+rs.getString("quantity")+"</td>");
                        out.println("<td width=\"10%\" align=\"right\">");
                        if(dAmount > 0)
                        {
                            out.println(toTwoDec(rs.getString("price"))+"/"+rs.getString("unit"));
                        }
                        out.println("</td>");
                        out.println("<td width=\"10%\" align=\"right\">");
                        
                        if(dAmount > 0)
                        {
                            out.println(toTwoDec(Double.toString(roundToDecimal(dAmount,2))));
                            dTAmount = dTAmount + dAmount;
                        }
                        out.println("</td>");
                        out.println("<td width=\"10%\" align=\"right\">");
                        double dTax = 0;
                        dTax = dAmount * (Double.parseDouble(sTaxRate)/100);
                        dTax = Double.parseDouble(toTwoDec(Double.toString(roundToDecimal(dTax,2))));
                        if(!rs.getString("taxable").equalsIgnoreCase("Yes"))
                        {
                            dTax = 0; 
                        }
                        if(dAmount > 0)
                        {
                            out.println(toTwoDec(Double.toString(roundToDecimal(dTax,2))));
                            dTTax = dTTax + dTax;
                        }
                        out.println("</td>");
                        out.println("<td width=\"10%\" align=\"right\">");
                        double dCost = dAmount + dTax;
                        if(dAmount > 0)
                        {
                            out.println(toTwoDec(Double.toString(dCost)));
                            dTCost = dTCost + dCost;
                        }
                        out.println("</td>");
                        out.println("</tr>");
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
                out.println("<tr>");
                out.println("<td colspan=\"4\" align=\"right\"><b>Total: </b></td>");
                out.println("<td align=\"right\">"+toTwoDec(Double.toString(dTAmount))+"</td>");
                out.println("<td align=\"right\">"+toTwoDec(Double.toString(dTTax))+"</td>");
                out.println("<td align=\"right\">"+toTwoDec(Double.toString(dTCost))+"</td>");
                out.println("</tr>");
            %>
            <tr>
                <td colspan="2" align="right">
                    <br><br>
                    Approval:&nbsp;_____________________________________________
                </td>
                <td colspan="3" align="left">
                    <br><br>
                    Date:&nbsp;<u>____/____/________</u>
                </td>
            </tr>
        </table>
        </font>
    </body>
</html>
