From: Dorian Gray <yourfavouritegod-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Error: DMA: Out of SW-IOMMU space [was: External USB drives
 become unresponsive after few hours.]
Date: Thu, 16 Apr 2015 18:57:46 +0200
Message-ID: <CAJ2095q3Gs=+e4ndKiD4EEX9LMh0Mjkv0nNOT=C-0aLD7tBDew@mail.gmail.com>
References: <Pine.LNX.4.44L0.1504161010370.1391-100000@iolanthe.rowland.org>
	<552FCD25.9060807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <552FCD25.9060807-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Duyck <alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 16 April 2015 at 16:15, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> This appears to be a problem with the IOMMU or SWIOTLB subsystems, not
> the USB subsystem.  I have CC'ed the appropriate mailing lists.

Thanks, I'm far from being a kernel expert, so was expecting it could
be wrong subsection.



On 16 April 2015 at 16:24, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org> wrote:
> Try increasing the SWIOTLB size to 128MB .Default is 64MB.

Ok, so I'm back to k3.18.7 (default in the latest Fatdog), although
I'm not sure what should be the exact value of swiotlb boot param?
Got totally mixed results from uncle Google - some says the unit is in
MiB, some that it's 4k pages and another that 128MiB = 65536, so I
played it safe and used swiotlb=131072.
Is this correct?
It may take a few days, but I'll let you know if it worked (or for how
long, if not).



On 16 April 2015 at 16:54, Alexander Duyck <alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> More likely would be a device driver that is DMA mapping memory but not
> unmapping it after it is done resulting in the bounce buffer pool being
> depleted.
> You might want dump the list of drivers loaded on the system with lsmod,
> and then possibly look at doing a git bisect for something introduced
> between 3.17 and 3.18 since that seems to be when you started seeing
> this issue.

Ok, I'll (try to) look at this, but like I said - I'm not a kernel
(nor git) expert.
Anyway, I guess I'm gonna start with this:
https://wiki.gentoo.org/wiki/Kernel_git-bisect
Who knows...perhaps I'll find something...



Thank you all for the replies.
Jake
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
