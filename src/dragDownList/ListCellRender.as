package dragDownList 
{
	import dragDownList.Event.DragDownListEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	
	/**
	 * ...
	 * @author kongfuzhou
	 */
	public class ListCellRender extends BaseCompoent 
	{
		private var _selected:Boolean = false;
		private var _data:*;
		private var _labelField:String;
		public function ListCellRender() 
		{
			super();
			this.buttonMode = true;
		}
		
		public function get data():* 
		{
			return _data;
		}
		
		public function set data(value:*):void 
		{
			_data = value;
			if (this._labelField) 
			{
				this.label = _data[this._labelField];
			}else
			{
				this.label = _data.label;
			}
			
		}
		override protected function onClickBtn(e:MouseEvent):void 
		{
			super.onClickBtn(e);
			this.dispatchEvent(new DragDownListEvent(DragDownListEvent.SELECT_LIST,this._data));
			
		}
		public function get labelField():String 
		{
			return _labelField;
		}
		
		public function set labelField(value:String):void 
		{
			_labelField = value;
		}
		
		public function get selected():Boolean 
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			if (_selected) 
			{
				var colorFilter:ColorMatrixFilter = new ColorMatrixFilter([ //灰色滤镜
									0.5086,0.2094,0.082,0,0,
									0.5086,0.2094,0.082,0,0,
									0.5086,0.2094,0.082,0,0,
									0,0,0,1,0
								]);
				this.filters = [colorFilter];
			}else
			{
				this.filters = [];
			}
		}
		
	}

}