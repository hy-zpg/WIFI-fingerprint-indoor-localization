package com.example.ap_test;
// the aim is to updata the code enabled to automatically obtain the mat file
import java.io.FileOutputStream;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;



import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.AppCompatActivity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

	private WifiManager wifimanager;
	List<ScanResult> scanresults;
	private String filename;
	
	//generated the file name of mat(ap mac)
	private String fileroot="/sdcard/AP/";
	public counting count;
	private Timer timer=null;
	private TimerTask timerTask=null;
	EditText filetext;
	FileOutputStream fos;
	
	//the two button of software interface
	Button startbutton;
	Button stopbutton;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		 startbutton=(Button) findViewById(R.id.start);
		 stopbutton=(Button) findViewById(R.id.stop);
		filetext=(EditText)findViewById(R.id.filetext);
		stopbutton.setEnabled(false);
		wifimanager=(WifiManager)getSystemService(Context.WIFI_SERVICE);
		if (!wifimanager.isWifiEnabled()) {
			if (wifimanager.getWifiState() != WifiManager.WIFI_STATE_ENABLING) {
				wifimanager.setWifiEnabled(true);
			}
		}
		count=new counting();
		registerReceiver(new BroadcastReceiver(){
			
			@Override
			public void onReceive(Context context, Intent intent) {
				// TODO 自动生成的方法存根
				scanresults=wifimanager.getScanResults();
				for(ScanResult result:scanresults){
					if(count.Maclist.size()==0){
						count.Maclist.add(result.BSSID);
						count.Numlist.add(1);
					}else{
						if(count.Maclist.contains(result.BSSID)){
							count.Numlist.set(count.Maclist.indexOf(result.BSSID),count.Numlist.get(count.Maclist.indexOf(result.BSSID))+1);
						}else{
							count.Maclist.add(result.BSSID);
							count.Numlist.add(1);
						}
						
					}
				}
			}
			},  new IntentFilter(WifiManager.SCAN_RESULTS_AVAILABLE_ACTION) );
		
		
		
		
		
		startbutton.setOnClickListener(new OnClickListener(){
			public void onClick(View v){
				startsampling();
				count=new counting();
				startbutton.setEnabled(false);
				stopbutton.setEnabled(true);
				filename=fileroot+filetext.getText().toString()+".txt";
				try{
					fos=new FileOutputStream(filename,true);
				}catch(Exception e){
					
				}
			}
		});
		
		stopbutton.setOnClickListener(new OnClickListener(){

			@Override
			public void onClick(View v) {
				// TODO 自动生成的方法存根
				stopsampling();
				
				stopbutton.setEnabled(false);
				startbutton.setEnabled(true);
				String Mactmp=null;
				Integer Numtmp=null;
				
				for(int i=0;i<count.Maclist.size();i++){
					for(int j=i+1;j<count.Maclist.size();j++){
						if(count.Numlist.get(i)<count.Numlist.get(j)){
							
							Mactmp=count.Maclist.get(i);
							Numtmp=count.Numlist.get(i);
							
							count.Maclist.set(i, count.Maclist.get(j));
							count.Numlist.set(i, count.Numlist.get(j));
							
							count.Maclist.set(j, Mactmp);
							count.Numlist.set(j, Numtmp);
						}
					}
				}
				
				try{
					
					for(int k=0;k<count.Maclist.size();k++){
						fos.write((count.Maclist.get(k)+"\t").getBytes());
						fos.write((count.Numlist.get(k)+"\t").getBytes());
						fos.write(("\r\n").getBytes());
					}
					fos.close();
					
				}catch(Exception e ){
					
				}
			}
			
		});
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
	}
	
	public void startsampling(){
		timer=new Timer();
		timerTask=new TimerTask(){

			@Override
			public void run() {
				// TODO 自动生成的方法存根
				wifimanager.startScan();
			}
			
		
	};
	timer.schedule(timerTask, 0, 1500);
}
	
	public void stopsampling(){
		if (timer != null) {
			// cancels the scanning task
			timer.cancel();
			timer = null;
		}
	}
}