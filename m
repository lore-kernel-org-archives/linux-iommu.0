From: Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH] dma-direct: Fix return value of dma_direct_supported
Date: Thu, 4 Oct 2018 08:13:26 -0700
Message-ID: <CAKgT0UfbAokpR=-xrfNjeYMroEDH4HtPgM6qK_nWmBqK3QOf6A@mail.gmail.com>
References: <20181003234746.3586.42014.stgit@localhost.localdomain> <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: alexander.h.duyck@linux.intel.com, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Greg KH <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 4, 2018 at 4:25 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 04/10/18 00:48, Alexander Duyck wrote:
> > It appears that in commit 9d7a224b463e ("dma-direct: always allow dma mask
> > <= physiscal memory size") the logic of the test was changed from a "<" to
> > a ">=" however I don't see any reason for that change. I am assuming that
> > there was some additional change planned, specifically I suspect the logic
> > was intended to be reversed and possibly used for a return. Since that is
> > the case I have gone ahead and done that.
>
> Bah, seems I got hung up on the min_mask code above it and totally
> overlooked that the condition itself got flipped. It probably also can't
> help that it's an int return type, but treated as a bool by callers
> rather than "0 for success" as int tends to imply in isolation.
>
> Anyway, paying a bit more attention this time, I think this looks like
> the right fix - cheers Alex.
>
> Robin.

Thanks for the review.

- Alex

P.S. It looks like I forgot to add Christoph to the original mail
since I had just copied the To and Cc from the original submission, so
I added him to the Cc for this.

> > This addresses issues I had on my system that prevented me from booting
> > with the above mentioned commit applied on an x86_64 system w/ Intel IOMMU.
> >
> > Fixes: 9d7a224b463e ("dma-direct: always allow dma mask <= physiscal memory size")
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >   kernel/dma/direct.c |    4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 5a0806b5351b..65872f6c2e93 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -301,9 +301,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
> >
> >       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
> >
> > -     if (mask >= phys_to_dma(dev, min_mask))
> > -             return 0;
> > -     return 1;
> > +     return mask >= phys_to_dma(dev, min_mask);
> >   }
> >
> >   int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
> >
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
