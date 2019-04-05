using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontierAccounts
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bindLists(GetAccounts());
        }

        public List<Account> GetAccounts()
        {
            List<Account> accounts = new List<Account>();
            HttpClient client = new HttpClient();
            client.BaseAddress = new Uri("https://frontiercodingtests.azurewebsites.net/");
            HttpResponseMessage response = client.GetAsync($"api/accounts/getall").Result;
            if (response.IsSuccessStatusCode)
            {
                var responseContent = response.Content.ReadAsStringAsync().Result;
                if (responseContent != null)
                {
                    accounts = JsonConvert.DeserializeObject<List<Account>>(responseContent);
                }
            }
            return accounts;
        }

        private void bindLists(List<Account> accounts)
        {
            repeaterActiveList.DataSource = accounts.Where(x => (AccountStatus)x.AccountStatusId == AccountStatus.Active).ToList();
            repeaterActiveList.DataBind();

            repeaterOverDueList.DataSource = accounts.Where(x => (AccountStatus)x.AccountStatusId == AccountStatus.Overdue).ToList();
            repeaterOverDueList.DataBind();

            repeaterInactiveList.DataSource = accounts.Where(x => (AccountStatus)x.AccountStatusId == AccountStatus.Inactive).ToList();
            repeaterInactiveList.DataBind();
        }

        protected void repeaterInactiveList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            foreach (RepeaterItem item in repeaterInactiveList.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    var listItem = e.Item.FindControl("liDueDate");


                        //item.FindControl("liDueDate") as ListItem;



                }
            }
        }
    }

    public class Account
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public decimal AmountDue { get; set; }
        public DateTime? PaymentDueDate { get; set; }
        public int AccountStatusId { get; set; }
    }

    enum AccountStatus
    {
        Active,
        Inactive,
        Overdue
    }
}