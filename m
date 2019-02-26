From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: MT76x2U crashes XHCI driver on AMD Ryzen system
Date: Tue, 26 Feb 2019 11:05:36 +0100
Message-ID: <20190226100535.GA20740@8bytes.org>
References: <CAJ0CqmVNF83bWgc+LSQ3_i=zfp-sXC5Nf=nKfqB3SWa8r7sKdQ@mail.gmail.com>
 <83A1D243-9073-48D1-9F26-5A2581DCB829@gmail.com>
 <CAJ0CqmUgPWNJtCW4Q__sOtB8w-YtwW+uZy7crxMNrmSgQ6OFyA@mail.gmail.com>
 <1547404075.1582.0@smtp.gmail.com>
 <CAJ0CqmU7k5i26g7dGPxNdts7Gm67W6qNsr4vYuW05ugsEF1ohw@mail.gmail.com>
 <CAKxU2N-+CTaRdJMFVRdozJ5TTpN+_4thiDRBJBFq8gGtuRVYvA@mail.gmail.com>
 <20190114091841.GA23045@localhost.localdomain>
 <CAKxU2N8ioMszBCyQcH7CVhgBdW4aj7yZ+kYQe14DCV5OSAnxrg@mail.gmail.com>
 <20190115090400.GA2267@localhost.localdomain>
 <20190218143742.GA11872@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190218143742.GA11872-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stanislaw Gruszka <sgruszka-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rosen Penev <rosenp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Samuel Sieb <samuel-yL8jFUf1A1M@public.gmane.org>, Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 18, 2019 at 03:37:48PM +0100, Stanislaw Gruszka wrote:
> 0001-mt76x02u-use-usb_bulk_msg-to-upload-firmware.patch
> 0002-mt76usb-do-not-use-compound-head-page-for-SG-I-O.patch
> 
> Or problem can be solved by just one of it (either first or second).
> 
> Additionally I'm not 100% sure if
> 
> 0002-mt76usb-do-not-use-compound-head-page-for-SG-I-O.patch
> 
> is correct. So perhaps some IOMMU maintainer could look at it.

The patch looks good, but I don't understand why it is needed. The AMD
IOMMU driver should handle sg->offset > PAGE_SIZE just fine. Can you
verify that this is the problem? I will look into that again if it turns
out there is bug in the IOMMU driver.

Regards,

	Joerg
