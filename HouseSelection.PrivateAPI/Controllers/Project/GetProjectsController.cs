﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using HouseSelection.Model;
using HouseSelection.BLL;
using HouseSelection.Authorize;
using HouseSelection.LoggerHelper;
using HouseSelection.PrivateAPI.Models;
using HouseSelection.Utility;

namespace HouseSelection.PrivateAPI.Controllers
{
    public class GetProjectsController : ApiController
    {
        private ProjectBLL _projectBLL = new ProjectBLL();

        [ApiAuthorize]
        public ProjectListResultEntity Post(SearchRequestModel Search)
        {
            Logger.LogDebug("GetProjects Request:" + JsonHelper.SerializeObject(Search), "GetProjectsController", "Post");
            ProjectListResultEntity ret = new ProjectListResultEntity();
            try
            {
                var lstProject = _projectBLL.GetModelsByPage(Search.PageSize, Search.PageIndex, true, x => x.ID, x => x.Number.Contains(Search.SearchStr) || x.Name.Contains(Search.SearchStr)).ToList();
                //List<Project> tmp1 = new List<Project>();
                //List<Project> tmp2 = new List<Project>();
                //if (!string.IsNullOrWhiteSpace(Search.SearchStr))
                //{
                //    tmp1 = lstProject.Where(x => x.Number.Contains(Search.SearchStr)).ToList();
                //    tmp2 = lstProject.Where(x => x.Name.Contains(Search.SearchStr)).ToList();
                //}
                ret.ProjectList = new List<ProjectEntity>();
                foreach (var p in lstProject)
                {
                    ProjectEntity retP = new ProjectEntity()
                    {
                        ID = p.ID,
                        Number = p.Number,
                        Name = p.Name,
                        Address = p.Address,
                        ProjectArea = p.Area.Name,
                        DevelopCompany = p.DevelopCompany,
                        IdentityNumber = p.IdentityNumber,
                        IsEnd = p.IsEnd,
                        EndReason = p.EndReason
                    };
                    ret.ProjectList.Add(retP);
                }
                ret.Code = 0;
                ret.ErrMsg = "";
                ret.RecordCount = _projectBLL.GetModels(x => x.Number.Contains(Search.SearchStr) || x.Name.Contains(Search.SearchStr)).Count();
            }
            catch (Exception ex)
            {
                Logger.LogException("获取项目列表发生异常！", "", "", ex);
                ret.Code = 999;
                ret.ErrMsg = ex.Message;
                ret.ProjectList = null;
            }
            return ret;
        }
    }
}
