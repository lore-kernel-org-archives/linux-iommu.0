From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v2 11/15] drivers: iommu: arm-smmu-v3: add IORT iommu
	configuration
Date: Wed, 15 Jun 2016 09:52:48 +0100
Message-ID: <20160615085248.GA32390@red-moon>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1465306270-27076-12-git-send-email-lorenzo.pieralisi@arm.com>
	<20160614183939.GL16531@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160614183939.GL16531-5wv7dgnIgG8@public.gmane.org>
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
Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 14, 2016 at 07:39:39PM +0100, Will Deacon wrote:
> On Tue, Jun 07, 2016 at 02:31:06PM +0100, Lorenzo Pieralisi wrote:
> > In ACPI bases systems, in order to be able to create platform
> > devices and initialize them for arm-smmu-v3 components, the IORT
> > infrastructure requires ARM SMMU drivers to initialize a set of
> > operations that are used by the IORT kernel layer to configure platform
> > devices for ARM SMMU components in turn.
> > 
> > This patch adds the IORT IOMMU configuration for the ARM SMMU v3 kernel
> > driver.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> > Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> > Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/iort.h        |  12 +++++-
> >  2 files changed, 112 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index 90745a8..7acb6b5 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -2687,6 +2687,107 @@ static int __init arm_smmu_of_init(struct device_node *np)
> >  }
> >  IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", arm_smmu_of_init);
> >  
> > +#ifdef CONFIG_ACPI
> > +static int acpi_smmu_init(struct acpi_iort_node *node)
> > +{
> > +	iort_smmu_set_ops(node, &arm_smmu_ops, NULL);
> > +
> > +	return 0;
> > +}
> > +
> > +static void acpi_smmu_register_irq(int hwirq, const char *name,
> > +				   struct resource *res)
> > +{
> > +	int irq = acpi_register_gsi(NULL, hwirq, ACPI_EDGE_SENSITIVE,
> > +				    ACPI_ACTIVE_HIGH);
> > +
> > +	if (irq < 0) {
> > +		pr_err("could not register gsi hwirq %d name [%s]\n", hwirq,
> > +								      name);
> > +		return;
> > +	}
> > +
> > +	res->start = irq;
> > +	res->end = irq;
> > +	res->flags = IORESOURCE_IRQ;
> > +	res->name = name;
> > +}
> > +
> > +static int arm_smmu_count_resources(struct acpi_iort_node *node)
> > +{
> > +	struct acpi_iort_smmu_v3 *smmu;
> > +	/* Always present mem resource */
> > +	int num_res = 1;
> > +
> > +	/* Retrieve SMMUv3 specific data */
> > +	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> > +
> > +	if (smmu->event_gsiv)
> > +		num_res++;
> > +
> > +	if (smmu->pri_gsiv)
> > +		num_res++;
> > +
> > +	if (smmu->gerr_gsiv)
> > +		num_res++;
> > +
> > +	if (smmu->sync_gsiv)
> > +		num_res++;
> > +
> > +	return num_res;
> > +}
> > +
> > +static void arm_smmu_init_resources(struct resource *res,
> > +				    struct acpi_iort_node *node)
> > +{
> > +	struct acpi_iort_smmu_v3 *smmu;
> > +	int num_res = 0;
> > +
> > +	/* Retrieve SMMUv3 specific data */
> > +	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> > +
> > +	res[num_res].start = smmu->base_address;
> > +	res[num_res].end = smmu->base_address + SZ_128K - 1;
> > +	res[num_res].flags = IORESOURCE_MEM;
> > +
> > +	num_res++;
> > +
> > +	if (smmu->event_gsiv)
> > +		acpi_smmu_register_irq(smmu->event_gsiv, "eventq",
> > +				       &res[num_res++]);
> > +
> > +	if (smmu->pri_gsiv)
> > +		acpi_smmu_register_irq(smmu->pri_gsiv, "priq",
> > +				       &res[num_res++]);
> > +
> > +	if (smmu->gerr_gsiv)
> > +		acpi_smmu_register_irq(smmu->gerr_gsiv, "gerror",
> > +				       &res[num_res++]);
> > +
> > +	if (smmu->sync_gsiv)
> > +		acpi_smmu_register_irq(smmu->sync_gsiv, "cmdq-sync",
> > +				       &res[num_res++]);
> > +}
> > +
> > +static bool arm_smmu_is_coherent(struct acpi_iort_node *node)
> > +{
> > +	struct acpi_iort_smmu_v3 *smmu;
> > +
> > +	/* Retrieve SMMUv3 specific data */
> > +	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> > +
> > +	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
> > +}
> > +
> > +const struct iort_iommu_config iort_arm_smmu_v3_cfg = {
> > +	.name = "arm-smmu-v3",
> > +	.iommu_init = acpi_smmu_init,
> > +	.iommu_is_coherent = arm_smmu_is_coherent,
> > +	.iommu_count_resources = arm_smmu_count_resources,
> > +	.iommu_init_resources = arm_smmu_init_resources
> > +};
> > +#endif
> > +
> >  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
> >  MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
> >  MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/iort.h b/include/linux/iort.h
> > index ced3054..5dcfa09 100644
> > --- a/include/linux/iort.h
> > +++ b/include/linux/iort.h
> > @@ -55,7 +55,17 @@ struct iort_iommu_config {
> >  static inline const struct iort_iommu_config *
> >  iort_get_iommu_config(struct acpi_iort_node *node)
> >  {
> > -	return NULL;
> > +	switch (node->type) {
> > +#if IS_ENABLED(CONFIG_ARM_SMMU_V3)
> > +	case ACPI_IORT_NODE_SMMU_V3: {
> > +		extern const struct iort_iommu_config iort_arm_smmu_v3_cfg;
> > +
> > +		return &iort_arm_smmu_v3_cfg;
> > +	}
> > +#endif
> 
> Oh, yuck! I really don't like this mixture of SMMU driver code and IORT
> code over two files using a global structure of largely stateless function
> pointers.
> 
> I think you have two options:
> 
>   (1) Move this all into iort.c (my preference)
>   (2) Introduce something like SMMU_ACPI_DECLARE which allows drivers to
>       register a callback if they're matched in the IORT.
> 
> that at least keeps internal data in one place, rather than spreading it
> around.

(1) is possible for most of the function pointers. Problem is that iort.c
has to know ARM SMMU v3 driver internals (driver name for platform
device matching and IRQ resources names - I wanted to keep the ARM SMMU
v3 probing routine as FW agnostic as possible), it is obviously doable
but I have to make sure I keep them in sync.

We still need (2) to have an IOMMU_OF_DECLARE() equivalent (ie to
make sure that we can carry out the of_xlate() equivalent when
devices are probed), I did not want to add a linker script section
for two components (ARM SMMUv1/v2 and v3) but that's doable too,
I will make changes for v3.

Thanks for having a look !

Lorenzo
