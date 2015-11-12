From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] iommu/dma: Map scatterlists more parsimoniously
Date: Thu, 12 Nov 2015 13:47:09 +0800
Message-ID: <1447307229.27650.5.camel@mhfsdcap03>
References: <104b4682056bc5b4aa0afadd39196c03fc06555d.1447249098.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <104b4682056bc5b4aa0afadd39196c03fc06555d.1447249098.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tiffany.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2015-11-11 at 14:54 +0000, Robin Murphy wrote:
> Whilst blindly assuming the worst case for segment boundaries and
> aligning every segment individually is safe from the point of view
> of respecting the device's parameters, it is also undeniably a waste
> of IOVA space. Futhermore, the knock-on effects of more pages than
> necessary being exposed to device access, additional overhead in page
> table updates and TLB invalidations, etc., are even more undesirable.
> 
> Improve matters by taking the actual boundary mask into account to
> actively detect the cases in which we really do need to adjust a
> segment, and avoid wasting space in the remainder.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> Hi all,
> 
> I've given this some brief testing on Juno with USB and (via magic
> PCI hacks) SATA to confirm that all the +1s and -1s at least seem to
> be in the right places, so I'm throwing it out now for a head-start on
> checking whether it also helps the media folks with the v4l portability
> issues they're up against (I'm confident it should). If all goes well I
> figure I'll repost next week based on rc1 instead of some random local
> development commit.
> 
> Robin.

It works well on MT8173. containing
VDA/VEA(VideoDecodeAccelerator/VideoEncodeAccelerator) unit test.

Tested-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

> 
>  drivers/iommu/dma-iommu.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 3a20db4..821ebc4 100644
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
> @@ -460,17 +461,19 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
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
>  		if (prev) {
> -			size_t pad_len = roundup_pow_of_two(s_length);
> +			size_t pad_len = (mask - iova_len + 1) & mask;
>  
> -			pad_len = (pad_len - iova_len) & (pad_len - 1);
> -			prev->length += pad_len;
> -			iova_len += pad_len;
> +			if (pad_len && pad_len < s_length - 1) {
> +				prev->length += pad_len;
> +				iova_len += pad_len;
> +			}
>  		}
>  
>  		iova_len += s_length;
