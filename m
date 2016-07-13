From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/dma-iommu: respect established iova region limits
Date: Wed, 13 Jul 2016 19:09:02 +0100
Message-ID: <578683BE.3010903@arm.com>
References: <1468428072-16944-1-git-send-email-nwatters@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1468428072-16944-1-git-send-email-nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Nate,

On 13/07/16 17:41, Nate Watterson wrote:
> In the current dma-iommu implementation, the upper limit used when
> allocating iovas is based on the calling device's dma_mask without
> considering the potentially more restrictive iova limits established
> in iommu_dma_init_domain. To ensure that iovas are allocated within
> the expected iova region, this patch adds logic in __alloc_iova to
> clip input dma_limit values that are out of bounds.

This was actually fairly deliberate - due to the current state of
of_dma_configure(), iommu_dma_init() is mostly only ever called with the
default 32-bit mask of any newly-created device. We only have true
visibility of what the device might want to address after its probe
routine has run, where the driver may have set a larger mask, but
conversely that same probe routine may call dma_alloc_coherent()
straight away, so the IOVA domain has to be initialised with *something*
beforehand. Fortunately dma_32bit_pfn is more of an "expected upper
bound" than an actual limit, so there's no real problem with allocating
above it (in the same way intel-iommu does under similar circumstances).

As such, I'm not sure that a change effectively just hard-limiting IOVAs
to 4GB is all that worthwhile - what we're really missing here are much
more significant things like being able to tie the IOVA size to what's
actually wired up at the IOMMU input, and having proper dma_set_mask()
implementations in the first place (for arm/arm64 in general, not just
dma-iommu).

Robin.

> Signed-off-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/iommu/dma-iommu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index ea5a9eb..2066066 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -157,11 +157,14 @@ static struct iova *__alloc_iova(struct iova_domain *iovad, size_t size,
>  	unsigned long shift = iova_shift(iovad);
>  	unsigned long length = iova_align(iovad, size) >> shift;
>  
> +	/* Respect the upper limit established in iommu_dma_init_domain */
> +	dma_limit = min_t(dma_addr_t, dma_limit >> shift, iovad->dma_32bit_pfn);
> +
>  	/*
>  	 * Enforce size-alignment to be safe - there could perhaps be an
>  	 * attribute to control this per-device, or at least per-domain...
>  	 */
> -	return alloc_iova(iovad, length, dma_limit >> shift, true);
> +	return alloc_iova(iovad, length, dma_limit, true);
>  }
>  
>  /* The IOVA allocator knows what we mapped, so just unmap whatever that was */
> 
