From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 12/12] iommu/amd: Remove find_last_devid_on_pci()
Date: Tue, 20 Oct 2015 17:33:45 +0200
Message-ID: <1445355225-17557-13-git-send-email-joro@8bytes.org>
References: <1445355225-17557-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445355225-17557-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The value read from the PCI header is not reliable, so
remove this code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu_init.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index e3afa37..65674104 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -408,20 +408,6 @@ static inline int ivhd_entry_length(u8 *ivhd)
 }
 
 /*
- * This function reads the last device id the IOMMU has to handle from the PCI
- * capability header for this IOMMU
- */
-static int __init find_last_devid_on_pci(int bus, int dev, int fn, int cap_ptr)
-{
-	u32 cap;
-
-	cap = read_pci_config(bus, dev, fn, cap_ptr+MMIO_RANGE_OFFSET);
-	update_last_devid(PCI_DEVID(MMIO_GET_BUS(cap), MMIO_GET_LD(cap)));
-
-	return 0;
-}
-
-/*
  * After reading the highest device id from the IOMMU PCI capability header
  * this function looks if there is a higher device id defined in the ACPI table
  */
@@ -433,11 +419,6 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 	p += sizeof(*h);
 	end += h->length;
 
-	find_last_devid_on_pci(PCI_BUS_NUM(h->devid),
-			PCI_SLOT(h->devid),
-			PCI_FUNC(h->devid),
-			h->cap_ptr);
-
 	while (p < end) {
 		dev = (struct ivhd_entry *)p;
 		switch (dev->type) {
-- 
1.9.1
