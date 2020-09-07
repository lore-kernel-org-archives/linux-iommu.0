Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03586C433E2
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 10:17:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09AB21473
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 10:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KltwrjUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09AB21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 422D120522;
	Mon,  7 Sep 2020 10:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vzcGqCIKeFj2; Mon,  7 Sep 2020 10:17:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1986A2050C;
	Mon,  7 Sep 2020 10:17:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF005C0893;
	Mon,  7 Sep 2020 10:17:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AD9FC0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 10:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 27360870F6
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 10:17:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bY-tMrGz677y for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 10:17:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 67A6586F5E
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 10:17:02 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id b79so13642388wmb.4
 for <iommu@lists.linux-foundation.org>; Mon, 07 Sep 2020 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2AcZ+ht5heIUGMeBtkrSAl5QfbjkEelxxHKDjkGuZF4=;
 b=KltwrjUzSC3k4btOVShbI2P9fHUWGgNbRAPmHJTtAi6/JEb36d5AntVkI4lzadidvf
 4rvV0jYBTTbsZi3pZ8fjZbxeP1tjOVlfsPFwAt1bjeCZs7rJDVJbJyN5Lwa+du4rZ+Hk
 XQEB78tFEop+SHR7b1KscY+z5cBD/vIIRFTh2g5XOrIm2acQOAB9XnMI70w/a5fRXN0U
 HBto/oEqQAfPKHF2FssPCM57qNk6wqR87VhAw2GXUw13Ft1umShjzltUa0eIU3eZ6lC2
 s7noChxVg5u+RbAsNvEWuhOMzXxcYL2eNpw54g3rBv4m0dwYbD2JozVlzVA8w3H6jycl
 8oGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2AcZ+ht5heIUGMeBtkrSAl5QfbjkEelxxHKDjkGuZF4=;
 b=A+Q1vYjQHAuZIvwRWxf6HsGaDdEe3Y2CE5zL/52gjjRvO1nVCs7bvF8ARpneLg8uNn
 nUHMbLlF5fjqf6TJtiA9Nh9sXS4seSJhaumXwwWSGwQUS0uGa54sZ82KbJ41P/B7HW7n
 hf0uvoxStZtG8qgZXYuE+OsTI0tuckT7aSHYY3/rHwUFxe7nchnhFME9/C7hwGlWdchW
 H1wqkdSQGSk0pTnvdHbLYx2GdQ3QCNkr4zs4GGVDatmWVjauPCUT1PQKdBQ/rWySbah5
 0slGVJML24VkxwIdJBDLSZzdoYh1aDVfMRCD55LBREZW10zSQdL1h+CgPxPzj1x0uz/8
 J0CA==
X-Gm-Message-State: AOAM530y7fBktzWjpX3ubVcieOsoSeSr8SBbGpldfOyDSGlsSnz8Cp1u
 qwtCW7nL1tjcqvipwKMztW3tP95A5LAa3A==
X-Google-Smtp-Source: ABdhPJyud3Q1FarNaloME4DE60XHhksKDdkBuTqKpEI/obuHP2Cli5CKDBJKYcqqf9+p8T2C8RQClA==
X-Received: by 2002:a1c:dd87:: with SMTP id
 u129mr19928577wmg.172.1599473820650; 
 Mon, 07 Sep 2020 03:17:00 -0700 (PDT)
Received: from localhost.localdomain (122.105.23.93.rev.sfr.net.
 [93.23.105.122])
 by smtp.gmail.com with ESMTPSA id j7sm28728689wrw.35.2020.09.07.03.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 03:17:00 -0700 (PDT)
From: Fabien Parent <fparent@baylibre.com>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH v4 3/3] iommu/mediatek: add support for MT8167
Date: Mon,  7 Sep 2020 12:16:49 +0200
Message-Id: <20200907101649.1573134-3-fparent@baylibre.com>
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

Add support for the IOMMU on MT8167

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

V4;
	* Removed HAS_4GB_MODE flag since this SoC does not seem to support it
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
index b1f85a7e9346..4ff071eb5279 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -817,6 +817,13 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
 };
 
+static const struct mtk_iommu_plat_data mt8167_data = {
+	.m4u_plat     = M4U_MT8167,
+	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR,
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
