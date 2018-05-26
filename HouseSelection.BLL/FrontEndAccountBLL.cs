﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HouseSelection.DAL;
using HouseSelection.Model;

namespace HouseSelection.BLL
{
    public class FrontEndAccountBLL : BaseBLL<FrontEndAccount>
    {
        public override void SetDAL()
        {
            _dal = new FrontEndAccountDAL();
        }
    }
}