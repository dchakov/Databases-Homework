namespace CommaSeparatedValue
{
    using System.Collections.ObjectModel;
    using System.Data.SqlTypes;
    using System.IO;
    using Microsoft.SqlServer.Server;

    [System.Serializable]
    [SqlUserDefinedAggregate(
    Format.UserDefined,
    IsInvariantToDuplicates = false,
    IsInvariantToNulls = false,
    IsInvariantToOrder = true,
    IsNullIfEmpty = true,
    MaxByteSize = -1,
    Name = "CommaSeparatedValue"
    )]

    public struct CommaSeparatedValue : IBinarySerialize
    {
        private Collection<string> list;
        private string delimiter;

        public void Init()
        {
            this.list = new Collection<string>();
            this.delimiter = string.Empty;
        }

        public void Accumulate(string value, string delimiter)
        {
            if (value != null)
            {
                if (this.delimiter != delimiter)
                {
                    this.delimiter = delimiter;
                }

                this.list.Add(value.ToString().Replace(this.delimiter, string.Empty));
            }
        }

        public void Merge(CommaSeparatedValue group)
        {
            if (null != group.list && group.list.Count > 0)
            {
                foreach (string entry in group.list)
                {
                    this.list.Add(entry);
                }
            }
        }

        public SqlString Terminate()
        {
            return new SqlString(string.Join(", ", this.list));
        }

        public void Write(BinaryWriter writer)
        {
            writer.Write(this.delimiter);
            foreach (string entry in this.list)
            {
                writer.Write(entry);
            }
        }

        public void Read(BinaryReader reader)
        {
            this.delimiter = reader.ReadString();
            this.list = new Collection<string>();
            while (reader.BaseStream.Position != reader.BaseStream.Length)
            {
                this.list.Add(reader.ReadString());
            }
        }
    }
}