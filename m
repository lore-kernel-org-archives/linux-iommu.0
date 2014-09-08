From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: ath9k and AMD IOMMU alias breakage on 3.16?
Date: Mon, 8 Sep 2014 12:32:03 +0200
Message-ID: <20140908103203.GQ28786@8bytes.org>
References: <CAGou9MhCmRajqfh91rxbBUr9PBvJxo7U=g9p4Onp0pJk4BwBnA@mail.gmail.com>
 <1409976104.2982.56.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409976104.2982.56.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Newton <nevion-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 05, 2014 at 10:01:44PM -0600, Alex Williamson wrote:
> On Fri, 2014-09-05 at 20:00 -0700, Jason Newton wrote:
> > Hi,
> > 
> > I have an AR9462 connected over minipcie, it came with the ASRock
> > FM2A88x-itx motherboard and I'm using an AMD A10-7850K cpu with it.  When I
> > have IOMMU enabled, and this is desirable for opencl related things, the
> > AR9462 malfunctions with these two errors occurring:
> > 
> > AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=00:00.1
> > address=0x000000fdf8080020 flags=0x0a00]

This means that the device 00:00.1 is sending to the interrupt/EOI
address-range while interrupt remapping is enabled. You can boot with
intremap=off on the kernel command line to work around this problem.

This looks either like another PCI aliasing issue or a 00:00.1 hidden
device is sending interrupt requests (which it is not allowed to do).


	Joerg

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
