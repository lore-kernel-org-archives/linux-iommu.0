From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [RFC PATCH v2 4/7] iommu: provide helper function to configure an
	IOMMU for an of master
Date: Wed, 10 Sep 2014 16:01:34 +0300
Message-ID: <1486715.2XVviDPC9Z@avalon>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
	<1409680587-29818-5-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409680587-29818-5-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

Thank you for the patch.

On Tuesday 02 September 2014 18:56:24 Will Deacon wrote:
> The generic IOMMU device-tree bindings can be used to add arbitrary OF
> masters to an IOMMU with a compliant binding.
> 
> This patch introduces of_iommu_configure, which does exactly that.
> 
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/Kconfig       |  2 +-
>  drivers/iommu/of_iommu.c    | 52 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-mapping.h |  7 ++++++
>  include/linux/of_iommu.h    |  8 +++++++
>  4 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dd5112265cc9..6d13f962f156 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -15,7 +15,7 @@ if IOMMU_SUPPORT
> 
>  config OF_IOMMU
>         def_bool y
> -       depends on OF
> +       depends on OF && IOMMU_API
> 
>  config FSL_PAMU
>  	bool "Freescale IOMMU support"
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index f9209666157c..1188c929ffa7 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -18,6 +18,7 @@
>   */
> 
>  #include <linux/export.h>
> +#include <linux/iommu.h>
>  #include <linux/limits.h>
>  #include <linux/of.h>
>  #include <linux/of_iommu.h>
> @@ -90,6 +91,57 @@ int of_get_dma_window(struct device_node *dn, const char
> *prefix, int index, }
>  EXPORT_SYMBOL_GPL(of_get_dma_window);
> 
> +struct iommu_dma_mapping *of_iommu_configure(struct device *dev)
> +{
> +	struct of_phandle_args iommu_spec;
> +	struct iommu_dma_mapping *mapping;
> +	struct bus_type *bus = dev->bus;
> +	const struct iommu_ops *ops = bus->iommu_ops;
> +	struct iommu_data *iommu = NULL;
> +	int idx = 0;
> +
> +	if (!iommu_present(bus) || !ops->of_xlate)
> +		return NULL;
> +
> +	/*
> +	 * We don't currently walk up the tree looking for a parent IOMMU.
> +	 * See the `Notes:' section of
> +	 * Documentation/devicetree/bindings/iommu/iommu.txt
> +	 */
> +	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
> +					   "#iommu-cells", idx,
> +					   &iommu_spec)) {
> +		struct device_node *np = iommu_spec.np;
> +		struct iommu_data *data = of_iommu_get_data(np);
> +
> +		if (!iommu) {
> +			if (!ops->of_xlate(dev, &iommu_spec))
> +				iommu = data;

If I understand the code correctly, this will call of_xlate for the first 
IOMMU reference only and silently ignore all subsequent references if they 
point to the same IOMMU device but with different stream/requester IDs. Is 
that the desired behaviour ?

> +		} else if (iommu != data) {
> +			pr_warn("Rejecting device %s with multiple IOMMU instances\n",
> +				dev_name(dev));
> +			iommu = NULL;
> +		}
> +
> +		of_node_put(np);
> +
> +		if (!iommu)
> +			break;
> +
> +		idx++;
> +	}
> +
> +	if (!iommu)
> +		return NULL;
> +
> +	mapping = devm_kzalloc(dev, sizeof(*mapping), GFP_KERNEL);
> +	if (!mapping)
> +		return NULL;
> +
> +	mapping->iommu = iommu;
> +	return mapping;
> +}
> +
>  void __init of_iommu_init(void)
>  {
>  	struct device_node *np;
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 0f7f7b68b0db..16bf92f71c3e 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -62,6 +62,13 @@ struct dma_map_ops {
>  	int is_phys;
>  };
> 
> +struct iommu_data;
> +
> +struct iommu_dma_mapping {
> +	struct iommu_data *iommu;
> +	struct list_head node;
> +};
> +
>  #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> 
>  #define DMA_MASK_NONE	0x0ULL
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index a39e2d78f735..f2d3b1e780d7 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -1,9 +1,12 @@
>  #ifndef __OF_IOMMU_H
>  #define __OF_IOMMU_H
> 
> +#include <linux/device.h>
>  #include <linux/iommu.h>
>  #include <linux/of.h>
> 
> +struct iommu_dma_mapping;
> +
>  #ifdef CONFIG_OF_IOMMU
> 
>  extern int of_get_dma_window(struct device_node *dn, const char *prefix,
> @@ -11,6 +14,7 @@ extern int of_get_dma_window(struct device_node *dn, const
> char *prefix, size_t *size);
> 
>  extern void of_iommu_init(void);
> +extern struct iommu_dma_mapping *of_iommu_configure(struct device *dev);
> 
>  #else
> 
> @@ -22,6 +26,10 @@ static inline int of_get_dma_window(struct device_node
> *dn, const char *prefix, }
> 
>  static inline void of_iommu_init(void) { }
> +static inline struct iommu_dma_mapping *of_iommu_configure(struct device
> *dev) +{
> +	return NULL;
> +}
> 
>  #endif	/* CONFIG_OF_IOMMU */

-- 
Regards,

Laurent Pinchart
