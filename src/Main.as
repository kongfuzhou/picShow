package 
{
	import config.Config;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
			this.stage.addEventListener(MouseEvent.CLICK, onClick);
			
		}
		private var scence:Scence;
		private var type:int = 1;
		private function onClick(e:MouseEvent):void 
		{
			var pic:Bitmap = new Bitmap();
			if (type==1) 
			{
				type = 2;
				pic.bitmapData = new youth_bmd();
			}else
			{
				type = 1;
				pic.bitmapData = new sweet_bmd();
			}
			
			//addChild(pic);
			if (!scence) 
			{
				scence = new Scence();
				this.addChild(scence);
			}
			
			scence.showPictue(pic);
		}
		
	}
	
}