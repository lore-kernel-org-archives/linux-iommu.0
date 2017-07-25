From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4] acpi/iort: numa: Add numa node mapping for smmuv3
 devices
Date: Tue, 25 Jul 2017 17:01:52 +0100
Message-ID: <20170725160152.GA19744@red-moon>
References: <20170725050237.11033-1-ganapatrao.kulkarni@cavium.com>
 <20170725151305.GU17961@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170725151305.GU17961@rric.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Robert Richter <robert.richter@cavium.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, Will.Deacon@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com, lv.zheng@intel.com, joro@8bytes.org, rjw@rjwysocki.net, lenb@kernel.org, jnair@caviumnetworks.com, gklkml16@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 25, 2017 at 05:13:05PM +0200, Robert Richter wrote:
> On 25.07.17 10:32:37, Ganapatrao Kulkarni wrote:
> > ARM IORT specification(rev. C) has added  provision to define proximity
> > domain in SMMUv3 IORT table. Adding required code to parse Proximity
> > domain and set numa_node of smmv3 platform devices.
> > 
> > Add code to parse proximity domain in SMMUv3 IORT table to
> > set numa node mapping for smmuv3 devices.
> > 
> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > ---
> > 
> > This patch has dependency on header file patch [1], which is
> > already merged to linux-pm.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=c944230064eb65e4fa018d86779b4fd200b1d7e7
> > 
> > v4:
> >   - Fix compilation issue in !CONFIG_NUMA
> > 
> > v3:
> >   - Addressed Lorenzo Pieralisi comment.
> > 
> > v2:
> >   - Changed as per Lorenzo Pieralisi and Hanjun Guo suggestions.
> > 
> > v1:
> >   - Initial patch
> > 
> >  drivers/acpi/arm64/iort.c | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index a3215ee..c5c82c3 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -908,6 +908,28 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
> >  	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
> >  }
> >  
> > +#if defined(CONFIG_ACPI_NUMA) && (ACPI_CA_VERSION >= 0x20170629)
> 
> This acpica version check was very unhandy for backports when we did
> this last time. If we backport just c944230064 and this single patch
> it wont work as the version check prevents the code from being
> enabled. Isn't there another way to handle cross tree dependencies of
> pull requests? E.g. we could base this patch on acpica (ab539eaa50)
> and remove the check.

I think I will send this patch (and other IORT ones) via arm64,
if acpica goes via the ACPI tree I do not think there is much else
we can do (that is not complicated).

> Alternatively we could do in this case:
> 
> #if defined(CONFIG_ACPI_NUMA) && defined(ACPI_IORT_SMMU_V3_PXM_VALID)

This would do, agreed on all other changes requested, I will send it
to Catalin as soon as I collect all IORT patches for v4.14.

Thanks !
Lorenzo

> > +/*
> > + * set numa proximity domain for smmuv3 device
> > + */
> > +static void  __init arm_smmu_v3_set_proximity(struct acpi_iort_node *node,
> > +		struct device *dev)
> > +{
> > +	struct acpi_iort_smmu_v3 *smmu;
> > +
> > +	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> > +	if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
> > +		set_dev_node(dev, acpi_map_pxm_to_node(smmu->pxm));
> > +		pr_info("SMMUV3[%llx] Mapped to Proximity domain %d\n",
> 
> Better use dev_info() here.
> 
> > +			smmu->base_address,
> > +			smmu->pxm);
> > +	}
> > +}
> > +#else
> > +static void  __init arm_smmu_v3_set_proximity(struct acpi_iort_node *node,
> > +		struct device *dev) { }
> 
> Just do:
> 
> #define arm_smmu_v3_set_proximity NULL
> 
> > +#endif
> > +
> >  static int __init arm_smmu_count_resources(struct acpi_iort_node *node)
> >  {
> >  	struct acpi_iort_smmu *smmu;
> > @@ -977,20 +999,24 @@ struct iort_iommu_config {
> >  	int (*iommu_count_resources)(struct acpi_iort_node *node);
> >  	void (*iommu_init_resources)(struct resource *res,
> >  				     struct acpi_iort_node *node);
> > +	void (*iommu_set_proximity)(struct acpi_iort_node *node,
> > +				     struct device *dev);
> 
> Wrt pseudo-OO programming this is more a method for struct dev than
> node, so swap args: iommu_set_proximity(dev, node)
> 
> >  };
> >  
> >  static const struct iort_iommu_config iort_arm_smmu_v3_cfg __initconst = {
> >  	.name = "arm-smmu-v3",
> >  	.iommu_is_coherent = arm_smmu_v3_is_coherent,
> >  	.iommu_count_resources = arm_smmu_v3_count_resources,
> > -	.iommu_init_resources = arm_smmu_v3_init_resources
> > +	.iommu_init_resources = arm_smmu_v3_init_resources,
> > +	.iommu_set_proximity = arm_smmu_v3_set_proximity
> 
> Add comma at the end here.
> 
> >  };
> >  
> >  static const struct iort_iommu_config iort_arm_smmu_cfg __initconst = {
> >  	.name = "arm-smmu",
> >  	.iommu_is_coherent = arm_smmu_is_coherent,
> >  	.iommu_count_resources = arm_smmu_count_resources,
> > -	.iommu_init_resources = arm_smmu_init_resources
> > +	.iommu_init_resources = arm_smmu_init_resources,
> > +	.iommu_set_proximity = NULL
> 
> No need for null assignment.
> 
> -Robert
> 
> >  };
> >  
> >  static __init
> > @@ -1028,6 +1054,9 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
> >  	if (!pdev)
> >  		return -ENOMEM;
> >  
> > +	if (ops->iommu_set_proximity)
> > +		ops->iommu_set_proximity(node, &pdev->dev);
> > +
> >  	count = ops->iommu_count_resources(node);
> >  
> >  	r = kcalloc(count, sizeof(*r), GFP_KERNEL);
> > -- 
> > 2.9.4
> > 
