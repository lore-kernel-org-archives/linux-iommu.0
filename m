From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] iommu/dma: Map scatterlists more parsimoniously
Date: Thu, 26 Nov 2015 16:37:28 +0100
Message-ID: <20151126153728.GC17674@8bytes.org>
References: <cf89e25139683d85862302e75f9923d101ba233e.1448016328.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cf89e25139683d85862302e75f9923d101ba233e.1448016328.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 20, 2015 at 10:57:40AM +0000, Robin Murphy wrote:
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 3a20db4..427fdc1 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -441,6 +441,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  	struct scatterlist *s, *prev = NULL;
>  	dma_addr_t dma_addr;
>  	size_t iova_len = 0;
> +	unsigned long mask = dma_get_seg_boundary(dev);
>  	int i;
>  
>  	/*
> @@ -452,6 +453,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  	for_each_sg(sg, s, nents, i) {
>  		size_t s_offset = iova_offset(iovad, s->offset);
>  		size_t s_length = s->length;
> +		size_t pad_len = (mask - iova_len + 1) & mask;
>  
>  		sg_dma_address(s) = s->offset;
>  		sg_dma_len(s) = s_length;
> @@ -460,15 +462,13 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  		s->length = s_length;
>  
>  		/*
> -		 * The simple way to avoid the rare case of a segment
> -		 * crossing the boundary mask is to pad the previous one
> -		 * to end at a naturally-aligned IOVA for this one's size,
> -		 * at the cost of potentially over-allocating a little.
> +		 * With a single size-aligned IOVA allocation, no segment risks
> +		 * crossing the boundary mask unless the total size exceeds
> +		 * the mask itself. The simple way to maintain alignment when
> +		 * that does happen is to pad the previous segment to end at the
> +		 * next boundary, at the cost of over-allocating a little.
>  		 */
> -		if (prev) {
> -			size_t pad_len = roundup_pow_of_two(s_length);
> -
> -			pad_len = (pad_len - iova_len) & (pad_len - 1);
> +		if (pad_len && pad_len < s_length - 1) {
>  			prev->length += pad_len;
>  			iova_len += pad_len;
>  		}

Hmm, this whole code looks overly complicated. Why don't you just add
the sizes of the individual sg-elements together and then do an
allocation aligned on the next power-of-two. This will not cross the
boundary mask until the size is smaller than the mask.
When the size is bigger than the mask you can either put a WARN on into
and return error (to see if that really happens), or just do multiple
smaller allocations that fit into the boundary mask.



	Joerg
