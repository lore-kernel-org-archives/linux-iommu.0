From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v8 6/8] irqchip/gicv2m: implement msi_doorbell_info
	callback
Date: Wed, 4 May 2016 14:02:23 +0100
Message-ID: <5729F2DF.80908@arm.com>
References: <1461831730-5575-1-git-send-email-eric.auger@linaro.org>
	<1461831730-5575-7-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1461831730-5575-7-git-send-email-eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, eric.auger-qxv4g6HH51o@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 28/04/16 09:22, Eric Auger wrote:
> This patch implements the msi_doorbell_info callback in the
> gicv2m driver.
> 
> The driver now is able to return its doorbell characteristics
> (base, size, prot). A single doorbell is exposed.
> 
> This will allow the msi layer to iommu_map this doorbell when
> requested.
> 
> Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> ---
> 
> v7 -> v8:
> - gicv2m_msi_doorbell_info does not return a pointer to const
> - remove spurious !v2m check
> - add IOMMU_MMIO flag
> 
> v7: creation
> ---
>  drivers/irqchip/irq-gic-v2m.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
> index 28f047c..a1ea40c 100644
> --- a/drivers/irqchip/irq-gic-v2m.c
> +++ b/drivers/irqchip/irq-gic-v2m.c
> @@ -24,6 +24,8 @@
>  #include <linux/of_pci.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/percpu.h>
> +#include <linux/iommu.h>
>  
>  /*
>  * MSI_TYPER:
> @@ -64,6 +66,7 @@ struct v2m_data {
>  	u32 nr_spis;		/* The number of SPIs for MSIs */
>  	unsigned long *bm;	/* MSI vector bitmap */
>  	u32 flags;		/* v2m flags for specific implementation */
> +	struct irq_chip_msi_doorbell_info doorbell_info;
>  };
>  
>  static void gicv2m_mask_msi_irq(struct irq_data *d)
> @@ -105,6 +108,14 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		msg->data -= v2m->spi_start;
>  }
>  
> +static inline struct irq_chip_msi_doorbell_info *

You do not need an inline here, specially given that you're assigning
its pointer to a structure just below.

> +gicv2m_msi_doorbell_info(struct irq_data *data)
> +{
> +	struct v2m_data *v2m = irq_data_get_irq_chip_data(data);
> +
> +	return &v2m->doorbell_info;
> +}
> +
>  static struct irq_chip gicv2m_irq_chip = {
>  	.name			= "GICv2m",
>  	.irq_mask		= irq_chip_mask_parent,
> @@ -112,6 +123,7 @@ static struct irq_chip gicv2m_irq_chip = {
>  	.irq_eoi		= irq_chip_eoi_parent,
>  	.irq_set_affinity	= irq_chip_set_affinity_parent,
>  	.irq_compose_msi_msg	= gicv2m_compose_msi_msg,
> +	.msi_doorbell_info	= gicv2m_msi_doorbell_info,
>  };
>  
>  static int gicv2m_irq_gic_domain_alloc(struct irq_domain *domain,
> @@ -247,6 +259,7 @@ static void gicv2m_teardown(void)
>  
>  	list_for_each_entry_safe(v2m, tmp, &v2m_nodes, entry) {
>  		list_del(&v2m->entry);
> +		free_percpu(v2m->doorbell_info.percpu_doorbells);
>  		kfree(v2m->bm);
>  		iounmap(v2m->base);
>  		of_node_put(to_of_node(v2m->fwnode));
> @@ -299,6 +312,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
>  {
>  	int ret;
>  	struct v2m_data *v2m;
> +	phys_addr_t __percpu *doorbell;
>  
>  	v2m = kzalloc(sizeof(struct v2m_data), GFP_KERNEL);
>  	if (!v2m) {
> @@ -311,11 +325,23 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
>  
>  	memcpy(&v2m->res, res, sizeof(struct resource));
>  
> +	v2m->doorbell_info.percpu_doorbells =
> +		alloc_percpu(phys_addr_t);
> +	if (WARN_ON(!v2m->doorbell_info.percpu_doorbells)) {
> +		ret = -ENOMEM;
> +		goto err_free_v2m;
> +	}
> +	doorbell = per_cpu_ptr(v2m->doorbell_info.percpu_doorbells, 0);
> +	*doorbell = v2m->res.start;
> +	v2m->doorbell_info.size = 4;
> +	v2m->doorbell_info.prot = IOMMU_WRITE | IOMMU_MMIO;
> +	v2m->doorbell_info.nb_doorbells = 1;


So if you take my earlier suggestion, this becomes:

	v2m->doorbell_info.global_doorbell = v2m->res.start;
	v2m->doorbell_info.size = sizeof(u32);
	v2m->doorbell_info.doorbell_is_percpu = false;

a bit nicer.

> +
>  	v2m->base = ioremap(v2m->res.start, resource_size(&v2m->res));
>  	if (!v2m->base) {
>  		pr_err("Failed to map GICv2m resource\n");
>  		ret = -ENOMEM;
> -		goto err_free_v2m;
> +		goto err_free_v2m_doorbells;
>  	}
>  
>  	if (spi_start && nr_spis) {
> @@ -359,6 +385,8 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
>  
>  err_iounmap:
>  	iounmap(v2m->base);
> +err_free_v2m_doorbells:
> +	free_percpu(v2m->doorbell_info.percpu_doorbells);
>  err_free_v2m:
>  	kfree(v2m);
>  	return ret;
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
