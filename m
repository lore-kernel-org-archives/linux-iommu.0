From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] arm64/dma-mapping: Add DMA_ATTR_ALLOC_SINGLE_PAGES support
Date: Thu, 24 Mar 2016 11:50:09 +0000
Message-ID: <20160324115008.GE9323@arm.com>
References: <1456944866-15990-1-git-send-email-yong.wu@mediatek.com>
	<20160321180147.GR23397@arm.com>
	<CAD=FV=WL-OgE6D+8m3A8ZSJ8HgVZJw_+7uBce=qPh80LaxQKbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=WL-OgE6D+8m3A8ZSJ8HgVZJw_+7uBce=qPh80LaxQKbg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Doug,

On Tue, Mar 22, 2016 at 10:37:14AM -0700, Doug Anderson wrote:
> On Mon, Mar 21, 2016 at 11:01 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Thu, Mar 03, 2016 at 02:54:26AM +0800, Yong Wu wrote:
> >> Sometimes it is not worth for the iommu allocating big chunks.
> >> Here we enable DMA_ATTR_ALLOC_SINGLE_PAGES which could help avoid to
> >> allocate big chunks while iommu allocating buffer.
> >>
> >> More information about this attribute, please check Doug's commit[1].
> >>
> >> [1]: https://lkml.org/lkml/2016/1/11/720
> >>
> >> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> >> Suggested-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> >> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >> ---
> >>
> >> Our video drivers may soon use this.
> >>
> >>  arch/arm64/mm/dma-mapping.c |  4 ++--
> >>  drivers/iommu/dma-iommu.c   | 14 ++++++++++----
> >>  include/linux/dma-iommu.h   |  4 ++--
> >>  3 files changed, 14 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> >> index 331c4ca..3225e3ca 100644
> >> --- a/arch/arm64/mm/dma-mapping.c
> >> +++ b/arch/arm64/mm/dma-mapping.c
> >> @@ -562,8 +562,8 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
> >>               struct page **pages;
> >>               pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
> >>
> >> -             pages = iommu_dma_alloc(dev, iosize, gfp, ioprot, handle,
> >> -                                     flush_page);
> >> +             pages = iommu_dma_alloc(dev, iosize, gfp, ioprot, attrs,
> >> +                                     handle, flush_page);
> >>               if (!pages)
> >>                       return NULL;
> >>
> >> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> >> index 72d6182..3569cb6 100644
> >> --- a/drivers/iommu/dma-iommu.c
> >> +++ b/drivers/iommu/dma-iommu.c
> >> @@ -190,7 +190,8 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
> >>       kvfree(pages);
> >>  }
> >>
> >> -static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
> >> +static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp,
> >> +                                          struct dma_attrs *attrs)
> >>  {
> >>       struct page **pages;
> >>       unsigned int i = 0, array_size = count * sizeof(*pages);
> >> @@ -203,6 +204,10 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
> >>       if (!pages)
> >>               return NULL;
> >>
> >> +     /* Go straight to 4K chunks if caller says it's OK. */
> >> +     if (dma_get_attr(DMA_ATTR_ALLOC_SINGLE_PAGES, attrs))
> >> +             order = 0;
> >
> > I have a slight snag with this, in that you don't consult the IOMMU
> > pgsize_bitmap at any point, and assume that it can map pages at the
> > same granularity as the CPU. The documentation for
> > DMA_ATTR_ALLOC_SINGLE_PAGES seems to be weaker than that.
> 
> Interesting.  Is that something that exists in the real world?  ...or
> something you think is coming soon?

All it would take is for an IOMMU driver to choose a granule size that
differs from the CPU. For example, if the SMMU driver chose 64k pages
and the CPU was using 4k pages, then you'd have this problem.

> I'd argue that such a case existed in the real world then probably
> we're already broken.  Unless I'm misreading, existing code will
> already fall all the way back to order 0 allocations.  ...so while
> existing code might could work if it was called on a totally
> unfragmented system, it would already break once some fragmentation
> was introduced.

I disagree. For example, in the case I described previously, they may
well settle on a common supported granule (e.g. 2M), assuming that
contiguous pages were implemented in the page table code.

> I'm not saying that we shouldn't fix the code to handle this, I'm just
> saying that Yong Wu's patch doesn't appear to break any code that
> wasn't already broken.  That might be reason to land his code first,
> then debate the finer points of whether IOMMUs with less granularity
> are likely to exist and whether we need to add complexity to the code
> to handle them (or just detect this case and return an error).
> 
> From looking at a WIP patch provided to me by Yong Wu, it looks as if
> he thinks several more functions need to change to handle this need
> for IOMMUs that can't handle small pages.  That seems to be further
> evidence that the work should be done in a separate patch.

Sure, my observations weren't intended to hold up this patch, but we
should double-check that we're no regressing any of the existing IOMMU
drivers/platforms by going straight to order 0 allocations.

Will
