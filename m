From: Olof Johansson <olof@lixom.net>
Subject: [PATCH 1/2] iommu: Add config option to set passthrough as default
Date: Wed, 11 Jul 2018 13:59:35 -0700
Message-ID: <20180711205936.18614-1-olof@lixom.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
List-Id: iommu@lists.linux-foundation.org

This allows the default behavior to be controlled by a kernel config
option instead of changing the commandline for the kernel to include
"iommu.passthrough=on" on machines where this is desired.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/iommu/Kconfig | 10 ++++++++++
 drivers/iommu/iommu.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 689ffe538370..a9bb1a5b5e43 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -60,6 +60,16 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
 endmenu
 
+config IOMMU_DEFAULT_PASSTHROUGH
+	bool "IOMMU passthrough by default"
+	depends on IOMMU_API
+        help
+	  Enable passthrough by default (removing the need to pass in
+	  iommu.passthrough=on through command line). If this is enabled,
+	  you can still disable with iommu.passthrough=off
+
+	  If unsure, say N here.
+
 config IOMMU_IOVA
 	tristate
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 63b37563db7e..ab8fc54467e0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -36,7 +36,11 @@
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
+#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
+static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
+#else
 static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
+#endif
 
 struct iommu_callback_data {
 	const struct iommu_ops *ops;
-- 
2.11.0
