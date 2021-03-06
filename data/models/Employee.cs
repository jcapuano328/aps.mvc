﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;

namespace ica.aps.data.models
{
    [DataContract]
    public class Employee
    {
        [DataMember]
        public Guid? EmployeeID { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Title { get; set; }
        public int Sequence { get; set; }
        [DataMember]
        public IEnumerable<Rent> Rents { get; set; }
        [DataMember]
        public bool Enabled { get; set; }
        [DataMember]
        public DateTime Modified { get; set; }
        [DataMember]
        public string ModifiedBy { get; set; }

        public Rent EffectiveRent(DateTime? dt = null)
        {
            try
            {
                if (this.Rents == null || this.Rents.Count() < 1)
                    return new Rent { RentPct = 0 };

                if (dt == null || !dt.HasValue)
                    dt = DateTime.Now;

                var rent =
                    from r in this.Rents
                    where r.EffectiveTDS <= dt
                    orderby r.EffectiveTDS descending
                    select r;

                if (rent != null)
                    return rent.First();
                return this.Rents.First();
            }
            catch
            {
                return this.Rents.First();
            }
        }
    }
}
