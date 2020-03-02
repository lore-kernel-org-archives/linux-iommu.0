Return-Path: <SRS0=ZrTS=4T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0E2C3F2D2
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 11:22:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F83021775
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 11:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HrqcWs/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F83021775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 01B95854B3;
	Mon,  2 Mar 2020 11:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PsFiSgWmh3gs; Mon,  2 Mar 2020 11:22:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 80D4C84D16;
	Mon,  2 Mar 2020 11:22:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CF5DC07FE;
	Mon,  2 Mar 2020 11:22:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92A75C013E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 11:22:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8E099850EA
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 11:22:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ivWgdcjrKo6O for <iommu@lists.linux-foundation.org>;
 Mon,  2 Mar 2020 11:22:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BF788850E1
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 11:22:21 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id e10so10640810wrr.10
 for <iommu@lists.linux-foundation.org>; Mon, 02 Mar 2020 03:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4twAZzpqE7OZHthVARi42fhoM9wMIzUTa1b3XIbc4u0=;
 b=HrqcWs/tM1UMeqgqQDpvy3jpqRSAaC9KOUedVpPAAvQXG3RKGJEGAKffHVNPColesQ
 XmJC8gVr91n0yVRfBh5hJIgxN9YGBInf8dxyQV9MOR+vauyVfx/rs1trGy5WKr+ppnSY
 xPNcptl/HEFg1e2S8eAWVFv4Q5y9PVMn9NqIV3MYzpRlBTcz8yFMsOTa1HGbIGY1K7Gt
 GsFLln6giCDJ1dDj49uhcLCoEnMDB4qd9U0rI0iX9KSIwHGJNAc03zON9tAvUnNuiZdQ
 xeZEus/ihesqcBQ/4+ERXw6UkZGG0pE7kquuOyrm+1jE6cQq8pWiEkXWYx+nD0T4SWzN
 oCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4twAZzpqE7OZHthVARi42fhoM9wMIzUTa1b3XIbc4u0=;
 b=SFXDnq44L5Wka42Opx005Bew8s8dMZxKFzsJDRR6cyxtYppLN8UUtIanKg0dDEK+Gb
 VDQd9IeG2Wn8Bpl5c2g3V3XfyGT8tPvpBzE3jvR31xyOSwh4RGQ+b62TY4SIEjsQY2tR
 pSjqUMpO/Pi82PU4KUHssUER5xeqjPTgmJwNGskc7/yF/U8qknbK1c1EZQF/JuS74y81
 WBWS2SgxrBFVBPjuuzJMiOoDa7ba58oMy/sspYH8voxC64Ys2Hb8muzVJElW68IsvCyk
 UA606nFoiv5/XjFvEHaHxq0Va/NOfhkEbvfYFk+powBZD1OsJDKxVUbK3rQk+3q4FSSb
 CoFQ==
X-Gm-Message-State: APjAAAW+hZ1LYvpm+z5OQ2yn6dn4ckYomdW04AYwGnMdV25BwKbmz1fV
 hyk6PUxo1hsJp9B9JDnU3KNXKQ==
X-Google-Smtp-Source: APXvYqwoftzxlJ69VQL0xqAKsfOX0Z+thgz1rFA+uNAT/dQGnLIN+PHomnMXJLjLb67L3CQ3sbGx9g==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr21399020wrn.209.1583148140211; 
 Mon, 02 Mar 2020 03:22:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ecba:5540:6f5c:582a:cc84:32f5])
 by smtp.gmail.com with ESMTPSA id j14sm28398441wrn.32.2020.03.02.03.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 03:22:19 -0800 (PST)
From: Fabien Parent <fparent@baylibre.com>
To: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v2 2/3] iommu/mediatek: add pdata member for legacy ivrp paddr
Date: Mon,  2 Mar 2020 12:21:51 +0100
Message-Id: <20200302112152.2887131-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200302112152.2887131-1-fparent@baylibre.com>
References: <20200302112152.2887131-1-fparent@baylibre.com>
MIME-Version: 1.0
Cc: matthias.bgg@gmail.com, ck.hu@mediatek.com,
 Fabien Parent <fparent@baylibre.com>
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

Add a new platform data member in order to select which IVRP_PADDR
format is used by an SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

v2: new patch

---
 drivers/iommu/mtk_iommu.c | 3 ++-
 drivers/iommu/mtk_iommu.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 95945f467c03..78cb14ab7dd0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -569,7 +569,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
 	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
 
-	if (data->plat_data->m4u_plat == M4U_MT8173)
+	if (data->plat_data->has_legacy_ivrp_paddr)
 		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
 	else
 		regval = lower_32_bits(data->protect_base) |
@@ -786,6 +786,7 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.has_4gb_mode = true,
 	.has_bclk     = true,
+	.has_legacy_ivrp_paddr = true;
 	.reset_axi    = true,
 	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
 };
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index ea949a324e33..4696ba027a71 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -42,6 +42,7 @@ struct mtk_iommu_plat_data {
 	bool                has_bclk;
 	bool                has_vld_pa_rng;
 	bool                reset_axi;
+	bool                has_legacy_ivrp_paddr;
 	unsigned char       larbid_remap[MTK_LARB_NR_MAX];
 };
 
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
