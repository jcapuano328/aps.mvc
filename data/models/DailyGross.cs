﻿using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace ica.aps.data.models
{
    [DataContract]
    public class DailyGross
    {
        [DataMember]
        public Guid? DailyGrossID { get; set; }        
        [DataMember]
        public DateTime GrossTDS { get; set; }
        [DataMember]
        public decimal Gross { get; set; }
        [DataMember]
        public DateTime ModifiedTDS { get; set; }
        [DataMember]
        public string ModifiedBy { get; set; }
        [DataMember]
        public bool Dirty { get; set; }
    }
}
