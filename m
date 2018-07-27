From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 7/7] OF: Don't set default coherent DMA mask
Date: Fri, 27 Jul 2018 12:36:00 +0100
Message-ID: <c7a9c7ae-1f4a-af9d-df78-1f48bb5c28a5@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
	<66c08e4df2032fde82a2f97544f41fd3a2f24a94.1532382222.git.robin.murphy@arm.com>
	<4ed75bc9-1694-2bcb-2ea9-3f2a04f33f54@ti.com>
	<92d6b010-b5c0-fc59-0668-5b455e26c912@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <92d6b010-b5c0-fc59-0668-5b455e26c912-l0cyMroinI0@public.gmane.org>
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
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 27/07/18 01:22, Grygorii Strashko wrote:
[...]
>> the result of this change is pretty strange as for me :(
>> Resulted code:
>>
>> 	/*
>> 	 * If @dev is expected to be DMA-capable then the bus code that created
>> 	 * it should have initialised its dma_mask pointer by this point. For
>> 	 * now, we'll continue the legacy behaviour of coercing it to the
>> 	 * coherent mask if not, but we'll no longer do so quietly.
>> 	 */
>> 	if (!dev->dma_mask) {
>> 		dev_warn(dev, "DMA mask not set\n");
>> 		dev->dma_mask = &dev->coherent_dma_mask;
>> ^this will always produce warning in case of platform-bus or if there are no bus driver.
>> even if DT contains correct definition of dma-range
>> 	}
>>
>> 	if (!size && dev->coherent_dma_mask)
>>
>> ^ coherent_dma_mask is zero, so size will not be calculated
> pls, ignore this particular comment
> 
>> 		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>> 	else if (!size)
>> 		size = 1ULL << 32;
>>
>> 	dev->dma_pfn_offset = offset;
>>
>> 	/*
>> 	 * Limit coherent and dma mask based on size and default mask
>> 	 * set by the driver.
>> 	 */
>> 	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
>> 	dev->bus_dma_mask = mask;
>> 	dev->coherent_dma_mask &= mask;
>>
>> ^^ if nobody set coherent_dma_mask before it will stay null forever unless drivers
>> will overwrite it. Again even if DT has correct definition for dma-range.

That is intentional. Consider a 32-bit device on a bus with an upstream 
DMA range of 40 bits (which could easily happen with e.g. PCI). If the 
firmware code gives that device 40-bit DMA masks and the driver doesn't 
change them, then DMA is not going to work correctly. Therefore the 
firmware code cannot safely make {coherent_}dma_mask larger than the 
default value passed in, and if the default is 0 then that should be 
fixed in whatever code created the device, not worked around later.

Robin.

>>
>> 	*dev->dma_mask &= mask;
>>
>> 	coherent = of_dma_is_coherent(np);
>> 	dev_dbg(dev, "device is%sdma coherent\n",
>> 		coherent ? " " : " not ");
>>
>>
> 
> FYI, with below diff i can boot at least:
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 5957cd4..f7dc121 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -150,8 +150,8 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>           */
>          mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
>          dev->bus_dma_mask = mask;
> -       dev->coherent_dma_mask &= mask;
> -       *dev->dma_mask &= mask;
> +       dev->coherent_dma_mask = mask;
> +       *dev->dma_mask = mask;
>   
>          coherent = of_dma_is_coherent(np);
>          dev_dbg(dev, "device is%sdma coherent\n",
> 
> 
> 
