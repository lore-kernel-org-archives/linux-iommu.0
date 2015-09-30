From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH char-misc-next v2 03/22] iommu: Make the iova library a module
Date: Tue, 29 Sep 2015 18:08:26 -0700
Message-ID: <866d1f9f43d7b7d779e5e7545c0859a3704e5ed0.1443573394.git.ashutosh.dixit@intel.com>
References: <cover.1443573394.git.ashutosh.dixit@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1443573394.git.ashutosh.dixit@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, David Woodhouse <David.Woodhouse@intel.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Sudeep Dutt <sudeep.dutt@intel.com>, Nikhil Rao <nikhil.rao@intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

The iova library has use outside the intel-iommu driver, thus make it a
module.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 drivers/iommu/Kconfig | 2 +-
 drivers/iommu/iova.c  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 4664c2a..d9da766 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -43,7 +43,7 @@ config IOMMU_IO_PGTABLE_LPAE_SELFTEST
 endmenu
 
 config IOMMU_IOVA
-	bool
+	tristate
 
 config OF_IOMMU
        def_bool y
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index dd87123..dd64d33 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/iova.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 
 void
@@ -559,3 +560,6 @@ error:
 		free_iova_mem(prev);
 	return NULL;
 }
+
+MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
+MODULE_LICENSE("GPL");
-- 
2.0.0.rc3.2.g998f840
