package com.app.urbike.urbike.Fragment;

import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.Toast;

import com.app.urbike.urbike.Activity.MainActivity;
import com.app.urbike.urbike.R;

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

import de.keyboardsurfer.android.widget.crouton.Crouton;
import de.keyboardsurfer.android.widget.crouton.Style;

public class SearchFragment extends Fragment implements View.OnClickListener{
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    private String mParam1;
    private String mParam2;
    private View mView;
    private ImageButton mValid;
    private MainActivity mActivity;
    private EditText mDestination;

    public static SearchFragment newInstance(String param1, String param2) {
        SearchFragment fragment = new SearchFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }
    public SearchFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        mView = inflater.inflate(R.layout.fragment_search, container, false);
        mValid = (ImageButton)mView.findViewById(R.id.button_ok_1);
        mDestination = (EditText)mView.findViewById(R.id.destination);
        mValid.setOnClickListener(this);
        mActivity = (MainActivity)getActivity();
        return mView;
    }

    @Override
    public void onClick(View v) {
        if (!mDestination.getText().toString().isEmpty())
             new FetchAddress().execute(mDestination.getText().toString());
        else
            Crouton.makeText(mActivity, getString(R.string.error_destination), Style.ALERT).show();
    }
    private Double[] getLocationFromJson(String json){
        Double[] result = null;
        try {
            JSONObject object = new JSONObject(json);
            JSONArray array = object.getJSONArray("results");
            object = array.getJSONObject(0).getJSONObject("geometry").getJSONObject("location");
            result = new Double[2];
            result[0] = object.getDouble("lat");
            result[1] = object.getDouble("lng");
        } catch (JSONException e) {
            e.printStackTrace();
            Toast.makeText(mActivity, "Fail", Toast.LENGTH_SHORT).show();
        }
        return result;
    }
    private class FetchAddress extends AsyncTask<String, Void, Double[]>
    {
        private final String URL_API = "https://maps.googleapis.com/maps/api/geocode/json?";
        private final String ADDRESS_API = "address";
        HttpURLConnection urlConnection = null;
        BufferedReader reader = null;
        private Uri buildUri;

        @Override
        protected Double[] doInBackground(String... params) {
            String line = null;
            try {

                buildUri = Uri.parse(URL_API).buildUpon()
                        .appendQueryParameter(ADDRESS_API, params[0])
                        .build();
                URL url = new URL(buildUri.toString());
                urlConnection = (HttpURLConnection) url.openConnection();
                urlConnection.setRequestMethod("GET");
                urlConnection.connect();
                InputStream inputStream = urlConnection.getInputStream();
                StringBuffer buffer = new StringBuffer();
                if (inputStream == null)
                    return null;
                reader = new BufferedReader(new InputStreamReader(inputStream));
                while ((line = reader.readLine()) != null) {
                    buffer.append(line + "\n");
                }
                if (buffer.length() == 0)
                    return null;
                line = buffer.toString();
            } catch (MalformedURLException e) {
                e.printStackTrace();
            } catch (ProtocolException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            finally {
                if (urlConnection != null) {
                    urlConnection.disconnect();
                }
                if (reader != null) {
                    try {
                        reader.close();
                    } catch (final IOException e) {
                        Log.e("FetchAddress", "Error closing stream", e);
                    }
                }
            }

            return getLocationFromJson(line);
        }

        protected void onPostExecute(Double[] result){
            mActivity.setDestinationLocation(result);
            mActivity.swipeNextView();
        }

    }
}
