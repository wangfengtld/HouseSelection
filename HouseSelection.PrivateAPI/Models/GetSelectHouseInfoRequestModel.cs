﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HouseSelection.PrivateAPI.Models
{
    public class GetSelectHouseInfoRequestModel
    {
        public int ProjectID { get; set; }
        public int SubscriberID { get; set; }
    }
}