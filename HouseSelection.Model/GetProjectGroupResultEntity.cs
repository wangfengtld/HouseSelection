﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HouseSelection.Model
{
    public class GetProjectGroupResultEntity : BaseListResultEntity
    {
        public List<ProjectGroupEntity> ProjectGroupList { get; set; }
    }
}
