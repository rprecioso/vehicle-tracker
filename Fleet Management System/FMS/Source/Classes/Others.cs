using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Runtime.CompilerServices;
using System.Linq.Dynamic;
using FMS_BusinessObjects;

namespace FMS.Source.Classes
{
    public static class extensions
    {


        public static int getExpType(this string _string)
        {
            using (FMS_DBDataContext dcontext = new FMS_DBDataContext())
            {
                var res = dcontext.refEXPTypes.Where(x => x.type.ToLower().Contains(_string.ToLower().Trim()));
                if (res.Count() > 0)
                {
                    return res.FirstOrDefault().exp_type_id;
                }
                else
                {
                    return 0;
                }
            }
        }

        public static int strToInt(this string _string)
        {
            try
            {
                return Convert.ToInt32(_string);
            }
            catch (Exception)
            {
                return 0;
                //throw new Exception("string characters cannot be converted to int32");
            }

        }

        public static double strToDouble(this string _string)
        {
            try
            {
                return Convert.ToDouble(_string);
            }
            catch (Exception)
            {

                throw new Exception("string characters cannot be converted to double");
            }

        }

        public static void CopyPropertyValues(this object destination, object source, string[] exception)
        {


            if (!(destination.GetType().Equals(source.GetType())))
                throw new ArgumentException("Type mismatch");
            if (destination is IEnumerable)
            {
                var dest_enumerator = (destination as IEnumerable).GetEnumerator();
                var src_enumerator = (source as IEnumerable).GetEnumerator();
                while (dest_enumerator.MoveNext() && src_enumerator.MoveNext())
                    dest_enumerator.Current.CopyPropertyValues(src_enumerator.Current, exception);
            }
            else
            {

                foreach (var sourceProperty in source.GetType().GetProperties())
                {
                    foreach (var destProperty in destination.GetType().GetProperties())
                    {
                        if (destProperty.Name == sourceProperty.Name
                           && destProperty.PropertyType.FullName.Contains("FMS") == false
                            && exception.Contains(destProperty.Name) == false
                            && destProperty.PropertyType.GetType()
                                .IsAssignableFrom(sourceProperty.PropertyType.GetType()))
                        {
                            destProperty.SetValue(destination, sourceProperty.GetValue(
                                source, new object[] { }), new object[] { });
                            break;
                        }
                    }
                }
            }
        }
    }
    public class filterMenu
    {
        public String DataValue { get; set; }
        public String DataText { get; set; }
    }

    //public class DynamicObject
    //{
    //    public dynamic Instance = new ExpandoObject();

    //    public void AddProperty(string name, object value)
    //    {
    //        ((IDictionary<string, object>)this.Instance).Add(name, value);
    //    }

    //    public dynamic GetProperty(string name)
    //    {
    //        if (((IDictionary<string, object>)this.Instance).ContainsKey(name))
    //            return ((IDictionary<string, object>)this.Instance)[name];
    //        else
    //            return null;
    //    }

    //    public void AddMethod(Action methodBody, string methodName)
    //    {
    //        this.AddProperty(methodName, methodBody);
    //    }
    //}

}