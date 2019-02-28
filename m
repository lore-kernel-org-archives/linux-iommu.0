From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: MT76x2U crashes XHCI driver on AMD Ryzen system
Date: Thu, 28 Feb 2019 10:04:12 +0100
Message-ID: <20190228090411.GA24938@redhat.com>
References: <CAJ0CqmU7k5i26g7dGPxNdts7Gm67W6qNsr4vYuW05ugsEF1ohw@mail.gmail.com>
 <CAKxU2N-+CTaRdJMFVRdozJ5TTpN+_4thiDRBJBFq8gGtuRVYvA@mail.gmail.com>
 <20190114091841.GA23045@localhost.localdomain>
 <CAKxU2N8ioMszBCyQcH7CVhgBdW4aj7yZ+kYQe14DCV5OSAnxrg@mail.gmail.com>
 <20190115090400.GA2267@localhost.localdomain>
 <20190218143742.GA11872@redhat.com>
 <20190226100535.GA20740@8bytes.org>
 <20190226103450.GA2989@redhat.com>
 <20190226104413.GH20740@8bytes.org>
 <20190226112407.GB2989@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190226112407.GB2989@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Rosen Penev <rosenp@gmail.com>, linux-wireless <linux-wireless@vger.kernel.org>, Samuel Sieb <samuel@sieb.net>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 26, 2019 at 12:24:08PM +0100, Stanislaw Gruszka wrote:
> On Tue, Feb 26, 2019 at 11:44:13AM +0100, Joerg Roedel wrote:
> > On Tue, Feb 26, 2019 at 11:34:51AM +0100, Stanislaw Gruszka wrote:
> > > On Tue, Feb 26, 2019 at 11:05:36AM +0100, Joerg Roedel wrote:
> > > If sg->offset > PAGE_SIZE is fine then most likely we have problem with
> > > alignment.
> > 
> > The map_sg implementation in the AMD IOMMU driver uses sg_phys() which
> > handles the sg->page + sg->offset calculation fine.
> > 
> > > Note hat issue is with dma_map_sg(), switching to dma_map_single()
> > > by using urb->transfer_buffer instead of urb->sg make things work
> > > on AMD IOMMU.
> > 
> > On the other hand this points to a bug in the driver, I'll look further
> > if I can spot something there.
> 
> I think so too. And I have done some changes that avoid strange allocation
> scheme and use usb synchronous messages instead of allocating buffers
> with unaligned sizes. However things work ok on Intel IOMMU and 
> there is no documentation what are dma_map_sg() requirement versus
> dma_map_single() which works. I think there are some unwritten
> requirements and things can work on some platforms and fails on others
> (different IOMMUs, no-IOMMU on some ARCHes)  

For the record: we have another bug report with this issue:
https://bugzilla.kernel.org/show_bug.cgi?id=202673

I provided there patch that change alignment for page_frag_alloc() and
it did not fixed the problem. So this is not alignment issue.
Now I think it could be page->refcount issue ...

Stanislaw
