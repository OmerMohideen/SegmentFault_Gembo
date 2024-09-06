import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';
import { getFirestore } from 'firebase/firestore';

const firebaseConfig = {
  apiKey: "AIzaSyDS-aGaoUtNrKQZh_VPzHTNb-_CtSpwz4c",
  authDomain: "segmentfault-gembo-cd0f7.firebaseapp.com",
  projectId: "segmentfault-gembo-cd0f7",
  storageBucket: "segmentfault-gembo-cd0f7.appspot.com",
  messagingSenderId: "836629613949",
  appId: "1:836629613949:web:43cd0eead48abc03e79014"
};

const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const firestore = getFirestore(app);

