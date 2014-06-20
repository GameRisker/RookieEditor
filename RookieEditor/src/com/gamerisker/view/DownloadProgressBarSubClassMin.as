package view
{
	import mx.preloaders.*; 
	import flash.events.ProgressEvent;
	
	public class DownloadProgressBarSubClassMin extends DownloadProgressBar
	{
		public function DownloadProgressBarSubClassMin()
		{   
			super();
			// Set the download label.
			downloadingLabel="Downloading app..."
			// Set the initialization label.
			initializingLabel="正在初始化程序..."
			// Set the minimum display time to 2 seconds.

			MINIMUM_DISPLAY_TIME = 5000;
		}
		
		// Override to return true so progress bar appears
		// during initialization.       
		override protected function showDisplayForInit(elapsedTime:int, 
													   count:int):Boolean {
			return true;
		}
		
		// Override to return true so progress bar appears during download.     
		override protected function showDisplayForDownloading(
			elapsedTime:int, event:ProgressEvent):Boolean {
			return true;
		}
	}
	
}