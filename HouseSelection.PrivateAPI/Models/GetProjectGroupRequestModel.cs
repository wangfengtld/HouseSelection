﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HouseSelection.PrivateAPI.Models
{
    public class GetProjectGroupRequestModel : BaseRequestModel
    {
        public int ProjectID { get; set; }
    }
}