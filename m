From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: MT76x2U crashes XHCI driver on AMD Ryzen system
Date: Tue, 26 Feb 2019 11:34:51 +0100
Message-ID: <20190226103450.GA2989@redhat.com>
References: <83A1D243-9073-48D1-9F26-5A2581DCB829@gmail.com>
 <CAJ0CqmUgPWNJtCW4Q__sOtB8w-YtwW+uZy7crxMNrmSgQ6OFyA@mail.gmail.com>
 <1547404075.1582.0@smtp.gmail.com>
 <CAJ0CqmU7k5i26g7dGPxNdts7Gm67W6qNsr4vYuW05ugsEF1ohw@mail.gmail.com>
 <CAKxU2N-+CTaRdJMFVRdozJ5TTpN+_4thiDRBJBFq8gGtuRVYvA@mail.gmail.com>
 <20190114091841.GA23045@localhost.localdomain>
 <CAKxU2N8ioMszBCyQcH7CVhgBdW4aj7yZ+kYQe14DCV5OSAnxrg@mail.gmail.com>
 <20190115090400.GA2267@localhost.localdomain>
 <20190218143742.GA11872@redhat.com>
 <20190226100535.GA20740@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190226100535.GA20740@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Rosen Penev <rosenp@gmail.com>, linux-wireless <linux-wireless@vger.kernel.org>, Samuel Sieb <samuel@sieb.net>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 26, 2019 at 11:05:36AM +0100, Joerg Roedel wrote:
> On Mon, Feb 18, 2019 at 03:37:48PM +0100, Stanislaw Gruszka wrote:
> > 0001-mt76x02u-use-usb_bulk_msg-to-upload-firmware.patch
> > 0002-mt76usb-do-not-use-compound-head-page-for-SG-I-O.patch
> > 
> > Or problem can be solved by just one of it (either first or second).
> > 
> > Additionally I'm not 100% sure if
> > 
> > 0002-mt76usb-do-not-use-compound-head-page-for-SG-I-O.patch
> > 
> > is correct. So perhaps some IOMMU maintainer could look at it.
> 
> The patch looks good, but I don't understand why it is needed. The AMD
> IOMMU driver should handle sg->offset > PAGE_SIZE just fine. Can you
> verify that this is the problem? I will look into that again if it turns
> out there is bug in the IOMMU driver.

I'm try to get that information from bug reporter, but I can't get it so
far.

If sg->offset > PAGE_SIZE is fine then most likely we have problem with
alignment. We use page_frag_alloc() in mt76usb for buffer allocation
in scheme like this

page_frag_alloc(max_payload);	// something like 14434
page_frag_alloc(1024);
page_frag_alloc(2048)
page_frag_alloc(2048)
page_frag_alloc(2048)
...

page_frag_alloc works smart and fast way internally by allocating
fragments just but changing internal offset:

        offset = nc->offset - fragsz;
        if (unlikely(offset < 0)) {
                page = virt_to_page(nc->va);
	.
	.
	.

        }

        nc->offset = offset;
	return nc->va + offset;

but unlike other allocators like kmalloc that make effort to provide
ARCH_DMA_MINALIGN buffers, it does not care about alignment. Above
scheme of allocation in mt76usb breaks it. 

Note hat issue is with dma_map_sg(), switching to dma_map_single()
by using urb->transfer_buffer instead of urb->sg make things work
on AMD IOMMU.

Stanislaw
