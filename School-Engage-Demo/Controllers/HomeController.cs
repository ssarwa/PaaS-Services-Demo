using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Configuration;
using StackExchange.Redis;
using Microsoft.Azure;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using School_Engage_Demo.Models;
using System.IO;
using System.Threading.Tasks;
using System.Drawing;
using System.Net.Mime;

namespace School_Engage_Demo.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        public ActionResult RedisCache()
        {
            ViewBag.Message = "A simple example with Azure Cache for Redis on ASP.NET.";

            var lazyConnection = new Lazy<ConnectionMultiplexer>(() =>
            {
                string cacheConnection = ConfigurationManager.AppSettings["CacheConnection"].ToString();
                return ConnectionMultiplexer.Connect(cacheConnection);
            });

            // Connection refers to a property that returns a ConnectionMultiplexer
            // as shown in the previous example.
            IDatabase cache = lazyConnection.Value.GetDatabase();

            // Perform cache operations using the cache object...

            // Simple PING command
            ViewBag.command1 = "PING";
            ViewBag.command1Result = cache.Execute(ViewBag.command1).ToString();

            // Simple get and put of integral data types into the cache
            ViewBag.command2 = "GET Message";
            ViewBag.command2Result = cache.StringGet("Message").ToString();

            ViewBag.command3 = "SET Message \"Hello! The cache is working from ASP.NET!\"";
            ViewBag.command3Result = cache.StringSet("Message", "Hello! The cache is working from ASP.NET!").ToString();

            // Demonstrate "SET Message" executed as expected...
            ViewBag.command4 = "GET Message";
            ViewBag.command4Result = cache.StringGet("Message").ToString();

            // Get the client list, useful to see if connection list is growing...
            ViewBag.command5 = "CLIENT LIST";
            ViewBag.command5Result = cache.Execute("CLIENT", "LIST").ToString().Replace(" id=", "\rid=");

            lazyConnection.Value.Dispose();

            return View();
        }

        public ActionResult Storage()
        {
            ViewBag.Message = "Azure Storage Operations";
            return View(ListBlobs());
        }
        [HttpPost]
        public ActionResult Storage(HttpPostedFileBase file)
        {
            if (file != null)
            {
                string containerName = "images";
                if (file.ContentType == "application/pdf")
                {
                    containerName = "pdfs";
                }
                UploadFileToBlobStorage(containerName, file);
            }

            return View(ListBlobs());
        }

        public void UploadFileToBlobStorage(string containerName, HttpPostedFileBase file)
        {
            BlobContainerClient container = GetBlobContainer(containerName);
            
            BlobClient blobClient = container.GetBlobClient(file.FileName);
            blobClient.  UploadAsync(file.InputStream, true);
        }

        public static Containers ListBlobs()
        {
            BlobContainerClient images = GetBlobContainer("images");
            BlobContainerClient pdfs = GetBlobContainer("pdfs");
            Containers containers = new Containers();

            foreach (BlobItem item in images.GetBlobs())
            {
                containers.Images.Add(item.Name);
            }

            foreach (BlobItem item in pdfs.GetBlobs())
            {
                containers.Pdfs.Add(item.Name);
            }

            return containers;
        }

        private static BlobContainerClient GetBlobContainer(string containerName)
        {
            string storageAccountConnString = CloudConfigurationManager.GetSetting("schoolengage-con-str");
            BlobContainerClient containerClient = new BlobContainerClient(storageAccountConnString, containerName);
            return containerClient;
        }
    }
}