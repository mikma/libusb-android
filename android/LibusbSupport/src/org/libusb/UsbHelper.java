package org.libusb;

import java.io.PrintWriter;
import java.io.StringWriter;

import android.app.Service;
import android.content.Context;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbDeviceConnection;
import android.hardware.usb.UsbManager;

public class UsbHelper {
    private static UsbManager manager;

    public static UsbManager getManager() {
        return manager;
    }

    public static void useContext(Context context) {
        manager = (UsbManager) context.getSystemService(Service.USB_SERVICE);
    }

    @SuppressWarnings("UnusedDeclaration")
    public static UsbDeviceConnection openDevice(String path) {
        UsbDevice device = manager.getDeviceList().get(path);
        if (device == null) return null;
        return manager.openDevice(device);
    }

    @SuppressWarnings("UnusedDeclaration")
    public static String getStackTraceAsString(Throwable throwable) {
        StringWriter writer = new StringWriter();

        throwable.printStackTrace(new PrintWriter(writer));
        return writer.toString();
    }
}
