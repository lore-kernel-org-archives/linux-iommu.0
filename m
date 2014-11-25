From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH v4 6/8] dma-mapping: set dma segment properties in
 of_dma_configure
Date: Tue, 25 Nov 2014 13:05:36 +0000
Message-ID: <54747EA0.1020001@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
 <1415991397-9618-7-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1415991397-9618-7-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Cc: "jroedel@suse.de" <jroedel@suse.de>, "arnd@arndb.de" <arnd@arndb.de>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "hdoyu@nvidia.com" <hdoyu@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 14/11/14 18:56, Will Deacon wrote:
> of_dma_configure determines the size of the DMA range for a device by
> either parsing the dma-ranges property or inspecting the coherent DMA
> mask. This same information can be used to initialise the max segment
> size and boundary_mask to a default value.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Sadly, NAK on this one. After a thorough investigation and testing, 
generic code really shouldn't be touching dma_parms like this, and I 
have some corrupted files on my USB filesystem to prove it ;) It seems 
it's a bad idea to effectively change the default segment size 
universally unless you really want to go through the entire block layer 
(and who-knows-what-else) to find and fix everything that relies on it 
being 64k.

Simply dropping this patch and letting the existing defaults in 
dma_set_max_seg_size and dma_get_seg_boundary stand seems like the 
correct action.


Marek, I believe you may have some use case for this - if so, as I 
understand it your individual drivers should be setting up their own 
dma_parms directly, to tell the IOMMU they can handle it merging 
scatterlists into arbitrarily long segments, without affecting the other 
drivers that assume they'll never see >64k segments and go wrong if they 
do (including the generic USB stack, apparently).


Robin.

> ---
>   drivers/of/platform.c           | 4 ++++
>   include/linux/amba/bus.h        | 1 +
>   include/linux/platform_device.h | 2 ++
>   3 files changed, 7 insertions(+)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index b89caf8c7586..0a2842d91db4 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -191,6 +191,8 @@ static void of_dma_configure(struct device *dev)
>   		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
>   	}
>   	dev->dma_pfn_offset = offset;
> +	dma_set_max_seg_size(dev, size);
> +	dma_set_seg_boundary(dev, size);
>
>   	coherent = of_dma_is_coherent(dev->of_node);
>   	dev_dbg(dev, "device is%sdma coherent\n",
> @@ -236,6 +238,7 @@ static struct platform_device *of_platform_device_create_pdata(
>
>   	dev->dev.bus = &platform_bus_type;
>   	dev->dev.platform_data = platform_data;
> +	dev->dev.dma_parms = &dev->dma_parms;
>   	of_dma_configure(&dev->dev);
>
>   	if (of_device_add(dev) != 0) {
> @@ -295,6 +298,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>   	dev->dev.of_node = of_node_get(node);
>   	dev->dev.parent = parent;
>   	dev->dev.platform_data = platform_data;
> +	dev->dev.dma_parms = &dev->dma_parms;
>   	if (bus_id)
>   		dev_set_name(&dev->dev, "%s", bus_id);
>   	else
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index c324f5700d1a..9b232eeb6c20 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -32,6 +32,7 @@ struct amba_device {
>   	struct clk		*pclk;
>   	unsigned int		periphid;
>   	unsigned int		irq[AMBA_NR_IRQS];
> +	struct device_dma_parameters dma_parms;
>   };
>
>   struct amba_driver {
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 153d303af7eb..8dc48487b34b 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -27,6 +27,8 @@ struct platform_device {
>   	u32		num_resources;
>   	struct resource	*resource;
>
> +	struct device_dma_parameters dma_parms;
> +
>   	const struct platform_device_id	*id_entry;
>   	char *driver_override; /* Driver name to force a match */
>
>
