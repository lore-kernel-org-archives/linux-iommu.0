From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 04/09] iommu/ipmmu-vmsa: Make use of IOMMU_OF_DECLARE()
Date: Wed, 08 Mar 2017 20:02:03 +0900
Message-ID: <148897092335.16106.10892669490439039957.sendpatchset@little-apple>
References: <148897088333.16106.13237004440297956899.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <148897088333.16106.13237004440297956899.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Hook up IOMMU_OF_DECLARE() support in case CONFIG_IOMMU_DMA
is enabled. The only current supported case for 32-bit ARM
is disabled, however for 64-bit ARM usage of OF is required.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Changes since V2:
 - Reworked registration code to make use of recently introduced:
     iommu_device_register()
     iommu_device_set_ops()
     iommu_device_set_fwnode()

 Changes since V1:
 - Reworked slightly to fit updated patch order and
   [PATCH v3 00/06] iommu/ipmmu-vmsa: IPMMU multi-arch update V3

 drivers/iommu/ipmmu-vmsa.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

--- 0012/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-03-08 19:08:31.610607110 +0900
@@ -19,6 +19,7 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_iommu.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -41,6 +42,7 @@ struct ipmmu_features {
 struct ipmmu_vmsa_device {
 	struct device *dev;
 	void __iomem *base;
+	struct iommu_device iommu;
 	struct list_head list;
 	const struct ipmmu_features *features;
 	bool is_leaf;
@@ -1161,6 +1163,25 @@ static int ipmmu_probe(struct platform_d
 		ipmmu_device_reset(mmu);
 	}
 
+#if defined(CONFIG_IOMMU_DMA)
+	/*
+	 * Register the IPMMU to the IOMMU subsystem in the following cases:
+	 * - R-Car Gen2 IPMMU (all devices registered)
+	 * - R-Car Gen3 IPMMU (leaf devices only - skip root IPMMU-MM device)
+	 */
+	if (!mmu->features->has_cache_leaf_nodes || mmu->is_leaf) {
+		ret = iommu_device_register(&mmu->iommu);
+		if (ret)
+			return ret;
+
+		iommu_device_set_ops(&mmu->iommu, &ipmmu_ops);
+		iommu_device_set_fwnode(&mmu->iommu,
+					&pdev->dev.of_node->fwnode);
+
+		if (!iommu_present(&platform_bus_type))
+			bus_set_iommu(&platform_bus_type, &ipmmu_ops);
+	}
+#endif
 	/*
 	 * We can't create the ARM mapping here as it requires the bus to have
 	 * an IOMMU, which only happens when bus_set_iommu() is called in
@@ -1204,15 +1225,22 @@ static struct platform_driver ipmmu_driv
 
 static int __init ipmmu_init(void)
 {
+	static bool setup_done;
 	int ret;
 
+	if (setup_done)
+		return 0;
+
 	ret = platform_driver_register(&ipmmu_driver);
 	if (ret < 0)
 		return ret;
 
+#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 	if (!iommu_present(&platform_bus_type))
 		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
+#endif
 
+	setup_done = true;
 	return 0;
 }
 
@@ -1224,6 +1252,17 @@ static void __exit ipmmu_exit(void)
 subsys_initcall(ipmmu_init);
 module_exit(ipmmu_exit);
 
+#ifdef CONFIG_IOMMU_DMA
+static int __init ipmmu_vmsa_iommu_of_setup(struct device_node *np)
+{
+	ipmmu_init();
+	return 0;
+}
+
+IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa",
+		 ipmmu_vmsa_iommu_of_setup);
+#endif
+
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
 MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>");
 MODULE_LICENSE("GPL v2");
