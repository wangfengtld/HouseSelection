﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using HouseSelection.Model;
using HouseSelection.PrivateAPI.Models;
using HouseSelection.BLL;
using HouseSelection.Authorize;
using HouseSelection.LoggerHelper;

namespace HouseSelection.PrivateAPI.Controllers
{
    /// <summary>
    /// 按楼盘名称搜索楼盘信息
    /// </summary>
    public class GetHouseEstatesController : ApiController
    {
        private HouseEstateBLL _houseEstateBLL = new HouseEstateBLL();

        [ApiAuthorize]
        public GetHouseEstateResultEntity Post(SearchRequestModel Req)
        {
            var ret = new GetHouseEstateResultEntity()
            {
                code = 0,
                errMsg = ""
            };
            try
            {
                var _houseEstateList = _houseEstateBLL.GetModelsByPage(Req.PageSize, Req.PageIndex, true, p => p.ID, x => x.Name.Contains(Req.SearchStr));
                var _hseList = new List<HouseEstateEntity>();
                foreach (var DBhe in _houseEstateList)
                {
                    var he = new HouseEstateEntity()
                    {
                        HouseEstateID = DBhe.ID,
                        ProjectNumber = DBhe.Project.Number,
                        ProjectName = DBhe.Project.Name,
                        HouseEstateName = DBhe.Name
                    };
                    _hseList.Add(he);
                }
                ret.HouseEstateList = _hseList;
                ret.recordCount = _houseEstateBLL.GetModels(x => x.Name.Contains(Req.SearchStr)).Count();
            }
            catch (Exception ex)
            {
                Logger.LogException("搜索楼盘信息时发生异常！", "GetHouseEstateInfoController", "Post", ex);
                ret.code = 999;
                ret.errMsg = ex.Message;
            }
            return ret;
        }
    }
}
