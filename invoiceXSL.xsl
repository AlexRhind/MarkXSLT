<?xml version = "1.0" encoding = "UTF-8" ?>

<!-- Render this xml file an xsl stylesheet -->
<xsl:stylesheet version = "1.0"
                xmlns:xsl = "http://www.w3.org/1999/XSL/Transform">

<!-- Define the output as an HTML page -->
<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<!-- HTML page template and root (doc or /) definition -->
<xsl:template match = "dataroot">

<html>
  <head>
    <title>Invoice Output</title>
    <!-- The css goes in the head of the template -->
    <link rel="stylesheet" type="text/css" href="invoiceCSS.css" />
</head>

<body>


<!-- Grid wrapper -->
<div class="boundingGrid">

<div class="box1">

  <!-- there's more than 1 cusotmer, in so for-each here-->
  <xsl:for-each select="//customer">
    <h2>Customer details</h2>
    <ul>
      <li>
        Customer name: <xsl:value-of select="CustomerName"/>
      </li>
      <li>
        Address: <xsl:value-of select="Address"/>
      </li>
      <li>
        City: <xsl:value-of select="City"/>
      </li>
      <li>
        State/Province: <xsl:value-of select="StateProvince"/>
      </li>
      <li>
        Zip: <xsl:value-of select="ZipPostal"/>
      </li>
    </ul>
  </xsl:for-each>
</div>


 <div class="box2">

    <xsl:for-each select="//InvoiceData">
    <h2>Invoice details</h2>
        <ul>
          <li>Invoice ID: <xsl:value-of select="InvoiceID"/></li>
          <li>Invoice date: <xsl:value-of select="InvoiceDate"/></li>
        </ul>
        <br/>
   </xsl:for-each>


   <xsl:for-each select="//order">

<!--format-number(<xsl:value-of select="Tax"/>,"$#,###,###.00")
<xsl:value-of select="format-number(score, '#,###.00')"/>-->
   <h2>Order details</h2>
        <ul>
          <li>Order ID: <xsl:value-of select="OrderID"/></li>
          <li>Order placed: <xsl:value-of select="OrderDate"/></li>
          <li>Order taken by: <xsl:value-of select="SalesPerson"/></li>
          <li>Order value excluding tax: <xsl:value-of select='format-number("Tax", "#,###.##")'/>
        </li>
          <li>Tax: <xsl:value-of select="Tax"/>
        </li>


          <li>Order including tax: $<xsl:value-of select="OrderTotal"/></li>
        </ul>

    </xsl:for-each>

</div>

<div class="box3">

  <xsl:for-each select="//orderLines">

    <h2>Order summary</h2>
        <table class="tableHeader">
          <tr>
              <th>Prod ID</th>
              <th>Product</th>
              <th>Quantity</th>
              <th>Price</th>
              <th>Discount</th>
          </tr>

          <!-- //product/* -alternative: select all children of the product node in this doc -->
      <xsl:for-each select="product">
        <xsl:sort select="id" order = "ascending" data-type = "number" />
          <tr class="tableRow">
              <td><xsl:value-of select="id"/></td>
              <td><xsl:value-of select="ProductName"/></td>
              <td><xsl:value-of select="Quantity"/></td>
              <td><xsl:value-of select="UnitPrice"/></td>
              <td><xsl:value-of select="Discount"/></td>
          </tr>
      </xsl:for-each>

        </table>

  </xsl:for-each>

</div>



<div class="box4">

  <xsl:for-each select="//delivery">

    <xsl:for-each select="//delivery">
              <!-- Queries the xs:choice element -->
              <xsl:choose>
                    <!-- set a test for the choice value  dataroot/customer/InvoiceData/delivery/shipping -->
                    <xsl:when test="shipping">

                          <xsl:for-each select="//shipping">
                            <h2>Shipping details</h2>
                                <ul>
                                  <li>Shipping company used: <xsl:value-of select="ShipVia"/></li>
                                  <li>Deliver to: <xsl:value-of select="ShipName"/></li>
                                  <li>Address: <xsl:value-of select="ShipAddress"/></li>
                                  <li>City: <xsl:value-of select="ShipCity"/></li>
                                  <li>State/Province: <xsl:value-of select="ShipStateProvince"/></li>
                                  <li>Zip/Postcode: <xsl:value-of select="ShipZIPPostal"/></li>
                                  <li>Country: <xsl:value-of select="ShipCountryRegion"/></li>
                                  <li>Shipped on: <xsl:value-of select="ShippedDate"/></li>
                                  <li>Fee: <xsl:value-of select="ShippingFee"/></li>
                                </ul>
                          </xsl:for-each>
                    </xsl:when>

                    <!-- with ship or collect, collect is the only other option -->
                    <xsl:otherwise>
                          <xsl:for-each select="//collect">
                            <h2>Collection details</h2>
                                <ul>
                                  <li>Collection name: <xsl:value-of select="CollectName"/></li>
                                  <li>Collection ID: <xsl:value-of select="CollectID"/></li>
                                  <li>Collection date: <xsl:value-of select="CollectDate"/></li>
                                </ul>
                          </xsl:for-each>
                    </xsl:otherwise>

            </xsl:choose>

      </xsl:for-each>

  </xsl:for-each>

  <!-- end box4 -->
</div>
<!-- end grid wrapper -->
</div>

\
<!-- Close the tag -->
</xsl:stylesheet>
