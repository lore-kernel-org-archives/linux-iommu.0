From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 06/13] drm/etnaviv: Use sychronized interface of the
	IOMMU-API
Date: Thu, 17 Aug 2017 15:32:38 +0200
Message-ID: <1502976758.19806.25.camel@pengutronix.de>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
	<1502974596-23835-7-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1502974596-23835-7-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Russell King <linux+etnaviv-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Am Donnerstag, den 17.08.2017, 14:56 +0200 schrieb Joerg Roedel:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> The map and unmap functions of the IOMMU-API changed their
> semantics: They do no longer guarantee that the hardware
> TLBs are synchronized with the page-table updates they made.
> 
> To make conversion easier, new synchronized functions have
> been introduced which give these guarantees again until the
> code is converted to use the new TLB-flush interface of the
> IOMMU-API, which allows certain optimizations.
> 
> But for now, just convert this code to use the synchronized
> functions so that it will behave as before.

I don't think this is necessary. Etnaviv has managed and batched up TLB
flushes from day 1, as they don't happen through the MMU MMIO interface,
but through the GPU command stream.

So if my understanding of this series is correct, Etnaviv is just fine
with the changed semantics of the unsynchronized map/unmap calls.

Regards,
Lucas

> 
> Cc: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Russell King <linux+etnaviv-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
> Cc: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>
> Cc: etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> index f103e78..ae0247c 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> @@ -47,7 +47,7 @@ int etnaviv_iommu_map(struct etnaviv_iommu *iommu, u32 iova,
>  
>  		VERB("map[%d]: %08x %08x(%zx)", i, iova, pa, bytes);
>  
> -		ret = iommu_map(domain, da, pa, bytes, prot);
> +		ret = iommu_map_sync(domain, da, pa, bytes, prot);
>  		if (ret)
>  			goto fail;
>  
> @@ -62,7 +62,7 @@ int etnaviv_iommu_map(struct etnaviv_iommu *iommu, u32 iova,
>  	for_each_sg(sgt->sgl, sg, i, j) {
>  		size_t bytes = sg_dma_len(sg) + sg->offset;
>  
> -		iommu_unmap(domain, da, bytes);
> +		iommu_unmap_sync(domain, da, bytes);
>  		da += bytes;
>  	}
>  	return ret;
> @@ -80,7 +80,7 @@ int etnaviv_iommu_unmap(struct etnaviv_iommu *iommu, u32 iova,
>  		size_t bytes = sg_dma_len(sg) + sg->offset;
>  		size_t unmapped;
>  
> -		unmapped = iommu_unmap(domain, da, bytes);
> +		unmapped = iommu_unmap_sync(domain, da, bytes);
>  		if (unmapped < bytes)
>  			return unmapped;
>  
> @@ -338,7 +338,7 @@ int etnaviv_iommu_get_suballoc_va(struct etnaviv_gpu *gpu, dma_addr_t paddr,
>  			mutex_unlock(&mmu->lock);
>  			return ret;
>  		}
> -		ret = iommu_map(mmu->domain, vram_node->start, paddr, size,
> +		ret = iommu_map_sync(mmu->domain, vram_node->start, paddr, size,
>  				IOMMU_READ);
>  		if (ret < 0) {
>  			drm_mm_remove_node(vram_node);
> @@ -362,7 +362,7 @@ void etnaviv_iommu_put_suballoc_va(struct etnaviv_gpu *gpu,
>  
>  	if (mmu->version == ETNAVIV_IOMMU_V2) {
>  		mutex_lock(&mmu->lock);
> -		iommu_unmap(mmu->domain,iova, size);
> +		iommu_unmap_sync(mmu->domain,iova, size);
>  		drm_mm_remove_node(vram_node);
>  		mutex_unlock(&mmu->lock);
>  	}
