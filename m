From: Grygorii Strashko via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v2 7/7] OF: Don't set default coherent DMA mask
Date: Thu, 26 Jul 2018 18:52:23 -0500
Message-ID: <4ed75bc9-1694-2bcb-2ea9-3f2a04f33f54@ti.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
	<66c08e4df2032fde82a2f97544f41fd3a2f24a94.1532382222.git.robin.murphy@arm.com>
Reply-To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <66c08e4df2032fde82a2f97544f41fd3a2f24a94.1532382222.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 07/23/2018 05:16 PM, Robin Murphy wrote:
> Now that we can track upstream DMA constraints properly with
> bus_dma_mask instead of trying (and failing) to maintain it in
> coherent_dma_mask, it doesn't make much sense for the firmware code to
> be touching the latter at all. It's merely papering over bugs wherein a
> driver has failed to call dma_set_coherent_mask() *and* the bus code has
> not initialised any default value.
> 
> We don't really want to encourage more drivers coercing dma_mask so
> we'll continue to fix that up if necessary, but add a warning to help
> flush out any such buggy bus code that remains.
> 
> CC: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>   drivers/of/device.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 0d39633e8545..5957cd4fa262 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -127,20 +127,20 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>   	}
>   
>   	/*
> -	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
> -	 * setup the correct supported mask.
> +	 * If @dev is expected to be DMA-capable then the bus code that created
> +	 * it should have initialised its dma_mask pointer by this point. For
> +	 * now, we'll continue the legacy behaviour of coercing it to the
> +	 * coherent mask if not, but we'll no longer do so quietly.
>   	 */
> -	if (!dev->coherent_dma_mask)
> -		dev->coherent_dma_mask = DMA_BIT_MASK(32);
> -	/*
> -	 * Set it to coherent_dma_mask by default if the architecture
> -	 * code has not set it.
> -	 */
> -	if (!dev->dma_mask)
> +	if (!dev->dma_mask) {
> +		dev_warn(dev, "DMA mask not set\n");
>   		dev->dma_mask = &dev->coherent_dma_mask;
> +	}
>   
> -	if (!size)
> +	if (!size && dev->coherent_dma_mask)
>   		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
> +	else if (!size)
> +		size = 1ULL << 32;
>   
>   	dev->dma_pfn_offset = offset;
>   
> 

the result of this change is pretty strange as for me :(
Resulted code:

	/*
	 * If @dev is expected to be DMA-capable then the bus code that created
	 * it should have initialised its dma_mask pointer by this point. For
	 * now, we'll continue the legacy behaviour of coercing it to the
	 * coherent mask if not, but we'll no longer do so quietly.
	 */
	if (!dev->dma_mask) {
		dev_warn(dev, "DMA mask not set\n");
		dev->dma_mask = &dev->coherent_dma_mask;
^this will always produce warning in case of platform-bus or if there are no bus driver.
even if DT contains correct definition of dma-range
	}

	if (!size && dev->coherent_dma_mask)

^ coherent_dma_mask is zero, so size will not be calculated
		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
	else if (!size)
		size = 1ULL << 32;

	dev->dma_pfn_offset = offset;

	/*
	 * Limit coherent and dma mask based on size and default mask
	 * set by the driver.
	 */
	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
	dev->bus_dma_mask = mask;
	dev->coherent_dma_mask &= mask;

^^ if nobody set coherent_dma_mask before it will stay null forever unless drivers
will overwrite it. Again even if DT has correct definition for dma-range.

	*dev->dma_mask &= mask;

	coherent = of_dma_is_coherent(np);
	dev_dbg(dev, "device is%sdma coherent\n",
		coherent ? " " : " not ");


-- 
regards,
-grygorii
