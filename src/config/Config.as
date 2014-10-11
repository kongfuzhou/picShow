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
		
		public function Config() 
		{
			
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