//------------------------------------------------------------------------------
// <auto-generated>
//     此代码已从模板生成。
//
//     手动更改此文件可能导致应用程序出现意外的行为。
//     如果重新生成代码，将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace HouseSelection.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class RoleFamilyNumberAndRoomType
    {
        public int ID { get; set; }
        public int ProjectID { get; set; }
        public int FamilyNumber { get; set; }
        public int RoomTypeID { get; set; }
        public System.DateTime CreateTime { get; set; }
        public Nullable<System.DateTime> LastUpdate { get; set; }
    
        public virtual Project Project { get; set; }
        public virtual RoomType RoomType { get; set; }
    }
}