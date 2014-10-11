package com.app.urbike.urbike.Fragment;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RadioButton;

import com.app.urbike.urbike.R;

public class RadioBox extends Fragment implements RadioButton.OnClickListener {
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    private String mParam1;
    private String mParam2;
    private RadioButton mRadio1;
    private RadioButton mRadio2;
    private RadioButton mRadio3;
    private View mView;

    public static RadioBox newInstance(String param1, String param2) {
        RadioBox fragment = new RadioBox();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }
    public RadioBox() {
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
        mView = inflater.inflate(R.layout.fragment_radio_box, container, false);
        mRadio1 = (RadioButton)mView.findViewById(R.id.radio_1);
        mRadio2 = (RadioButton)mView.findViewById(R.id.radio_2);
        mRadio3 = (RadioButton)mView.findViewById(R.id.radio_3);
        mRadio1.setOnClickListener(this);
        mRadio2.setOnClickListener(this);
        mRadio3.setOnClickListener(this);
        return mView;
    }


    @Override
    public void onClick(View v) {
        if (v == mRadio1){
            mRadio2.setChecked(false);
            mRadio3.setChecked(false);
        }
        else if (v == mRadio2){
            mRadio1.setChecked(false);
            mRadio3.setChecked(false);
        }
        else {
            mRadio1.setChecked(false);
            mRadio2.setChecked(false);
        }
    }
}
