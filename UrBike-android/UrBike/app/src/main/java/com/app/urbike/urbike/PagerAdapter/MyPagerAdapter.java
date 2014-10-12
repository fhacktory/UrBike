package com.app.urbike.urbike.PagerAdapter;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;

import java.util.List;

/**
 * Created by mehdichouag on 11/10/2014.
 */

public class MyPagerAdapter extends FragmentPagerAdapter {

    private final List<Fragment> mFragments;

    public MyPagerAdapter(FragmentManager fm, List fragments){
        super(fm);
        this.mFragments = fragments;
    }

    @Override
    public int getCount() {
        return mFragments.size();
    }

    @Override
    public Fragment getItem(int i) {
        return mFragments.get(i);
    }
}