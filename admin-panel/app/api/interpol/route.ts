import { NextResponse } from 'next/server';

export async function GET(request: Request) {
    const { searchParams } = new URL(request.url);
    const forename = searchParams.get('forename');

    try {
        const response = await fetch(
            `https:///ws-public.interpol.int/notices/v1/red?forename=${forename}`,
            {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                },
            }
        );
        const data = await response.json();
        return NextResponse.json(data);
    } catch (error) {
        return NextResponse.json({ error: 'Error fetching Red Notices' }, { status: 500 });
    }
}
