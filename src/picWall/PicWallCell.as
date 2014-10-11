package picWall 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author kongfuzhou
	 */
	public class PicWallCell extends Sprite 
	{
		private var _picture:DisplayObject;
		private var _cnTxt:TextField;
		private var _enTxt:TextField;
		private var _container:Sprite;
		private var _loader:Loader;
		private var _info:PicWallCellInfo;
		public function PicWallCell() 
		{
			super();
			init();			
		}		
		private function init():void 
		{
			//_container = new Sprite();
			//this.addChild(_container);
			this.buttonMode = true;
			this._cnTxt = this.crateTxt();
			this._enTxt = this.crateTxt();;
		}
		
		public function get info():PicWallCellInfo 
		{
			return _info;
		}
		
		public function set info(value:PicWallCellInfo):void 
		{
			_info = value;
			if (_info.source)
			{
				if (_info.source is DisplayObject)
				{
					this.clear();
					picture = _info.source as DisplayObject;
					addChild((_info.source as DisplayObject));
					this.setTxt();
				}else if (_info.source is String)
				{
					this.load((_info.source as String));
				}
			}
			
		}
		
		public function get picture():DisplayObject 
		{
			return _picture;
		}
		
		public function set picture(value:DisplayObject):void 
		{
			_picture = value;
		}
		private function load(url:String):void 
		{
			if (!_loader)
			{
				_loader = new Loader();
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			}
			_loader.unloadAndStop();
			_loader.load(new URLRequest(url));
			
		}
		
		private function onLoaded(e:Event):void 
		{
			this.clear();
			picture = this._loader.content;
			addChild(this._loader.content);
			this.setTxt();
		}
		private function setTxt():void 
		{
			this._cnTxt.text = this._info.typeCN;
			this._enTxt.text = "("+this._info.type+")";
			this.txtLayout();
		}
		private function clear():void 
		{
			/*while(this._container.numChildren>0)
			{
				this._container.removeChildAt(0);
			}*/
		}
		private function crateTxt():TextField
		{
			var txt:TextField = new TextField();
			txt.mouseEnabled = false;
			txt.autoSize = "left";
			this.addChild(txt);
			return txt;
		}
		public function txtLayout():void
		{
			this._cnTxt.y = this.picture.y + this.picture.height + 10;
			this._cnTxt.x = (this.picture.width - this._cnTxt.textWidth) / 2;
			this._enTxt.x = (this.picture.width - this._enTxt.textWidth) / 2;
			this._enTxt.y = this._cnTxt.y + this._cnTxt.textHeight + 3;
		}
		public function distroy():void 
		{
			if (this.parent) 
			{
				this.parent.removeChild(this);
			}
			if (this._loader)
			{
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded);
			}
		}
		
		
	}

}