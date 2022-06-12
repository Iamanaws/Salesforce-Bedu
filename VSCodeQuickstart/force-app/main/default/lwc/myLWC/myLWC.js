import { LightningElement, wire } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList'

export default class MyLWC extends LightningElement {
   @wire (getContactList) contacts;
}