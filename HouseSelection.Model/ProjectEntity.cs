﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HouseSelection.Model
{
    public class ProjectEntity
    {
        /// <summary>
        /// 项目ID
        /// </summary>
        public int ID { get; set; }

        /// <summary>
        /// 项目编号
        /// </summary>
        public string Number { get; set; }

        /// <summary>
        /// 项目名称
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// 项目地址
        /// </summary>
        public string Address { get; set; }

        /// <summary>
        /// 项目所属区域
        /// </summary>
        public string ProjectArea { get; set; }

        /// <summary>
        /// 开发企业
        /// </summary>
        public string DevelopCompany { get; set; }

        /// <summary>
        /// 预售证号
        /// </summary>
        public string IdentityNumber { get; set; }

        /// <summary>
        /// 项目是否结束
        /// </summary>
        public bool IsEnd { get; set; }

        /// <summary>
        /// 项目结束原因
        /// </summary>
        public string EndReason { get; set; }
    }
}
