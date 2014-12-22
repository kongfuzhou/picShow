package  
{
	import config.Config;
	import dragDownList.DragDownList;
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
		private var list:DragDownList;
		public function Scence() 
		{
			super();
			init();
		}
		private function init():void 
		{
			this.graphics.lineStyle(1, 0xff0000,0.5);
			this.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			
			list = new DragDownList(this);
			list.show(true);
			list.label = "场景选择";		
			list.x = 30;
			list.y = 50;
			list.listTextColor = "#ff0000";
			//list.listBgColor = 0xffff00;
			list.setStyle("labelColor", "#ff0000");
			list.setStyle("btnColor", 0xffff00);
			list.setStyle("btnWidth", 200);
			list.setStyle("btnHeight", 50);
			list.dataProvide = Config.getScenceData();
			trace(list.parent);
		}
		
		public function showPictue(pic:DisplayObject):void 
		{
			//Global.clearChild(this);
			if (curPic && curPic.parent) 
			{
				curPic.parent.removeChild(curPic);
			}
			this.addChild(pic);
			curPic = pic;
			curSize = {w:curPic.width,h:curPic.height };			
			curEffectType= Math.random() * (Global.MAX_EFFECT - 1) + 1;
			//curEffectType = 1;
			Global.centerUI(this, Config.STAGE_W, Config.STAGE_H,null,WIDTH,HEIGHT);
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