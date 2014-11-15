<%-- 
    Document   : ClientScreen
    Created on : Nov 9, 2014, 4:19:57 PM
    Author     : Gord
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>CSE | Client Screen</title>
<link href="styles/aboutPageStyle.css" rel="stylesheet" type="text/css">

<!--The following script tag downloads a font from the Adobe Edge Web Fonts server for use within the web page. We recommend that you do not modify it.-->
<script>var __adobewebfontsappname__="dreamweaver"</script><script src="http://use.edgefonts.net/montserrat:n4:default;source-sans-pro:n2:default.js" type="text/javascript"></script>
<script language="JavaScript">
</script>
<%!

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
 * Unformat a date so that it is just numbers
 * Returns the unformatted date in string format
 * @param   sDate       the date to be unformatted
 */
private String unformatDate(String sDate)
{
    String sDateVals[] = sDate.split("-");
    return sDateVals[0]+sDateVals[1]+sDateVals[2];
}
/**
 * format a date to "yyyy-mm-dd"
 * Returns the unformatted date in string format
 * @param   sDate       the date to be formatted
 */
private String formatDate(String sDate)
{
    return sDate.substring(0,4)+"-"+sDate.substring(4,6)+"-"+sDate.substring(6);
}
/**
 * Create an Insert Statement
 * @param   sID         the ID value
 * @param   sName       the client name
 * @param   sContact    the contact person
 * @param   sTitle      the contact title
 * @param   sAddr1      the first part of the address
 * @param   sAddr2      the second part of the address
 * @param   sCity       the city
 * @param   sProv       the province
 * @param   sPostal     the postal code
 * @param   sPhone      the phone number
 * @param   sFax        the fax number
 * @param   sWeb        the website
 * @param   sEmail      the email address
 * @param   sRep        the representative for the client
 * @param   sFUDate     the follow up date
 * @param   sRate       the rate to charge the client
 * @param   sNotes      any other notes about the client
 * @param   sActive     whether the client is active or not
 */
