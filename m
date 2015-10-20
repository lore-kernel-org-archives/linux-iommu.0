From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 11/12] iommu/amd: Remove first/last_device handling
Date: Tue, 20 Oct 2015 17:33:44 +0200
Message-ID: <1445355225-17557-12-git-send-email-joro@8bytes.org>
References: <1445355225-17557-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445355225-17557-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The code is buggy and the values read from PCI are not
reliable anyway, so it is the best to just remove this code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu_init.c  | 34 +++-------------------------------
 drivers/iommu/amd_iommu_types.h |  5 -----
 2 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6432bdb..e3afa37 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -824,20 +824,10 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		switch (e->type) {
 		case IVHD_DEV_ALL:
 
-			DUMP_printk("  DEV_ALL\t\t\t first devid: %02x:%02x.%x"
-				    " last device %02x:%02x.%x flags: %02x\n",
-				    PCI_BUS_NUM(iommu->first_device),
-				    PCI_SLOT(iommu->first_device),
-				    PCI_FUNC(iommu->first_device),
-				    PCI_BUS_NUM(iommu->last_device),
-				    PCI_SLOT(iommu->last_device),
-				    PCI_FUNC(iommu->last_device),
-				    e->flags);
+			DUMP_printk("  DEV_ALL\t\t\tflags: %02x\n", e->flags);
 
-			for (dev_i = iommu->first_device;
-					dev_i <= iommu->last_device; ++dev_i)
-				set_dev_entry_from_acpi(iommu, dev_i,
-							e->flags, 0);
+			for (dev_i = 0; dev_i <= amd_iommu_last_bdf; ++dev_i)
+				set_dev_entry_from_acpi(iommu, dev_i, e->flags, 0);
 			break;
 		case IVHD_DEV_SELECT:
 
@@ -993,17 +983,6 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	return 0;
 }
 
-/* Initializes the device->iommu mapping for the driver */
-static int __init init_iommu_devices(struct amd_iommu *iommu)
-{
-	u32 i;
-
-	for (i = iommu->first_device; i <= iommu->last_device; ++i)
-		set_iommu_for_device(iommu, i);
-
-	return 0;
-}
-
 static void __init free_iommu_one(struct amd_iommu *iommu)
 {
 	free_command_buffer(iommu);
@@ -1122,8 +1101,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	 */
 	amd_iommu_rlookup_table[iommu->devid] = NULL;
 
-	init_iommu_devices(iommu);
-
 	return 0;
 }
 
@@ -1253,11 +1230,6 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_MISC_OFFSET,
 			      &misc);
 
-	iommu->first_device = PCI_DEVID(MMIO_GET_BUS(range),
-					 MMIO_GET_FD(range));
-	iommu->last_device = PCI_DEVID(MMIO_GET_BUS(range),
-					MMIO_GET_LD(range));
-
 	if (!(iommu->cap & (1 << IOMMU_CAP_IOTLB)))
 		amd_iommu_iotlb_sup = false;
 
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 921b2e9..fc9501d 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -516,11 +516,6 @@ struct amd_iommu {
 	/* pci domain of this IOMMU */
 	u16 pci_seg;
 
-	/* first device this IOMMU handles. read from PCI */
-	u16 first_device;
-	/* last device this IOMMU handles. read from PCI */
-	u16 last_device;
-
 	/* start of exclusion range of that IOMMU */
 	u64 exclusion_start;
 	/* length of exclusion range of that IOMMU */
-- 
1.9.1
