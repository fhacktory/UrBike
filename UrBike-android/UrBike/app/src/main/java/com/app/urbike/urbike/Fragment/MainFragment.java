package com.app.urbike.urbike.Fragment;

import android.content.Context;
import android.location.Location;
import android.location.LocationListener;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Vibrator;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import com.app.urbike.urbike.ModelsTurn;
import com.app.urbike.urbike.R;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesClient;
import com.google.android.gms.location.LocationClient;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.gms.maps.model.Polyline;
import com.google.android.gms.maps.model.PolylineOptions;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
/**
 * Created by mehdichouag on 11/10/2014.
 */
public class MainFragment extends Fragment implements LocationListener, GooglePlayServicesClient.ConnectionCallbacks, GooglePlayServicesClient.OnConnectionFailedListener, GoogleMap.OnMapLongClickListener{
    private Location mCurrentLocation;
    private LocationClient mLocationClient = null;
    private GoogleMap mMap = null;
    private View mView;
    private Double[] mDestination = null;
    private TextView mDistance;
    private TextView mTime;
    private Marker mMarkerDestination;
    private Marker mFakePosition = null;
    private List<JSONObject> mPath = null;
    private List<LatLng> mTurn = null;
    private List<ModelsTurn> mTurnVibrate = null;
    private Polyline mLine = null;
    private Button mButton;
    Vibrator mVibrator = null;

    public MainFragment() {
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        mView = inflater.inflate(R.layout.fragment_main, container, false);
        if (mLocationClient == null)
            mLocationClient = new LocationClient(getActivity(), this, this);
        mDistance = (TextView)mView.findViewById(R.id.distance);
        mTime = (TextView)mView.findViewById(R.id.time);
        mVibrator = (Vibrator) getActivity().getSystemService(Context.VIBRATOR_SERVICE);
        return mView;
    }

    @Override
    public void onConnected(Bundle bundle){
        mCurrentLocation = mLocationClient.getLastLocation();
        if (mMap == null){
            bindView();
            FetchData();
        }
    }

    private void FetchData(){
        Double[] path = new Double[4];
        if (mDestination != null){
            path[0] = mCurrentLocation.getLatitude();
            path[1] = mCurrentLocation.getLongitude();
            path[2] = mDestination[0];
            path[3] = mDestination[1];
            new PathDestination().execute(path);
            mMarkerDestination = mMap.addMarker(new MarkerOptions()
                .position(new LatLng(mDestination[0], mDestination[1])));
        }
    }

    public void onStart() {
        super.onStart();
        mLocationClient.connect();
    }

    public void onStop(){
        super.onStop();
        mLocationClient.disconnect();
    }

    public void bindView() {
        mMap = ((SupportMapFragment)getActivity().getSupportFragmentManager().findFragmentById(R.id.map)).getMap();
        if (mMap != null && mLocationClient.isConnected() && mCurrentLocation != null) {
            LatLng place = new LatLng(mCurrentLocation.getLatitude(), mCurrentLocation.getLongitude());
            mMap.moveCamera(CameraUpdateFactory.newLatLngZoom(place, 17));
            mMap.setMyLocationEnabled(true);
            mMap.setOnMapLongClickListener(this);
        }
    }

    public void vibrate(int direction)
    {
        long[] left = {0, 2000, 1000, 2000};

        if (mVibrator != null){
            if (direction == ModelsTurn.LEFT)
                mVibrator.vibrate(left, -1);
            else if (direction == ModelsTurn.RIGHT){
                mVibrator.vibrate(5000);
            }
        }
    }

    public void getNextLocation(LatLng location){
        float[] result = new float[3];
//        float[] diff = new float[3];
//        LatLng nextPoint;

        for (int i = 0; i < mTurnVibrate.size(); i++){
            LatLng distance = mTurnVibrate.get(i).getmPosition();
            Location.distanceBetween(location.latitude, location.longitude, distance.latitude, distance.longitude, result);
            if (result[0] <= 50.0 && mTurnVibrate.get(i).getmDirection() != ModelsTurn.NONE && i + 1 < mTurnVibrate.size()) {
//                nextPoint = mTurnVibrate.get(i + 1).getmPosition();
//                Location.distanceBetween(distance.latitude, distance.longitude, nextPoint.latitude, nextPoint.longitude, diff);
//                Location.distanceBetween(location.latitude, location.longitude, nextPoint.latitude, nextPoint.longitude, result);
//                if (result[0] > diff[0]) {
                    vibrate(mTurnVibrate.get(i + 1).getmDirection());
//                }
            }
        }
    }
    @Override
    public void onDisconnected() {

    }

    @Override
    public void onLocationChanged(Location location) {

    }

    @Override
    public void onStatusChanged(String provider, int status, Bundle extras) {

    }

    @Override
    public void onProviderEnabled(String provider) {

    }

    @Override
    public void onProviderDisabled(String provider) {

    }

    @Override
    public void onConnectionFailed(ConnectionResult connectionResult) {

    }

