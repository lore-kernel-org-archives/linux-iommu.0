From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iommu: Fix IOMMU debugfs fallout
Date: Wed, 20 Feb 2019 14:05:05 +0100
Message-ID: <20190220130505.1188-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

A change made in the final version of IOMMU debugfs support replaced the
public function iommu_debugfs_new_driver_dir() by the public dentry
iommu_debugfs_dir in <linux/iommu.h>, but forgot to update both the
implementation in iommu-debugfs.c, and the patch description.

Fix this by exporting iommu_debugfs_dir, and removing the reference to
and implementation of iommu_debugfs_new_driver_dir().

Fixes: bad614b24293ae46 ("iommu: Enable debugfs exposure of IOMMU driver internals")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/iommu-debugfs.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
index 3b1bf88fd1b0494a..f0354894209648fd 100644
--- a/drivers/iommu/iommu-debugfs.c
+++ b/drivers/iommu/iommu-debugfs.c
@@ -12,6 +12,7 @@
 #include <linux/debugfs.h>
 
 struct dentry *iommu_debugfs_dir;
+EXPORT_SYMBOL_GPL(iommu_debugfs_dir);
 
 /**
  * iommu_debugfs_setup - create the top-level iommu directory in debugfs
@@ -23,9 +24,9 @@ struct dentry *iommu_debugfs_dir;
  * Emit a strong warning at boot time to indicate that this feature is
  * enabled.
  *
- * This function is called from iommu_init; drivers may then call
- * iommu_debugfs_new_driver_dir() to instantiate a vendor-specific
- * directory to be used to expose internal data.
+ * This function is called from iommu_init; drivers may then use
+ * iommu_debugfs_dir to instantiate a vendor-specific directory to be used
+ * to expose internal data.
  */
 void iommu_debugfs_setup(void)
 {
@@ -48,19 +49,3 @@ void iommu_debugfs_setup(void)
 		pr_warn("*************************************************************\n");
 	}
 }
-
-/**
- * iommu_debugfs_new_driver_dir - create a vendor directory under debugfs/iommu
- * @vendor: name of the vendor-specific subdirectory to create
- *
- * This function is called by an IOMMU driver to create the top-level debugfs
- * directory for that driver.
- *
- * Return: upon success, a pointer to the dentry for the new directory.
- *         NULL in case of failure.
- */
-struct dentry *iommu_debugfs_new_driver_dir(const char *vendor)
-{
-	return debugfs_create_dir(vendor, iommu_debugfs_dir);
-}
-EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
-- 
2.17.1
