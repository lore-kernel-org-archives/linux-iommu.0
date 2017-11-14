From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFT v5 2/3] iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
Date: Tue, 14 Nov 2017 09:34:50 +0100
Message-ID: <20171114083451.4052-3-horms+renesas@verge.net.au>
References: <20171114083451.4052-1-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171114083451.4052-1-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Magnus Damm <damm+renesas@opensource.se>
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Support the r8a7796 IPMMU by sharing feature flags between
r8a7795 and r8a7796. Also update IOMMU_OF_DECLARE to hook
up the updated compat string.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 286af358d8ce..f936f834984a 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -760,8 +760,9 @@ static bool ipmmu_slave_whitelist(struct device *dev)
 	return false;
 }
 
-static const struct soc_device_attribute soc_r8a7795[] = {
+static const struct soc_device_attribute soc_rcar_gen3[] = {
 	{ .soc_id = "r8a7795", },
+	{ .soc_id = "r8a7796", },
 	{ /* sentinel */ }
 };
 
@@ -769,7 +770,7 @@ static int ipmmu_of_xlate(struct device *dev,
 			  struct of_phandle_args *spec)
 {
 	/* For R-Car Gen3 use a white list to opt-in slave devices */
-	if (soc_device_match(soc_r8a7795) && !ipmmu_slave_whitelist(dev))
+	if (soc_device_match(soc_rcar_gen3) && !ipmmu_slave_whitelist(dev))
 		return -ENODEV;
 
 	iommu_fwspec_add_ids(dev, spec->args, 1);
@@ -923,7 +924,7 @@ static const struct ipmmu_features ipmmu_features_default = {
 	.twobit_imttbcr_sl0 = false,
 };
 
-static const struct ipmmu_features ipmmu_features_r8a7795 = {
+static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
 	.use_ns_alias_offset = false,
 	.has_cache_leaf_nodes = true,
 	.number_of_contexts = 8,
@@ -937,7 +938,10 @@ static const struct of_device_id ipmmu_of_ids[] = {
 		.data = &ipmmu_features_default,
 	}, {
 		.compatible = "renesas,ipmmu-r8a7795",
-		.data = &ipmmu_features_r8a7795,
+		.data = &ipmmu_features_rcar_gen3,
+	}, {
+		.compatible = "renesas,ipmmu-r8a7796",
+		.data = &ipmmu_features_rcar_gen3,
 	}, {
 		/* Terminator */
 	},
@@ -1123,6 +1127,8 @@ IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa",
 		 ipmmu_vmsa_iommu_of_setup);
 IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
 		 ipmmu_vmsa_iommu_of_setup);
+IOMMU_OF_DECLARE(ipmmu_r8a7796_iommu_of, "renesas,ipmmu-r8a7796",
+		 ipmmu_vmsa_iommu_of_setup);
 #endif
 
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
-- 
2.11.0
