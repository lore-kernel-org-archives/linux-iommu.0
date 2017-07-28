From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 1/2] acpi:iort: Add an IORT helper function to reserve
 HW ITS address regions for IOMMU drivers
Date: Fri, 28 Jul 2017 10:57:55 +0100
Message-ID: <20170728095755.GA10987@red-moon>
References: <20170725111732.41792-1-shameerali.kolothum.thodi@huawei.com>
 <20170725111732.41792-2-shameerali.kolothum.thodi@huawei.com>
 <20170725171100.GA1663@red-moon>
 <b7512f89-4fe7-940e-0fa9-9274d8b1e935@arm.com>
 <20170726095208.GA2468@red-moon>
 <5FC3163CFD30C246ABAA99954A238FA8383C0268@FRAEML521-MBX.china.huawei.com>
 <989fec76-45e7-d744-3411-78ec2764cb7d@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA8383C04A2@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8383C04A2@FRAEML521-MBX.china.huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, John Garry <john.garry@huawei.com>, "will.deacon@arm.com" <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 27, 2017 at 01:26:14PM +0000, Shameerali Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Robin Murphy [mailto:robin.murphy@arm.com]
> > Sent: Thursday, July 27, 2017 12:13 PM
> > To: Shameerali Kolothum Thodi; Lorenzo Pieralisi
> > Cc: Guohanjun (Hanjun Guo); Gabriele Paoloni; marc.zyngier@arm.com;
> > John Garry; will.deacon@arm.com; Linuxarm; linux-acpi@vger.kernel.org;
> > iommu@lists.linux-foundation.org; hanjun.guo@linaro.org; Wangzhou (B);
> > sudeep.holla@arm.com; linux-arm-kernel@lists.infradead.org;
> > devel@acpica.org
> > Subject: Re: [PATCH v4 1/2] acpi:iort: Add an IORT helper function to reserve
> > HW ITS address regions for IOMMU drivers
> > 
> [...]
> 
> > >>>> I can make these changes but I suspect this series will go via IOMMU
> > >>>> tree, let me know how you want to handle it.
> > >>>>
> > >>>> Lorenzo
> > >>>>
> > >>>>> +	node = iort_find_dev_node(dev);
> > >>>>> +	if (!node)
> > >>>>> +		return -ENODEV;
> > >>>>> +
> > >>>
> > >>> I'd suggest we also want a comment here to clarify that we're currently
> > >>> assuming straightforward topologies where all mappings for a given root
> > >>> complex/named component target the same ITS group. Otherwise
> > we're
> > >> going
> > >>> to need somewhat more logic to iterate the its_node processing over
> > >>> every mapping (or every alias in the PCI case), but avoid creating
> > >>> duplicate entries.
> > >>
> > >> You have a point and we have time to update the code. Short of reserving
> > >> all ITS regions for every device that maps to one at least, we could (even
> > >> pre-compute instead of looking it up on the fly) create a list of ITS
> > >> identifiers a given IORT node may map to and use that to reserve the
> > >> regions.
> > >
> > > I am trying to understand the use case scenario discussed here. Apologies
> > > if it is a dumb query.
> > >
> > > My understanding is that, it is possible to have a PCI  RC iort node mapped
> > to
> > > multiple ITS group nodes.  That is perfectly fine and given a dev input RID
> > we
> > > can identify the ITS group the device points to using - iort_node_map_id().
> > >
> > > But the above discussion seems to suggest that there might be situations
> > where
> > > we have to go through all the mapped ITS groups and identify all the ITSs
> > associated
> > > with the RC.  Clearly I am missing something.
> > 
> > I was mostly thinking of a situation like this:
> > 
> > +----Node 0-----+  +----Node 1-----+
> > |  [CPU 0..n]   |  |  [CPU n+1..]  |
> > | [ITS group 0] |  | [ITS group 1] |
> > +---------------+  +---------------+
> >         ^                  ^
> >          \_______  _______/
> >                  \/
> >             +--Node 2--+
> >             |  [SMMU]  |
> >             |     ^    |
> >             |     |    |
> >             | [Device] |
> >             +----------+
> > 
> > where the (named component) device has IDs for both ITS groups (to help
> > optimise affining, or allow physically hotplugging CPU nodes, or
> > whatever - I'm hypothesising here ;)).  A generic IORT function isn't in
> > a position to decide *which* ITS region the device may be targeting at
> > any given time, so can only correctly describe both.
> 
> Thanks Robin. That makes it clear.
>  
> > I'm perfectly happy not to even try to support such crazy configurations
> > until they actually exist, if ever; I'd just prefer to document whatever
> > assumptions we do make, so that we don't have to remember or re-derive
> > them when looking at the code in future.
> 
> So I think the conclusion here is we will document the assumption that we are
> only taking care of the straightforward topologies for now.
> 
> Hi Lorenzo,
> If you are ok with the above, please let me know if it make sense to send out
> a v5 with this and your other comments or you can take care of them. I am fine
> either way.

I added below what should be the final patch - please have a look test and
post it as part of v5 that should hopefully be final.

Heads-up: I noticed this contains irqchip changes too so care must be
taken for cross-tree dependencies.

-- >8 --
Subject: [PATCH] ACPI/IORT: Add ITS address regions reservation helper

On some platforms ITS address regions have to be excluded from normal
IOVA allocation in that they are detected and decoded in a HW specific
way by system components and so they cannot be considered normal IOVA
address space.

Add an helper function that retrieves ITS address regions through IORT
device <-> ITS mappings and reserves it so that these regions will not
be translated by IOMMU and will be excluded from IOVA allocations.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
[lorenzo.pieralisi@arm.com: updated commit log/added comments]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/acpi/arm64/iort.c        | 95 ++++++++++++++++++++++++++++++++++++++--
 drivers/irqchip/irq-gic-v3-its.c |  3 +-
 include/linux/acpi_iort.h        |  8 +++-
 3 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index c5c82c3..7097cd9e 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -39,6 +39,7 @@
 struct iort_its_msi_chip {
 	struct list_head	list;
 	struct fwnode_handle	*fw_node;
+	phys_addr_t		base_addr;
 	u32			translation_id;
 };
 
@@ -136,14 +137,16 @@ static LIST_HEAD(iort_msi_chip_list);
 static DEFINE_SPINLOCK(iort_msi_chip_lock);
 
 /**
- * iort_register_domain_token() - register domain token and related ITS ID
- * to the list from where we can get it back later on.
+ * iort_register_domain_token() - register domain token along with related
+ * ITS ID and base address to the list from where we can get it back later on.
  * @trans_id: ITS ID.
+ * @base: ITS base address.
  * @fw_node: Domain token.
  *
  * Returns: 0 on success, -ENOMEM if no memory when allocating list element
  */
-int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node)
+int iort_register_domain_token(int trans_id, phys_addr_t base,
+			       struct fwnode_handle *fw_node)
 {
 	struct iort_its_msi_chip *its_msi_chip;
 
@@ -153,6 +156,7 @@ int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node)
 
 	its_msi_chip->fw_node = fw_node;
 	its_msi_chip->translation_id = trans_id;
