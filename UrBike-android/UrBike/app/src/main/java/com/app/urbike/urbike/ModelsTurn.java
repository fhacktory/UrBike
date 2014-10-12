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

    public ModelsTurn(LatLng position, int direction){
        this.mPosition = position;
        this.mDirection = direction;
    }

    public int getmDirection() {
        return mDirection;
    }

    public void setmDirection(int mDirection) {
        this.mDirection = mDirection;
    }

    public LatLng getmPosition() {
        return mPosition;
    }

    public void setmPosition(LatLng mPosition) {
        this.mPosition = mPosition;
    }
}
