Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C99C433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 00:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C82D40504;
	Tue,  8 Feb 2022 00:20:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9svUVo7RsXeT; Tue,  8 Feb 2022 00:20:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 40F3C40400;
	Tue,  8 Feb 2022 00:20:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19811C0011;
	Tue,  8 Feb 2022 00:20:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3875C0073
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 00:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7430A403C1
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 00:20:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dn3IXB-P7Jxi for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 00:20:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC84A403C8
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 00:20:38 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,351,1635174000"; d="scan'208";a="110545975"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 08 Feb 2022 09:20:36 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id B908B400A102;
 Tue,  8 Feb 2022 09:20:36 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: joro@8bytes.org,
	will@kernel.org,
	robh+dt@kernel.org
Subject: [PATCH v3 2/2] iommu/ipmmu-vmsa: Add support for R-Car Gen4
Date: Tue,  8 Feb 2022 09:20:30 +0900
Message-Id: <20220208002030.1319984-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208002030.1319984-1-yoshihiro.shimoda.uh@renesas.com>
References: <20220208002030.1319984-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, Geert Uytterhoeven <geert+renesas@glider.be>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add support for R-Car Gen4 like r8a779f0 (R-Car S4-8). The IPMMU
hardware design of r8a779f0 is the same as r8a779a0. So, rename
"r8a779a0" to "rcar_gen4".

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ca752bdc710f..0f7e975546e9 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -719,6 +719,7 @@ static int ipmmu_init_platform_device(struct device *dev,
 
 static const struct soc_device_attribute soc_needs_opt_in[] = {
 	{ .family = "R-Car Gen3", },
+	{ .family = "R-Car Gen4", },
 	{ .family = "RZ/G2", },
 	{ /* sentinel */ }
 };
@@ -743,7 +744,7 @@ static bool ipmmu_device_is_allowed(struct device *dev)
 	unsigned int i;
 
 	/*
-	 * R-Car Gen3 and RZ/G2 use the allow list to opt-in devices.
+	 * R-Car Gen3/4 and RZ/G2 use the allow list to opt-in devices.
 	 * For Other SoCs, this returns true anyway.
 	 */
 	if (!soc_device_match(soc_needs_opt_in))
@@ -926,7 +927,7 @@ static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
 	.utlb_offset_base = 0,
 };
 
-static const struct ipmmu_features ipmmu_features_r8a779a0 = {
+static const struct ipmmu_features ipmmu_features_rcar_gen4 = {
 	.use_ns_alias_offset = false,
 	.has_cache_leaf_nodes = true,
 	.number_of_contexts = 16,
@@ -982,7 +983,10 @@ static const struct of_device_id ipmmu_of_ids[] = {
 		.data = &ipmmu_features_rcar_gen3,
 	}, {
 		.compatible = "renesas,ipmmu-r8a779a0",
-		.data = &ipmmu_features_r8a779a0,
+		.data = &ipmmu_features_rcar_gen4,
+	}, {
+		.compatible = "renesas,rcar-gen4-ipmmu",
+		.data = &ipmmu_features_rcar_gen4,
 	}, {
 		/* Terminator */
 	},
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
