Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB403C4332F
	for <iommu@archiver.kernel.org>; Mon, 30 May 2022 18:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CD4641B8A;
	Mon, 30 May 2022 18:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9s-mAATn-stO; Mon, 30 May 2022 18:04:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B94BA41B87;
	Mon, 30 May 2022 18:04:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4476DC0082;
	Mon, 30 May 2022 18:04:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05171C002D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 18:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1EAB83EFF
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 18:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=baylibre-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fBOtPUZYZNEY for <iommu@lists.linux-foundation.org>;
 Mon, 30 May 2022 18:04:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE9FA83EE3
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 18:03:59 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id o9so6862347wmd.0
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 11:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZmgLvUIbxgbpdB2bdHpHdShKYYvDRAzse8YTxTcYmlw=;
 b=NfEC1OIXJEz3OYJ6J87rT9rzJ1mbZNB0gKkeP3tMJSIX/sM8LGt31DrleZc5+pOgwE
 5KAoev3tGKNxqP5IHJYqti6jxR1OasqD8F/XhjuE0JmwxCEbgqDtNRsL7DZ6vZyKNcFW
 f+lKaiQkrlyWUQYfWiftdcvKoxFeEORW0pgsLIwrwyAz5uyPtgy4gLAP8iMtiZrM2wtR
 zwdy/TO0g+G0huyLhlqJR2uz4v8437twjVazYvtTO00cfSnBdq9Wka9kZqoGpgmn0LbO
 k33+uKtOndBl3UlThJThhtyxMA++fkVMajtvMiS3bXy0WlGB5T4wYUHVgz76hnEXzJxf
 pm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZmgLvUIbxgbpdB2bdHpHdShKYYvDRAzse8YTxTcYmlw=;
 b=6ziFrAQiC72WoTaJBZTS6fXRC/PROrb1DfXon1ZUuuOsCbp35NEj8Y+/od2iaozDNg
 PvhZIRriwuUZW2oP9rzYtUVzWmUFCOqbTwM7hQYU+dFWXYo78stz4bFLMepPi+341xrK
 t4zKST3WB8MVIhGHPHEHPSkcATkUoHRKIli+QwQ/ZrZPMNULVs7gurVMBU3t4D5ssTga
 MR0raQUn1uz/eEAA1ExXtUufwJME73cHwqtATGnDgwmugXStKblaxDeQow9CCWBt7elg
 W+6OJcsS7f4+x9LO7EpNV+o2cQKwINZe7aMfXFeKMuzsUeCBJoSsZKcIvzN1ZKsmjagV
 vOoQ==
X-Gm-Message-State: AOAM531372QVtdBf348OTxxg95lq31+S/Q3b3eghn/rJkZfLKifU4cbc
 TeGZnl5eicrsOBfWTKZVVM/cWw==
X-Google-Smtp-Source: ABdhPJy3TpSKfEh0yxmuTCQYqERubX5Qj/lcKQ/awW7gRS0/MmJIqd0Xb3r8aUJ1ih0s8IO0W9TpgA==
X-Received: by 2002:a1c:4443:0:b0:397:38a7:30 with SMTP id
 r64-20020a1c4443000000b0039738a70030mr19773587wma.14.1653933838195; 
 Mon, 30 May 2022 11:03:58 -0700 (PDT)
Received: from helium.lan ([88.160.162.107]) by smtp.gmail.com with ESMTPSA id
 9-20020a1c0209000000b00397550b387bsm1647wmc.23.2022.05.30.11.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 May 2022 11:03:57 -0700 (PDT)
From: Fabien Parent <fparent@baylibre.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 2/3] iommu: mtk_iommu: add support for 6-bit encoded port IDs
Date: Mon, 30 May 2022 20:03:27 +0200
Message-Id: <20220530180328.845692-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530180328.845692-1-fparent@baylibre.com>
References: <20220530180328.845692-1-fparent@baylibre.com>
MIME-Version: 1.0
Cc: Fabien Parent <fparent@baylibre.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Until now the port ID was always encoded as a 5-bit data. On MT8365,
the port ID is encoded as a 6-bit data. This requires to rework the
macros F_MMU_INT_ID_LARB_ID, and F_MMU_INT_ID_PORT_ID in order
to support 5-bit and 6-bit encoded port IDs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 17 +++++++++++++----
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6fd75a60abd6..b692347d8d56 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -103,8 +103,10 @@
 #define REG_MMU1_INT_ID				0x154
 #define F_MMU_INT_ID_COMM_ID(a)			(((a) >> 9) & 0x7)
 #define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
-#define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
-#define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
+#define F_MMU_INT_ID_LARB_ID(a, port_width)	\
+				((a) >> ((port_width + 2) & 0x7))
+#define F_MMU_INT_ID_PORT_ID(a, port_width)	\
+				(((a) >> 2) & GENMASK(port_width - 1, 0))
 
 #define MTK_PROTECT_PA_ALIGN			256
 
@@ -291,12 +293,13 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 		fault_pa |= (u64)pa34_32 << 32;
 	}
 
-	fault_port = F_MMU_INT_ID_PORT_ID(regval);
+	fault_port = F_MMU_INT_ID_PORT_ID(regval, data->plat_data->port_width);
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM)) {
 		fault_larb = F_MMU_INT_ID_COMM_ID(regval);
 		sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
 	} else {
-		fault_larb = F_MMU_INT_ID_LARB_ID(regval);
+		fault_larb = F_MMU_INT_ID_LARB_ID(regval,
+						  data->plat_data->port_width);
 	}
 	fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 
@@ -1034,6 +1037,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
+	.port_width   = 5,
 };
 
 static const struct mtk_iommu_plat_data mt6779_data = {
@@ -1043,6 +1047,7 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 	.iova_region   = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
+	.port_width    = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8167_data = {
@@ -1052,6 +1057,7 @@ static const struct mtk_iommu_plat_data mt8167_data = {
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}}, /* Linear mapping. */
+	.port_width   = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8173_data = {
@@ -1062,6 +1068,7 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
+	.port_width   = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8183_data = {
@@ -1071,6 +1078,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
+	.port_width   = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8192_data = {
@@ -1082,6 +1090,7 @@ static const struct mtk_iommu_plat_data mt8192_data = {
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
 	.larbid_remap   = {{0}, {1}, {4, 5}, {7}, {2}, {9, 11, 19, 20},
 			   {0, 14, 16}, {0, 13, 18, 17}},
+	.port_width     = 5,
 };
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index b742432220c5..84cecaf6d61c 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -54,6 +54,7 @@ struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat m4u_plat;
 	u32                 flags;
 	u32                 inv_sel_reg;
+	u8                  port_width;
 
 	unsigned int				iova_region_nr;
 	const struct mtk_iommu_iova_region	*iova_region;
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
