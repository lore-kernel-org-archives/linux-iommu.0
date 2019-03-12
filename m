From: Stanislaw Gruszka <sgruszka-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: MT76x2U crashes XHCI driver on AMD Ryzen system
Date: Tue, 12 Mar 2019 08:13:14 +0100
Message-ID: <20190312071314.GB2483@redhat.com>
References: <20190226103450.GA2989@redhat.com>
	<20190226104413.GH20740@8bytes.org>
	<20190226112407.GB2989@redhat.com>
	<20190228090411.GA24938@redhat.com>
	<20190228104223.GA2749@redhat.com>
	<20190228121948.GD6072@redhat.com>
	<20190228134029.GC1594@8bytes.org>
	<20190304071037.GA2787@redhat.com>
	<CAKxU2N-k-9DCYBv6W3CohL963dr3AeY3VHyt8FrUuo=BfacDsw@mail.gmail.com>
	<20190311084319.GA3310@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190311084319.GA3310-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rosen Penev <rosenp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Samuel Sieb <samuel-yL8jFUf1A1M@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvme-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, jan.viktorin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Lorenzo Bianconi <lorenzo.bianconi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 11, 2019 at 09:43:19AM +0100, Stanislaw Gruszka wrote:
> > > However after fixing that mt76usb still did not work. To make things
> > > work we had to change rx frag size from 2048 to PAGE_SIZE and change
> > > virt_to_head_page() to virt_to_page() when setting SG's.
> >
> > > I think I understand why first change was needed. If we do 2 separate
> > > dma maps of 2 different buffers in single page i.e (PAGE + off=0
> > > and PAGE + off=2048) it causes problem. So either map_sg() return
> > > error which mt76usb does not handle correctly or there is issue
> > > in AMD IOMMU because two dma maps use the same page.
> 
> Any comment on that? Is fine or not to do 2 or more dma mappings
> within the same single page on AMD IOMMU? If not, is there any
> mechanism for drivers to find out about this limitation to prevent
> to prepare wrong SG buffers?

FTR: it was confirmed by Jan (bug reporter) the 2 or more dma mappings
within single page works with AMD IOMMU. Most likely it was needed
previously to workaround this sg->offset problem until proper fix to
AMD IOMMU was applied.

Stanislaw 
