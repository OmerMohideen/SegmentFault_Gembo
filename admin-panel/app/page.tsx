"use client";
import { useState, useEffect } from 'react';
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { signInWithEmailAndPassword, signOut, User } from 'firebase/auth';
import { collection, getDocs } from 'firebase/firestore';
import { VisaApplication } from '../types';
import { Loader2 } from "lucide-react";
import { auth, firestore } from '@/firebaseConfig';
import { useRouter } from 'next/navigation';

export default function AdminPanel() {
  const [email, setEmail] = useState<string>('');
  const [password, setPassword] = useState<string>('');
  const [user, setUser] = useState<User | null>(null);
  const [applications, setApplications] = useState<VisaApplication[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const router = useRouter();

  useEffect(() => {
    const unsubscribe = auth.onAuthStateChanged((user) => {
      setUser(user);
      setLoading(false);
      if (user) {
        fetchApplications();
      }
    });

    return () => unsubscribe();
  }, []);

  const handleLogin = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);
    setError(null);
    try {
      await signInWithEmailAndPassword(auth, email, password);
    } catch (error) {
      console.error('Login failed:', error);
      setError('Invalid email or password');
    } finally {
      setLoading(false);
    }
  };

  const handleLogout = async () => {
    try {
      await signOut(auth);
    } catch (error) {
      console.error('Logout failed:', error);
    }
  };
  const fetchApplications = async () => {
    try {
      const usersCollectionRef = collection(firestore, 'users');
      const usersSnapshot = await getDocs(usersCollectionRef);

      const allVisaApplications: VisaApplication[] = [];

      for (const userDoc of usersSnapshot.docs) {
        const userId = userDoc.id;

        const visaApplicationsRef = collection(firestore, 'users', userId, 'visa_applications');
        const querySnapshot = await getDocs(visaApplicationsRef);

        if (!querySnapshot.empty) {
          const visaApplications = querySnapshot.docs.map((doc) => ({
            id: doc.id,
            userId,
            ...doc.data(),
          }) as unknown as VisaApplication);

          allVisaApplications.push(...visaApplications);
        }
      }

      setApplications(allVisaApplications);
    } catch (error) {
      console.error('Error fetching visa applications:', error);
    }
  };

  const handleReview = (userId: string, applicationId: string) => {
    router.push(`/review/${userId}/${applicationId}`);
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <Loader2 className="w-8 h-8 animate-spin" />
      </div>
    );
  }

  if (!user) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <Card className="w-[350px]">
          <CardHeader>
            <CardTitle>Admin Login</CardTitle>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleLogin} className="space-y-4">
              {error && <p className="text-sm text-red-500">{error}</p>}
              <div className="space-y-2">
                <Input
                  type="email"
                  placeholder="Email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                />
                <Input
                  type="password"
                  placeholder="Password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                />
              </div>
              <Button type="submit" className="w-full">
                {loading ? <Loader2 className="w-4 h-4 animate-spin mr-2" /> : null}
                Login
              </Button>
            </form>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="container mx-auto p-6">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold">Visa Applications</h1>
        <Button onClick={handleLogout} variant="outline">Logout</Button>
      </div>
      {error && <p className="mb-4 text-sm text-red-500">{error}</p>}
      <Card>
        <CardContent className="p-0">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Name</TableHead>
                <TableHead>Passport Number</TableHead>
                <TableHead>Visa Type</TableHead>
                <TableHead>Date of Arrival</TableHead>
                <TableHead>Date of Departure</TableHead>
                <TableHead>Action</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {applications.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={6} className="text-center">No pending applications found</TableCell>
                </TableRow>
              ) : (
                applications.map((application) => (
                  <TableRow key={application.id}>
                    <TableCell>{application.fields.passport_name}</TableCell>
                    <TableCell>{application.fields.passport_number}</TableCell>
                    <TableCell>{application.fields.visa_type}</TableCell>
                    <TableCell>{application.fields.date_of_arrival}</TableCell>
                    <TableCell>{application.fields.date_of_departure}</TableCell>
                    <TableCell>
                      <Button onClick={() => handleReview(application.userId, application.id)} size="sm">
                        Review
                      </Button>
                    </TableCell>
                  </TableRow>
                ))
              )}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  );
}