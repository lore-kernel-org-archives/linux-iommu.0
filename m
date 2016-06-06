From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v2 11/11] iommu/ipmmu-vmsa: Hook up r8a7795 DT matching code
Date: Mon, 06 Jun 2016 12:59:07 +0900
Message-ID: <20160606035907.31763.20748.sendpatchset@little-apple>
References: <20160606035723.31763.66500.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160606035723.31763.66500.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Tie in r8a7795 features and update the IOMMU_OF_DECLARE
compat string to hook up the updated compat string.

TODO:
 - Go over init order once more
 - Consider counting number of IPMMU devices from ->xlate()
 - Experiment with delaying call to bus_set_iommu()

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - Enable multi context feature
 - Update TODO list

 drivers/iommu/ipmmu-vmsa.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- 0027/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2016-06-06 11:13:33.220607110 +0900
@@ -1074,11 +1074,22 @@ static const struct ipmmu_features ipmmu
 	.twobit_imttbcr_sl0 = false,
 };
 
+static const struct ipmmu_features ipmmu_features_r8a7795 = {
+	.use_ns_alias_offset = false,
+	.has_cache_leaf_nodes = true,
+	.has_eight_ctx = true,
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
@@ -1255,6 +1266,8 @@ static int __init ipmmu_vmsa_iommu_of_se
 
 IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa",
 		 ipmmu_vmsa_iommu_of_setup);
+IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
+		 ipmmu_vmsa_iommu_of_setup);
 #endif
 
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
