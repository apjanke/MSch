package net.apjanke.msch;

import com.jcraft.jsch.UserInfo;

/**
 * A simple holder for a username and password that is to be populated programmatically by the
 * caller. Does not do any prompting or user interaction.
 */
public class DumbUserInfo implements UserInfo {

    private String password;
    private String passphrase;

    public DumbUserInfo() {

    }

    public DumbUserInfo(String password, String passphrase) {
        this.passphrase = passphrase;
        this.password = password;
    }

    @Override
    public String getPassphrase() {
        return this.passphrase;
    }

    @Override
    public String getPassword() {
        return this.password;
    }

    @Override
    public boolean promptPassword(String s) {
        return password != null;
    }

    @Override
    public boolean promptPassphrase(String s) {
        return passphrase != null;
    }

    @Override
    public boolean promptYesNo(String s) {
        return false;
    }

    @Override
    public void showMessage(String s) {
        System.out.println(s);
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setPassphrase(String passphrase) {
        this.passphrase = passphrase;
    }

}
