From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 43/44] dma-mapping: Remove dma_get_attr
Date: Fri, 10 Jun 2016 11:58:53 +0100
Message-ID: <575A9D6D.9040808@arm.com>
References: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
	<1465553521-27303-44-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1465553521-27303-44-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "James E.J. Bottomley" <jejb-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andrea Gelmini <andrea.gelmini-PT7Us6ch6G9eoWH0uzbU5w@public.gmane.org>, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>, Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Osciak <pawel-FA/gS7QP4orQT0dZR+AlfA@public.gmane.org>, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Alexey Brodkin <abrodkin-HKixBCOQz3jQFizaE/u3fw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/06/16 11:12, Krzysztof Kozlowski wrote:
> After switching DMA attributes to unsigned long it is easier to just
> compare the bits.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> [for avr32]
> Acked-by: Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>
> ---
[...]
>   arch/arm64/mm/dma-mapping.c                    | 10 +++----
[...]
>   drivers/iommu/dma-iommu.c                      |  2 +-
[...]
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index a7686028dfeb..06c068ca3541 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -32,7 +32,7 @@
>   static pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot,
>   				 bool coherent)
>   {
> -	if (!coherent || dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
> +	if (!coherent || (attrs & DMA_ATTR_WRITE_COMBINE))
>   		return pgprot_writecombine(prot);
>   	return prot;
>   }
> @@ -702,7 +702,7 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
>   	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
>
>   	if (!iommu_dma_mapping_error(dev, dev_addr) &&
> -	    !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>   		__iommu_sync_single_for_device(dev, dev_addr, size, dir);
>
>   	return dev_addr;
> @@ -712,7 +712,7 @@ static void __iommu_unmap_page(struct device *dev, dma_addr_t dev_addr,
>   			       size_t size, enum dma_data_direction dir,
>   			       unsigned long attrs)
>   {
> -	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>   		__iommu_sync_single_for_cpu(dev, dev_addr, size, dir);
>
>   	iommu_dma_unmap_page(dev, dev_addr, size, dir, attrs);
> @@ -752,7 +752,7 @@ static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
>   {
>   	bool coherent = is_device_dma_coherent(dev);
>
> -	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>   		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
>
>   	return iommu_dma_map_sg(dev, sgl, nelems,
> @@ -764,7 +764,7 @@ static void __iommu_unmap_sg_attrs(struct device *dev,
>   				   enum dma_data_direction dir,
>   				   unsigned long attrs)
>   {
> -	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>   		__iommu_sync_sg_for_cpu(dev, sgl, nelems, dir);
>
>   	iommu_dma_unmap_sg(dev, sgl, nelems, dir, attrs);
[...]
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 6c1bda504fb1..08a1e2f3690f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -306,7 +306,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   	} else {
>   		size = ALIGN(size, min_size);
>   	}
> -	if (dma_get_attr(DMA_ATTR_ALLOC_SINGLE_PAGES, attrs))
> +	if (attrs & DMA_ATTR_ALLOC_SINGLE_PAGES)
>   		alloc_sizes = min_size;
>
>   	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
[...]

These all look appropriate to me; thanks!

For arm64 and dma-iommu:

Acked-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
