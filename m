From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 09/09] iommu/ipmmu-vmsa: Hook up r8a7795 DT matching code
Date: Mon, 19 Jun 2017 18:15:20 +0900
Message-ID: <149786372027.14868.17337099469033750355.sendpatchset@little-apple>
References: <149786362527.14868.2143461703972595839.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <149786362527.14868.2143461703972595839.sendpatchset@little-apple>
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

Tie in r8a7795 features and update the IOMMU_OF_DECLARE
compat string to include the updated compat string.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

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

 drivers/iommu/ipmmu-vmsa.c |   48 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

--- 0029/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-06-19 14:10:58.930607110 +0900
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/sys_soc.h>
 
 #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 #include <asm/dma-iommu.h>
@@ -730,10 +731,6 @@ static int ipmmu_init_platform_device(st
 	struct platform_device *ipmmu_pdev;
 	struct ipmmu_vmsa_iommu_priv *priv;
 
-	/* Initialize once - xlate() will call multiple times */
-	if (to_priv(dev))
-		return 0;
-
 	ipmmu_pdev = of_find_device_by_node(args->np);
 	if (!ipmmu_pdev)
 		return -ENODEV;
@@ -748,11 +745,41 @@ static int ipmmu_init_platform_device(st
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
+	/* Failing in ->attach_device() results in a hang, so make
+	 * sure the root device is installed before going there
+	 */
+	if (!__ipmmu_find_root()) {
+		dev_err(dev, "Unable to locate IPMMU root device\n");
+		return -ENODEV;
+	}
+
+	/* For R-Car Gen3 use a white list to opt-in slave devices */
+	if (soc_device_match(soc_r8a7795) && !ipmmu_slave_whitelist(dev))
+		return -ENODEV;
+
 	iommu_fwspec_add_ids(dev, spec->args, 1);
 
+	/*
+	 * Execute ipmmu_init_platform_device() once per device.
+	 * This xlate() callback will be invoked multiple times.
+	 */
+	if (to_priv(dev))
+		return 0;
+
 	return ipmmu_init_platform_device(dev, spec);
 }
 
@@ -1003,11 +1030,22 @@ static const struct ipmmu_features ipmmu
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
@@ -1185,6 +1223,8 @@ static int __init ipmmu_vmsa_iommu_of_se
 
 IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa",
 		 ipmmu_vmsa_iommu_of_setup);
+IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
+		 ipmmu_vmsa_iommu_of_setup);
 #endif
 
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
