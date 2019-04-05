﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FrontierAccounts.Default" %>

<!DOCTYPE html>
<html>
  <head>
    <title>Accounts Coding Test</title>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
    <style>
      html, body {
        height: 100%;
        width: 100%;
        font-family: Roboto, Helvetica, Arial, sans-serif
      }
      article {
        height: 100%;
        grid-template-columns:1fr;
        grid-template-areas:
            "header"
            "main"
            "footer";
        grid-template-rows: 100px 1fr 150px;
      }
      header {
        grid-area: header;
        background-color:#006643;
        color: #fff;
        grid-template-columns: 1% 98% 1%;
      }
      h1 {
        font-size: 3em;
        font-weight: bold;
      }
      h2 {
        font-size: 2em;
        color:#006643;
      }
      h3 {
        display: block;
        font-size: 1.5em;
        color:#006643;
      }
      main {
        grid-area: main;
      }
      footer {
        grid-area: footer;
        background-color:#006643;
        color: #fff;
        grid-template-columns: 1% 98% 1%;
        grid-template-rows: 5% 90% 5%;
      }
      .grid {
        display: grid;
      }
      .title-container {
        grid-column-start: 2;
        align-self: center;
      }
      #home-content {
        grid-row-gap: 25px;
        grid-template-rows: 10px 100px auto;
      }
      #account-grid {
        grid-template-columns: 1fr 1fr 1fr;
        grid-row-start: 3;
      }
      .account-column {
        grid-template-rows: 2em repeat(2, 10em);
      }
      .content-title-container {
        justify-self: center;
        height: 1em;
        grid-row-start: 2;
      }
      #overdue-account-container-title > h3{
        color: #B22222;
      }
      #inactive-account-container-title > h3 {
        color:#808080;
      }
      .account-container {
        justify-self: center;
        height: 5em;
      }
      .account-container-title {
        justify-self: center;
      }
      .account-data-list {
        list-style: none;
      }
      .account-data-list > li {
        margin: 10px 0;
      }
      .account-data-list > li > label {
        font-weight: bold;
        margin: 0 5px 0 0;
      }
      .copy {
        place-self: end;
        grid-row-start: 2;
        grid-column-start: 2;
      }
    </style>
  </head>
  <body>
    <article class="grid">
      <header class="grid">
        <div class="title-container">
          <h1>Coding Test</h1>
        </div>
      </header>
      <main class="content grid" id="home-content">
        <div class="content-title-container">
          <h2>Accounts</h2>
        </div>
        <section class="grid" id="account-grid">
          <section class="account-column grid" id="active-account-column">
            <div class="account-container-title" id="active-account-container-title">
              <h3>Active</h3>
            </div>
            <div class="account-container active-account">
              <ul class="account-data-list" >
                <asp:Repeater ID="repeaterActiveList" Runat="server" >
                    <ItemTemplate>
                        <li><label>Name:</label><%# Eval("LastName") %>, <%# Eval("FirstName") %></li>
                        <li><label>Email:</label><%# Eval("Email") %></li>
                        <li><label>Phone Number:</label><%# String.Format("{0:(###) ###-####}", Convert.ToInt64(Eval("PhoneNumber"))) %></li>
                        <li><label>Amount Due:</label><%# Eval("AmountDue",  "{0:c}") %></li>
                        <li><label>Due Date:</label><%#  Eval("PaymentDueDate") != null ? Eval("PaymentDueDate", "{0:d}") : string.Empty %></li>
                    </ItemTemplate>
                </asp:Repeater>
              </ul>
            </div>     
          </section>
          <section class="account-column grid" id="overdue-account-column">
            <div class="account-container-title" id="overdue-account-container-title">
              <h3>Overdue</h3>
            </div>
            <div class="account-container overdue-account">
              <ul class="account-data-list">
                <asp:Repeater ID="repeaterOverDueList" Runat="server">
                    <ItemTemplate>
                        <li><label>Name:</label><%# Eval("LastName") %>, <%# Eval("FirstName") %></li>
                        <li><label>Email:</label><%# Eval("Email") %></li>
                        <li><label>Phone Number:</label><%# String.Format("{0:(###) ###-####}", Convert.ToInt64(Eval("PhoneNumber"))) %></li>
                        <li><label>Amount Due:</label><%# Eval("AmountDue",  "{0:c}") %></li>
                        <li><label>Due Date:</label><%#  Eval("PaymentDueDate") != null ? Eval("PaymentDueDate", "{0:d}") : string.Empty %></li>
                    </ItemTemplate>
                </asp:Repeater>
              </ul>
            </div>
          </section>
          <div class="account-column grid" id="inactive-account-column">
            <div class="account-container-title" id="inactive-account-container-title">
              <h3>Inactive</h3>
            </div>
            <div class="account-container inactive-account">
              <ul class="account-data-list">
                <asp:Repeater ID="repeaterInactiveList" Runat="server">
                    <ItemTemplate>
                        <li><label>Name:</label><%# Eval("LastName") %>, <%# Eval("FirstName") %></li>
                        <li><label>Email:</label><%# Eval("Email") %></li>
                        <li><label>Phone Number:</label><%# String.Format("{0:(###) ###-####}", Convert.ToInt64(Eval("PhoneNumber"))) %></li>
                        <li><label>Amount Due:</label><%# Eval("AmountDue",  "{0:c}") %></li>
                        <li><label>Due Date:</label><div><%#  Eval("PaymentDueDate") != null ? Eval("PaymentDueDate", "{0:d}") : string.Empty %></div></li>
                    </ItemTemplate>
                </asp:Repeater>
              </ul>
            </div>
          </div>
        </section>
      </main>
      <footer class="grid">
        <p class="copy">&copy;<script>document.write(new Date().getFullYear())</script></p>
      </footer>
    </article>
  </body>
</html>
