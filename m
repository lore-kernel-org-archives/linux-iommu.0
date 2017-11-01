From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 2/2] iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code
Date: Wed,  1 Nov 2017 11:34:23 +0100
Message-ID: <20171101103423.7334-3-horms+renesas@verge.net.au>
References: <20171101103423.7334-1-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171101103423.7334-1-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

Support the r8a77970 (R-Car V3M) and r8a77995 (R-Car D3) IPMMUs by sharing
feature flags with r8a7795 (R-Car H3) and r8a7796 (R-Car M3-W). Also update
IOMMU_OF_DECLARE to hook up the compat strings.

Based on work for the r8a7796 by Magnus Damm

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/iommu/ipmmu-vmsa.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 02989bb060cc..c22520a453ff 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -749,6 +749,8 @@ static bool ipmmu_slave_whitelist(struct device *dev)
 static const struct soc_device_attribute soc_rcar_gen3[] = {
 	{ .soc_id = "r8a7795", },
 	{ .soc_id = "r8a7796", },
+	{ .soc_id = "r8a77970", },
+	{ .soc_id = "r8a77995", },
 	{ /* sentinel */ }
 };
 
@@ -1036,6 +1038,12 @@ static const struct of_device_id ipmmu_of_ids[] = {
 		.compatible = "renesas,ipmmu-r8a7796",
 		.data = &ipmmu_features_rcar_gen3,
 	}, {
+		.compatible = "renesas,ipmmu-r8a77970",
+		.data = &ipmmu_features_rcar_gen3,
+	}, {
+		.compatible = "renesas,ipmmu-r8a77995",
+		.data = &ipmmu_features_rcar_gen3,
+	}, {
 		/* Terminator */
 	},
 };
@@ -1224,6 +1232,10 @@ IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
 		 ipmmu_vmsa_iommu_of_setup);
 IOMMU_OF_DECLARE(ipmmu_r8a7796_iommu_of, "renesas,ipmmu-r8a7796",
 		 ipmmu_vmsa_iommu_of_setup);
+IOMMU_OF_DECLARE(ipmmu_r8a77970_iommu_of, "renesas,ipmmu-r8a77970",
+		 ipmmu_vmsa_iommu_of_setup);
+IOMMU_OF_DECLARE(ipmmu_r8a77995_iommu_of, "renesas,ipmmu-r8a77995",
+		 ipmmu_vmsa_iommu_of_setup);
 #endif
 
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
-- 
2.11.0
