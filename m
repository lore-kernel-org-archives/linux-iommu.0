Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260ADC2BB84
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 10:17:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9969207C3
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 10:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VxIbSxKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9969207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4B7C086F5E;
	Mon,  7 Sep 2020 10:17:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MJdSjl7lv7eb; Mon,  7 Sep 2020 10:17:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D6C30870F6;
	Mon,  7 Sep 2020 10:17:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2BB9C0052;
	Mon,  7 Sep 2020 10:17:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21BFCC0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 10:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0CECA86749
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 10:17:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ntyPZkNpgUz for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 10:17:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 58DBE86746
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 10:17:00 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id c18so15177314wrm.9
 for <iommu@lists.linux-foundation.org>; Mon, 07 Sep 2020 03:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a6r4qRpyiPjYoazUXrGcYGUllitYhB0RC4eGKhazF9E=;
 b=VxIbSxKhSrWc+F+oc18qEnTOaZd41KDrz5frjSOA/RXEGtv8Rkpmq3MmHG5a3Ke2/6
 qxO6UBZoWo74fLIBwgG12aBOvgWUFfo+dNHTaPST+7WpVEmKjhtqw/e7onJ5yiYoZR+Y
 oLzYytplhw+JUDu4TMDVxz59bsx5yUvNQUFh+wCbrAJs8wNSMSP0ADg5yqkMd/JHk4NW
 BT3MePh7FTSUT6DSBOvFRKhkY+G2S7YrM03g0hceBVZoyA8kGvIzPEyGKygq9Rx3jfEG
 tIZjBwOwQonMxWYr9Y5d4Lb5cNx7LfNmZVGq7BWtx05JuotJ7L7ctpDHxGMa789PGlXA
 TV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a6r4qRpyiPjYoazUXrGcYGUllitYhB0RC4eGKhazF9E=;
 b=asu9AQoy0WS9e52Am9AFH5lOxsOKH4SzxCP9Q0Ro/xKufMjOThISKiZjRynpXt9sFl
 7jtz0OAHL0yu5A0MOE+/wUSYwwRZaYKhy4IQy7jQEXnvBUvD4zE7IeHVzujj3AKXQSNA
 g5cUJj0FtZm9goL6cXj7lxRB4rN0X8nl8g/EvuVP2C6qGFBYv4YMS6K8D757qe+x7HxS
 zjIMenVRMN3WcpeDTfbUC1YqLzPwh40XVZZsHRWdTPWP5PqWbjzQKShCIAWI58DuofWV
 zoUPwLf/FP6it22W1yDFIA9coRyqrTiHflEcXAWC9zy/Fn8q8s8B6k+B4mKPUJIjPuuM
 Gwpw==
X-Gm-Message-State: AOAM531v3E2j3/Qi7j7RuCqgKLVXpKNeAFoRks0V5O6Jrfa7XBOlVEgV
 wIsXWO3mfkEhnTt8KEtgCsQVQCLq2I9STw==
X-Google-Smtp-Source: ABdhPJx2mHI+LxUYgnUtc5wgXC9XjqJnZvPO9JK3D0PlntFtIsdK2B0n8vwCwkckPL2XhfzljaycXw==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr22515101wrm.229.1599473818648; 
 Mon, 07 Sep 2020 03:16:58 -0700 (PDT)
Received: from localhost.localdomain (122.105.23.93.rev.sfr.net.
 [93.23.105.122])
 by smtp.gmail.com with ESMTPSA id j7sm28728689wrw.35.2020.09.07.03.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 03:16:58 -0700 (PDT)
From: Fabien Parent <fparent@baylibre.com>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH v4 2/3] iommu/mediatek: add flag for legacy ivrp paddr
Date: Mon,  7 Sep 2020 12:16:48 +0200
Message-Id: <20200907101649.1573134-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907101649.1573134-1-fparent@baylibre.com>
References: <20200907101649.1573134-1-fparent@baylibre.com>
MIME-Version: 1.0
Cc: Fabien Parent <fparent@baylibre.com>, miles.chen@mediatek.com,
 robh+dt@kernel.org, matthias.bgg@gmail.com
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
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
---

v4: no change
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
