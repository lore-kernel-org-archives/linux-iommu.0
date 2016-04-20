From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 6/8] irqchip/gicv2m: implement msi_doorbell_info
	callback
Date: Wed, 20 Apr 2016 18:56:48 +0100
Message-ID: <20160420185648.5982deb7@arm.com>
References: <1461085990-2547-1-git-send-email-eric.auger@linaro.org>
	<1461085990-2547-7-git-send-email-eric.auger@linaro.org>
	<57174B8E.9050803@arm.com> <5717770D.6090005@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5717770D.6090005-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, eric.auger-qxv4g6HH51o@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 20 Apr 2016 14:33:17 +0200
Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> Marc,
> On 04/20/2016 11:27 AM, Marc Zyngier wrote:
> > On 19/04/16 18:13, Eric Auger wrote:
> >> This patch implements the msi_doorbell_info callback in the
> >> gicv2m driver.
> >>
> >> The driver now is able to return its doorbell characteristics
> >> (base, size, prot). A single doorbell is exposed.
> >>
> >> This will allow the msi layer to iommu_map this doorbell when
> >> requested.
> >>
> >> Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>
> >> ---
> >>
> >> v7: creation
> >> ---
> >>  drivers/irqchip/irq-gic-v2m.c | 32 +++++++++++++++++++++++++++++++-
> >>  1 file changed, 31 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
> >> index 28f047c..54690b9 100644
> >> --- a/drivers/irqchip/irq-gic-v2m.c
> >> +++ b/drivers/irqchip/irq-gic-v2m.c
> >> @@ -24,6 +24,8 @@
> >>  #include <linux/of_pci.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/spinlock.h>
> >> +#include <linux/percpu.h>
> >> +#include <linux/iommu.h>
> >>  
> >>  /*
> >>  * MSI_TYPER:
> >> @@ -64,6 +66,7 @@ struct v2m_data {
> >>  	u32 nr_spis;		/* The number of SPIs for MSIs */
> >>  	unsigned long *bm;	/* MSI vector bitmap */
> >>  	u32 flags;		/* v2m flags for specific implementation */
> >> +	struct irq_chip_msi_doorbell_info doorbell_info;
> >>  };
> >>  
> >>  static void gicv2m_mask_msi_irq(struct irq_data *d)
> >> @@ -105,6 +108,16 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> >>  		msg->data -= v2m->spi_start;
> >>  }
> >>  
> >> +static const struct irq_chip_msi_doorbell_info *
> >> +gicv2m_msi_doorbell_info(struct irq_data *data)
> >> +{
> >> +	struct v2m_data *v2m = irq_data_get_irq_chip_data(data);
> >> +
> >> +	if (!v2m)
> >> +		return NULL;
> > 
> > How can this ever be NULL? I think you can drop that test.
> OK
> > 
> >> +	return (const struct irq_chip_msi_doorbell_info *)(&v2m->doorbell_info);
> > 
> > Please don't do that. Use "const" in the functions that are using
> > irq_chip_msi_doorbell_info, but do not make this "const" here.
> It definitively compiles without casting so obviously this is not needed
> but is there any other wrong thing I don't see?
> we still want this function to return a pointer to a const?

I don't think we can return a const pointer, because it is obviously
not (the memory has been kmalloc'ed, and you've written to it, so it is
not really "read-only").

Maybe I'm being overly zealous, but I've seen compilers taking amazing
shortcuts when offered a const qualifier...

> > 
> >> +}
> >> +
> >>  static struct irq_chip gicv2m_irq_chip = {
> >>  	.name			= "GICv2m",
> >>  	.irq_mask		= irq_chip_mask_parent,
> >> @@ -112,6 +125,7 @@ static struct irq_chip gicv2m_irq_chip = {
> >>  	.irq_eoi		= irq_chip_eoi_parent,
> >>  	.irq_set_affinity	= irq_chip_set_affinity_parent,
> >>  	.irq_compose_msi_msg	= gicv2m_compose_msi_msg,
> >> +	.msi_doorbell_info	= gicv2m_msi_doorbell_info,
> >>  };
> >>  
> >>  static int gicv2m_irq_gic_domain_alloc(struct irq_domain *domain,
> >> @@ -247,6 +261,7 @@ static void gicv2m_teardown(void)
> >>  
> >>  	list_for_each_entry_safe(v2m, tmp, &v2m_nodes, entry) {
> >>  		list_del(&v2m->entry);
> >> +		free_percpu(v2m->doorbell_info.percpu_doorbells);
> >>  		kfree(v2m->bm);
> >>  		iounmap(v2m->base);
> >>  		of_node_put(to_of_node(v2m->fwnode));
> >> @@ -299,6 +314,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
> >>  {
> >>  	int ret;
> >>  	struct v2m_data *v2m;
> >> +	struct irq_chip_msi_doorbell __percpu *doorbell;
> >>  
> >>  	v2m = kzalloc(sizeof(struct v2m_data), GFP_KERNEL);
> >>  	if (!v2m) {
> >> @@ -311,11 +327,23 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
> >>  
> >>  	memcpy(&v2m->res, res, sizeof(struct resource));
> >>  
> >> +	v2m->doorbell_info.percpu_doorbells =
> >> +		alloc_percpu(struct irq_chip_msi_doorbell);
> >> +	if (WARN_ON(!v2m->doorbell_info.percpu_doorbells)) {
> >> +		ret = -ENOMEM;
> >> +		goto err_free_v2m;
> >> +	}
> >> +	doorbell = per_cpu_ptr(v2m->doorbell_info.percpu_doorbells, 0);
> >> +	doorbell->base = v2m->res.start;
> >> +	doorbell->size = 4;
> >> +	doorbell->prot = IOMMU_WRITE;
> > 
> > You probably need to also have something that says IOMMU_DEVICE or
> > something similar, because I'm afraid you're getting a memory mapping
> > here. I've had a quick look at the two other series, but couldn't find
> > anything that would force the memory attributes.
> Yes you're right I currently just enforce the direction (which is
> checked against what VFIO user registered). Do you refer to IOMMU_MMIO,
> latterly proposed on the ML. In the positive, yes I intend to add it
> once it gets upstreamed.

Yeah, Robin's patches should become a dependency here, because there is
absolutely no guarantee that the device write to the doorbell won't be
treated a normal cacheable memory, with disastrous effects.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
