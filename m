From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 9/9] iommu/amd: Don't copy GCR3 table root pointer
Date: Thu, 20 Oct 2016 19:37:20 +0800
Message-ID: <1476963440-23039-10-git-send-email-bhe@redhat.com>
References: <1476963440-23039-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1476963440-23039-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

If a device is set up with guest translations (DTE.GV=1), then don't
copy GCR3 table root pointer but move the device over to an empty
guest-cr3 table and handle the faults in the PPR log (which answer them
with INVALID). After all these PPR faults are recoverable for the device
and we should not allow the device to change old-kernels data when we
don't have to.

And clear the old GV flag when update domain information into dte entry
if the domain doesn't support IOMMUv2.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 45 ++++++++++++++++++-----------------------
 drivers/iommu/amd_iommu_init.c  | 11 ++++++++++
 drivers/iommu/amd_iommu_proto.h |  1 +
 drivers/iommu/amd_iommu_types.h | 22 ++++++++++++++++++++
 drivers/iommu/amd_iommu_v2.c    | 18 ++++++++++++++++-
 5 files changed, 71 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 46f438f..af0b9ce 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -120,28 +120,6 @@ int amd_iommu_max_glx_val = -1;
 static struct dma_map_ops amd_iommu_dma_ops;
 
 /*
- * This struct contains device specific data for the IOMMU
- */
-struct iommu_dev_data {
-	struct list_head list;		  /* For domain->dev_list */
-	struct list_head dev_data_list;	  /* For global dev_data_list */
-	struct protection_domain *domain; /* Domain the device is bound to */
-	u16 devid;			  /* PCI Device ID */
-	u16 alias;			  /* Alias Device ID */
-	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
-	bool passthrough;		  /* Device is identity mapped */
-	struct {
-		bool enabled;
-		int qdep;
-	} ats;				  /* ATS state */
-	bool pri_tlp;			  /* PASID TLB required for
-					     PPR completions */
-	u32 errata;			  /* Bitmap for errata to apply */
-	bool use_vapic;			  /* Enable device to use vapic mode */
-	bool domain_updated;
-};
-
-/*
  * general struct to manage commands send to an IOMMU
  */
 struct iommu_cmd {
@@ -350,10 +328,11 @@ static struct iommu_dev_data *find_dev_data(u16 devid)
 	return dev_data;
 }
 
-static struct iommu_dev_data *get_dev_data(struct device *dev)
+struct iommu_dev_data *get_dev_data(struct device *dev)
 {
 	return dev->archdata.iommu;
 }
+EXPORT_SYMBOL(get_dev_data);
 
 /*
 * Find or create an IOMMU group for a acpihid device.
@@ -2383,6 +2362,12 @@ static int dir2prot(enum dma_data_direction direction)
 	else
 		return 0;
 }
+
+static void clear_dte_flag_gv(u16 devid)
+{
+	amd_iommu_dev_table[devid].data[0] &= (~DTE_FLAG_GV);
+}
+
 /*
  * This function contains common code for mapping of a physically
  * contiguous memory region into DMA address space. It is used by all
@@ -2417,8 +2402,13 @@ static dma_addr_t __map_single(struct device *dev,
 	if (translation_pre_enabled(iommu) && !dev_data->domain_updated) {
 		dev_data->domain_updated = true;
 		set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled);
-		if (alias != dev_data->devid)
+		if (!(domain->flags & PD_IOMMUV2_MASK))
+			clear_dte_flag_gv(dev_data->devid);
+		if (alias != dev_data->devid) {
 			set_dte_entry(alias, domain, dev_data->ats.enabled);
+			if (!(domain->flags & PD_IOMMUV2_MASK))
+				clear_dte_flag_gv(alias);
+		}
 		device_flush_dte(dev_data);
 	}
 
@@ -2593,8 +2583,13 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	if (translation_pre_enabled(iommu) && !dev_data->domain_updated) {
 		dev_data->domain_updated = true;
 		set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled);
-		if (alias != dev_data->devid)
+		if (!(domain->flags & PD_IOMMUV2_MASK))
+			clear_dte_flag_gv(dev_data->devid);
+		if (alias != dev_data->devid) {
 			set_dte_entry(alias, domain, dev_data->ats.enabled);
+			if (!(domain->flags & PD_IOMMUV2_MASK))
+				clear_dte_flag_gv(alias);
+		}
 		device_flush_dte(dev_data);
 	}
 
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index d936c40..9ddce11 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -204,6 +204,7 @@ u16 *amd_iommu_alias_table;
  * for a specific device. It is also indexed by the PCI device id.
  */
 struct amd_iommu **amd_iommu_rlookup_table;
