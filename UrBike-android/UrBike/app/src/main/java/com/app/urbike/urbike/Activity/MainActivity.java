package com.app.urbike.urbike.Activity;

import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.MenuItem;
import android.widget.SearchView;

import com.app.urbike.urbike.Fragment.RadioBox;
import com.app.urbike.urbike.R;


public class MainActivity extends FragmentActivity{

    SearchView mSearch;
    MenuItem mItemSearch;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction()
                    .add(R.id.container, new RadioBox())
                    .commit();
        }
    }

}
