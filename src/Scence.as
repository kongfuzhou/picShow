package  
{
	import config.Config;
	import dragDownList.DragDownList;
	import dragDownList.Event.DragDownListEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author kongfuzhou
	 */
	public class Scence extends Sprite 
	{
		private const WIDTH:Number = 850;
		private const HEIGHT:Number = 500;
		private var curPic:DisplayObject;
		private var curEffectType:int;
		private var curSize:Object;
		private var scenceList:DragDownList;
		private var _allPictrues:Array = [];
		
		public function Scence() 
		{
			super();
			init();
		}
		private function init():void 
		{
			this.graphics.lineStyle(1, 0xff0000,0.5);
			this.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			
			scenceList = new DragDownList(this);
			scenceList.show(true);
			scenceList.label = "场景选择";		
			scenceList.x = this.WIDTH+10;
			scenceList.y = 0;
			scenceList.listTextColor = "#ffff00";
			//scenceList.listBgColor = 0xffff00;
			scenceList.setStyle("labelColor", "#ffff00");
			
			scenceList.setStyle("buttonSkin",ListBtn2);
			scenceList.listBtnSkin = ListBtn2;
			scenceList.setStyle("btnColor", 0xffff00);
			
			/*scenceList.setStyle("btnWidth", 60);
			scenceList.setStyle("btnHeight", 30);*/
			
			scenceList.dataProvide = Config.getScenceData();
			scenceList.addEventListener(DragDownListEvent.LIST_CHANGE, onListChange);
		}
		
		private function onListChange(e:DragDownListEvent):void 
		{
			trace(e.data.id);
		}
		
		public function showPictue(pic:DisplayObject):void 
		{
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