# Script to spoof sim info to US
chmod +x $MODPATH/boot-completed.sh
chmod +x $MODPATH/action.sh
        
        # make Google dialer as system app
        if [ -z $(pm list packages -s $DIALER) ] && [ ! -f /data/adb/modules/PixelifyNext/system/product/priv-app/GoogleDialer/GoogleDialer.apk ]; then
            print ""
            print "- Google Dialer is not installed as a system app !!"
            print "- Making Google Dialer a system app"
            echo " - Making Google Dialer a system app" >>$logfile
            print ""
            cp -r $app/com.google.android.dialer*/. $MODPATH/system$product/priv-app/GoogleDialer
            mv $MODPATH/system$product/priv-app/GoogleDialer/base.apk $MODPATH/system$product/priv-app/GoogleDialer/GoogleDialer.apk
            rm -rf $MODPATH/system$product/priv-app/GoogleDialer/oat
        # Remake google dialer as system app if Pixelify made it system app
        elif [ -f /data/adb/modules/PixelifyNext/system$product/priv-app/GoogleDialer/GoogleDialer.apk ]; then
            print ""
            print "- Google Dialer is not installed as a system app !!"
            print "- Making Google Dialer a system app"
            echo " - Making Google Dialer a system app" >>$logfile
            print ""
            cp -r $app/com.google.android.dialer*/. $MODPATH/system$product/priv-app/GoogleDialer
            mv $MODPATH/system$product/priv-app/GoogleDialer/base.apk $MODPATH/system$product/priv-app/GoogleDialer/GoogleDialer.apk
            rm -rf $MODPATH/system$product/priv-app/GoogleDialer/oat
        fi

        # Show option to remove Samsung dialer for OneUi users have android version greater than equal to Android S
        [ ! -z "$(getprop ro.oneui.version)" ] && [ $API -ge 31 ] && remove_samsung_dialer
    else
        # Remove Google dialer files if user doesn't want to enable it
        chmod 755 /data/data/com.google.android.dialer/files/phenotype
        sed -i -e "s/cp -Tf $MODDIR\/com.google.android.dialer/#cp -Tf $MODDIR\/com.google.android.dialer/g" $MODPATH/service.sh
        sed -i -e "s/chmod 500 \/data\/data\/com.google.android.dialer\/files\/phenotype/#chmod 500 \/data\/data\/com.google.android.dialer\/files\/phenotype/g" $MODPATH/service.sh
    fi
else
    # Remove Google dialer files if user doesn't want to enable it
    chmod 755 /data/data/com.google.android.dialer/files/phenotype
    sed -i -e "s/cp -Tf $MODDIR\/com.google.android.dialer/#cp -Tf $MODDIR\/com.google.android.dialer/g" $MODPATH/service.sh
    sed -i -e "s/chmod 500 \/data\/data\/com.google.android.dialer\/files\/phenotype/#chmod 500 \/data\/data\/com.google.android.dialer\/files\/phenotype/g" $MODPATH/service.sh
fi
