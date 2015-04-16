From: Dorian Gray <yourfavouritegod-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Error: DMA: Out of SW-IOMMU space [was: External USB drives
 become unresponsive after few hours.]
Date: Thu, 16 Apr 2015 22:13:33 +0200
Message-ID: <CAJ2095o-xbxnDB=+GWzituiB2rP1SK4e1iSYrsFNLhUJn6qpiw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1504161010370.1391-100000@iolanthe.rowland.org>
	<552FCD25.9060807@gmail.com>
	<CAJ2095q3Gs=+e4ndKiD4EEX9LMh0Mjkv0nNOT=C-0aLD7tBDew@mail.gmail.com>
	<20150416184252.GE7388@x230.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150416184252.GE7388-sHAKZZqAc8NKMcnDSFYBzAC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Alexander Duyck <alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 16 April 2015 at 20:42, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> And easier way is to compile the kernel with CONFIG_DMA_API_DEBUG
> and then load the attached module.
>
> That should tell you who and what else is holding on the buffers.

Thanks, this will be my next step then, right after I'm done with
testing the increased SWIOTLB.

Jake
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
