package com.app.urbike.urbike.Activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;

import com.app.urbike.urbike.Fragment.MainFragment;
import com.app.urbike.urbike.Fragment.RadioBox;
import com.app.urbike.urbike.Fragment.SearchFragment;
import com.app.urbike.urbike.PagerAdapter.MyPagerAdapter;
import com.app.urbike.urbike.R;

import java.util.ArrayList;
import java.util.List;


public class MainActivity extends FragmentActivity{

    PagerAdapter mPagerAdapter;
    ViewPager mViewPager;
    List<Fragment> mFragments = new ArrayList<Fragment>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mFragments.add(new SearchFragment());
        mFragments.add(new RadioBox());
        mFragments.add(new MainFragment());
        mPagerAdapter = new MyPagerAdapter(getSupportFragmentManager(), mFragments);
        mViewPager = (ViewPager)findViewById(R.id.viewpager);
        mViewPager.setAdapter(mPagerAdapter);
    }

    public void swipeNextView(){
        if (mViewPager.getCurrentItem() < mPagerAdapter.getCount())
            mViewPager.setCurrentItem(mViewPager.getCurrentItem() + 1);
    }

    public void setDestinationLocation(Double[] location){
        MainFragment fragment = (MainFragment)mFragments.get(2);
        fragment.setmDestination(location);
    }
}
