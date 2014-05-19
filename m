From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] arm: dma-iommu: Clean up redundant variable
Date: Mon, 19 May 2014 20:37:59 +0530
Message-ID: <CAD15agb4zgZUVvqLYC+nNvojB8oVwu72P4_0nQdF5cn9ePro4A@mail.gmail.com>
References: <1400511859-22286-1-git-send-email-ritesh.harjani@gmail.com>
	<1400511859-22286-2-git-send-email-ritesh.harjani@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1400511859-22286-2-git-send-email-ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

++ mailing lists

On Mon, May 19, 2014 at 8:34 PM,  <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> mapping->size can be derived from mapping->bits << PAGE_SHIFT
> which makes mapping->size as redundant.
>
> Clean this up.
>
> Signed-off-by: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/include/asm/dma-iommu.h |  1 -
>  arch/arm/mm/dma-mapping.c        | 11 ++++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
> index eec0a12..8e3fcb9 100644
> --- a/arch/arm/include/asm/dma-iommu.h
> +++ b/arch/arm/include/asm/dma-iommu.h
> @@ -18,7 +18,6 @@ struct dma_iommu_mapping {
>         unsigned int            extensions;
>         size_t                  bitmap_size;    /* size of a single bitmap */
>         size_t                  bits;           /* per bitmap */
> -       unsigned int            size;           /* per bitmap */
>         dma_addr_t              base;
>
>         spinlock_t              lock;
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 6b00be1..ec3373c 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1074,6 +1074,7 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
>         unsigned int order = get_order(size);
>         unsigned int align = 0;
>         unsigned int count, start;
> +       unsigned int mapping_size = mapping->bits << PAGE_SHIFT;
>         unsigned long flags;
>         dma_addr_t iova;
>         int i;
> @@ -1119,7 +1120,7 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
>         }
>         spin_unlock_irqrestore(&mapping->lock, flags);
>
> -       iova = mapping->base + (mapping->size * i);
> +       iova = mapping->base + (mapping_size * i);
>         iova += start << PAGE_SHIFT;
>
>         return iova;
> @@ -1129,6 +1130,7 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
>                                dma_addr_t addr, size_t size)
>  {
>         unsigned int start, count;
> +       unsigned int mapping_size = mapping->bits << PAGE_SHIFT;
>         unsigned long flags;
>         dma_addr_t bitmap_base;
>         u32 bitmap_index;
> @@ -1136,14 +1138,14 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
>         if (!size)
>                 return;
>
> -       bitmap_index = (u32) (addr - mapping->base) / (u32) mapping->size;
> +       bitmap_index = (u32) (addr - mapping->base) / (u32) mapping_size;
>         BUG_ON(addr < mapping->base || bitmap_index > mapping->extensions);
>
> -       bitmap_base = mapping->base + mapping->size * bitmap_index;
> +       bitmap_base = mapping->base + mapping_size * bitmap_index;
>
>         start = (addr - bitmap_base) >> PAGE_SHIFT;
>
> -       if (addr + size > bitmap_base + mapping->size) {
> +       if (addr + size > bitmap_base + mapping_size) {
>                 /*
>                  * The address range to be freed reaches into the iova
>                  * range of the next bitmap. This should not happen as
> @@ -1964,7 +1966,6 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
>         mapping->extensions = extensions;
>         mapping->base = base;
>         mapping->bits = BITS_PER_BYTE * bitmap_size;
> -       mapping->size = mapping->bits << PAGE_SHIFT;
>
>         spin_lock_init(&mapping->lock);
>
> --
> 1.8.1.3
>
