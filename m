From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH] iommu/ipmmu-vmsa: Hook up r8a774c0 DT matching code
Date: Thu, 13 Dec 2018 20:22:44 +0000
Message-ID: <1544732564-7185-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Support RZ/G2E (a.k.a. R8A774C0) IPMMU.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/iommu/ipmmu-vmsa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 32e572b..8074dec 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -757,6 +757,7 @@ static int ipmmu_init_platform_device(struct device *dev,
 
 static const struct soc_device_attribute soc_rcar_gen3[] = {
 	{ .soc_id = "r8a774a1", },
+	{ .soc_id = "r8a774c0", },
 	{ .soc_id = "r8a7795", },
 	{ .soc_id = "r8a7796", },
 	{ .soc_id = "r8a77965", },
@@ -767,6 +768,7 @@ static const struct soc_device_attribute soc_rcar_gen3[] = {
 };
 
 static const struct soc_device_attribute soc_rcar_gen3_whitelist[] = {
+	{ .soc_id = "r8a774c0", },
 	{ .soc_id = "r8a7795", .revision = "ES3.*" },
 	{ .soc_id = "r8a77965", },
 	{ .soc_id = "r8a77990", },
@@ -976,6 +978,9 @@ static const struct of_device_id ipmmu_of_ids[] = {
 		.compatible = "renesas,ipmmu-r8a774a1",
 		.data = &ipmmu_features_rcar_gen3,
 	}, {
+		.compatible = "renesas,ipmmu-r8a774c0",
+		.data = &ipmmu_features_rcar_gen3,
+	}, {
 		.compatible = "renesas,ipmmu-r8a7795",
 		.data = &ipmmu_features_rcar_gen3,
 	}, {
-- 
2.7.4
