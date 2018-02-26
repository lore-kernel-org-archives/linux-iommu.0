From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH 6/8] iommu/ipmmu-vmsa: Hook up R8A77965 DT matching code
Date: Mon, 26 Feb 2018 18:57:14 +0100
Message-ID: <1519667836-31330-7-git-send-email-jacopo+renesas@jmondi.org>
References: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: geert@linux-m68k.org, horms@verge.net.au, sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Add support for R-Car M3-N (R8A77965) SoC IPMMUs.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/iommu/ipmmu-vmsa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 933a3da..6a0e714 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -763,6 +763,7 @@ static bool ipmmu_slave_whitelist(struct device *dev)
 static const struct soc_device_attribute soc_rcar_gen3[] = {
 	{ .soc_id = "r8a7795", },
 	{ .soc_id = "r8a7796", },
+	{ .soc_id = "r8a77965", },
 	{ .soc_id = "r8a77970", },
 	{ .soc_id = "r8a77995", },
 	{ /* sentinel */ }
@@ -945,6 +946,9 @@ static const struct of_device_id ipmmu_of_ids[] = {
 		.compatible = "renesas,ipmmu-r8a7796",
 		.data = &ipmmu_features_rcar_gen3,
 	}, {
+		.compatible = "renesas,ipmmu-r8a77965",
+		.data = &ipmmu_features_rcar_gen3,
+	}, {
 		.compatible = "renesas,ipmmu-r8a77970",
 		.data = &ipmmu_features_rcar_gen3,
 	}, {
@@ -1127,6 +1131,7 @@ module_exit(ipmmu_exit);
 IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa");
 IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795");
 IOMMU_OF_DECLARE(ipmmu_r8a7796_iommu_of, "renesas,ipmmu-r8a7796");
+IOMMU_OF_DECLARE(ipmmu_r8a77965_iommu_of, "renesas,ipmmu-r8a77965");
 IOMMU_OF_DECLARE(ipmmu_r8a77970_iommu_of, "renesas,ipmmu-r8a77970");
 IOMMU_OF_DECLARE(ipmmu_r8a77995_iommu_of, "renesas,ipmmu-r8a77995");
 
-- 
2.7.4