+EXPORT_SYMBOL(amd_iommu_rlookup_table);
 
 /*
  * This table is used to find the irq remapping table for a given device id
@@ -257,6 +258,7 @@ bool translation_pre_enabled(struct amd_iommu *iommu)
 {
 	return (iommu->flags & AMD_IOMMU_FLAG_TRANS_PRE_ENABLED);
 }
+EXPORT_SYMBOL(translation_pre_enabled);
 
 static void clear_translation_pre_enabled(struct amd_iommu *iommu)
 {
@@ -844,6 +846,7 @@ static int copy_dev_tables(void)
 	struct amd_iommu *iommu;
 	u16 dom_id, dte_v, irq_v;
 	static int copied;
+	u64 tmp;
 
 	for_each_iommu(iommu) {
 		if (!translation_pre_enabled(iommu)) {
@@ -887,6 +890,14 @@ static int copy_dev_tables(void)
 				amd_iommu_dev_table[devid].data[1]
 					= old_devtb[devid].data[1];
 				__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
+				/* If gcr3 table existed, mask it out */
+				if (old_devtb[devid].data[0] & DTE_FLAG_GV) {
+					tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
+					tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
+					amd_iommu_dev_table[devid].data[1] &= ~tmp;
+					tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
+					amd_iommu_dev_table[devid].data[0] &= ~tmp;
+				}
 			}
 
 			irq_v = old_devtb[devid].data[2] & DTE_IRQ_REMAP_ENABLE;
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 9560183..d6a2c36 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -94,4 +94,5 @@ static inline bool iommu_feature(struct amd_iommu *iommu, u64 f)
 }
 
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
+extern struct iommu_dev_data *get_dev_data(struct device *dev);
 #endif /* _ASM_X86_AMD_IOMMU_PROTO_H  */
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index e385d50..1d316cd 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -612,6 +612,28 @@ struct devid_map {
 	bool cmd_line;
 };
 
+/*
+ * This struct contains device specific data for the IOMMU
+ */
+struct iommu_dev_data {
+	struct list_head list;		  /* For domain->dev_list */
+	struct list_head dev_data_list;	  /* For global dev_data_list */
+	struct protection_domain *domain; /* Domain the device is bound to */
+	u16 devid;			  /* PCI Device ID */
+	u16 alias;			  /* Alias Device ID */
+	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
+	bool passthrough;		  /* Device is identity mapped */
+	struct {
+		bool enabled;
+		int qdep;
+	} ats;				  /* ATS state */
+	bool pri_tlp;			  /* PASID TLB required for
+					     PPR completions */
+	u32 errata;			  /* Bitmap for errata to apply */
+	bool use_vapic;			  /* Enable device to use vapic mode */
+	bool domain_updated;
+};
+
 /* Map HPET and IOAPIC ids to the devid used by the IOMMU */
 extern struct list_head ioapic_map;
 extern struct list_head hpet_map;
diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 594849a..7c4a847 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -561,13 +561,29 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 	unsigned long flags;
 	struct fault *fault;
 	bool finish;
-	u16 tag;
+	u16 tag, devid;
 	int ret;
+	struct iommu_dev_data *dev_data;
+	struct pci_dev *pdev = NULL;
 
 	iommu_fault = data;
 	tag         = iommu_fault->tag & 0x1ff;
 	finish      = (iommu_fault->tag >> 9) & 1;
 
+	devid = iommu_fault->device_id;
+	pdev = pci_get_bus_and_slot(PCI_BUS_NUM(devid), devid & 0xff);
+	if (!pdev)
+		return -ENODEV;
+	dev_data = get_dev_data(&pdev->dev);
+
+	/* In kdump kernel pci dev is not initialized yet -> send INVALID */
+	if (translation_pre_enabled(amd_iommu_rlookup_table[devid])
+		&& !dev_data->domain_updated) {
+		amd_iommu_complete_ppr(pdev, iommu_fault->pasid,
+				       PPR_INVALID, tag);
+		goto out;
+	}
+
 	ret = NOTIFY_DONE;
 	dev_state = get_device_state(iommu_fault->device_id);
 	if (dev_state == NULL)
-- 
2.5.5