    public void setmDestination(Double[] destination){
        this.mDestination = destination;
    }

    private void getPath(JSONArray array){
        mPath = new ArrayList<JSONObject>();
        mTurnVibrate = new ArrayList<ModelsTurn>();
        String turn = null;
        int z;
        try {
            for (int i = 0; i < array.length(); i++){
                mPath.add(array.getJSONObject(i));
            }

            PolylineOptions options = new PolylineOptions().width(10).color(R.color.gray_title);
            for (int i = 0; i != mTurn.size(); i++){
                options.add(mTurn.get(i));
            }
            mLine = mMap.addPolyline(options);
            for (JSONObject object : mPath){
                if (object.has("maneuver")){
                    turn = object.getString("maneuver");
                    if (turn.contains("left"))
                        z = ModelsTurn.LEFT;
                    else if (turn.contains("right"))
                        z = ModelsTurn.RIGHT;
                    else
                        z = ModelsTurn.NONE;
                }
                else
                    z = ModelsTurn.NONE;
                object = object.getJSONObject("start_location");
                mTurnVibrate.add(new ModelsTurn(new LatLng(object.getDouble("lat"), object.getDouble("lng")), z));
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

    }
    private List<LatLng> decodePoly(String encoded) {

        List<LatLng> poly = new ArrayList<LatLng>();
        int index = 0, len = encoded.length();
        int lat = 0, lng = 0;

        while (index < len) {
            int b, shift = 0, result = 0;
            do {
                b = encoded.charAt(index++) - 63;
                result |= (b & 0x1f) << shift;
                shift += 5;
            } while (b >= 0x20);
            int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
            lat += dlat;

            shift = 0;
            result = 0;
            do {
                b = encoded.charAt(index++) - 63;
                result |= (b & 0x1f) << shift;
                shift += 5;
            } while (b >= 0x20);
            int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
            lng += dlng;

            LatLng p = new LatLng((((double) lat / 1E5)),
                    (((double) lng / 1E5)));
            poly.add(p);
        }
        return poly;
    }


    private void makePath(){

        mFakePosition = mMap.addMarker(new MarkerOptions().position(mTurn.get(0)));
    }

    @Override
    public void onMapLongClick(LatLng latLng) {
        if (mFakePosition != null)
            mFakePosition.remove();
        mFakePosition = mMap.addMarker(new MarkerOptions()
                .position(latLng)
                .draggable(true));
        getNextLocation(mFakePosition.getPosition());
    }

    private class PathDestination extends AsyncTask<Double[], Void, String>{

        private final String URL_API = "https://maps.googleapis.com/maps/api/directions/json?";
        private final String ORIGIN_API = "origin";
        private final String DESTINATION_API = "destination";
        private final String KEY_API = "key";
        private final String KEY_VALUE = "AIzaSyA-JaX5e4nThw-jOzgrW6tPEJeuInx1gq8";
        private final String MODE_API = "mode";
        private final String MODE_VALUE = "bicycling";
        HttpURLConnection urlConnection = null;
        BufferedReader reader = null;
        private Uri buildUri;
        private String result = null;

        @Override
        protected String doInBackground(Double[]... params) {
            buildUri = Uri.parse(URL_API).buildUpon()
                    .appendQueryParameter(ORIGIN_API, String.valueOf(params[0][0]) + "," + String.valueOf(params[0][1]))
                    .appendQueryParameter(DESTINATION_API, String.valueOf(params[0][2]) + "," + String.valueOf(params[0][3]))
                    .appendQueryParameter(KEY_API, KEY_VALUE)
                    .appendQueryParameter(MODE_API, MODE_VALUE)
                    .build();
            try {
                URL url = new URL(buildUri.toString());
                urlConnection = (HttpURLConnection) url.openConnection();
                urlConnection.setRequestMethod("GET");
                urlConnection.connect();
                InputStream inputStream = urlConnection.getInputStream();
                StringBuffer buffer = new StringBuffer();
                if (inputStream == null)
                    return null;
                reader = new BufferedReader(new InputStreamReader(inputStream));
                while ((result = reader.readLine()) != null) {
                    buffer.append(result + "\n");
                }
                if (buffer.length() == 0)
                    return null;
                result = buffer.toString();
            } catch (MalformedURLException e) {
                e.printStackTrace();
            } catch (ProtocolException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return result;
        }
        protected void onPostExecute(String result){
            mTurn = new ArrayList<LatLng>();
            try{
                JSONObject object = new JSONObject(result);
                JSONArray array = object.getJSONArray("routes");
                object = array.getJSONObject(0).getJSONArray("legs").getJSONObject(0);
                mTurn = decodePoly(array.getJSONObject(0).getJSONObject("overview_polyline").getString("points"));
                mDistance.setText(object.getJSONObject("distance").getString("text"));
                mTime.setText(object.getJSONObject("duration").getString("text"));
                getPath(object.getJSONArray("steps"));
            } catch (JSONException e) {
                e.printStackTrace();
            }


        }
    }
}
