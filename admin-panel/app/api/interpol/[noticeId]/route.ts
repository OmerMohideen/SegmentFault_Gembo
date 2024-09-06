import { NextResponse } from 'next/server';

export async function GET(request: Request, { params }: { params: { noticeID: string } }) {
    const { noticeID } = params;
    try {
        const response = await fetch(`https://ws-public.interpol.int/notices/v1/red/${noticeID}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            },
        });

        const data = await response.json();
        return NextResponse.json(data);
    } catch (error) {
        return NextResponse.json({ error: 'Error fetching Red Notice details' }, { status: 500 });
    }
}