private void doInsert(String sID,String sName,String sContact,String sTitle,String sAddr1,String sAddr2,String sCity,String sProv,String sPostal,String sPhone,String sFax,String sWeb,String sEmail,String sRep,String sTech,String sFUDate,String sRate,String sNotes,String sActive)
{
    String sInsert = "INSERT INTO clients VALUES('"+sID+"','"+sName+"','"+sContact+"','"+sTitle+"','"+sAddr1+"','"+sAddr2+"','"+sCity+"','"+sProv+"','"+sPostal+"','"+sPhone+"','"+sFax+"','"+sWeb+"','"+sEmail+"','"+sRep+"','"+sTech+"','"+sFUDate+"',"+sRate+",'"+sNotes+"','"+sActive+"')";
    doNonQuery(sInsert);
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
 * Update the ID and set it up to be unique
 * returns a string with the ID when it is done updating
 * @param   sNewValue       the new value
 * @param   sKeyValue       the old value
 */
private String updateID(String sNewValue, String sKeyValue)
{
    String sID = "";
    String sID2 = "";
    String sUpdate = "";
    if(sNewValue != sKeyValue)
    {
        sID = sNewValue;
        sID2 = sNewValue;
        sID = makeUnique(sID,sID2);
    }
    return sID;
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
%>
</head>

<%
int currentRecord = 0;
//get the current record
try
{
    currentRecord = Integer.parseInt(request.getParameter("RecordNo"));
}
catch(NumberFormatException e)
{
    currentRecord = 0;
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
    //Insert
    if(request.getParameter("hdnAction").equals("I"))
    {
        String sID = request.getParameter("txtClientCode");
        String sID2 = sID;
        sID = makeUnique(sID,sID2);
        String sCheckActive = request.getParameter("chkActive")+"_a";
        String sActiveValue = "false";
        if(sCheckActive.equalsIgnoreCase("on_a"))
        {
            sActiveValue = "true";
        }
        doInsert(sID,request.getParameter("txtClientName"),request.getParameter("txtContactPerson"),request.getParameter("txtTitle"),request.getParameter("txtAddress1"),request.getParameter("txtAddress2"),request.getParameter("txtCity"),request.getParameter("txtProv"),request.getParameter("txtPostal"),request.getParameter("txtTel"),request.getParameter("txtFax"),request.getParameter("txtWeb"),request.getParameter("txtEmail"),request.getParameter("cmbRep"),request.getParameter("cmbTech"),unformatDate(request.getParameter("txtFUDate")),toTwoDec(request.getParameter("txtRate")),request.getParameter("mmonotes").trim(),sActiveValue);
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
    //Update
    if(request.getParameter("hdnAction").equals("U"))
    {
        //make ID unique
        String sID = request.getParameter("txtClientCode");
        String sID2 = sID;
        String sOrigID = request.getParameter("hdnOrigCode");
        if(!sID.equals(sOrigID))
        {
            sID = makeUnique(sID,sID2);
        }
        
        
        updateSRecord("clients","clientID",sID,"clientID",sOrigID);
        updateSRecord("quotes","client",sID,"client",sOrigID);
        updateSRecord("invoices","client",sID,"client",sOrigID);
        updateSRecord("clients","clientname",request.getParameter("txtClientName"),"clientID",sOrigID);
        updateSRecord("clients","contactperson",request.getParameter("txtContactPerson"),"clientID",sOrigID);
        updateSRecord("clients","contacttitle",request.getParameter("txtTitle"),"clientID",sOrigID);
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
        updateSRecord("clients","postal",request.getParameter("txtPostal"),"clientID",sOrigID);
        updateSRecord("clients","phone",request.getParameter("txtTel"),"clientID",sOrigID);
        updateSRecord("clients","fax",request.getParameter("txtFax"),"clientID",sOrigID);
        updateSRecord("clients","web",request.getParameter("txtWeb"),"clientID",sOrigID);
        updateSRecord("clients","email",request.getParameter("txtEmail"),"clientID",sOrigID);
        updateSRecord("clients","rep",request.getParameter("cmbRep"),"clientID",sOrigID);
        updateSRecord("clients","tech",request.getParameter("cmbTech"),"clientID",sOrigID);
        updateSRecord("clients","followupdate",unformatDate(request.getParameter("txtFUDate")),"clientID",sOrigID);
        updateNRecord("clients","rate",toTwoDec(request.getParameter("txtRate")),"clientID",sOrigID); 
        updateSRecord("clients","notes",request.getParameter("mmonotes").trim(),"clientID",sOrigID);
        currentRecord = 0;
        
        //get current record
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
        
        //out.println(sID+"-"+Integer.toString(currentRecord));
    }
}
catch(NullPointerException e)
{
}
//get the max record, next record, and previous record
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
//redirect if insert so that if refreshed, cannot insert again.
if(request.getParameter("hdnAction").equals("I"))
{
    out.println("<body onload=\"window.location.href='ClientScreen.jsp?RecordNo="+String.valueOf(currentRecord)+"&hdnAction=V'\">");
}
else
{
    out.println("<body>");
}
%>
<!-- Header content -->
<header>
  <div class="profileLogo">
    <!-- Profile logo. Add a img tag in place of <span>. -->
    <form name="form2" action ="ClientScreen.jsp" method="GET">
          <label>Search</label><input type="search" name="txtSearch" placeholder="Search"></input><input type="hidden" name="hdnAction" value="S"></input><button type="button" onclick="document.form2.submit();">Search</button>
    </form>
  </div>
  <div class="profilePhoto">
    <!-- Profile photo -->
      <img src="images/profilephoto.png" alt="sample">
  </div>
  <!-- Identity details -->
  <div class="profileHeader">
  	<table width="50%">
  		<tr>
  			<td colspan="2">
                            <%
                                //New Record
                                if(request.getParameter("hdnAction").equals("N"))
                                {
                                    out.println("<button type=\"button\" style=\"width:24%;\" onclick=\"document.form1.submit();\">Commit Record</button>");
                                    out.println("<button type=\"button\" style=\"width:24%;\" onclick=\"window.location.href='ClientScreen.jsp?hdnAction=V'\">Cancel</button>");
                                }
                                else
                                {
                                    out.println("<button type=\"button\" style=\"width:24%;\" onclick=\"window.location.href='ClientScreen.jsp?RecordNo="+String.valueOf(prevRecord)+"&hdnAction=V'\">&lt;</button>");
                                    out.println("<button type=\"button\" style=\"width:24%;\" onclick=\"window.location.href='ClientScreen.jsp?RecordNo="+String.valueOf(nextRecord)+"&hdnAction=V'\">&gt;</button>");
                                    out.println("<button type=\"button\" style=\"width:24%;\" onclick=\"window.location.href='ClientScreen.jsp?hdnAction=N'\">+</button>");
                                    out.println("<button type=\"button\" style=\"width:24%;\" onclick=\"document.form1.submit();\">Commit Change</button>");
                                }
                                
                            %>
        	</td>
  		</tr>
                <form name="form1" action="ClientScreen.jsp" method="GET">
  		<tr>
  			<td align="right">
                            <label>Client Code</label>
  			</td>
  			<td>
                            <%
                                //for all like this, if new, set blank, if not, get value of current record
                                if(request.getParameter("hdnAction").equals("N"))
                                {
                                    out.println("<input type=\"hidden\" name=\"hdnAction\" value=\"I\"></input>");
                                }
                                else
                                {
                                    out.println("<input type=\"hidden\" name=\"hdnAction\" value=\"U\"></input>");
                                }
                            %>
                            
                            <%
                                if(request.getParameter("hdnAction").equals("N"))
                                {
                                    out.println("<input type=\"hidden\" name=\"hdnOrigCode\" value=\"\"></input>");
                                    out.println("<input type=\"text\" name=\"txtClientCode\" value=\"\" style=\"width:99%;\"></input>"); 
                                }
                                else
                                {
                                    out.println("<input type=\"hidden\" name=\"hdnOrigCode\" value=\""+getField("clients","clientID",currentRecord)+"\"></input>");
                                    out.println("<input type=\"text\" name=\"txtClientCode\" value=\""+getField("clients","clientID",currentRecord)+"\" style=\"width:99%;\"></input>"); 
                                }   
                            %>
  			</td>
  		</tr>
		<tr>
  			<td align="right">
  				<label>Client Name</label>
  			</td>
  			<td>
                            <%
                                
                                if(request.getParameter("hdnAction").equals("N"))
                                {
                                    out.println("<input type=\"text\" name=\"txtClientName\" value=\"\" style=\"width:99%;\"></input>");
                                }
                                else
                                {
                                    out.println("<input type=\"text\" name=\"txtClientName\" value=\""+getField("clients","clientname",currentRecord)+"\" style=\"width:99%;\"></input>");
                                }
  				
                            %>
  			</td>
  		</tr>
  		<tr>
			<td align="right">
				<label>Contact Person</label>
			</td>
			<td>
                            <%
                                if(request.getParameter("hdnAction").equals("N"))
                                {
                                    out.println("<input type=\"text\" name=\"txtContactPerson\" value=\"\" style=\"width:99%;\"></input>");
                                }
                                else
                                {
                                    out.println("<input type=\"text\" name=\"txtContactPerson\" value=\""+getField("clients","contactperson",currentRecord)+"\" style=\"width:99%;\"></input>");
                                }
				
                            %>
			</td>
  		</tr>
  		<tr>
			<td align="right">
				<label>Job Title</label>
			</td>
			<td>
                            <%
                                if(request.getParameter("hdnAction").equals("N"))
                                {
                                    out.println("<input type=\"text\" name=\"txtTitle\" value=\"\" style=\"width:99%;\"></input>");
                                }
                                else
                                {
                                    out.println("<input type=\"text\" name=\"txtTitle\" value=\""+getField("clients","contacttitle",currentRecord)+"\" style=\"width:99%;\"></input>");
                                }
				
                            %>
			</td>
  		</tr>
  		<tr>
  			<td colspan="2" align="center">
                            <%
                                
                                if(request.getParameter("hdnAction").equals("N"))
                                {
                                    out.println("<input type=\"Checkbox\" name=\"chkActive\" checked>Active</input>");
                                }
                                else
                                {
                                    String sActive1 = "";
                                    if(getField("clients","active",currentRecord).equalsIgnoreCase("true"))
                                    {
                                        sActive1 = " checked";
                                    }
                                    out.println("<input type=\"Checkbox\" name=\"chkActive\""+sActive1+">Active</input>");
                                }
                                
                            %>
  			</td>
  		</tr>
  	</table>
    <hr>
  </div>
</header>
<!-- content -->
<div class="mainContent">
  <!-- Contact details -->
  <section class="section1">
    <h2 class="sectionTitle">Client Details</h2>
    <hr class="sectionTitleRule">
    <hr class="sectionTitleRule2">
    <div class="section1Content">
      <table width=100%>
      	<tr>
      		<td align="right">
      			<label><span>Address :</span></label>
      		</td>
      		<td>
                    <%
                        if(request.getParameter("hdnAction").equals("N"))
                        {
                            out.println("<input type=\"text\" name=\"txtAddress1\" value=\"\" style=\"width:99%;\"></input>");
                        }
                        else
                        {
                            out.println("<input type=\"text\" name=\"txtAddress1\" value=\""+getField("clients","address1",currentRecord)+"\" style=\"width:99%;\"></input>");
                        }
                    %>
      		</td>
      	</tr>
      	<tr>
			<td align="right">
			</td>
			<td>
                            <%
                                if(request.getParameter("hdnAction").equals("N"))
                                {
                                    out.println("<input type=\"text\" name=\"txtAddress2\" value=\"\" style=\"width:99%;\"></input>");
                                }
                                else
                                {
                                    out.println("<input type=\"text\" name=\"txtAddress2\" value=\""+getField("clients","address2",currentRecord)+"\" style=\"width:99%;\"></input>");
                                }
				
                            %>            
			</td>
      	</tr>
      	<tr>
			<td align="right">
			</td>
			<td>
                            <%
                                if(request.getParameter("hdnAction").equals("N"))
                                {
                                    out.println("<input type=\"text\" name=\"txtCity\" value=\"\" style=\"width:59%;\"></input>");
                                    out.println("<input type=\"text\" name=\"txtProv\" value=\"\" style=\"width:10%;\"></input>");
                                    out.println("<input type=\"text\" name=\"txtPostal\" value=\"\" style=\"width:28%;\"></input>");
                                }
                                else
                                {
                                    out.println("<input type=\"text\" name=\"txtCity\" value=\""+getField("clients","city",currentRecord)+"\" style=\"width:59%;\"></input>");
                                    out.println("<input type=\"text\" name=\"txtProv\" value=\""+getField("clients","prov",currentRecord)+"\" style=\"width:10%;\"></input>");
                                    out.println("<input type=\"text\" name=\"txtPostal\" value=\""+getField("clients","postal",currentRecord)+"\" style=\"width:28%;\"></input>");
                                }		
                            %>            
			</td>
      	</tr>
      	<tr>
			<td align="right">
				<label><span>Tel :</span></label>
			</td>
			<td>
                            <%
                                if(request.getParameter("hdnAction").equals("N"))
                                {
                                    out.println("<input type=\"tel\" name=\"txtTel\" value=\"\" style=\"width:99%;\"></input>");
                                }
                                else
                                {
                                    out.println("<input type=\"tel\" name=\"txtTel\" value=\""+getField("clients","phone",currentRecord)+"\" style=\"width:99%;\"></input>");
                                }				
                            %>
			</td>
      	</tr>
      	<tr>
			<td align="right">
				<label><span>Fax :</span></label>
			</td>
			<td>
                            <%
                                if(request.getParameter("hdnAction").equals("N"))
                                {
                                    out.println("<input type=\"tel\" name=\"txtFax\" value=\"\" style=\"width:99%;\"></input>");
                                }
                                else
                                {
                                    out.println("<input type=\"tel\" name=\"txtFax\" value=\""+getField("clients","fax",currentRecord)+"\" style=\"width:99%;\"></input>");
                                }				
                            %>
                        </td>
      	</tr>
      	<tr>
			<td align="right">
				<label><span>Web</span></label>
			</td>
			<td>
                            <%
                                if(request.getParameter("hdnAction").equals("N"))
                                {
                                    out.println("<input type=\"url\" name=\"txtWeb\" value=\"\" style=\"width:69%;\"></input>");
                                }
                                else
                                {
                                    out.println("<input type=\"url\" name=\"txtWeb\" value=\""+getField("clients","web",currentRecord)+"\" style=\"width:69%;\"></input><button type=\"button\" style=\"width:29%;\" onclick=\"window.open('"+getField("clients","web",currentRecord)+"');return false;\">Go</button>");
                                }
                            %>
			</td>
      	</tr>
      	<tr>
			<td align="right">
				<label><span>Email</span></label>
			</td>
			<td>
                            <%
                                if(request.getParameter("hdnAction").equals("N"))
                                {
                                    out.println("<input type=\"email\" name=\"txtEmail\" value=\"\" style=\"width:69%;\"></input>");
                                }
                                else
                                {
                                    out.println("<input type=\"email\" name=\"txtEmail\" value=\""+getField("clients","email",currentRecord)+"\" style=\"width:69%;\"></input><button type=\"button\" style=\"width:29%;\" onclick=\"window.location.href='mailto:"+getField("clients","email",currentRecord)+"';return false;\">Email</button>");
                                }
                            %>
			</td>
      	</tr>
        <tr>
                <td align="right">
                        <label><span>Rep</span></label>
                </td>
                <td>
                        <select name="cmbRep" style="width:44%;">
                        <%
                            if(request.getParameter("hdnAction").equals("N"))
                            {
                                out.println(getSelectOptions(""));
                            }
                            else
                            {
                                String sRep = getField("clients","rep",currentRecord);
                                out.println(getSelectOptions(sRep));
                            }
                        %>
                        </select>
                        <label style="width:20%;"><span>Tech</span></label>
                        <select name="cmbTech" style="width:44%;">
                        <%
                            if(request.getParameter("hdnAction").equals("N"))
                            {
                                out.println(getSelectOptions(""));
                            }
                            else
                            {
                                String sTech = getField("clients","tech",currentRecord);
                                out.println(getSelectOptions(sTech));
                            }
                        %>
                        </select>
                </td>
        </tr>
        <tr>
            <td align="right">
                <label><span>Follow Up Date</span></label>
            </td>
            <td>
                <%
                    if(request.getParameter("hdnAction").equals("N"))
                    {
                        out.println("<input name=\"txtFUDate\" type=\"date\" step=\"7\" value = \"\" style=\"width:44%;\"></input>");
                    }
                    else
                    {
                        String sDate = formatDate(getField("clients","followupdate",currentRecord));
                        out.println("<input name=\"txtFUDate\" type=\"date\" step=\"7\" value = \""+sDate+"\" style=\"width:44%;\"></input>");
                    }
                %>
            </td>
        </tr>
        <tr>
            <td align="right">
                <label><span>Rate</span></label>
            </td>
            <td>
                <%
                    if(request.getParameter("hdnAction").equals("N"))
                    {
                        out.println("<input name=\"txtRate\" type=\"number\" step=\"0.01\" value=\"\" min = \"0.00\" placeholder=\"0.00\" style=\"width:44%;text-align:right;\"></input>");
                    }
                    else
                    {
                        String sRate = getField("clients","rate",currentRecord);
                        out.println("<input name=\"txtRate\" type=\"number\" step=\"0.01\" value=\""+toTwoDec(sRate)+"\" min = \"0.00\" placeholder=\"0.00\" style=\"width:44%;text-align:right;\"></input>");
                    }
                %>
            </td>
        </tr>
      </table>
    </div>
  </section>
  <!-- Previous experience details -->
  <section class="section2">
    <h2 class="sectionTitle">Notes</h2>
    <hr class="sectionTitleRule">
    <hr class="sectionTitleRule2">
    <!-- First Title & company details  -->
    <div class="section2Content">
		
                    <% 
                        String sOut = "<textarea style=\"width:100%;\" rows=\"10\" name=\"mmonotes\">";
                        if(!request.getParameter("hdnAction").equals("N"))
                        {
                            sOut = sOut + getField("clients","notes",currentRecord);
                        }
                        sOut = sOut + "</textarea>";
                        out.println(sOut);
                    %>
                
    </div>
</form>

    <!-- Replicate the above Div block to add more title and company details -->
  </section>
  <!-- Links to expore your past projects and download your CV -->
  <div class="externalResourcesNav">
    <div class="externalResources"><a href="QuoteScreen.jsp?hdnAction=V" title="Quote Screen">Quote Screen</a> </div>
    <span class="stretch"></span>
    <div class="externalResources"><a href="InvoiceScreen.jsp?hdnAction=V" title="Invoice Screen">Invoice Screen</a> </div>
  </div>
</div>
<footer>
  <hr>
  <p class="footerDisclaimer">A1 Software: <span>All Rights Reserved</span></p>
  <p class="footerNote">Hello, <label>Michael</label> <span>Logout</span></p>
</footer>
</body>
</html>

