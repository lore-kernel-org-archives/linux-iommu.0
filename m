From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] arm64/dma-mapping: fix DMA_ATTR_FORCE_CONTIGUOUS
	mmaping code
Date: Mon, 24 Apr 2017 18:38:53 +0100
Message-ID: <20170424173853.GJ25449@e104818-lin.cambridge.arm.com>
References: <CGME20170331110300eucas1p1535f003de554a9f6e1db56eb47630885@eucas1p1.samsung.com>
	<1490958171-2303-1-git-send-email-a.hajda@samsung.com>
	<20170421173233.GE5312@e104818-lin.cambridge.arm.com>
	<CAMuHMdXRkZGTd71emwVBpm4bWcuE--YR2avaMDZX=KG50zZ2Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXRkZGTd71emwVBpm4bWcuE--YR2avaMDZX=KG50zZ2Yg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Fri, Apr 21, 2017 at 07:39:43PM +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 21, 2017 at 7:32 PM, Catalin Marinas
> <catalin.marinas-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Fri, Mar 31, 2017 at 01:02:51PM +0200, Andrzej Hajda wrote:
> >> In case of DMA_ATTR_FORCE_CONTIGUOUS allocations vm_area->pages
> >> is invalid. __iommu_mmap_attrs and __iommu_get_sgtable should not
> >> use it and take advantage of contiguous nature of the allocation.
> >
> > As I replied to your original patch, I think
> > dma_common_contiguous_remap() should be fixed not to leave a dangling
> > area->pages pointer.
> >
> >>  arch/arm64/mm/dma-mapping.c | 17 ++++++++++++++++-
> >>  1 file changed, 16 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> >> index f7b5401..41c7c36 100644
> >> --- a/arch/arm64/mm/dma-mapping.c
> >> +++ b/arch/arm64/mm/dma-mapping.c
> >> @@ -703,6 +703,10 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
> >>       if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
> >>               return ret;
> >>
> >> +     if (attrs & DMA_ATTR_FORCE_CONTIGUOUS)
> >> +             return vm_iomap_memory(vma,
> >> +                             page_to_phys(vmalloc_to_page(cpu_addr)), size);
> >
> > I replied to Geert's patch on whether we actually need to call
> > dma_common_contiguous_remap() in __iommu_alloc_attrs() if the device is
> > coherent. We don't do this for the swiotlb allocation. If we are going
> > to change this, cpu_addr may or may not be in the vmalloc range and
> > vmalloc_to_page() would fail (I guess we could add an is_vmalloc_addr()
> > check).
> >
> > Alternatively, just open-code dma_common_contiguous_remap() in
> > __iommu_alloc_attrs() to keep a valid area->pages around (I think Geert
> > already suggested this). AFAICT, arch/arm does this already in its own
> > __iommu_alloc_buffer().
> >
> > Yet another option would be for iommu_dma_alloc() to understand
> > DMA_ATTR_FORCE_CONTIGUOUS and remove the arm64-specific handling.
> 
> That was actually the approach I took in my v1.
> V2 changed that to provide standalone iommu_dma_{alloc,free}_contiguous()
> functions.
> V3 changed that to call everything directly from the arm64 code.
> ...

I now read through the past discussions (as I ignored the threads
previously). I got Robin's point of not extending iommu_dma_alloc()
(though it looked simpler) and open-coding dma_common_contiguous_remap()
wouldn't make sense either as a way to pass this buffer to
iommu_dma_mmap() since it wasn't returned by iommu_dma_alloc().

So I think we should just fall back to the swiotlb ops for the mmap and
get_sgtable but since we don't have a dma_addr_t handle (we only have
the one of the other side of the IOMMU), we'd need to factor out the
common code from __swiotlb_mmap into a __swiotlb_mmap_page (similarly
for __swiotlb_get_sgtable). The __iommu_* functions would call these
with the correct page (from vmalloc_to_page) if
DMA_ATTR_FORCE_CONTIGUOUS and the buffer is not a candidate for
*_from_coherent.

While fixing/removing dma_get_sgtable() is a nice goal, we first need to
address DMA_ATTR_FORCE_CONTIGUOUS on arm64 since the patch breaks
existing use-cases (and I'd like to avoid reverting this patch).

-- 
Catalin
