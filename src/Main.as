package 
{
	import config.Config;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import picWall.PictureWall;
	
	/**
	 * ...
	 * @author kongfuzhou
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var wall:PictureWall = new PictureWall();
			this.addChild(wall);
			wall.dataProvide = Config.getPicWallData();
			wall.x = 30;
			wall.y = 50;
			
			
			
		}
		
	}
	
}