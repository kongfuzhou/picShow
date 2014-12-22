package  
{
	import config.Config;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author kongfuzhou
	 */
	public class Scence extends Sprite 
	{
		private const WIDTH:Number = 700;
		private const HEIGHT:Number = 500;
		private var curPic:DisplayObject;
		private var curEffectType:int;
		private var curSize:Object;
		public function Scence() 
		{
			super();
			this.graphics.lineStyle(1, 0xff0000,0.5);
			this.graphics.drawRect(0, 0, WIDTH, HEIGHT);
		}
		
		public function showPictue(pic:DisplayObject):void 
		{
			Global.clearChild(this);
			this.addChild(pic);
			curPic = pic;
			curSize = {w:curPic.width,h:curPic.height };			
			curEffectType= Math.random() * (Global.MAX_EFFECT - 1) + 1;
			//curEffectType = 1;
			Global.centerUI(this, Config.STAGE_W, Config.STAGE_H);
			if (curEffectType==2 || curEffectType==3) 
			{
				Global.centerUI(curPic, WIDTH, HEIGHT,new Point(curSize.w/2,curSize.h/2));				
			}else
			{
				Global.centerUI(curPic, WIDTH, HEIGHT);
			}
			var duration:Number = 0.5;
			curEffectType == 1?duration = 1.5:"";
			Global.effect(pic, curEffectType,duration,onUpdate);
		}
		private function onUpdate():void 
		{
			
		}
		private function onComplete():void 
		{
			
		}
		
	}

}