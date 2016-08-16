From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 5/8] drivers: platform: Configure dma operations at probe
	time
Date: Tue, 16 Aug 2016 12:25:02 +0300
Message-ID: <14864888.EhQqoi8buh@avalon>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
	<1470696550-3416-6-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1470696550-3416-6-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Sricharan,

Thank you for the patch.

On Tuesday 09 Aug 2016 04:19:07 Sricharan R wrote:
> Configuring DMA ops at probe time will allow deferring device probe when
> the IOMMU isn't available yet.
> 
> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/base/dd.c           | 11 +++++++++++
>  drivers/base/dma-mapping.c  | 11 +++++++++++
>  include/linux/dma-mapping.h |  3 +++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 16688f5..b9978af 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -19,6 +19,7 @@
> 
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/module.h>
>  #include <linux/kthread.h>
>  #include <linux/wait.h>
> @@ -353,6 +354,10 @@ static int really_probe(struct device *dev, struct
> device_driver *drv) if (ret)
>  		goto pinctrl_bind_failed;
> 
> +	ret = dma_configure_ops(dev);

Your patch doesn't remove the of_dma_configure_ops() from 
of_platform_device_create_pdata(). Unless I'm mistaken, you will then end up 
configuring the DMA ops twice, which at least on ARM will be a no-op the 
second time:

(arch_setup_dma_ops)

        /*
         * Don't override the dma_ops if they have already been set. Ideally
         * this should be the only location where dma_ops are set, remove this
         * check when all other callers of set_dma_ops will have disappeared.
         */
        if (dev->archdata.dma_ops)
                return;

For the same reason I'm wondering whether you shouldn't also remove the 
of_dma_configure_ops() call from of_amba_device_create() (I don't remember why 
I left it there in my original patch series).

> +	if (ret)
> +		goto dma_failed;
> +
>  	if (driver_sysfs_add(dev)) {
>  		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
>  			__func__, dev_name(dev));
> @@ -394,7 +399,10 @@ static int really_probe(struct device *dev, struct
> device_driver *drv) drv->bus->name, __func__, dev_name(dev), drv->name);
>  	goto done;
> 
> +
>  probe_failed:
> +	dma_deconfigure(dev);
> +dma_failed:
>  	if (dev->bus)
>  		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>  					     BUS_NOTIFY_DRIVER_NOT_BOUND, 
dev);
> @@ -780,6 +788,9 @@ static void __device_release_driver(struct device *dev)
>  			dev->bus->remove(dev);
>  		else if (drv->remove)
>  			drv->remove(dev);
> +
> +		dma_deconfigure(dev);
> +
>  		devres_release_all(dev);
>  		dev->driver = NULL;
>  		dev_set_drvdata(dev, NULL);
> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
> index d799662..ccc1c6e 100644
> --- a/drivers/base/dma-mapping.c
> +++ b/drivers/base/dma-mapping.c
> @@ -10,6 +10,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/export.h>
>  #include <linux/gfp.h>
> +#include <linux/of_device.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> 
> @@ -166,6 +167,16 @@ void dmam_free_noncoherent(struct device *dev, size_t
> size, void *vaddr, }
>  EXPORT_SYMBOL(dmam_free_noncoherent);
> 
> +int dma_configure_ops(struct device *dev)
> +{
> +	return of_dma_configure_ops(dev, dev->of_node);
> +}
> +
> +void dma_deconfigure(struct device *dev)
> +{
> +	of_dma_deconfigure(dev);
> +}
> +
>  #ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
> 
>  static void dmam_coherent_decl_release(struct device *dev, void *res)
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 71c1b21..a49aac9 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -613,6 +613,9 @@ dma_mark_declared_memory_occupied(struct device *dev,
>  }
>  #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
> 
> +int dma_configure_ops(struct device *dev);
> +void dma_deconfigure(struct device *dev);
> +
>  /*
>   * Managed DMA API
>   */

-- 
Regards,

Laurent Pinchart