+	its_msi_chip->base_addr = base;
 
 	spin_lock(&iort_msi_chip_lock);
 	list_add(&its_msi_chip->list, &iort_msi_chip_list);
@@ -481,6 +485,24 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
 	return -ENODEV;
 }
 
+static inline int iort_find_its_base(u32 its_id, phys_addr_t *base)
+{
+	struct iort_its_msi_chip *its_msi_chip;
+	bool match = false;
+
+	spin_lock(&iort_msi_chip_lock);
+	list_for_each_entry(its_msi_chip, &iort_msi_chip_list, list) {
+		if (its_msi_chip->translation_id == its_id) {
+			*base = its_msi_chip->base_addr;
+			match = true;
+			break;
+		}
+	}
+	spin_unlock(&iort_msi_chip_lock);
+
+	return match ? 0 : -ENODEV;
+}
+
 /**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
@@ -639,6 +661,71 @@ int iort_add_device_replay(const struct iommu_ops *ops, struct device *dev)
 
 	return err;
 }
+
+/**
+ * iort_iommu_its_get_resv_regions - Reserved region driver helper
+ * @dev: Device from iommu_get_resv_regions()
+ * @list: Reserved region list from iommu_get_resv_regions()
+ *
+ * Returns: Number of reserved regions on success(0 if no associated ITS),
+ *          appropriate error value otherwise.
+ */
+int iort_iommu_its_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	struct acpi_iort_its_group *its;
+	struct acpi_iort_node *node, *its_node = NULL;
+	int i, resv = 0;
+
+	node = iort_find_dev_node(dev);
+	if (!node)
+		return -ENODEV;
+
+	/*
+	 * Current logic to reserve ITS regions relies on HW topologies
+	 * where a given PCI or named component maps its IDs to only one
+	 * ITS group; if a PCI or named component can map its IDs to
+	 * different ITS groups through IORT mappings this function has
+	 * to be reworked to ensure we reserve regions for all ITS groups
+	 * a given PCI or named component may map IDs to.
+	 */
+	if (dev_is_pci(dev)) {
+		u32 rid;
+
+		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid, &rid);
+		its_node = iort_node_map_id(node, rid, NULL, IORT_MSI_TYPE);
+	} else {
+		for (i = 0; i < node->mapping_count; i++) {
+			its_node = iort_node_map_platform_id(node, NULL,
+							 IORT_MSI_TYPE, i);
+			if (its_node)
+				break;
+		}
+	}
+
+	if (!its_node)
+		return 0;
+
+	/* Move to ITS specific data */
+	its = (struct acpi_iort_its_group *)its_node->node_data;
+
+	for (i = 0; i < its->its_count; i++) {
+		phys_addr_t base;
+
+		if (!iort_find_its_base(its->identifiers[i], &base)) {
+			int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+			struct iommu_resv_region *region;
+
+			region = iommu_alloc_resv_region(base, SZ_128K, prot,
+							 IOMMU_RESV_MSI);
+			if (region) {
+				list_add_tail(&region->list, head);
+				resv++;
+			}
+		}
+	}
+
+	return (resv == its->its_count) ? resv : -ENODEV;
+}
 #else
 static inline
 const struct iommu_ops *iort_fwspec_iommu_ops(struct iommu_fwspec *fwspec)
