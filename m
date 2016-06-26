From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH 1/1] iommu/amd: initialize devid variable before using it
Date: Sun, 26 Jun 2016 10:33:29 +0200
Message-ID: <20160626083329.674-1-nicolas.iooss_linux@m4x.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nicolas Iooss <nicolas.iooss_linux@m4x.org>
List-Id: iommu@lists.linux-foundation.org

Commit 2a0cb4e2d423 ("iommu/amd: Add new map for storing IVHD dev entry
type HID") added a call to DUMP_printk in init_iommu_from_acpi() which
used the value of devid before this variable was initialized.

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 drivers/iommu/amd_iommu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 9e0034196e10..d091defc3426 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1107,13 +1107,13 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 				break;
 			}
 
+			devid = e->devid;
 			DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %02x:%02x.%x\n",
 				    hid, uid,
 				    PCI_BUS_NUM(devid),
 				    PCI_SLOT(devid),
 				    PCI_FUNC(devid));
 
-			devid  = e->devid;
 			flags = e->flags;
 
 			ret = add_acpi_hid_device(hid, uid, &devid, false);
-- 
2.9.0
