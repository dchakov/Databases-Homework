namespace _03.Processing_JSON_in_.NET
{
    using Newtonsoft.Json;

    public class Video
    {
        [JsonProperty("title")]
        public string Title { get; set; }

        [JsonProperty("link")]
        public Link Link { get; set; }

        [JsonProperty("yt:videoId")]
        public string Id { get; set; }
    }
}
