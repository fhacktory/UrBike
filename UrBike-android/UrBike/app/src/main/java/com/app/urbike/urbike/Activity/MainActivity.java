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
    /*
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        mItemSearch = menu.findItem(R.id.search_address);
        mItemSearch.setOnActionExpandListener(this);
        mSearch = (SearchView) menu.findItem(R.id.search_address).getActionView();
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {


        int id = item.getItemId();
        if (id == R.id.search_address) {

            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public boolean onQueryTextSubmit(String query) {
        return false;
    }

    @Override
    public boolean onQueryTextChange(String newText) {
        return false;
    }

    @Override
    public boolean onMenuItemActionExpand(MenuItem item) {
        FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
        Fragment fragment = getSupportFragmentManager().findFragmentById(R.id.map);
        ft.hide(fragment);
        ft.commit();
        return true;
    }

    @Override
    public boolean onMenuItemActionCollapse(MenuItem item) {
        FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
        Fragment fragment = getSupportFragmentManager().findFragmentById(R.id.map);
        ft.show(fragment);
        ft.commit();
        return true;
    }
    */
}
