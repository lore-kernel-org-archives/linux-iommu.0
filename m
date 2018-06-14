From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [RESEND 3/6] iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code
Date: Thu, 14 Jun 2018 12:48:23 +0200
Message-ID: <1528973306-7962-4-git-send-email-jacopo+renesas@jmondi.org>
References: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com, joro@8bytes.org
Cc: linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jacopo Mondi <jacopo+renesas@jmondi.org>
List-Id: iommu@lists.linux-foundation.org

From: Simon Horman <horms+renesas@verge.net.au>

Support the r8a77970 (R-Car V3M) and r8a77995 (R-Car D3) IPMMUs by sharing
feature flags with r8a7795 (R-Car H3) and r8a7796 (R-Car M3-W). Also update
IOMMU_OF_DECLARE to hook up the compat strings.

Based on work for the r8a7796 by Magnus Damm

[rebased on v4.17]
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 04c8015..933a3da 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -763,6 +763,8 @@ static bool ipmmu_slave_whitelist(struct device *dev)
 static const struct soc_device_attribute soc_rcar_gen3[] = {
 	{ .soc_id = "r8a7795", },
 	{ .soc_id = "r8a7796", },
+	{ .soc_id = "r8a77970", },
+	{ .soc_id = "r8a77995", },
 	{ /* sentinel */ }
 };
 
@@ -943,6 +945,12 @@ static const struct of_device_id ipmmu_of_ids[] = {
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
@@ -1119,6 +1127,8 @@ module_exit(ipmmu_exit);
 IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa");
 IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795");
 IOMMU_OF_DECLARE(ipmmu_r8a7796_iommu_of, "renesas,ipmmu-r8a7796");
+IOMMU_OF_DECLARE(ipmmu_r8a77970_iommu_of, "renesas,ipmmu-r8a77970");
+IOMMU_OF_DECLARE(ipmmu_r8a77995_iommu_of, "renesas,ipmmu-r8a77995");
 
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
 MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
-- 
2.7.4
