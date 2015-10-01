namespace Processing_JSON_in_.NET
{
    using _03.Processing_JSON_in_.NET;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Linq;
    using System;
    using System.IO;
    using System.Linq;
    using System.Net;
    using System.Text;
    using System.Xml.Linq;

    public class Program
    {
        public static void Main()
        {
            // i.The RSS feed is located at https://www.youtube.com/feeds/videos.xml?channel_id=UCLC-vbm7OWvpbqzXaoAMGGw
            // ii.Download the content of the feed programatically

            string path = "../../feed.xml";
            string uri = "https://www.youtube.com/feeds/videos.xml?channel_id=UCLC-vbm7OWvpbqzXaoAMGGw";
            WebClient xmlFile = new WebClient();
            xmlFile.DownloadFile(uri, path);

            // iii.Parse teh XML from the feed to JSON

            XDocument document = XDocument.Load(path);
            string jsonFromXml = JsonConvert.SerializeXNode(document, Formatting.Indented);

            // iv.Using LINQ-to-JSON select all the video titles and print the on the console

            var jsonObj = JObject.Parse(jsonFromXml);
            var videoTitles = jsonObj["feed"]["entry"]
                              .Select(t => t["title"]);

            foreach (var item in videoTitles)
            {
                Console.WriteLine(item);
            }

            // v.Parse the videos' JSON to POCO

            var deserializeVideos = jsonObj["feed"]["entry"]
                .Select(t => JsonConvert.DeserializeObject<Video>(t.ToString()));

            foreach (var item in deserializeVideos)
            {
                Console.WriteLine(item.Id);
            }

            // vi.Using the POCOs create a HTML page that shows all videos from the RSS
            // Use <iframe>
            // Provide a links, that nagivate to their videos in YouTube

            StringBuilder html = new StringBuilder();
            html.Append("<!DOCTYPE html><html lang=\"en\" xmlns=\"http://www.w3.org/1999/xhtml\">" +
                "<head><meta charset=\"utf-8\" /><title></title></head><body>");

            foreach (var video in deserializeVideos)
            {
                html.Append(string.Format("<div><h4>{0}</h4><iframe width=\"300\" height=\"200\" " +
                                  "src=\"http://www.youtube.com/embed/{1}?autoplay=0\" ></iframe>" +
                                  "<a href=\"{2}\">Video on YouTube</a></div>",
                                 video.Title, video.Id, video.Link.Href));
            }
            html.Append("</body></html>");

            File.WriteAllText("../../index.html", html.ToString());
        }
    }
}
