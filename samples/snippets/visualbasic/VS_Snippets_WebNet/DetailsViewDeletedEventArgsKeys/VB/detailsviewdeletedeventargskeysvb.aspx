<!-- <Snippet1> -->

<%@ Page language="VB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

  Sub StoresDetailView_ItemDeleted(ByVal sender As Object, _
    ByVal e As DetailsViewDeletedEventArgs)

    Dim entry As DictionaryEntry
    Dim i As Integer
    
    ' Display the value of the key fields in the Keys property.
    KeysMessageLabel.Text = _
      "The key fields for the deleted record are: <br/>"

    ' In VB, you cannot iterate through the DictionaryEntry objects
    ' in the Keys property directly. Use the CopyTo method to 
    ' copy the objects to an array first.
    Dim keysArray(e.Keys.Count - 1) As DictionaryEntry
    e.Keys.CopyTo(keysArray, 0)
    
    ' Iterate through the array and display its values.
    For Each entry In keysArray
    
      DisplayValue(entry, KeysMessageLabel)
    
    Next

    ' Display the value of the non-key fields in the Values 
    ' property.
    ValuesMessageLabel.Text = _
      "The non-key fields for the deleted record are: <br/>"

    Dim valuesArray(e.Values.Count - 1) As DictionaryEntry
    e.Values.CopyTo(valuesArray, 0)

    For Each entry In valuesArray
    
      DisplayValue(entry, ValuesMessageLabel)
    
    Next
    
  End Sub

  Sub DisplayValue(ByVal entry As DictionaryEntry, _
    ByVal displayLabel As Label)
  
    ' Display the field name contained in the DictionaryEntry object.
    If entry.Key IsNot Nothing Then
    
      displayLabel.Text &= "Name=" & entry.Key.ToString() & ", "
    
    Else
    
      displayLabel.Text &= "Name=null, "
      
    End If

    ' Display the field value contained in the DictionaryEntry object.
    If entry.Value IsNot Nothing Then
    
      displayLabel.Text &= "Value=" & entry.Value.ToString() & "<br/>"
    
    Else
    
      displayLabel.Text &= "Value=null<br/>"
      
    End If
        
  End Sub

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
  <head runat="server">
    <title>DetailsViewDeletedEventArgs Keys and Values Example</title>
</head>
<body>
    <form id="form1" runat="server">
        
      <h3>DetailsViewDeletedEventArgs Keys and Values Example</h3>
                
        <asp:detailsview id="CustomerDetailsView"
          datasourceid="DetailsViewSource"
          datakeynames="CustomerID"
          autogeneratedeletebutton="true"  
          autogeneraterows="true"
          allowpaging="true"
          onitemdeleted="StoresDetailView_ItemDeleted" 
          runat="server">
               
          <fieldheaderstyle backcolor="Navy"
            forecolor="White"/>
                    
        </asp:detailsview>
        
        <asp:label id="KeysMessageLabel"
          forecolor="Red"
          runat="server"/>
          
        <br/><br/>
          
        <asp:label id="ValuesMessageLabel"
          forecolor="Red"
          runat="server"/>
            
        <!-- This example uses Microsoft SQL Server and connects  -->
        <!-- to the Northwind sample database. Use an ASP.NET     -->
        <!-- expression to retrieve the connection string value   -->
        <!-- from the web.config file.                            -->
        <asp:sqldatasource id="DetailsViewSource"
          selectcommand="Select [CustomerID], [CompanyName], [Address], 
            [City], [PostalCode], [Country] From [Customers]"
          deletecommand="Delete [Customers] 
            Where [CustomerID]=@CustomerID"
          connectionstring=
            "<%$ ConnectionStrings:NorthWindConnectionString%>" 
         runat="server"/>
            
      </form>
  </body>
</html>

<!-- </Snippet1> -->