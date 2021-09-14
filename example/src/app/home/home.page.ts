import {
  Component,
  NgZone } from '@angular/core';

import {AlertController} from '@ionic/angular';

import { DataService, FetchEvent } from '../services/data.service';

import BackgroundGeolocation from '@transistorsoft/capacitor-background-geolocation';
import {BackgroundGeolocationFirebase} from '@transistorsoft/capacitor-background-geolocation-firebase';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {
  state:any = {
    enabled:false,
    status: -1
  }

  constructor(private data: DataService, private alertController:AlertController, private zone: NgZone) {}

  ionViewWillEnter() {

  }

  ngAfterContentInit() {
    this.init();
  }

  async init() {
    await BackgroundGeolocationFirebase.configure({
      locationsCollection: 'locations',
      geofencesCollection: 'geofences',
      updateSingleDocument: false
    });

    const state = await BackgroundGeolocation.ready({
      debug: true,
      logLevel: BackgroundGeolocation.LOG_LEVEL_VERBOSE,
      distanceFilter: 50,
      stopTimeout: 1,
      stopOnTerminate: false,
      startOnBoot: true
    });
    this.state.enabled = state.enabled;
  }

  onClickClear() {
    this.data.destroy();
  }

  async performYourWorkHere() {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        resolve(true);
      }, 1000);
    });
  }

  async onToggleEnabled() {
    if (this.state.enabled) {
      BackgroundGeolocation.start();
    } else {
      BackgroundGeolocation.stop();
    }
  }

  async onClickScheduleTask() {

  }

  getEvents(): FetchEvent[] {
    return this.data.getEvents();
  }

}
