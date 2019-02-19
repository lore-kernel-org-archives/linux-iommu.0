From: Stanislaw Gruszka <sgruszka-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: MT76x2U crashes XHCI driver on AMD Ryzen system
Date: Tue, 19 Feb 2019 12:08:52 +0100
Message-ID: <20190219110851.GA23223@redhat.com>
References: <83A1D243-9073-48D1-9F26-5A2581DCB829@gmail.com>
 <CAJ0CqmUgPWNJtCW4Q__sOtB8w-YtwW+uZy7crxMNrmSgQ6OFyA@mail.gmail.com>
 <1547404075.1582.0@smtp.gmail.com>
 <CAJ0CqmU7k5i26g7dGPxNdts7Gm67W6qNsr4vYuW05ugsEF1ohw@mail.gmail.com>
 <CAKxU2N-+CTaRdJMFVRdozJ5TTpN+_4thiDRBJBFq8gGtuRVYvA@mail.gmail.com>
 <20190114091841.GA23045@localhost.localdomain>
 <CAKxU2N8ioMszBCyQcH7CVhgBdW4aj7yZ+kYQe14DCV5OSAnxrg@mail.gmail.com>
 <20190115090400.GA2267@localhost.localdomain>
 <20190218143742.GA11872@redhat.com>
 <2cc5674a-a3a0-d8fe-65f5-4357da9b85d3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2cc5674a-a3a0-d8fe-65f5-4357da9b85d3-5wv7dgnIgG8@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Samuel Sieb <samuel-yL8jFUf1A1M@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rosen Penev <rosenp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 18, 2019 at 05:01:59PM +0000, Robin Murphy wrote:
> On 18/02/2019 14:37, Stanislaw Gruszka wrote:
> [...]
> >Another issue is that dma_map_sg() & dma_map_page() may require some
> >constraints. I'm not sure about that and I want to clarify that with
> >CCed mm maintainers. I think DMA drivers may expect sg->offset < PAGE_SIZE
> >for both dma_map_sg() and dma_map_page(). Additionally dma_map_page()
> >maight expect that offset & length specify buffer within one page.
> 
> Luckily, this came up a while back[1] and we seemed to reach a
> consensus that sg->offset >= PAGE_SIZE for dma_map_sg() was weird
> but valid. IIRC it was only the Intel IOMMU code which failed to
> handle that case appropriately (and which I fixed) - the AMD IOMMU
> code always looked like it should be OK, but I'm not sure I've ever
> seen definitive test results (and I don't have hardware to do so
> myself).

Funny that we have problems on AMD IOMMU and not with Intel IOMMU.

> For dma_map_page(), length >= PAGE_SIZE should be perfectly valid
> and handled correctly. The offset >= PAGE_SIZE case is a bit harder
> to justify, but at the same time has less scope for the DMA API
> backend to get it wrong, so either way is likely to be OK in
> practice (in particular the AMD IOMMU code looks like it won't have
> a problem, since its map_page() implementation converts page and
> offset to a plain physical address before doing anything else).

Thanks for clarify this. So my patch which do:

-		page = virt_to_head_page(data);
+		page = virt_to_page(data);
 		offset = data - page_address(page);
 		sg_set_page(&urb->sg[i], page, sglen, offset);

should not be necessary as IOMMU driver do exactly the same internally.

Are there any alignment requirement for offset for dma_map_{page,sg} ?
It will work with let say sg->offset=113 or we have make sure it is
aligned to some boundary. If so, what boundary ?

Stanislaw
