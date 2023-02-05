using Dapper;
using Microsoft.AspNetCore.Mvc;
using Sprint3Api.DbConnection;
using Sprint3Api.Models;

namespace Sprint3Api.Controllers
{
    public class CategoriesController : ControllerBase
    {
        //VER ESTE
        [HttpPost]
        [Route("Categories/Post")]
        public dynamic PostCategory(Categories c)
        {
            var result = 0;
            //DB.db.Query<Categories>("INSERT INTO Categories(category_name, category_description) VALUES(@category_name, @category_description)");
            using (DB.db)
            {
                var sql = "INSERT INTO Categories(category_name, category_description) VALUES(@category_name, @category_description)";
                result = DB.db.Execute(sql, c);
            }
            return result;
        }

        [HttpGet]
        [Route("Categories")]
        public dynamic GetCategories()
        {
            List<Categories> categories = DB.db.Query<Categories>("SELECT * FROM Categories").ToList();
            return categories;
        }

        [HttpGet]
        [Route("Categories/{id}")]
        public dynamic GetCategoriesId(int id)
        {
            List<Categories> categories = DB.db.Query<Categories>("SELECT * FROM Categories WHERE category_id="+id).ToList();
            return categories;
        }

        [HttpPut]
        [Route("Categories/{id}")]
        public dynamic UpdateCategoryId(int id, Categories c)
        {
            var result = 0;
            //DB.db.Query<Categories>("INSERT INTO Categories(category_name, category_description) VALUES(@category_name, @category_description)");
            using (DB.db)
            {
                var sql = "UPDATE Categories SET category_name=@category_name, category_description=@category_description WHERE category_id="+id;
                result = DB.db.Execute(sql, c);
            }
            return result;
        }

        [HttpDelete]
        [Route("Categories/{id}")]
        public ActionResult DeleteCategoriesId(int id)
        {
            List<Categories> categories = DB.db.Query<Categories>("SELECT * FROM Categories WHERE category_id=" + id).ToList();
            if (categories.Any())
            {
                return BadRequest();
            }
            else
            {
                DB.db.Query<Categories>("DELETE FROM Categories WHERE category_id=" + id);
                return NoContent();
            }           
        }
    }
}
