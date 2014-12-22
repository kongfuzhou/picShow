package dragDownList.Event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author kongfuzhou
	 */
	public class DragDownListEvent extends Event 
	{
		public static const LIST_CHANGE:String = "LIST_CHANGE";
		public static const SELECT_LIST:String = "SELECT_LIST";
		private var _data:*;
		public function DragDownListEvent(type:String,_data:*=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			this._data = _data;
			
		}
		
		public function get data():* 
		{
			return _data;
		}
		
		public function set data(value:*):void 
		{
			_data = value;
		}
		
	}

}