using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Newtonsoft.Json;
using System.Threading.Tasks;

namespace ServerStore.Controllers
{
    [RoutePrefix("api/PETS")]
    public class PetController : ApiController
    {

        public  StoreEntities petDB = new StoreEntities();
        //Get product
        [AllowCrossSiteJsonAttribute]
        [Route("GetPets")]
        [HttpGet]
        public HttpResponseMessage GetAllProduct()
        {
            petDB.Configuration.LazyLoadingEnabled = false;
            var proInfo = petDB.Products.Select
                (v => new
                {
                    ID = v.ProductID,
                    name = v.ProductName,
                    price = v.Price,
                    des = v.Description,
                    image = v.Image,
                    quantity = v.Quantity
                   
                }
                ).ToList();
            HttpResponseMessage respone = Request.CreateResponse();
            respone.StatusCode = HttpStatusCode.OK;
            respone.Content = new StringContent(JsonConvert.SerializeObject(proInfo, Formatting.None,
                        new JsonSerializerSettings()
                        {
                            ReferenceLoopHandling = ReferenceLoopHandling.Ignore
                        }));
            return respone;
        }
        //add pets
        [AllowCrossSiteJsonAttribute]
        [Route("Addpets")]
        [HttpPost]
        public async Task<HttpResponseMessage> AddPets()
        {
            string s = await Request.Content.ReadAsStringAsync();
            ServerStore.Product _user = JsonConvert.DeserializeObject<ServerStore.Product>(s);
            petDB.Products.Add(_user);
            petDB.SaveChanges();
            HttpResponseMessage respone = Request.CreateResponse();
            respone.Content = new StringContent("thanh cong");
            return respone;
        }


    }
}
