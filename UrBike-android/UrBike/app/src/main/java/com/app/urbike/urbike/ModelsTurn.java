package com.app.urbike.urbike;

import com.google.android.gms.maps.model.LatLng;

/**
 * Created by mehdichouag on 12/10/2014.
 */
public class ModelsTurn {
    public static final int RIGHT = 1;
    public static final int LEFT = 2;
    public static final int NONE = 3;
    private LatLng mPosition;
    private int mDirection;
    private String mDir;

    public ModelsTurn(LatLng position, int direction, String dir){
        this.mPosition = position;
        this.mDirection = direction;
        this.mDir = dir;
    }

    public int getmDirection() {
        return mDirection;
    }

    public LatLng getmPosition() {
        return mPosition;
    }

    public String getmDir() {
        return mDir;
    }
}
