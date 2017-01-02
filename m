From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 RESEND 11/12] iommu/amd: Don't copy GCR3 table root pointer
Date: Mon,  2 Jan 2017 15:39:57 +0800
Message-ID: <1483342798-6542-12-git-send-email-bhe@redhat.com>
References: <1483342798-6542-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1483342798-6542-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When in kdump kernel iommu is pre_enabled, if a device is set up with
guest translations (DTE.GV=1), then don't copy GCR3 table root pointer
but move the device over to an empty guest-cr3 table and handle the
faults in the PPR log (which answer them with INVALID). After all these
PPR faults are recoverable for the device and we should not allow the
device to change old-kernels data when we don't have to.

Suggested-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 26 +++-----------------------
 drivers/iommu/amd_iommu_init.c  | 11 +++++++++++
 drivers/iommu/amd_iommu_proto.h |  1 +
 drivers/iommu/amd_iommu_types.h | 22 ++++++++++++++++++++++
 drivers/iommu/amd_iommu_v2.c    | 18 +++++++++++++++++-
 5 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c23f3d11..bc3711e 100644
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
-	bool defer_attach;
-};
-
-/*
  * general struct to manage commands send to an IOMMU
  */
 struct iommu_cmd {
@@ -355,10 +333,11 @@ static struct iommu_dev_data *find_dev_data(u16 devid)
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
@@ -2380,6 +2359,7 @@ static int dir2prot(enum dma_data_direction direction)
 	else
 		return 0;
 }
+
 /*
  * This function contains common code for mapping of a physically
  * contiguous memory region into DMA address space. It is used by all
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 73b74ba..08d8d81 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -205,6 +205,7 @@ u16 *amd_iommu_alias_table;
  * for a specific device. It is also indexed by the PCI device id.
  */
 struct amd_iommu **amd_iommu_rlookup_table;
+EXPORT_SYMBOL(amd_iommu_rlookup_table);
 
 /*
  * This table is used to find the irq remapping table for a given device id
@@ -258,6 +259,7 @@ bool translation_pre_enabled(struct amd_iommu *iommu)
 {
 	return (iommu->flags & AMD_IOMMU_FLAG_TRANS_PRE_ENABLED);
 }
+EXPORT_SYMBOL(translation_pre_enabled);
 
 static void clear_translation_pre_enabled(struct amd_iommu *iommu)
 {
@@ -845,6 +847,7 @@ static int copy_dev_tables(void)
 	struct amd_iommu *iommu;
 	u16 dom_id, dte_v, irq_v;
 	static int copied;
+	u64 tmp;
 
 	for_each_iommu(iommu) {
 		if (!translation_pre_enabled(iommu)) {
@@ -888,6 +891,14 @@ static int copy_dev_tables(void)
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
index b5ae18e..5524cdd 100644
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
+	bool defer_attach;
+};
+
 /* Map HPET and IOAPIC ids to the devid used by the IOMMU */
 extern struct list_head ioapic_map;
 extern struct list_head hpet_map;
diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index f8ed8c9..7fcfc17 100644
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
+		&& dev_data->defer_attach) {
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
