package config 
{
	import flash.display.Bitmap;
	import flash.utils.getDefinitionByName;
	import picWall.PicWallCell;
	import picWall.PicWallCellInfo;
	/**
	 * 配置
	 * ...
	 * @author kongfuzhou
	 */
	public class Config 
	{
		public static const STAGE_W:Number = 1024;
		public static const STAGE_H:Number = 768;
		
		
		public function Config() 
		{
			
		}
		public static function getScenceData():Array
		{
			var data:Array = [];
			var labels:Array = ["无", "雪", "玫瑰", "蓝妖姬"];
			var obj:Object;
			for (var i:int = 0; i < labels.length; i++) 
			{
				obj = { id:i + 1, label:labels[i] };
				data.push(obj);
			}
			
			return data;
		}
		public static function getPicWallData():Vector.<PicWallCellInfo>
		{
			var vec:Vector.<PicWallCellInfo> = new Vector.<PicWallCellInfo>();
			
			var csNameArr:Array = [
				PicWallCellInfo.CHARISMA,
				PicWallCellInfo.LOVELY, 
				PicWallCellInfo.SEX, 
				PicWallCellInfo.SWEET,
				PicWallCellInfo.YOUTH
			];
			var pic:Bitmap;
			var cs:Class;
			var info:PicWallCellInfo;
			for (var i:int = 0; i < csNameArr.length; i++) 
			{
				cs = getDefinitionByName(csNameArr[i]+"_bmd") as Class;
				pic = new Bitmap(new cs());
				pic.width = 120;
				pic.height = 270;
				info = new PicWallCellInfo();
				info.source = pic;
				info.type = csNameArr[i];
				vec.push(info);
			}
			
			return vec;
		}
		
		
		
	}

}