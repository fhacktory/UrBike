package com.app.urbike.urbike.Fragment;

import android.location.Location;
import android.location.LocationListener;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.SearchView;
import android.widget.Toast;

import com.app.urbike.urbike.R;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesClient;
import com.google.android.gms.location.LocationClient;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;

/**
 * Created by mehdichouag on 11/10/2014.
 */
public class MainFragment extends Fragment implements LocationListener, GooglePlayServicesClient.ConnectionCallbacks, GooglePlayServicesClient.OnConnectionFailedListener
        , SearchView.OnQueryTextListener {
    private Location mCurrentLocation;
    private LocationClient mLocationClient;
    private GoogleMap mMap = null;
    private View mView;
    private SearchView mSearch;

    public MainFragment() {
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        mView = inflater.inflate(R.layout.fragment_main, container, false);
        mLocationClient = new LocationClient(getActivity(), this, this);
        return mView;
    }

    @Override
    public void onConnected(Bundle bundle){
        mCurrentLocation = mLocationClient.getLastLocation();
        if (mMap == null)
            bindView();
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
            mMap.moveCamera(CameraUpdateFactory.newLatLngZoom(place, 14));
            mMap.setMyLocationEnabled(true);
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

    @Override
    public boolean onQueryTextSubmit(String query) {
        Toast.makeText(getActivity(), query, Toast.LENGTH_SHORT).show();
        return false;
    }

    @Override
    public boolean onQueryTextChange(String newText) {
        return false;
    }
}
