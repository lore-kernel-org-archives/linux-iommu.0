From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v5 09/09] iommu/ipmmu-vmsa: Hook up r8a7795 DT matching code
Date: Mon, 16 Oct 2017 21:30:50 +0900
Message-ID: <150815705058.32763.9807688583552282804.sendpatchset@little-apple>
References: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Tie in r8a7795 features and update the IOMMU_OF_DECLARE
compat string to include the updated compat string.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V4:
 - Got rid of root device availability check in ->xlate()
   -> deferred probing is used to make sure the root is always present

 Changes since V3:
 - Rebased code on top of
   [PATCH 00/04] iommu/ipmmu-vmsa: 32-bit ARM update
   This includes support for iommu_fwspec_add_ids()
 - Use dev_err() instead of dev_info() - Thanks Geert!
 - Moved single-invokation check into of_xlate() - Thanks Geert!
 - Dropped TODO list
 
 Changes since V2:
 - Check for lack of root device in ->xlate()
   This fixed a bug when IPMMU-MM is disabled in DT the system hangs on boot
 - Added code to ipmmu_init_platform_device() to handle multiple ->xlate() calls
 - Include empty white list by default
 - Updated TODO list

 Changes since V1:
 - Enable multi context feature
 - Update TODO list

 drivers/iommu/ipmmu-vmsa.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- 0019/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-10-16 19:53:14.710607110 +0900
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/sys_soc.h>
 
 #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 #include <asm/dma-iommu.h>
@@ -735,9 +736,24 @@ static int ipmmu_init_platform_device(st
 	return 0;
 }
 
+static bool ipmmu_slave_whitelist(struct device *dev)
+{
+	/* By default, do not allow use of IPMMU */
+	return false;
+}
+
+static const struct soc_device_attribute soc_r8a7795[] = {
+	{ .soc_id = "r8a7795", },
+	{ /* sentinel */ }
+};
+
 static int ipmmu_of_xlate(struct device *dev,
 			  struct of_phandle_args *spec)
 {
+	/* For R-Car Gen3 use a white list to opt-in slave devices */
+	if (soc_device_match(soc_r8a7795) && !ipmmu_slave_whitelist(dev))
+		return -ENODEV;
+
 	iommu_fwspec_add_ids(dev, spec->args, 1);
 
 	/* Initialize once - xlate() will call multiple times */
@@ -996,11 +1012,22 @@ static const struct ipmmu_features ipmmu
 	.twobit_imttbcr_sl0 = false,
 };
 
+static const struct ipmmu_features ipmmu_features_r8a7795 = {
+	.use_ns_alias_offset = false,
+	.has_cache_leaf_nodes = true,
+	.number_of_contexts = 8,
+	.setup_imbuscr = false,
+	.twobit_imttbcr_sl0 = true,
+};
+
 static const struct of_device_id ipmmu_of_ids[] = {
 	{
 		.compatible = "renesas,ipmmu-vmsa",
 		.data = &ipmmu_features_default,
 	}, {
+		.compatible = "renesas,ipmmu-r8a7795",
+		.data = &ipmmu_features_r8a7795,
+	}, {
 		/* Terminator */
 	},
 };
@@ -1185,6 +1212,8 @@ static int __init ipmmu_vmsa_iommu_of_se
 
 IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa",
 		 ipmmu_vmsa_iommu_of_setup);
+IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
+		 ipmmu_vmsa_iommu_of_setup);
 #endif
 
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
