import {
  registerPlugin,
  PluginResultError
} from '@capacitor/core';

import type {
  BackgroundGeolocationFirebaseConfig
} from './definitions';

const TAG:string         = "BackgroundGeolocationFirebase";

const NativeModule:any = registerPlugin(TAG);

export class BackgroundGeolocationFirebase {

  static configure(config:BackgroundGeolocationFirebaseConfig):Promise<Void> {

    config = config || {};

    return new Promise((resolve:Function, reject:Function) => {
      NativeModule.configure({options:config}).then((result:any) => {
        resolve(result.status);
      }).catch((error:PluginResultError) => {
        console.warn(TAG, "ERROR:", error);
        reject(error.message);
      });
    });
  }
}

export * from './definitions';
