package edu.gatech.seclass.tccart;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import edu.gatech.seclass.services.PrintingService;
import edu.gatech.seclass.services.QRCodeService;

public class EditCustomer extends AppCompatActivity {

    private EditText edName;
    private EditText edEmail;
    private TextView txtCustomerId;
    private Button btnEditCustomerSave;
    private String hexId = ""; //if hexId is empty, we're creating a customer, else editing

    private boolean isEditMode(){
        if (hexId.equalsIgnoreCase("")) {
            return false; //empty -> create mode
        }
        else {
            return true; //has ID -> edit mode
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_customer);

        edName = (EditText)findViewById(R.id.edName);
        edEmail = (EditText)findViewById(R.id.edEmail);
        txtCustomerId = (TextView)findViewById(R.id.txtCustomerId);
        btnEditCustomerSave = (Button)findViewById(R.id.btnEditCustomerSave);
    }

    //clears EditText when selected
    public void onEditCustomerEditSelect(View view) {
        if (view.getId() == R.id.edName || view.getId() == R.id.edEmail) {
            EditText edit = (EditText) findViewById(view.getId());
            if (edit.getText().toString().equalsIgnoreCase("name") || edit.getText().toString().equalsIgnoreCase("email")) {
                edit.setText("");
            }
        }
    }

    public void onEditCustomerButtonClick(View view) {
        switch (view.getId()) {
            case R.id.btnEditCustomerSave:
                btnEditCustomerSaveAction();
                break;

            case R.id.btnEditCustomerScanQr:
                btnEditCustomerScanQrAction();
                break;

            case R.id.btnEditCustomerClear:
                modeResetToCreateAndClear();
                break;
        }
    }

    private void btnEditCustomerSaveAction() {
        String strName = edName.getText().toString();
        String strEmail = edEmail.getText().toString();

        if (!isEditMode()) { //create mode
            if (areNameAndEmailValid(strName, strEmail)) {
                Customer customer = new Customer(strName, strEmail);
                TCCartDBHelper.saveCustomerToDB(customer, this);

                //SQLite code catches exceptions and returns -1 on error
                if (customer.isEmailAlreadyRegistered()) { //if error, then it's most likely UNIQUE constraint on email
                    TCCartHelper.showMsg("Email already registered", this);
                } else {
                    //print id card
                    String[] firstAndLastNames = TCCartHelper.tokenizeString(customer.getName(), 2); //tokenize name into 2 strings
                    boolean isPrintCardSuccessful = false;
                    //using while loop since customer IDs are generated by the DB and it's the easiest thing to do for this sort of "reprint requirement"
                    while (!isPrintCardSuccessful) {
                        isPrintCardSuccessful = PrintingService.printCard(firstAndLastNames[0], firstAndLastNames[1], customer.getHexId());
                        if (!isPrintCardSuccessful) {
                            TCCartHelper.showMsg("ID card printing failed, trying to reprint", this);
                        }
                    }

                    TCCartHelper.showMsg("Created customer " + customer.getHexId() + " and printed ID card", this);
                    modeResetToCreateAndClear();
                }
            }
        }
        else{ //edit mode
            if (areNameAndEmailValid(strName, strEmail)) {
                //TODO: needs thorough testing with all state changes...

                Customer customer = new Customer(strName, strEmail);
                customer.setHexId(hexId);
                if (TCCartDBHelper.updateCustomerNameAndEmail(customer, this)) {
                    TCCartHelper.showMsg("Update successful", this);
                    modeResetToCreateAndClear();
                }
                else {
                    TCCartHelper.showMsg("Unable to update: customer is not found", this);
                    //can only happen due to race conditions: if you scan QR, load customer from DB and then manually delete that customer from DB via SQLite console
                    modeResetToCreateAndClear();
                }

            }
        }
    }

    private void btnEditCustomerScanQrAction() {
        hexId = QRCodeService.scanQRCode().toUpperCase();
        if (!hexId.equalsIgnoreCase("ERR")) {
            txtCustomerId.setText("Customer ID: " + hexId);

            Customer customer = TCCartDBHelper.loadCustomerFromDbByHexId(hexId, this);

            if (customer != null) { //checking for null anyway: see to-dos in db helper for more info
                edEmail.setText(customer.getEmail());
                edName.setText(customer.getName());
                btnEditCustomerSave.setText("Update");
            }
            else {
                TCCartHelper.showMsg("ERROR: customer for ID " + hexId + " doesn't exist! IS IT A COUNTERFEIT ID CARD?! :)", this);
                modeResetToCreateAndClear();
            }
        }
        else {
            modeResetToCreateAndClear();
            TCCartHelper.showMsg("Error scanning ID card, please rescan", this);
        }
    }


    //TODO: EditCustomer needs a reset button to go back from edit to create mode (reset)!
    private void modeResetToCreateAndClear() {
        hexId = "";
        btnEditCustomerSave.setText("Create");
        edEmail.setText("");
        edName.setText("");
        txtCustomerId.setText("Customer ID:");
    }

    //verifies input
    private boolean areNameAndEmailValid(String strName, String strEmail) {
        boolean isInputValidated = false;
        if (strName == null || strName.equalsIgnoreCase("")) {
            TCCartHelper.showMsg("Name should not be empty", this);
        } else if (strEmail == null || strEmail.equalsIgnoreCase("")) {
            TCCartHelper.showMsg("Email should not be empty", this);
        } else if (!strEmail.matches(".+@.+\\..+")) { //email must have "@", "." and at least 1 symbol before, after and in between
            TCCartHelper.showMsg("Invalid email address", this);
        } else if (!strName.matches("[a-zA-Z]+ [a-zA-Z]+")) { //name must have space between first and last names, no special chars
            TCCartHelper.showMsg("Name format should be \"First Last\" (No special characters are allowed)", this);
        } else {
            isInputValidated = true;
        }
        return isInputValidated;
    }
}