Return-Path: <SRS0=whWg=N5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AFBC4321E
	for <iommu@archiver.kernel.org>; Tue,  7 Sep 2021 08:30:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B15610FF
	for <iommu@archiver.kernel.org>; Tue,  7 Sep 2021 08:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 91B15610FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5163D828A5;
	Tue,  7 Sep 2021 08:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bAsXeMVdsGS1; Tue,  7 Sep 2021 08:30:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3D45282881;
	Tue,  7 Sep 2021 08:30:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 224D1C0011;
	Tue,  7 Sep 2021 08:30:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A1E0C000D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 08:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24688605E8
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 08:30:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Emv_jRGF8H69 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 08:30:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17EAF605BF
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 08:30:41 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.85,274,1624287600"; d="scan'208";a="93151329"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 07 Sep 2021 17:30:40 +0900
Received: from localhost.localdomain (unknown [10.166.14.185])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9A0EF400D0FA;
 Tue,  7 Sep 2021 17:30:40 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: joro@8bytes.org,
	will@kernel.org,
	robh+dt@kernel.org
Subject: [PATCH v2 2/2] iommu/ipmmu-vmsa: Add support for r8a779a0
Date: Tue,  7 Sep 2021 17:30:20 +0900
Message-Id: <20210907083020.907648-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907083020.907648-1-yoshihiro.shimoda.uh@renesas.com>
References: <20210907083020.907648-1-yoshihiro.shimoda.uh@renesas.com>
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

Add support for r8a779a0 (R-Car V3U). The IPMMU hardware design
of this SoC differs than others. So, add a new ipmmu_features for it.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index d38ff29a76e8..d8fe5ba0cb23 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -33,10 +33,10 @@
 #define arm_iommu_detach_device(...)	do {} while (0)
 #endif
 
-#define IPMMU_CTX_MAX		8U
+#define IPMMU_CTX_MAX		16U
 #define IPMMU_CTX_INVALID	-1
 
-#define IPMMU_UTLB_MAX		48U
+#define IPMMU_UTLB_MAX		64U
 
 struct ipmmu_features {
 	bool use_ns_alias_offset;
@@ -189,8 +189,12 @@ static void ipmmu_write(struct ipmmu_vmsa_device *mmu, unsigned int offset,
 static unsigned int ipmmu_ctx_reg(struct ipmmu_vmsa_device *mmu,
 				  unsigned int context_id, unsigned int reg)
 {
-	return mmu->features->ctx_offset_base +
-	       context_id * mmu->features->ctx_offset_stride + reg;
+	unsigned int base = mmu->features->ctx_offset_base;
+
+	if (context_id > 7)
+		base += 0x800 - 8 * 0x40;
+
+	return base + context_id * mmu->features->ctx_offset_stride + reg;
 }
 
 static u32 ipmmu_ctx_read(struct ipmmu_vmsa_device *mmu,
@@ -922,6 +926,20 @@ static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
 	.utlb_offset_base = 0,
 };
 
+static const struct ipmmu_features ipmmu_features_r8a779a0 = {
+	.use_ns_alias_offset = false,
+	.has_cache_leaf_nodes = true,
+	.number_of_contexts = 16,
+	.num_utlbs = 64,
+	.setup_imbuscr = false,
+	.twobit_imttbcr_sl0 = true,
+	.reserved_context = true,
+	.cache_snoop = false,
+	.ctx_offset_base = 0x10000,
+	.ctx_offset_stride = 0x1040,
+	.utlb_offset_base = 0x3000,
+};
+
 static const struct of_device_id ipmmu_of_ids[] = {
 	{
 		.compatible = "renesas,ipmmu-vmsa",
@@ -959,6 +977,9 @@ static const struct of_device_id ipmmu_of_ids[] = {
 	}, {
 		.compatible = "renesas,ipmmu-r8a77995",
 		.data = &ipmmu_features_rcar_gen3,
+	}, {
+		.compatible = "renesas,ipmmu-r8a779a0",
+		.data = &ipmmu_features_r8a779a0,
 	}, {
 		/* Terminator */
 	},
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
