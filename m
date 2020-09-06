Return-Path: <SRS0=6KmI=CP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28528C433E2
	for <iommu@archiver.kernel.org>; Sun,  6 Sep 2020 15:25:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C5E2075A
	for <iommu@archiver.kernel.org>; Sun,  6 Sep 2020 15:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OyUETwoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C5E2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0E93A8666B;
	Sun,  6 Sep 2020 15:25:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QVD13IF26Vrl; Sun,  6 Sep 2020 15:25:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3762C8666C;
	Sun,  6 Sep 2020 15:25:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03F84C0052;
	Sun,  6 Sep 2020 15:25:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA65BC0051
 for <iommu@lists.linux-foundation.org>; Sun,  6 Sep 2020 15:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C0C3285A74
 for <iommu@lists.linux-foundation.org>; Sun,  6 Sep 2020 15:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TPlwVENf7Z1n for <iommu@lists.linux-foundation.org>;
 Sun,  6 Sep 2020 15:25:00 +0000 (UTC)
X-Greylist: delayed 00:05:23 by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0F2548598E
 for <iommu@lists.linux-foundation.org>; Sun,  6 Sep 2020 15:25:00 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id x23so1093917wmi.3
 for <iommu@lists.linux-foundation.org>; Sun, 06 Sep 2020 08:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0U6+N87TtQqeJvtsYL++VRaHV5Y/ETKSefP9o6FFabM=;
 b=OyUETwoInfdSh4ScoNMRqAZdPJ8qgNTcs/PCZtrGedtu8dWgAmrBhfDVsXTa4UBvGI
 5M7Rl2ssXCVXKyL3S4lLa6uvMTPO7jGhZ1IPKbyzklrYMbOvENWb+OkSQ53y6qd2ZO4s
 P+B/MmJVjjCPhP5lFS1uKSUrKRV+lNEzkU0hAzXdDcG+L0i7Sj587sFJIqDIHfyW/gJR
 p8r0R+32AHVnG37XpelpYr+7bSLaSbsY+I8FqQ8Pl3OFewkFzCWFHeTau+MI7nGQhfH5
 3uLvhvYONA8hQE5Tr9VqO6w/kiialSKWmUHD3PpghDZs/JbTzaYtNtj5VeGt7ZUdCW+E
 ZyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0U6+N87TtQqeJvtsYL++VRaHV5Y/ETKSefP9o6FFabM=;
 b=ea4IEdDS8dtaqH8QC1OUFYZPuwm6KBExFe+MxYEsxRmoZcMDuwL8EebsUWvRYPMZnX
 5VJw4thXN/Oh+Kg7Nyc0bF9O56UWN8gqbo+He2cYTdPf/fzK9XtZZh1R+qZeJBKOzP0B
 eGyDM9pH07kptQ/86Nnqk4fuiHmgBs6NZMttwiYt+PxmZ7kXeqdYQ0uDrskWV4wJPD02
 suUmhAVCfYer/HEzAaRF/704QqTZDyo5pc6clNis+FLmgpD618UD3NLti7kzoPcXt7hQ
 e6LcrbSka0IWkrpJLNEokn9UXmqEKM0IpYtGZBTk9j4qOivRdJNJ56ZfKF1ahqDpOpSJ
 U87g==
X-Gm-Message-State: AOAM531hRNUVx6VVZgspFSyHusTnfMS5MAIrmEflEFXfPOfkJrL7k9e8
 27SEKc4EdbbDFcuA4TX/FIob1HMNzckBhg==
X-Google-Smtp-Source: ABdhPJyMy7k7z0Nq7lpLRDSASUYBRp7c5+96CRwDq7/6ApQXt4q76MVmMJxwJ56xh/mGeO95pXcGpA==
X-Received: by 2002:a1c:a5c8:: with SMTP id
 o191mr17179286wme.127.1599405577152; 
 Sun, 06 Sep 2020 08:19:37 -0700 (PDT)
Received: from localhost.localdomain (208.19.23.93.rev.sfr.net. [93.23.19.208])
 by smtp.gmail.com with ESMTPSA id a15sm26420646wrn.3.2020.09.06.08.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 08:19:36 -0700 (PDT)
From: Fabien Parent <fparent@baylibre.com>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH v3 3/3] iommu/mediatek: add support for MT8167
Date: Sun,  6 Sep 2020 17:19:28 +0200
Message-Id: <20200906151928.881209-3-fparent@baylibre.com>
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

Add support for the IOMMU on MT8167

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

V3:
	* use LEGACY_IVRP_PADDR flag instead of using a platform data member
V2:
	* removed if based on m4u_plat, and using instead the new
	  has_legacy_ivrp_paddr member that was introduced in patch 2.

---
 drivers/iommu/mtk_iommu.c | 8 ++++++++
 drivers/iommu/mtk_iommu.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b1f85a7e9346..6079f6a23c74 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -817,6 +817,13 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
 };
 
+static const struct mtk_iommu_plat_data mt8167_data = {
+	.m4u_plat     = M4U_MT8167,
+	.flags        = HAS_4GB_MODE | RESET_AXI | HAS_LEGACY_IVRP_PADDR,
+	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.larbid_remap = {{0}, {1}, {2}}, /* Linear mapping. */
+};
+
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
@@ -835,6 +842,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
+	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{}
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 122925dbe547..df32b3e3408b 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -39,6 +39,7 @@ enum mtk_iommu_plat {
 	M4U_MT2701,
 	M4U_MT2712,
 	M4U_MT6779,
+	M4U_MT8167,
 	M4U_MT8173,
 	M4U_MT8183,
 };
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
