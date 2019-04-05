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
            var accounts = GetAccounts();
            if (accounts != null && accounts.Count > 0)
                bindLists(accounts);
        }

        //TODO: This could have been done in jquery as an ajax call
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

        //Chose to use a repeater with the list. But a more up todate way to implement may have been to use some other jquery or javascript based control
        //Could have made a generic method to take in a type T of usercontrol and bind the control based on a passed value
        //That meethod would be static and in it's own file so other pages could use it.
        private void bindLists(List<Account> accounts)
        {
            repeaterActiveList.DataSource = accounts.Where(x => (AccountStatus)x.AccountStatusId == AccountStatus.Active).ToList();
            repeaterActiveList.DataBind();

            repeaterOverDueList.DataSource = accounts.Where(x => (AccountStatus)x.AccountStatusId == AccountStatus.Overdue).ToList();
            repeaterOverDueList.DataBind();

            repeaterInactiveList.DataSource = accounts.Where(x => (AccountStatus)x.AccountStatusId == AccountStatus.Inactive).ToList();
            repeaterInactiveList.DataBind();
        }
    }

    //TODO: Move these classes to a seperate MODELS folder with other classes
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
