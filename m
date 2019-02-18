From: Lorenzo Bianconi <lorenzo.bianconi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: MT76x2U crashes XHCI driver on AMD Ryzen system
Date: Mon, 18 Feb 2019 16:15:22 +0100
Message-ID: <20190218151521.GB9283@localhost.localdomain>
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
Cc: Rosen Penev <rosenp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Samuel Sieb <samuel-yL8jFUf1A1M@public.gmane.org>, Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

> (cc: IOMMU & page_frag_alloc maintainers)
> 
> On Tue, Jan 15, 2019 at 10:04:01AM +0100, Lorenzo Bianconi wrote:
> > > On Mon, Jan 14, 2019 at 1:18 AM Lorenzo Bianconi
> > > <lorenzo.bianconi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > > >
> > > > > On Sun, Jan 13, 2019 at 11:00 AM Lorenzo Bianconi
> > > > > <lorenzo.bianconi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On Sun, Jan 13, 2019 at 5:33 AM, Lorenzo Bianconi <lorenzo.bianconi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > > > > > >
> > > > > > > Direct. No VM used. This is the only peripheral causing this issue.
> > > > > > >
> > > > > > > Is the device connected to a usb3.0 port? If so, could you please try to connect the dongle to a 2.0 one?
> > > > > > >
> > > > > > > I tried through a USB 2.0 port. Shouldn't make a difference as they both use the xhci driver.
> > > > > > >
> > > > > >
> > > > > > mt76x2u supports scatter-gather on usb 3.0 (not on 2.0)
> > > > > Tried a USB 3 port. Same result.
> > > > > >
> > > > > > > Could you please double check if IOMMU is enabled?
> > > > > > >
> > > > > >
> > > > > > Have you tried to disable it? Does it make any difference?
> > > > > No idea how. UEFI doesn't seem to show anything similar.
> > > > >
> > > > > Similar bug report: https://bugzilla.kernel.org/show_bug.cgi?id=202241
> 
> FWIW: I provided some patches in the bugzilla, which were reported to
> solve the problem. But I looking for confirmation if both are needed:
> 
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
> 
> > > > You should be able to disable iommu using GRUB_CMDLINE_LINUX in
> > > > /etc/default/grub (I guess setting iommu=off and reinstalling grub)
> > > > https://wiki.gentoo.org/wiki/IOMMU_SWIOTLB
> > > Yep. Working great now. I wonder what mt76 is doing to cause the crash though...
> > 
> > Thanks for bisecting the issue. 
> 
> Lorenzo, what you mean by 'bisecting' here ? Someone did 'git bisect'
> on this issue?
> 

Hi Stanislaw,

I was meaning 'help bisecting' the issue

> > I think amd iommu does not support well usb scatter-gather
> > (used by default in mt76u). I am working on a series in order to add the possibility to
> > disable it.
> 
> Even if that true that AMD IOMMU does not support 'well' SG (what I think
> is not true) disabling SG in mt76 driver is not right solution. Right
> solution would be propagate the issue to AMD IOMMU maintainers
> (already CCed).

I meant that AMD iommu seems to have different constraints respect to Intel
one.

Regards,
Lorenzo

> 
> One problem in mt76 is page_frag_alloc() usage with different sizes.
> page_frag_alloc() unlike like other allocators do not assure alignment
> and relay on callers to provide buffers sizes that are aligned.
> Unaligned buffer might then not be appropriate for DMA.
> 
> Another issue is that dma_map_sg() & dma_map_page() may require some 
> constraints. I'm not sure about that and I want to clarify that with 
> CCed mm maintainers. I think DMA drivers may expect sg->offset < PAGE_SIZE
> for both dma_map_sg() and dma_map_page(). Additionally dma_map_page()
> maight expect that offset & length specify buffer within one page.
> 
> Stanislaw
