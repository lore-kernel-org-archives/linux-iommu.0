From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 3/3] iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
Date: Tue, 07 Jun 2016 12:39:45 +0900
Message-ID: <20160607033945.28687.70956.sendpatchset@little-apple>
References: <20160607033918.28687.98260.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160607033918.28687.98260.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Support the r8a7796 IPMMU by sharing feature flags between
r8a7795 and r8a7796. Also update IOMMU_OF_DECLARE to hook
up the updated compat string.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/ipmmu-vmsa.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- 0031/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2016-06-06 11:19:40.210607110 +0900
@@ -1074,7 +1074,7 @@ static const struct ipmmu_features ipmmu
 	.twobit_imttbcr_sl0 = false,
 };
 
-static const struct ipmmu_features ipmmu_features_r8a7795 = {
+static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
 	.use_ns_alias_offset = false,
 	.has_cache_leaf_nodes = true,
 	.has_eight_ctx = true,
@@ -1088,7 +1088,10 @@ static const struct of_device_id ipmmu_o
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
@@ -1268,6 +1271,8 @@ IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "r
 		 ipmmu_vmsa_iommu_of_setup);
 IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
 		 ipmmu_vmsa_iommu_of_setup);
+IOMMU_OF_DECLARE(ipmmu_r8a7796_iommu_of, "renesas,ipmmu-r8a7796",
+		 ipmmu_vmsa_iommu_of_setup);
 #endif
 
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