@@ -646,6 +733,8 @@ const struct iommu_ops *iort_fwspec_iommu_ops(struct iommu_fwspec *fwspec)
 static inline
 int iort_add_device_replay(const struct iommu_ops *ops, struct device *dev)
 { return 0; }
+int iort_iommu_its_get_resv_regions(struct device *dev, struct list_head *head)
+{ return -ENODEV; }
 #endif
 
 static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6893287..77322b3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1928,7 +1928,8 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
 		return -ENOMEM;
 	}
 
-	err = iort_register_domain_token(its_entry->translation_id, dom_handle);
+	err = iort_register_domain_token(its_entry->translation_id, res.start,
+					 dom_handle);
 	if (err) {
 		pr_err("ITS@%pa: Unable to register GICv3 ITS domain token (ITS ID %d) to IORT\n",
 		       &res.start, its_entry->translation_id);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 8379d40..56bb6c7 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -26,7 +26,8 @@
 #define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
 #define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
 
-int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node);
+int iort_register_domain_token(int trans_id, phys_addr_t base,
+			       struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_ACPI_IORT
@@ -38,8 +39,10 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 /* IOMMU interface */
 void iort_set_dma_mask(struct device *dev);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
+int iort_iommu_its_get_resv_regions(struct device *dev, struct list_head *head);
 #else
 static inline void acpi_iort_init(void) { }
+static inline bool iort_node_match(u8 type) { return false; }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 { return req_id; }
 static inline struct irq_domain *iort_get_device_domain(struct device *dev,
@@ -51,6 +54,9 @@ static inline void iort_set_dma_mask(struct device *dev) { }
 static inline
 const struct iommu_ops *iort_iommu_configure(struct device *dev)
 { return NULL; }
+static inline
+int iort_iommu_its_get_resv_regions(struct device *dev, struct list_head *head)
+{ return -ENODEV; }
 #endif
 
 #endif /* __ACPI_IORT_H__ */
-- 
2.10.0

