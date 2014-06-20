package com.gamerisker.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class Tool
	{
		public function Tool()
		{
		}
		
		/**
		 *	浅复制一个目标对象 
		 * @param _arg1		目标对象
		 * @return 			复制对象
		 * 
		 */		
		public static function UpdateObjectProperty(_arg1:Object) : Object
		{
			var _local3:String;
			var _arg2 : Object;
			if (_arg1 == null)
			{
				return _arg1;
			}
			
			_arg2 = new Object;
			for (_local3 in _arg1)
			{
				_arg2[_local3] = _arg1[_local3];
			}
			
			return _arg2;
		}
		
		public static function CleanObjectProperty(_arg1:Object):void
		{
			var _local2:String;
			if (_arg1 == null)
			{
				return;
			};
			for (_local2 in _arg1)
			{
				delete _arg1[_local2];
			};
		}
		
		public static function DrawBitmapRectangle(bitd : DisplayObject , rangle : Rectangle) : Bitmap
		{
			var mat : Matrix = new Matrix();
			mat.translate(-rangle.x,-rangle.y);
			var bitmap : BitmapData = new BitmapData(rangle.width,rangle.height);
			bitmap.draw(bitd,mat,null,null,new Rectangle(0,0,rangle.width,rangle.height));
			
			return new Bitmap(bitmap);
		}
	}
}