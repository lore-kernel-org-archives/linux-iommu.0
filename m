From: Dorian Gray <yourfavouritegod@gmail.com>
Subject: Re: Error: DMA: Out of SW-IOMMU space [was: External USB drives
 become unresponsive after few hours.]
Date: Fri, 17 Apr 2015 17:10:07 +0200
Message-ID: <CAJ2095rfTS-_z-9=UOOoUsCL4f5rAF4jm6VyoGqpjGLfPzNC4g@mail.gmail.com>
References: <Pine.LNX.4.44L0.1504161010370.1391-100000@iolanthe.rowland.org>
	<552FCD25.9060807@gmail.com>
	<CAJ2095q3Gs=+e4ndKiD4EEX9LMh0Mjkv0nNOT=C-0aLD7tBDew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ2095q3Gs=+e4ndKiD4EEX9LMh0Mjkv0nNOT=C-0aLD7tBDew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, iommu@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 16 April 2015 at 18:57, Dorian Gray <yourfavouritegod@gmail.com> wrote:
> On 16 April 2015 at 16:24, Suman Tripathi <stripathi@apm.com> wrote:
>> Try increasing the SWIOTLB size to 128MB .Default is 64MB.
>
> Ok, so I'm back to k3.18.7 (default in the latest Fatdog), although
> I'm not sure what should be the exact value of swiotlb boot param?
> Got totally mixed results from uncle Google - some says the unit is in
> MiB, some that it's 4k pages and another that 128MiB = 65536, so I
> played it safe and used swiotlb=131072.
> Is this correct?
> It may take a few days, but I'll let you know if it worked (or for how
> long, if not).

I was running 3.18.7 + swiotlb=131072 + 2 external drives plugged-in
and mounted for about 18 hours straight. The error didn't show up.

Well, I would run it a little longer, but I had to restart X and while
doing so, the system crashed for an unknown reason.

Anyway, this seems to be quite reliable workaround - at least I can
_use_ kernels newer than 3.17.8, because with that bug, popping up
after a couple of hours of uptime, it was a total show stopper to me.

Thanks!
Jake
