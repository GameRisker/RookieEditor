package com.gamerisker.manager
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 * 资源管理类
	 * @author GameRisker
	 * 
	 */
	public class TexturesManager
	{
		private static var sTextures : Dictionary = new Dictionary;
		
		[Embed(source="../../../ComponentIcon/Button.jpg")] 
		public static const ButtonIcon:Class;
		[Embed(source="../../../ComponentIcon/ImageButton.jpg")] 
		public static const ImageButtonIcon:Class;
		[Embed(source="../../../ComponentIcon/CheckBox.jpg")] 
		public static const CheckBoxIcon:Class;
		[Embed(source="../../../ComponentIcon/ColorPicker.jpg")] 
		public static const ColorPickerIcon:Class;
		[Embed(source="../../../ComponentIcon/ComboBox.jpg")] 
		public static const ComboBoxIcon:Class;
		[Embed(source="../../../ComponentIcon/DataGrid.jpg")] 
		public static const DataGridIcon:Class;
		[Embed(source="../../../ComponentIcon/Label.jpg")] 
		public static const LabelIcon:Class;
		[Embed(source="../../../ComponentIcon/List.jpg")] 
		public static const ListIcon:Class;
		[Embed(source="../../../ComponentIcon/NumericStepper.jpg")] 
		public static const NumericStepperIcon:Class;
		[Embed(source="../../../ComponentIcon/ProgressBar.jpg")] 
		public static const ProgressBarIcon:Class;
		[Embed(source="../../../ComponentIcon/RadioButton.jpg")] 
		public static const RadioButtonIcon:Class;
		[Embed(source="../../../ComponentIcon/ScrollPane.jpg")] 
		public static const ScrollPaneIcon:Class;
		[Embed(source="../../../ComponentIcon/Slider.jpg")] 
		public static const SliderIcon:Class;
		[Embed(source="../../../ComponentIcon/TextArea.jpg")] 
		public static const TextAreaIcon:Class;
		[Embed(source="../../../ComponentIcon/TextInput.jpg")] 
		public static const TextInputIcon:Class;
		[Embed(source="../../../ComponentIcon/TileList.jpg")] 
		public static const TileListIcon:Class;
		[Embed(source="../../../ComponentIcon/UILoader.jpg")] 
		public static const UILoaderIcon:Class;
		[Embed(source="../../../ComponentIcon/UIScrollBar.jpg")] 
		public static const UIScrollBarIcon:Class;
		[Embed(source="../../../ComponentIcon/ImageLoadBox.jpg")] 
		public static const TileIcon:Class;
		[Embed(source="../../../ComponentIcon/ImageLoadGrid.jpg")] 
		public static const TileGroupIcon:Class;
		[Embed(source="../../../ComponentIcon/ModelLoadBox.jpg")] 
		public static const ModelLoadBoxIcon:Class;
		[Embed(source="../../../ComponentIcon/UIMovie.jpg")]
		public static const UIMovieIcon:Class;
		[Embed(source="../../../ComponentIcon/UIImage.jpg")] 
		public static const SkinImageIcon:Class;
		[Embed(source="../../../ComponentIcon/UIFrame.jpg")] 
		public static const SkinFrameIcon:Class;
		[Embed(source="../../../ComponentIcon/PopupWindow.jpg")] 
		public static const TitleWindowIcon:Class;
		[Embed(source="../../../ComponentIcon/ComponentBag.jpg")] 
		public static const ComponentBagIcon:Class;		
		[Embed(source="../../../ComponentIcon/ImageNumber.jpg")] 
		public static const ImageNumberIcon:Class;	
	
		[Embed(source="../../../ComponentIcon/editorback.png")] 
		public static const editorback:Class;	
		
		/**
		 * 添加资源
		 * @param name	资源注册名称
		 * @param xml	
		 * @param byte
		 * 
		 */		
		public static function Add(name : String , xml : XML , byte : ByteArray) : void
		{
			var texture:Texture = Texture.fromAtfData(byte as ByteArray);
			
			Instantiate(new TextureAtlas(texture,xml),name);
		}

		/**
		 *	获取背景资源 
		 * @return 
		 * 
		 */		
		public static function GetAtlas(pngName : String) : TextureAtlas
		{
			var _texture : TextureAtlas = sTextures[pngName] as TextureAtlas;
			
			if(_texture == null)
				throw(new Error("not found textureAtlas : " + pngName));
			
			return _texture;
		}
		
		/**
		 *	注册  
		 * @param _texture
		 * 
		 */		
		private static function Instantiate(_texture : TextureAtlas , name : String) : void
		{
			if(sTextures[name] == undefined)
			{
				sTextures[name] = _texture;
			}
//			else
//			{
//				throw(new Error("repeat texture"))
//			}
		}
		
		public static function getIcon(name : String) : Sprite
		{
			var bitmap : Bitmap = new TexturesManager[name+"Icon"]();
			var container : Sprite = new Sprite;
			var text : TextField = new TextField();
			text.text = name;
			text.height = 16;
			container.addChild(bitmap);
			container.addChild(text);
			
			container.graphics.beginFill(0xffffff);
			container.graphics.drawRect(0,0,container.width,container.height);
			text.x = bitmap.width;
			text.mouseEnabled = false;
			return container;
		}
		
		public static function getTexture(name:String):Texture
		{
			if (sTextures[name] == undefined)
			{
				var data:Object = new TexturesManager[name]();
				
				if (data is Bitmap)
					sTextures[name] = Texture.fromBitmap(data as Bitmap);
				else if (data is ByteArray)
					sTextures[name] = Texture.fromAtfData(data as ByteArray);
			}
			
			return sTextures[name];
		}
	}
}
