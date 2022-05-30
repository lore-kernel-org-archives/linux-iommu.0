Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FDEC433FE
	for <iommu@archiver.kernel.org>; Mon, 30 May 2022 18:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD4E2611E9;
	Mon, 30 May 2022 18:04:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GGTH90MWaMSA; Mon, 30 May 2022 18:04:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AEF866119E;
	Mon, 30 May 2022 18:04:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C425C0039;
	Mon, 30 May 2022 18:04:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC3FBC002D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 18:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9F5340C58
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 18:04:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=baylibre-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iecVVx3xe0nU for <iommu@lists.linux-foundation.org>;
 Mon, 30 May 2022 18:04:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D703840AD5
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 18:04:01 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id k19so7490758wrd.8
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vmIAgX4stP7tbN1utudJdCwbmHGl9Wqirrw9D2YXhxA=;
 b=sj37xc3nASZ+YCXla39Pf94LuVNA1E3wbnpESKap4+mtZJkHFXPsMp7U6qzSqZUvSP
 Zkbt24QW2ES5ClbIchtBy19300ZLdqUNMSmmUTpB6UYympcjd01q1M0KrPM9xHbQ1Qxw
 GHrOPXCT+kGQ4dB/KttIVWVEUjPvL6qWZSfqcDa2MSh2XvY34u/O4j3wXJ/4xhzDGdS4
 KDD0P2RkI/tv81gLON3wHXZdLn5dCEoFpv7k5Jf/+ktP9RymmXCa2CHYVACXJiwm6ZVm
 HPCp8Ul/ru2dIS28/dji4srbNBakB6xMGNuUeH94i8RGl8OD1U0q+N7faTgqNzcaWwdG
 6aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vmIAgX4stP7tbN1utudJdCwbmHGl9Wqirrw9D2YXhxA=;
 b=BnnTuhsqG3DMxRN8dmxc03wWdaWQ5X+0DMirAAJMwQYvHujond1yDg99AcUg9p3mYX
 xHv3muMCYItCb7hCEp4SUwklpsOIJ4PiJmzgtbrDzjd9rfJv9MIK19KFDHAQDUdSXowL
 mUa3f0E1GNkvNRjn27TS6z9sFhxQTCWMk5VxKnbCTIEyAHzgxuFkd19RjO7y+O9HUyn/
 0Y6R8DqfdVO5S/jljVsVqsRUQfyqlmVtLh+5UT3r4JYAsIsd3jn9B4lJEFMD8nOpyOyB
 lRyBYFHLIHjuiBe5fcPgj0aEuSQsiZagapru7kW0nTaRxJZx2uLzZHG32+vteFxFMeNH
 dBEQ==
X-Gm-Message-State: AOAM531tCgujAX327vNFaAJiK5he3W/5jW1yKLtgS30GCUlYCDqIkfsy
 tXSAUti3aVenbT4MhqJemKO0pg==
X-Google-Smtp-Source: ABdhPJzbbLY65ueNfiMy634xwWX8GhshgQaMx9qx3BJ/rdkq+iVkOzEljqVwWPwdzKhOxGv1GHmSOg==
X-Received: by 2002:a05:6000:1247:b0:210:1f6c:b1cb with SMTP id
 j7-20020a056000124700b002101f6cb1cbmr12912728wrx.709.1653933839926; 
 Mon, 30 May 2022 11:03:59 -0700 (PDT)
Received: from helium.lan ([88.160.162.107]) by smtp.gmail.com with ESMTPSA id
 9-20020a1c0209000000b00397550b387bsm1647wmc.23.2022.05.30.11.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 May 2022 11:03:59 -0700 (PDT)
From: Fabien Parent <fparent@baylibre.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 3/3] iommu: mtk_iommu: add support for MT8365 SoC
Date: Mon, 30 May 2022 20:03:28 +0200
Message-Id: <20220530180328.845692-3-fparent@baylibre.com>
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

Add IOMMU support for MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 11 +++++++++++
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b692347d8d56..039b8f9d5022 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1093,6 +1093,16 @@ static const struct mtk_iommu_plat_data mt8192_data = {
 	.port_width     = 5,
 };
 
+static const struct mtk_iommu_plat_data mt8365_data = {
+	.m4u_plat     = M4U_MT8365,
+	.flags	      = RESET_AXI,
+	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.iova_region  = single_domain,
+	.iova_region_nr = ARRAY_SIZE(single_domain),
+	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
+	.port_width   = 6,
+};
+
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
@@ -1100,6 +1110,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
+	{ .compatible = "mediatek,mt8365-m4u", .data = &mt8365_data},
 	{}
 };
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 84cecaf6d61c..cb174fa6f2ab 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -46,6 +46,7 @@ enum mtk_iommu_plat {
 	M4U_MT8173,
 	M4U_MT8183,
 	M4U_MT8192,
+	M4U_MT8365,
 };
 
 struct mtk_iommu_iova_region;
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
