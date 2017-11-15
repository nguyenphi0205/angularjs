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
    //public class UserTest
    //{
    //    public int UserID { get; set; }
    //    public string UserName { get; set; }
    //    public string Password { get; set; }
    //}

    [RoutePrefix("api/User")]
    public class UserController : ApiController
    {
        public static StoreEntities userDB = new StoreEntities();

        

        [AllowCrossSiteJsonAttribute]
        [Route("GetAllUser")]
        [HttpGet]
        public HttpResponseMessage GetAllUseṛ()
        {
            userDB.Configuration.LazyLoadingEnabled = false;
            var UserInfor = userDB.Users.Select(
                u => new
                {
                    ID = u.UserID,
                    name = u.UserName,
                    firstname = u.Firstname,
                    lastname = u.Lastname,
                    userDoB = u.UserDOB,
                    Email = u.UserEmail,
                    gender = u.UserGender,
                    phone = u.UserPhone,
                    address = u.UserAddress

                }
                ).ToList();
            // var UserInfor = userDB.Users.Select(v=>new { id=v.UserID}).ToList();
            HttpResponseMessage respone = Request.CreateResponse();

            respone.Content = new StringContent(JsonConvert.SerializeObject(UserInfor, Formatting.None,
                        new JsonSerializerSettings()
                        {
                            ReferenceLoopHandling = ReferenceLoopHandling.Ignore
                        }));
            // respone.Content = new StringContent(JsonConvert.SerializeObject());
            return respone;
        }
        [AllowCrossSiteJsonAttribute]
        [Route("LoginUser")]
        [HttpPost]
        public HttpResponseMessage LoginUser(string username, string pass, string role)
        {
            //string username;
            // string pass;
            //  string username = "a";
            // string pass = "a";
            // string srequest = await Request.Content.ReadAsStringAsync();
            HttpResponseMessage respone = Request.CreateResponse();
            if (role == "user")
            {
                var userData = userDB.Users.Where(p => p.UserName == username && p.Password == pass && p.UserRole == role).FirstOrDefault();
               
                respone.Content = new StringContent("user dang nhap thanh cong");
          
            }
            else if (role == "Admin")
            {
                var userData = userDB.Users.Where(p => p.UserName == username && p.Password == pass && p.UserRole == role).FirstOrDefault();
              
                respone.Content = new StringContent("Admin dang nhap thanh cong");
              
            }
            return respone;

            //var userData = userDB.Users.Where(p => p.UserName == username && p.Password == pass && p.UserRole== role).FirstOrDefault();
            //HttpResponseMessage respone = Request.CreateResponse();

            //respone.Content = new StringContent(JsonConvert.SerializeObject(userData, Formatting.None,
            //            new JsonSerializerSettings()
            //            {
            //                ReferenceLoopHandling = ReferenceLoopHandling.Ignore
            //            }));
            //return respone;
        }
        [AllowCrossSiteJsonAttribute]
        [Route("LoginAdmin")]
        [HttpPost]
        public HttpResponseMessage LoginAdmin(string username, string pass)
        {
            //  string username = "a";
            // string pass = "a";
            // string srequest = await Request.Content.ReadAsStringAsync();
            var userData = userDB.Users.Where(p => p.UserName == username && p.Password == pass && p.UserRole == "Admin").FirstOrDefault();
            HttpResponseMessage respone = Request.CreateResponse();

            respone.Content = new StringContent(JsonConvert.SerializeObject(userData, Formatting.None,
                        new JsonSerializerSettings()
                        {
                            ReferenceLoopHandling = ReferenceLoopHandling.Ignore
                        }));
            return respone;
        }
        //search userID
        [AllowCrossSiteJsonAttribute]
        [Route("GetUserByID")]
        [HttpGet]
        public HttpResponseMessage GetUserByID(int id)
        { //var userDB = new StoreEntities();
            //var query = from user in userDB.Users
            //            where user.UserID == id
            //            select user;
            var userData = userDB.Users.Where(p => p.UserID == id).SingleOrDefault();
            HttpResponseMessage respone = Request.CreateResponse();
            respone.Content = new StringContent(JsonConvert.SerializeObject(userData, Formatting.None,
                        new JsonSerializerSettings()
                        {
                            ReferenceLoopHandling = ReferenceLoopHandling.Ignore
                        }));
            return respone;

        }
        [AllowCrossSiteJsonAttribute]
        [Route("AddUser")]
        [HttpPost]
        public async Task<HttpResponseMessage> AddUser()
        {
            string s = await Request.Content.ReadAsStringAsync();
            ServerStore.User _user = JsonConvert.DeserializeObject<ServerStore.User>(s);
            userDB.Users.Add(_user);
            userDB.SaveChanges();
            HttpResponseMessage respone = Request.CreateResponse();
            respone.Content = new StringContent("thanh cong");
            return respone;
        }

        [AllowCrossSiteJsonAttribute]
        [Route("DeleteUser")]
        [HttpPost]
        public HttpResponseMessage DeleteUser(int id)
        {
            var userData = userDB.Users.Where(p => p.UserID == id).SingleOrDefault();
            userDB.Users.Remove(userData);
            userDB.SaveChanges();
            HttpResponseMessage respone = Request.CreateResponse();
            respone.Content = new StringContent("thanh cong");
            return respone;
        }


        [AllowCrossSiteJsonAttribute]
        [Route("UpdateUser")]
        [HttpPost]
        public async Task<HttpResponseMessage> UpdateUser()
        {
            //GetUserByID
            //User EUser = GetUserByID(id);

            string s = await Request.Content.ReadAsStringAsync();
            ServerStore.User UpdateUser = JsonConvert.DeserializeObject<ServerStore.User>(s);

            var userUpdate = userDB.Users.Where(p => p.UserID == UpdateUser.UserID).SingleOrDefault();
            userUpdate.UserName = UpdateUser.UserName;
            userUpdate.Password = UpdateUser.Password;
            userUpdate.Firstname = UpdateUser.Firstname;
            userUpdate.Lastname = UpdateUser.Lastname;
            userUpdate.UserAddress = UpdateUser.UserAddress;
            userUpdate.UserDOB = UpdateUser.UserDOB;
            userUpdate.UserEmail = UpdateUser.UserEmail;
            userUpdate.UserGender = UpdateUser.UserGender;
            userUpdate.UserPhone = UpdateUser.UserPhone;
            userUpdate.UserRole = UpdateUser.UserRole;

            userDB.SaveChanges();
            HttpResponseMessage respone = Request.CreateResponse();
            respone.Content = new StringContent("thanh cong");
            return respone;
        }

    }


}
