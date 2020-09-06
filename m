Return-Path: <SRS0=6KmI=CP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B709BC433E2
	for <iommu@archiver.kernel.org>; Sun,  6 Sep 2020 15:26:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303C52075A
	for <iommu@archiver.kernel.org>; Sun,  6 Sep 2020 15:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SX4GDYqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303C52075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EA4938608B;
	Sun,  6 Sep 2020 15:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TeVhtP42n87b; Sun,  6 Sep 2020 15:26:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 781E686678;
	Sun,  6 Sep 2020 15:26:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 631E9C0052;
	Sun,  6 Sep 2020 15:26:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5464C0051
 for <iommu@lists.linux-foundation.org>; Sun,  6 Sep 2020 15:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C0FD0203CC
 for <iommu@lists.linux-foundation.org>; Sun,  6 Sep 2020 15:26:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EsPQlanIaZ3q for <iommu@lists.linux-foundation.org>;
 Sun,  6 Sep 2020 15:26:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 42BCB203A2
 for <iommu@lists.linux-foundation.org>; Sun,  6 Sep 2020 15:26:10 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id w2so11022730wmi.1
 for <iommu@lists.linux-foundation.org>; Sun, 06 Sep 2020 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uHlPaejxaoEdhUtjcAkbEk5MwemH61sGbulo7nTGaVI=;
 b=SX4GDYqTPOGWjEBwAPJ+63c5XJ+ugOUtKfk2l97qxzdS2k0Gs3m/RL1RxgLIqb9BGI
 GJzExp+fn4OA+P/b5Kx45NWqujGTB+EFHnJLjWDAsCu5e9IAyZe5RTNQSeCuXK1iGUBg
 ViS+LLN/xduUf/moO8/9B9eaCe2k/rBPGM05InBZDCSiKeQiJJgeD5+Wd7nRJfvpJl3D
 rseB2sAArVCsO6cAhTtEUqykbhjl/MSC3j2sngJ0x8bc5ATvxhvVw41dNoxye+lbXAZg
 zDoeVjmXF3eC9s4u20sPCwq2i26V0JPWhbcBJaBEQi1yTJcqExo3/h/EsPvOUeklCzVx
 +XvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uHlPaejxaoEdhUtjcAkbEk5MwemH61sGbulo7nTGaVI=;
 b=TsGl5B/Gqr7C603SpuGSC82GmjCyaentW1X11lwgs9Yn/3S+ThOlJNc8ZO/fVn/kRv
 YqhP9RIM2PfzgCDcMQDJStSxnRkdd5J6Vvpwejj7lnvlxX+DWTmT+GKtGmTlXkU10sp+
 UCF15ZTA9CGPSoKDxgUcrJ3Ug3VLmDqcoRFRLK2q1fIHuRPGXA0czZI3/d94wdOO9uvu
 QrHzyWxqZ9CfUOsMdrnrNgHUIWr3CpjP21lrWL8uGJzEQOEC2GhMLqEwHNwk4HswzUTs
 9ZK5Jc5othL+hTexH9cGBMQj2AUSHmVXYu+Dg07i8BfyX+uIMWHfDNAlRq66WpNKwJ/x
 9B9Q==
X-Gm-Message-State: AOAM533AA2r9ncgbxoWtWHqMFFHLnW9xbc54LCb+i4aKKps/vV/EZUC+
 wKDZcDwDU2D2YAXnc2C/gcsuDOnrGoNWuQ==
X-Google-Smtp-Source: ABdhPJxTiP5W3hXf0jIMlYDRBifFpSbd8PfKRCSzquyfrJqE89SWeJ2IDFhFHf02RC+vrWN02y3xIw==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr16979046wmb.25.1599405575412; 
 Sun, 06 Sep 2020 08:19:35 -0700 (PDT)
Received: from localhost.localdomain (208.19.23.93.rev.sfr.net. [93.23.19.208])
 by smtp.gmail.com with ESMTPSA id a15sm26420646wrn.3.2020.09.06.08.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 08:19:34 -0700 (PDT)
From: Fabien Parent <fparent@baylibre.com>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/3] iommu/mediatek: add flag for legacy ivrp paddr
Date: Sun,  6 Sep 2020 17:19:27 +0200
Message-Id: <20200906151928.881209-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906151928.881209-1-fparent@baylibre.com>
References: <20200906151928.881209-1-fparent@baylibre.com>
MIME-Version: 1.0
Cc: matthias.bgg@gmail.com, Fabien Parent <fparent@baylibre.com>,
 robh+dt@kernel.org
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

Add a new flag in order to select which IVRP_PADDR format is used
by an SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

v3: set LEGACY_IVRP_PADDR as a flag instead of platform data
v2: new patch

---
 drivers/iommu/mtk_iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 785b228d39a6..b1f85a7e9346 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -116,6 +116,7 @@
 #define OUT_ORDER_WR_EN			BIT(4)
 #define HAS_SUB_COMM			BIT(5)
 #define WR_THROT_EN			BIT(6)
+#define HAS_LEGACY_IVRP_PADDR		BIT(7)
 
 #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
 		((((pdata)->flags) & (_x)) == (_x))
@@ -582,7 +583,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
 	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
 
-	if (data->plat_data->m4u_plat == M4U_MT8173)
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_LEGACY_IVRP_PADDR))
 		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
 	else
 		regval = lower_32_bits(data->protect_base) |
@@ -818,7 +819,8 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
-	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI,
+	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
+			HAS_LEGACY_IVRP_PADDR,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
 };
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
