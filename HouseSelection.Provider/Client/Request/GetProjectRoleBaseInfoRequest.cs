﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HouseSelection.NetworkHelper;

namespace HouseSelection.Provider.Client.Request
{
    public class GetProjectRoleBaseInfoRequest : GeneralRequest
    {
        protected override string APIAddress
        {
            get { return "/api/GetProjectRoleBaseInfo"; }
        }

        public override PostRequestContentType ContentType
        {
            get { return PostRequestContentType.Json; }
        }

        /// <summary>
        /// ERP门店ID
        /// </summary>
        public int ProjectID { get; set; }
    }
}

