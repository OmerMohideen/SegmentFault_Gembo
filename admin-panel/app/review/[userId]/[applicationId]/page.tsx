"use client";
import { useState, useEffect } from 'react';
import { addDoc, collection, doc, getDoc, updateDoc } from 'firebase/firestore';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { ArrowLeft, Loader2 } from "lucide-react";
import { auth, firestore } from '@/firebaseConfig';
import { VisaApplication } from '@/types';
import { Button } from '@/components/ui/button';
import { useRouter } from 'next/navigation';

interface ReviewPageProps {
    params: {
        userId: string;
        applicationId: string;
    };
}

export default function ReviewPage({ params }: ReviewPageProps) {
    const { userId, applicationId } = params;
    const [application, setApplication] = useState<VisaApplication | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);
    const [redNoticeResult, setRedNoticeResult] = useState<any | null>(null);
    const [checkingRedNotice, setCheckingRedNotice] = useState(false);
    const router = useRouter();

    useEffect(() => {
        const fetchApplication = async () => {
            try {
                const docRef = doc(firestore, 'users', userId, 'visa_applications', applicationId);
                const docSnap = await getDoc(docRef);
                if (docSnap.exists()) {
                    setApplication(docSnap.data() as VisaApplication);
                } else {
                    setError('Application not found.');
                }
            } catch (err) {
                setError('Error fetching application details.');
                console.error(err);
            } finally {
                setLoading(false);
            }
        };

        fetchApplication();
    }, [userId, applicationId]);

    const checkForRedNotices = async () => {
        setCheckingRedNotice(true);
        setRedNoticeResult(null);

        try {
            const response = await fetch(`/api/interpol?forename=${application?.fields.passport_name}`);
            const data = await response.json();

            if (data && data._embedded && data._embedded.notices.length > 0) {
                setRedNoticeResult(data._embedded.notices);
                console.log(data._embedded.notices);
            } else {
                setRedNoticeResult('No Red Notices found.');
            }
        } catch (error) {
            console.error('Error checking Red Notices:', error);
            setRedNoticeResult('Error checking Red Notices.');
        } finally {
            setCheckingRedNotice(false);
        }
    };

    const fetchRedNoticeDetails = async (noticeID: string) => {
        try {
            const response = await fetch(`/api/interpol/${noticeID}`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                },
            });

            const data = await response.json();
            console.log(data);
        } catch (error) {
            console.error('Error fetching Red Notice details:', error);
        }
    };

    const handleApprove = async () => {
        const currentUser = auth.currentUser;
        const authorName = currentUser ? currentUser.email : 'Unknown';

        try {
            const docRef = doc(firestore, 'users', userId, 'visa_applications', applicationId);

            await updateDoc(docRef, {
                status: 'Approved',
            });

            const historyRef = collection(firestore, 'users', userId, 'visa_applications', applicationId, 'visa_status', applicationId, 'history');
            await addDoc(historyRef, {
                author: authorName,
                comments: 'Visa application approved.',
                status_code: 1,
                status_message: 'Application Approved',
                timestamp: new Date(),
            });

            console.log('Application approved and history updated!');
        } catch (error) {
            console.error('Error approving application:', error);
        }
    };

    const handleDecline = async () => {
        const currentUser = auth.currentUser;
        const authorName = currentUser ? currentUser.email : 'Unknown';

        try {
            const docRef = doc(firestore, 'users', userId, 'visa_applications', applicationId);

            await updateDoc(docRef, {
                status: 'Declined',
            });

            const historyRef = collection(firestore, 'users', userId, 'visa_applications', applicationId, 'visa_status', applicationId, 'history');
            await addDoc(historyRef, {
                author: authorName,
                comments: 'Visa application declined.',
                status_code: 2,
                status_message: 'Application Declined',
                timestamp: new Date(),
            });

            console.log('Application declined and history updated!');
        } catch (error) {
            console.error('Error declining application:', error);
        }
    };

    if (loading) {
        return (
            <div className="flex items-center justify-center min-h-screen">
                <Loader2 className="w-8 h-8 animate-spin" />
            </div>
        );
    }

    if (error) {
        return <p className="text-red-500">{error}</p>;
    }

    if (!application) {
        return <p>No application found.</p>;
    }

    return (
        <div className="container mx-auto p-6">
            <Button className='my-4' onClick={() => router.back()}>
                <ArrowLeft />
            </Button>
            <Card>
                <CardHeader>
                    <CardTitle>Review Application</CardTitle>
                </CardHeader>
                <CardContent>
                    <p><strong>Name:</strong> {application.fields.passport_name}</p>
                    <p><strong>Passport Number:</strong> {application.fields.passport_number}</p>
                    <p><strong>Visa Type:</strong> {application.fields.visa_type}</p>
                    <p><strong>Sub Visa Type:</strong> {application.fields.sub_visa_type}</p>
                    <p><strong>Visa Category:</strong> {application.fields.visa_category}</p>
                    <p><strong>Date of Arrival:</strong> {application.fields.date_of_arrival}</p>
                    <p><strong>Date of Departure:</strong> {application.fields.date_of_departure}</p>
                    <p><strong>Date of Birth:</strong> {application.fields.dob}</p>
                    <p><strong>Email:</strong> {application.fields.email}</p>
                    <p><strong>Gender:</strong> {application.fields.gender}</p>
                    <p><strong>Issue Date:</strong> {application.fields.issue_date}</p>
                    <p><strong>Nationality:</strong> {application.fields.nationality}</p>
                    <p><strong>Phone Number:</strong> {application.fields.personal_country_code}{application.fields.phone_number}</p>
                    <p><strong>WhatsApp Number:</strong> {application.fields.whatsapp_country_code}{application.fields.whatsapp_number}</p>
                    <p><strong>Port of Entry:</strong> {application.fields.port_entry}</p>
                    <p><strong>Purpose of Visit:</strong> {application.fields.purpose}</p>
                    <p><strong>Residence:</strong> {application.fields.country_of_residence}</p>
                    <p><strong>Residential Address:</strong> {application.fields.residential_address}</p>
                    <p><strong>Travel Document:</strong> {application.fields.travel_document}</p>
                    <p><strong>Valid Until:</strong> {application.fields.valid_date}</p>
                    <br /><p><strong>Uploaded Documents:</strong></p><br />
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                            <p><strong>Additional Document:</strong></p>
                            <img src={application.fileUrls.add_docs} alt="Additional Document" className="w-full h-auto border rounded" />
                        </div>
                        <div>
                            <p><strong>Invitation Letter:</strong></p>
                            <img src={application.fileUrls.invite_letter} alt="Invitation Letter" className="w-full h-auto border rounded" />
                        </div>
                        <div>
                            <p><strong>Passport Bio:</strong></p>
                            <img src={application.fileUrls.passport_bio} alt="Passport Bio" className="w-full h-auto border rounded" />
                        </div>
                    </div>

                    <Button onClick={handleApprove} className="mt-4 bg-green-400">Approve</Button>
                    <Button onClick={handleDecline} className="mt-4 mx-2 bg-red-400">Decline</Button>
                    <Button onClick={() => checkForRedNotices()} className="mt-4" disabled={checkingRedNotice}>
                        {checkingRedNotice ? <Loader2 className="w-4 h-4 animate-spin mr-2 " /> : null}
                        Check for Red Notices
                    </Button>

                    {redNoticeResult && (
                        <div className="my-4">
                            <strong>Red Notice Result:</strong>
                            {Array.isArray(redNoticeResult) ? (
                                <ul className="list-disc ml-5 flex flex-col gap-6">
                                    {redNoticeResult.map((notice: any) => (
                                        <li key={notice.entity_id} className='w-full flex justify-between'>
                                            {notice.forename} {notice.name}
                                            <Button
                                                className="ml-4"
                                                onClick={() => {
                                                    const formattedEntityId = notice.entity_id.replace('/', '-');
                                                    fetchRedNoticeDetails(formattedEntityId)
                                                }}
                                            >
                                                View Details
                                            </Button>
                                        </li>
                                    ))}
                                </ul>
                            ) : (
                                <p>{redNoticeResult}</p>
                            )}
                        </div>
                    )}
                </CardContent>
            </Card>
        </div>
    );
}
