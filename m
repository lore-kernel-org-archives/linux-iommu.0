From: dann frazier <dann.frazier@canonical.com>
Subject: Re: [RFC] arm64: swiotlb: cma_alloc error spew
Date: Tue, 23 Apr 2019 12:03:18 -0600
Message-ID: <CALdTtnsHxwTjzw1asO886jYWB4LOY=UT_UGeco=f1SZzVNo7fw@mail.gmail.com>
References: <20190417204817.GA28897@xps13.dannf> <fa287dc4-59e9-0500-70ee-e96c2920d5a9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fa287dc4-59e9-0500-70ee-e96c2920d5a9@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Xinwei Kong <kong.kongxinwei@hisilicon.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 23, 2019 at 5:32 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 17/04/2019 21:48, dann frazier wrote:
> > hey,
> >    I'm seeing an issue on a couple of arm64 systems[*] where they spew
> > ~10K "cma: cma_alloc: alloc failed" messages at boot. The errors are
> > non-fatal, and bumping up cma to a large enough size (~128M) gets rid
> > of them - but that seems suboptimal. Bisection shows that this started
> > after commit fafadcd16595 ("swiotlb: don't dip into swiotlb pool for
> > coherent allocations"). It looks like __dma_direct_alloc_pages()
> > is opportunistically using CMA memory but falls back to non-CMA if CMA
> > disabled or unavailable. I've demonstrated that this fallback is
> > indeed returning a valid pointer. So perhaps the issue is really just
> > the warning emission.
>
> The CMA area being full isn't necessarily an ignorable non-problem,
> since it means you won't be able to allocate the kind of large buffers
> for which CMA was intended. The question is, is it actually filling up
> with allocations that deserve to be there, or is this the same as I've
> seen on a log from a ThunderX2 system where it's getting exhausted by
> thousands upon thousands of trivial single page allocations? If it's the
> latter (CONFIG_CMA_DEBUG should help shed some light if necessary),

Appears so. Here's a histogram of count/size w/ a cma= large enough to
avoid failures:

$ dmesg | grep "cma: cma_alloc(cma" | sed -r 's/.*count
([0-9]+)\,.*/\1/' | sort -n | uniq -c
   2062 1
     32 2
    266 8
      2 24
      4 32
    256 33
      7 64
      2 128
      2 1024

  -dann

> then
> that does lean towards spending a bit more effort on this idea:
>
> https://lore.kernel.org/lkml/20190327080821.GB20336@lst.de/
>
> Robin.
>
> > The following naive patch solves the problem for me - just silence the
> > cma errors, since it looks like a soft error. But is there a better
> > approach?
> >
> > [*] APM X-Gene & HiSilicon Hi1620 w/ SMMU disabled
> >
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 6310ad01f915b..0324aa606c173 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -112,7 +112,7 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
> >          /* CMA can be used only in the context which permits sleeping */
> >          if (gfpflags_allow_blocking(gfp)) {
> >                  page = dma_alloc_from_contiguous(dev, count, page_order,
> > -                                                gfp & __GFP_NOWARN);
> > +                                                true);
> >                  if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> >                          dma_release_from_contiguous(dev, page, count);
> >                          page = NULL;
> >
> >
> >
> >
