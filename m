From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC/PATCH 6/9] drivers: platform: Configure dma operations at
 probe time
Date: Tue, 19 May 2015 11:39:17 +0100
Message-ID: <555B12D5.5080608@arm.com>
References: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1431644410-2997-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431644410-2997-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Laura Abbott <lauraa@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Mitchel Humpherys <mitchelh@codeaurora.org>, Joreg Roedel <joro@8bytes.org>, Will Deacon <Will.Deacon@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On 15/05/15 00:00, Laurent Pinchart wrote:
> Configuring DMA ops at probe time will allow deferring device probe when
> the IOMMU isn't available yet.

This is great, as I think it also subtly solves the ordering problem the 
current domain allocation has with platform devices. WRT to your comment 
on the other thread, this actually makes things slightly saner for IOMMU 
groups - the group assignment has to happen after device creation or 
else some sysfs stuff blows up, so of_xlate is far too early and the 
add_device callback is a reasonable place for it to be (until we can 
move it out of every driver and into bus code). However, we're currently 
attaching the device to the automatic domain long before that, so things 
happen logically backwards and drivers like the ARM SMMU which actually 
use the group to store relevant data get all confused.

With this change, the existing attach_device call in arch_setup_dma_ops 
will actually work far more reliably, and I might be able to revive my 
attempt to port the ARM SMMU driver over to of_xlate :D

Robin.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   drivers/base/platform.c | 9 +++++++++
>   drivers/of/platform.c   | 7 +++----
>   2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index ebf034b97278..508a866859dc 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -516,6 +516,10 @@ static int platform_drv_probe(struct device *_dev)
>   	if (ret < 0)
>   		return ret;
>
> +	ret = of_dma_configure_ops(_dev, _dev->of_node);
> +	if (ret < 0)
> +		goto done;
> +
>   	ret = dev_pm_domain_attach(_dev, true);
>   	if (ret != -EPROBE_DEFER) {
>   		ret = drv->probe(dev);
> @@ -523,6 +527,10 @@ static int platform_drv_probe(struct device *_dev)
>   			dev_pm_domain_detach(_dev, true);
>   	}
>
> +	if (ret)
> +		of_dma_deconfigure(_dev);
> +
> +done:
>   	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
>   		dev_warn(_dev, "probe deferral not supported\n");
>   		ret = -ENXIO;
> @@ -544,6 +552,7 @@ static int platform_drv_remove(struct device *_dev)
>
>   	ret = drv->remove(dev);
>   	dev_pm_domain_detach(_dev, true);
> +	of_dma_deconfigure(_dev);
>
>   	return ret;
>   }
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 9a29f09b7723..fc939bec799e 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -178,10 +178,8 @@ static struct platform_device *of_platform_device_create_pdata(
>   	dev->dev.bus = &platform_bus_type;
>   	dev->dev.platform_data = platform_data;
>   	of_dma_configure_masks(&dev->dev, dev->dev.of_node);
> -	of_dma_configure_ops(&dev->dev, dev->dev.of_node);
>
>   	if (of_device_add(dev) != 0) {
> -		of_dma_deconfigure(&dev->dev);
>   		platform_device_put(dev);
>   		goto err_clear_flag;
>   	}
> @@ -465,11 +463,12 @@ static int of_platform_device_destroy(struct device *dev, void *data)
>   	if (dev->bus == &platform_bus_type)
>   		platform_device_unregister(to_platform_device(dev));
>   #ifdef CONFIG_ARM_AMBA
> -	else if (dev->bus == &amba_bustype)
> +	else if (dev->bus == &amba_bustype) {
>   		amba_device_unregister(to_amba_device(dev));
> +		of_dma_deconfigure(dev);
> +	}
>   #endif
>
> -	of_dma_deconfigure(dev);
>   	of_node_clear_flag(dev->of_node, OF_POPULATED);
>   	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
>   	return 0;
>
