From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH RFC 1/1] iommu/of: Deconfigure iommu on driver detach
Date: Tue, 3 Apr 2018 11:57:10 +0100
Message-ID: <993dcde3-f518-9852-9271-3a2c5a3300a5@arm.com>
References: <20180328102529.13435-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180328102529.13435-1-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 28/03/18 11:25, Vivek Gautam wrote:
> As part of dma_deconfigure, lets deconfigure the iommu too
> on driver detach, so that we clear the iommu domain and
> related group.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
> 
> As a part of dma_deconfigure, shouldn't we deconfigure the iommu
> as well? This should reverse all that we do in of_iommu_configure.
> So that we call the .remove_device ops for iommu and eventually
> clear all the iommu domain, related group infrastructure.
> I am seeing that the loadable modules get the same iommu configurations
> after re-loading them, i.e. iommu domain, and iova_domain configurations,
> as we didn't cleared them.
> So should we be clearing these configurations, and therefore do a
> of_iommu_deconfigure() or sort?

Nope. Unbinding a driver does not cause the device to stop existing, nor 
remove it from its parent bus, which is what .remove_device represents. 
Device grouping is based on the underlying hardware topology, which 
isn't going to change at runtime, so there's little point in the 
software state pretending otherwise. If a module is leaking DMA mappings 
in the default domain when unloaded, that's a bug in that module (and 
certainly not specific to the IOMMU layer).

For reference, the only reason we touch .add_device in 
of_iommu_configure() is because iommu_bus_init() is not quite reliable 
enough for multiple IOMMU instances serving the platform bus (or 
similar). It's an ugly workaround which should go away if and when we 
manage to get rid of the notion of per-bus ops in the API.

Robin.

> 
>   drivers/iommu/of_iommu.c | 11 +++++++++++
>   drivers/of/device.c      |  1 +
>   include/linux/of_iommu.h |  5 +++++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 5c36a8b7656a..1a23e6204ade 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -160,6 +160,17 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
>   	return err;
>   }
>   
> +void of_iommu_deconfigure(struct device *dev)
> +{
> +	const struct iommu_ops *ops = NULL;
> +
> +	if (dev->iommu_fwspec && dev->iommu_fwspec->ops)
> +		ops = dev->iommu_fwspec->ops;
> +
> +	if (ops && ops->remove_device && dev->iommu_group)
> +		ops->remove_device(dev);
> +}
> +
>   const struct iommu_ops *of_iommu_configure(struct device *dev,
>   					   struct device_node *master_np)
>   {
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 064c818105bd..e13cb7914dbe 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -177,6 +177,7 @@ EXPORT_SYMBOL_GPL(of_dma_configure);
>   void of_dma_deconfigure(struct device *dev)
>   {
>   	arch_teardown_dma_ops(dev);
> +	of_iommu_deconfigure(dev);
>   }
>   
>   int of_device_register(struct platform_device *pdev)
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index 4fa654e4b5a9..3d4c22e95c0c 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -15,6 +15,8 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
>   extern const struct iommu_ops *of_iommu_configure(struct device *dev,
>   					struct device_node *master_np);
>   
> +extern void of_iommu_deconfigure(struct device *dev);
> +
>   #else
>   
>   static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
> @@ -30,6 +32,9 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
>   	return NULL;
>   }
>   
> +static inline void of_iommu_deconfigure(struct device *dev)
> +{ }
> +
>   #endif	/* CONFIG_OF_IOMMU */
>   
>   extern struct of_device_id __iommu_of_table;
> 
