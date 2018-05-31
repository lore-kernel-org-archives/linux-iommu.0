From: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>
Subject: Re: [PATCH 06/25] MIPS: loongson: remove loongson_dma_supported
Date: Thu, 31 May 2018 16:12:59 -0700
Message-ID: <20180531231259.s2zfywv3ei23rkoe@pburton-laptop>
References: <20180525092111.18516-1-hch@lst.de>
	<20180525092111.18516-7-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180525092111.18516-7-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiaxun Yang <jiaxun.yang-nEvAom26CKtBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tom Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Huacai Chen <chenhc-h23VmSynlr/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On Fri, May 25, 2018 at 11:20:52AM +0200, Christoph Hellwig wrote:
> swiotlb_dma_supported will always return true for the a mask
> large enough to be covered by wired up physical address, so this
> function is pointless.

Shouldn't this be "large enough to cover all wired up physical
addresses"? Or maybe even more correctly "large enough to cover all DMA
addresses that might be used"?

Also, there's a spurious "the" on the first line.

> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
>  arch/mips/loongson64/common/dma-swiotlb.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
> index 6a739f8ae110..a5e50f2ec301 100644
> --- a/arch/mips/loongson64/common/dma-swiotlb.c
> +++ b/arch/mips/loongson64/common/dma-swiotlb.c
> @@ -56,13 +56,6 @@ static void loongson_dma_sync_sg_for_device(struct device *dev,
>  	mb();
>  }
>  
> -static int loongson_dma_supported(struct device *dev, u64 mask)
> -{
> -	if (mask > DMA_BIT_MASK(loongson_sysconf.dma_mask_bits))
> -		return 0;

The comparison here will only evaluate true (indicating that DMA is not
supported) if the mask is larger than that supported by the system,
right? Therefore is this not essentially a check that the mask is
appropriately small, whilst swiotlb_dma_supported() checks that the mask
is appropriately large?

I'm struggling to understand how it follows that this function is
pointless given the behaviour of swiotlb_dma_supported(), which is what
the commit message suggests.

Thanks,
    Paul

> -	return swiotlb_dma_supported(dev, mask);
> -}
> -
>  dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
>  	long nid;
> @@ -99,7 +92,7 @@ static const struct dma_map_ops loongson_dma_map_ops = {
>  	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
>  	.sync_sg_for_device = loongson_dma_sync_sg_for_device,
>  	.mapping_error = swiotlb_dma_mapping_error,
> -	.dma_supported = loongson_dma_supported,
> +	.dma_supported = swiotlb_dma_supported,
>  };
>  
>  void __init plat_swiotlb_setup(void)
> -- 
> 2.17.0
> 
> 
