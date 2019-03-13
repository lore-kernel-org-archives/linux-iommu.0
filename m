From: Aaron Ma <aaron.ma@canonical.com>
Subject: [RESEND][PATCH] iommu/amd: Fix NULL dereference bug in match_hid_uid
Date: Wed, 13 Mar 2019 21:53:24 +0800
Message-ID: <1552485204-11381-1-git-send-email-aaron.ma@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, aaron.ma@canonical.com
List-Id: iommu@lists.linux-foundation.org

Add a non-NULL check to fix potential NULL pointer dereference
Cleanup code to call function once.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/iommu/amd_iommu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2a7b78bb98b4..dbda5b86f979 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -140,9 +140,14 @@ static inline int match_hid_uid(struct device *dev,
 				struct acpihid_map_entry *entry)
 {
 	const char *hid, *uid;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 
-	hid = acpi_device_hid(ACPI_COMPANION(dev));
-	uid = acpi_device_uid(ACPI_COMPANION(dev));
+	if (!adev) {
+		return -ENODEV;
+	}
+
+	hid = acpi_device_hid(adev);
+	uid = acpi_device_uid(adev);
 
 	if (!hid || !(*hid))
 		return -ENODEV;
-- 
2.20.1
