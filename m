From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] arm: dma-mapping: fix off-by-one check in
	arm_setup_iommu_dma_ops
Date: Wed, 29 Apr 2015 10:53:41 +0100
Message-ID: <20150429095341.GI8236@arm.com>
References: <1430294039-25218-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430294039-25218-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

A couple of really minor comments.

On Wed, Apr 29, 2015 at 08:53:59AM +0100, Marek Szyprowski wrote:
> diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
> index 8e3fcb924db6..2ef282f96651 100644
> --- a/arch/arm/include/asm/dma-iommu.h
> +++ b/arch/arm/include/asm/dma-iommu.h
> @@ -25,7 +25,7 @@ struct dma_iommu_mapping {
>  };
>  
>  struct dma_iommu_mapping *
> -arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size);
> +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64 size);
>  
>  void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
>  
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 09c5fe3d30c2..143c0735cb58 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1878,7 +1878,7 @@ struct dma_map_ops iommu_coherent_ops = {
>   * arm_iommu_attach_device function.
>   */
>  struct dma_iommu_mapping *
> -arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
> +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64 size)
>  {
>  	unsigned int bits = size >> PAGE_SHIFT;
>  	unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
> @@ -1886,6 +1886,10 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
>  	int extensions = 1;
>  	int err = -ENOMEM;
>  
> +	/* currently ony 32-bit DMA address space is supported */

s/ony/only/

> +	if (size > DMA_BIT_MASK(32) + 1)
> +		return ERR_PTR(-EINVAL);

-ERANGE?

With that,

  Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Can you stick this in the patch system please?

Will
