﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HouseSelection.Model
{
    public class GetHouseResultEntity : BaseListResultEntity
    {
        public List<HouseEntity> HouseList { get; set; }
    }
}
