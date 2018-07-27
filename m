From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 7/7] OF: Don't set default coherent DMA mask
Date: Fri, 27 Jul 2018 21:42:14 +0100
Message-ID: <6d18c0fb-58ed-e4a7-32a4-8bcfa4dc3761@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
	<66c08e4df2032fde82a2f97544f41fd3a2f24a94.1532382222.git.robin.murphy@arm.com>
	<4ed75bc9-1694-2bcb-2ea9-3f2a04f33f54@ti.com>
	<92d6b010-b5c0-fc59-0668-5b455e26c912@ti.com>
	<c7a9c7ae-1f4a-af9d-df78-1f48bb5c28a5@arm.com>
	<20180727181302.GC17271@n2100.armlinux.org.uk>
	<affa2718-5f3a-7439-db25-ce171a99414a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <affa2718-5f3a-7439-db25-ce171a99414a-l0cyMroinI0@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2018-07-27 7:45 PM, Grygorii Strashko wrote:
[...]
> But I have a question to all:
> - The patch [1] sets default DMA mask to DMA_BIT_MASK(32)
> +	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +	if (!dev->dev.dma_mask)
> +		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
> 
> this will also work the same way for ARM64
> 
> - But of_dma_configure() still have code which does:
> 	dev->coherent_dma_mask &= mask;
> 	*dev->dma_mask &= mask;
> 
> As result, DMA mask supplied from DT will always be truncated
>   to 32 bit for platform devices. for example:
> 
> soc0: soc0 {
>          compatible = "simple-bus";
>          #address-cells = <2>;
>          #size-cells = <2>;
>          ranges;
> +        dma-ranges = <0 0 0 0 0x10000 0>;
> 
> ^ 48 bit DMA mask expected to be generated and assigned.
> 
> But real mask will be DMA_BIT_MASK(32). As result, any
> DMA capable driver will have be modified to do dma_set_xxx_mask(),
> which disregards DT DMA configuration (especially for HW modules
> which are used on ARM32 and ARM64).

That has always been the case. Drivers which want to use 
larger-than-32-bit masks *must* explicitly say so. The issue that the DT 
dma-ranges (and ACPI equivalents) cannot be preserved in the device DMA 
masks is the entire purpose of this series. At the moment there's only a 
couple of point fixes for specific places with known problems, but this 
is just the start of some ongoing work.

> Could it be considered to do one the changes below?
> 
> 1) assign mask in case of dt
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

No, because that leads to a risk of DMA address truncation in hardware 
(and thus at worst random memory corruption) when drivers expect the 
default mask to be 32-bit and fail to explicitly set it as such.

> 2) use BITS_PER_LONG for default DMA mask for of_platform devices
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 7ba90c2..3f326e2 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -185,7 +185,7 @@ static struct platform_device *of_platform_device_create_pdata(
>          if (!dev)
>                  goto err_clear_flag;
>   
> -       dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +       dev->dev.coherent_dma_mask = DMA_BIT_MASK(BITS_PER_LONG);
>          if (!dev->dev.dma_mask)
>                  dev->dev.dma_mask = &dev->dev.coherent_dma_mask;

No, because that leads to a risk of DMA address truncation in hardware 
(and thus at worst random memory corruption) when drivers expect the 
default mask to be 32-bit and fail to explicitly set it as such.

> 3) ...

Remember when we found out how many drivers expect the default mask to 
be 32-bit and fail to explicitly set it as such, because they all broke 
when some chump set it to 0 in linux-next for a day? ;)

Robin.
