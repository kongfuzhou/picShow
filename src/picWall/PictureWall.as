package picWall 
{
	import com.greensock.core.Animation;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author kongfuzhou
	 */
	public class PictureWall extends Sprite 
	{
		private const WIDTH:Number = 120;
		private const HEIGHT:Number = 270;
		private var _container:Sprite;
		private var _length:int;
		private var _stepH:Number=15;
		private var _stepW:Number=10;
		private var _dataProvide:Vector.<PicWallCellInfo>;
		private var _cellList:Array;
		
		public function PictureWall() 
		{
			super();
			init();
		}
		
		private function init():void 
		{
			_container = new Sprite();
			addChild(_container);
			_cellList = [];
			this.addEventListener(MouseEvent.CLICK, mouseClick);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		public function get dataProvide():Vector.<PicWallCellInfo> 
		{
			return _dataProvide;
		}
		
		public function set dataProvide(value:Vector.<PicWallCellInfo>):void 
		{
			_dataProvide = value;
			this._length = _dataProvide.length;
			this.renderer();
		}
		/**
		 * 相邻高度差
		 */
		public function get stepH():Number 
		{
			return _stepH;
		}
		
		public function set stepH(value:Number):void 
		{
			_stepH = value;
		}
		
		private function mouseClick(e:MouseEvent):void 
		{
			var cell:PicWallCell = this.getMouseCell(e.target as DisplayObject);
			trace(cell);
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			var cell:PicWallCell = this.getMouseCell(e.target as DisplayObject);
		}
		private var pri:int=-1;
		private function onMouseOver(e:MouseEvent):void 
		{
			var cell:PicWallCell = this.getMouseCell(e.target as DisplayObject);
			if (cell)
			{
				var index:int = this._cellList.indexOf(cell);
				trace("index=",index);
				if (index > -1 && pri!=index)
				{
					pri=index
					this.reLayout(index);
				}
			}
		}
		private function getMouseCell(target:DisplayObject):PicWallCell 
		{
			var cell:PicWallCell;
			if (target is PicWallCell)
			{
				cell = target as PicWallCell;
			}else if (target==this)
			{
				return cell;
			}else
			{
				var parent:DisplayObjectContainer=target.parent;
				while (parent)
				{
					if (parent is PicWallCell)
					{
						cell = parent as PicWallCell;
						break;
					}
					if (parent == this)
					{
						break;
					}
					parent = parent.parent;
				}
			}
			
			return cell;
		}
		private function renderer(midi:int=1):void 
		{
			if (this._dataProvide && this._length>0)
			{
				this.pri = midi;
				this.clear();
				var cell:PicWallCell;
				
				var preX:Number=0;
				var preW:Number=0;
				var gap:Number=0;
				
				for (var i:int = 0; i < this._length; i++) 
				{
					cell = new PicWallCell();
					this._container.addChild(cell);
					cell.info = this._dataProvide[i];
					if (i < midi)
					{
						//左边
						cell.picture.height =this.HEIGHT- ( midi - i) * this._stepH;
						cell.picture.width =this.WIDTH- ( midi - i) * this._stepW;
					}else if (i > midi)
					{
						//右边
						cell.picture.height = this.HEIGHT - ( i - midi) * this._stepH;
						cell.picture.width =this.WIDTH- ( i - midi ) * this._stepW;
					}
					cell.picture.y = this.HEIGHT - cell.picture.height;
					cell.x = preX + preW + gap;
					cell.txtLayout();
					preX = cell.x;
					preW = cell.width;
					_cellList.push(cell);
				}
			}
		}
		private function reLayout(midi:int):void 
		{
			if (this._cellList.length > 0)
			{
				var cell:PicWallCell;
				
				var th:Number;
				var tw:Number;
				
				var tx:Number;
				var ty:Number;
				
				var preX:Number=0;
				var preW:Number=0;
				var gap:Number=0;
				
				for (var i:int = 0; i < this._length; i++) 
				{
					cell = this._cellList[i];					
					if (i < midi)
					{
						//左边
						th =this.HEIGHT - ( midi - i) * this._stepH;
						tw =this.WIDTH - ( midi - i) * this._stepW;
					}else if (i > midi)
					{
						//右边
						th = this.HEIGHT - ( i - midi) * this._stepH;
						tw =this.WIDTH- ( i - midi ) * this._stepW;
					}					
					ty = this.HEIGHT - th;
					tx = preX + preW + gap;
					if (i == midi)
					{						
						th = this.HEIGHT;
						tw = this.WIDTH;
						ty = 0;
					}
					preX = cell.x;
					preW = tw;
					TweenMax.killTweensOf(cell);
					TweenMax.killTweensOf(cell.picture);
					TweenMax.to(cell.picture, 0.15, { width:tw, height:th,y:ty } );
					TweenMax.to(cell, 0.2, { x:tx, delay:0.2 } );
					trace("i=",i,"tx=",tx,"ty=",ty,"midi=",midi);
					cell.txtLayout();					
					
				}
			}
		}
		private function clear():void 
		{
			while(this._container.numChildren>0)
			{
				this._container.removeChildAt(0);
			}
			var cell:PicWallCell;
			while (this._cellList.length > 0)
			{
				cell = this._cellList.pop() as PicWallCell;
				if (cell)
				{
					cell.distroy();
				}
			}
		}
		
		
		
	}

}