package picWall 
{
	/**
	 * ...
	 * @author kongfuzhou
	 */
	public class PicWallCellInfo 
	{
		/**甜美**/
		public static const SWEET:String = "sweet";
		/**sex**/
		public static const SEX:String = "sex";
		/**魅力**/
		public static const CHARISMA:String = "charisma";
		/**可爱**/
		public static const LOVELY:String = "lovely";
		/**青春**/
		public static const YOUTH:String = "youth";
		
		private var _source:*;
		private var _width:Number = -1;
		private var _height:Number = -1;
		private var _type:String;
		
		public function PicWallCellInfo() 
		{
			
		}
		/**
		 * 显示对象或者图片路径
		 */
		public function get source():* 
		{
			return _source;
		}
		
		public function set source(value:*):void 
		{
			_source = value;
		}
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function set width(value:Number):void 
		{
			_width = value;
		}
		
		public function get height():Number 
		{
			return _height;
		}
		
		public function set height(value:Number):void 
		{
			_height = value;
		}
		public function get typeCN():String
		{
			var cn:String = "";
			switch (this._type) 
			{
				case SWEET:
					cn = "甜美";
					break;
				case SEX:
					cn = "性感";
					break;
				case CHARISMA:
					cn = "魅力";
					break;
				case YOUTH:
					cn = "青春";
					break;
				case LOVELY:
					cn = "可爱";
					break;
				default:
			}
			return cn;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
	}

}