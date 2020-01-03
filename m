Return-Path: <SRS0=m4R2=22=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E526CC3F68F
	for <iommu@archiver.kernel.org>; Sun,  5 Jan 2020 15:27:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3CC20801
	for <iommu@archiver.kernel.org>; Sun,  5 Jan 2020 15:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tfxrTNAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3CC20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1D47D877B5;
	Sun,  5 Jan 2020 15:27:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f+fH83Sjm7QL; Sun,  5 Jan 2020 15:27:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F3F3C877E4;
	Sun,  5 Jan 2020 15:27:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED0E4C1D8B;
	Sun,  5 Jan 2020 15:27:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF669C077D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jan 2020 16:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 99766826B7
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jan 2020 16:32:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AI97wlfaTL0S for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jan 2020 16:32:37 +0000 (UTC)
X-Greylist: delayed 00:06:00 by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1BFA582157
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jan 2020 16:32:37 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id d16so42953668wre.10
 for <iommu@lists.linux-foundation.org>; Fri, 03 Jan 2020 08:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=89mFA8e7Xc7aCGnee/vBVuK6j5IjAiZj3SvE/aRAZkU=;
 b=tfxrTNAlbO1a4huM8IDy6tBKcl5I9hIGs22EGye9w5UqqHWTreoNTQ8QYcvb7YXmnN
 35WIII5O06Ed79JL1L2aWb4w4vlKdqPa68lhyM/kYS76+BuF0TNXQ3JdF6VKtsRVcIxt
 namNuW/NRTfnECEKBlixtu8EePuaeEnnCl+L1sqFgUij9RjLaFDsjrGZMqb0/B5JH6p1
 AwiiURZ7VLU5sgapnHFWxQ1B2ucVV3FT9uJwtXplth4sy+9CkpmwaKmoyLNSHWcsxFij
 MIDfBHJ+jR49lz5qMC9uZDHOTy31/xy7TXDvyNMEwMvBHQrgYoKqOPdIi02WnBU2luMd
 KTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=89mFA8e7Xc7aCGnee/vBVuK6j5IjAiZj3SvE/aRAZkU=;
 b=kuFOaRSbBjfT65bOr9RaEvnOCg5Mzw9nnXvga70JOakztseCCEpRg7FldIQkxb/WTa
 CnnNE2moTY83C7sSXoCmDN79ddylLk5zD4pINHD/O/TRPu989cQcZ2JEKbQ/AA8HiPyS
 Df7zbv/8Uz74E4VEBtG2WYA30ghNNdQvUWQC1eCrK49dyTdJY58hPicwDYCruQxEIVmR
 qAD5EgM7KjPAteAomCRiwMyChqfD4jRC0oJAQZ6W9zZysxCCifwjKLRpU84sIbXZhwWv
 vW7V5CyNQKLm52OdNmyPeWPnj1PVEtaQ0YtQn7ws80aIEx446mZfXYNenQ6LiU+eFPHE
 fqZQ==
X-Gm-Message-State: APjAAAX0/AZErMmc0AEZLah1igmUMmKFCrP3X0DnwENSmjVxjBe7SUG4
 cMAKQ/ULhuxU3wh3m3+Q/jY72I5xgaYmdA==
X-Google-Smtp-Source: APXvYqwPg2MhuwqZ0oIndjKJulvZt5tg9dwauR6SSxBiZJ9j/GpPtJP4TrTegUABwWAZ4oYoiSU4Og==
X-Received: by 2002:adf:e591:: with SMTP id l17mr82260400wrm.139.1578068796095; 
 Fri, 03 Jan 2020 08:26:36 -0800 (PST)
Received: from radium.baylibre.local
 (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id x14sm12564234wmj.42.2020.01.03.08.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2020 08:26:35 -0800 (PST)
From: Fabien Parent <fparent@baylibre.com>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] iommu/mediatek: add support for MT8167
Date: Fri,  3 Jan 2020 17:26:32 +0100
Message-Id: <20200103162632.109553-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.25.0.rc0
In-Reply-To: <20200103162632.109553-1-fparent@baylibre.com>
References: <20200103162632.109553-1-fparent@baylibre.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 05 Jan 2020 15:27:38 +0000
Cc: mark.rutland@arm.com, matthias.bgg@gmail.com, robh+dt@kernel.org,
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

Add support for the IOMMU on MT8167

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 11 ++++++++++-
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6fc1f5ecf91e..5fc6178a82dc 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -569,7 +569,8 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
 	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
 
-	if (data->plat_data->m4u_plat == M4U_MT8173)
+	if (data->plat_data->m4u_plat == M4U_MT8173 ||
+	    data->plat_data->m4u_plat == M4U_MT8167)
 		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
 	else
 		regval = lower_32_bits(data->protect_base) |
@@ -782,6 +783,13 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 	.larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
 };
 
+static const struct mtk_iommu_plat_data mt8167_data = {
+	.m4u_plat     = M4U_MT8167,
+	.has_4gb_mode = true,
+	.reset_axi    = true,
+	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
+};
+
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.has_4gb_mode = true,
@@ -798,6 +806,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
+	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{}
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index ea949a324e33..cb8fd5970cd4 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -30,6 +30,7 @@ struct mtk_iommu_suspend_reg {
 enum mtk_iommu_plat {
 	M4U_MT2701,
 	M4U_MT2712,
+	M4U_MT8167,
 	M4U_MT8173,
 	M4U_MT8183,
 };
-- 
2.25.0.rc0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
