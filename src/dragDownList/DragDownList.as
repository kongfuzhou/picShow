package dragDownList 
{
	import dragDownList.Event.DragDownListEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	/**
	 * 下拉列表...
	 * @author kongfuzhou
	 */
	public class DragDownList extends BaseCompoent 
	{
		private var _dataProvide:Array;
		private var _listContainer:Sprite;
		private var _selectIndex:int = 0;
		private var _cellList:Array;
		private var _verGap:Number = 3;
		private var _parent:DisplayObjectContainer;
		private var _listTextColor:String = "";
		private var _listBgColor:int = -1;
		private var _listBtnSkin:Class;
		
		public function DragDownList(_parent:DisplayObjectContainer) 
		{
			super();
			this._parent = _parent;
			init();
		}
		
		protected override function init():void 
		{
			super.init();			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			this._listContainer = new Sprite();
			this.addChild(this._listContainer);
			this._button.buttonMode = true;
			this.showList(false);
		}
		
		
		private function onAddToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
		}
		override protected function onClickBtn(e:MouseEvent):void 
		{
			super.onClickBtn(e);
			this.showList(!this._listContainer.visible);
		}
				
		public function get dataProvide():Array 
		{
			return _dataProvide;
		}
		
		public function set dataProvide(value:Array):void 
		{
			_dataProvide = value;
			this._listContainer.x = 0;
			this._listContainer.y = this._button.y + this._styleObj.btnHeight+this._verGap;
			this.createCell();
			this.selectIndex = 0;
		}
		
		public function get verGap():Number 
		{
			return _verGap;
		}
		
		public function set verGap(value:Number):void 
		{
			_verGap = value;
		}
		
		public function get selectIndex():int 
		{
			return _selectIndex;
		}
		
		public function set selectIndex(value:int):void 
		{
			if (value<this._dataProvide.length && value>=0) 
			{
				_selectIndex = value;
				this.selectList(this._dataProvide[_selectIndex]);
			}
			
		}
		
		public function get listTextColor():String 
		{
			return _listTextColor;
		}
		
		public function set listTextColor(value:String):void 
		{
			_listTextColor = value;
		}
		
		public function get listBgColor():int 
		{
			return _listBgColor;
		}
		
		public function set listBgColor(value:int):void 
		{
			_listBgColor = value;
		}
		private function createCell():void 
		{			
			this._cellList = [];
			while (this._listContainer.numChildren) 
			{
				this._listContainer.removeChildAt(0);
			}
			var cell:ListCellRender;
			var len:int = this._dataProvide.length;
			var prevH:Number = 0;
			for (var i:int = 0; i < len; i++) 
			{
				cell = new ListCellRender();
				cell.data = this._dataProvide[i];
				this._listContainer.addChild(cell);
				this._cellList.push(cell);				
				if (this._listTextColor!="") 
				{
					cell.setStyle("labelColor",this._listTextColor);
				}
				if (this._listBgColor>-1) 
				{
					cell.setStyle("btnColor",this._listBgColor);
				}
				if (_listBtnSkin) 
				{
					cell.setStyle("buttonSkin", _listBtnSkin);
				}
				cell.setStyle("btnWidth", this._styleObj.btnWidth);
				cell.setStyle("btnHeight", this._styleObj.btnHeight);
				cell.addEventListener(DragDownListEvent.SELECT_LIST, onSelectList);
				cell.y = prevH + this._verGap * i;
				prevH += cell.height;
				
			}
			this.selectList(this._dataProvide[0]);
		}
		
		private function onSelectList(e:DragDownListEvent):void 
		{
			selectList(e.data);
		}
		private function selectList(data:*):void 
		{
			var index:int = this._dataProvide.indexOf(data);
			if (index>-1) 
			{
				this._cellList[this.selectIndex].selected = false;
				this._selectIndex = index;
				this._cellList[this.selectIndex].selected = true;
				this.dispatchEvent(new DragDownListEvent(DragDownListEvent.LIST_CHANGE, data));
			}
		}
		
		public override function setStyle(style:String,value:*):void 
		{
			super.setStyle(style, value);
			
			
		}
		public function showList(flag:Boolean=true):void 
		{
			this._listContainer.visible = flag;
		}
		override public function get label():String 
		{
			return super.label;
		}
		
		override public function set label(value:String):void 
		{
			super.label = value;
		}
		/**
		 * 列表的按钮样式
		 */
		public function get listBtnSkin():Class 
		{
			return _listBtnSkin;
		}
		
		public function set listBtnSkin(value:Class):void 
		{
			_listBtnSkin = value;
			
		}
		public function show(flag:Boolean=true):void 
		{
			if (flag) 
			{
				this._parent.addChild(this);
			}else
			{
				if (this.parent) 
				{
					this.parent.removeChild(this);
				}
			}
		}
		
		
	}

}