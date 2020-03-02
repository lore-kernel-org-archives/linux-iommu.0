Return-Path: <SRS0=ZrTS=4T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B81C3F2D1
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 11:22:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8F921775
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 11:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aXkSI2bB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8F921775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6C9AF84E66;
	Mon,  2 Mar 2020 11:22:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bUhwiFC58v7W; Mon,  2 Mar 2020 11:22:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A8AB384D16;
	Mon,  2 Mar 2020 11:22:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91B2BC07FE;
	Mon,  2 Mar 2020 11:22:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B124EC013E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 11:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 99DBB84E66
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 11:22:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tSQNj6tRZSa2 for <iommu@lists.linux-foundation.org>;
 Mon,  2 Mar 2020 11:22:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 26B5484D16
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 11:22:25 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id f15so10697566wml.3
 for <iommu@lists.linux-foundation.org>; Mon, 02 Mar 2020 03:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pXFVNDmvd1Q57O9A14StFD9o/pCLl1WZ1LXT9jyY7wg=;
 b=aXkSI2bBqKF1Vn9HUmliqysTYyVduIDV+GQticrpQgMBTuEwdyXOU/yJMasY+tU5Bh
 hp9mdNGiZWQRZY43djxJU5Te2hjCeYOJpZE7Kf3yMhWMtbjr/YfeBWsTUYMli0o6aneL
 hjQxlCGaHxw5B4mqGQuBdfFY64NBTbqKcFbD9Q9B+reFNDjYSirVv+uhEuEH2mPjEYye
 DHGWR6uPEVThhBh32hv4RMSCHXtXBfMxNBgCzr3MAjMAcXu9Vuz4o2qszUfTlZaWAC/q
 a5CF7XzPxLXyWRXiFRJ0m1biCtXgBj/ia3i8conaAv6hKKaW6UZZ1bQ38AcQvB9ihgIL
 o5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pXFVNDmvd1Q57O9A14StFD9o/pCLl1WZ1LXT9jyY7wg=;
 b=CFCWYfDrgvOjQwX9ZevR34H2iSs97zQYTIP5E3NEp0n9i/m4FeEqMMVjvNDtVHrfCk
 m3vzqE0q1T0Keev8EwLTAv2Jj5Grd2jjZSAwCtIObJojqI6u5AAY/ZOnGc0Hq08NEr2i
 18yBkxwGUE8YN6dVMgpug3kCZOKbzudXHk0r8PC3uUMwWaJIQGbIrHIkyV3o7DR2t/EV
 AAh6VsaLxDMgBcyoIXd0LJADJiWXy7zlqaBlHbMaK92D1QRiruhoCiiTOioIu+noeNAa
 V70ctmKYT4V6rEh5vJAKhPiKgS47shDdOSp9r5yUnHGr6NNebhcbFGmyW6A5nIEulPch
 qtoQ==
X-Gm-Message-State: APjAAAXB7a3ZsG4zBmNAmW3Pp7qC2pQpmHj8m9bUUBjEV6WDg+gs76Pu
 mDn0PLKyl/F+Ydm0Wdn3MJZekA==
X-Google-Smtp-Source: APXvYqz+e/Cqch5x656k3Vz2SnBMUPxNp29Vb0LYw28FU3uDN1mzrpA/IdGcwPsttcC9lnuYBg3tgQ==
X-Received: by 2002:a05:600c:2942:: with SMTP id
 n2mr18840374wmd.87.1583148143534; 
 Mon, 02 Mar 2020 03:22:23 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ecba:5540:6f5c:582a:cc84:32f5])
 by smtp.gmail.com with ESMTPSA id j14sm28398441wrn.32.2020.03.02.03.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 03:22:23 -0800 (PST)
From: Fabien Parent <fparent@baylibre.com>
To: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v2 3/3] iommu/mediatek: add support for MT8167
Date: Mon,  2 Mar 2020 12:21:52 +0100
Message-Id: <20200302112152.2887131-3-fparent@baylibre.com>
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

Add support for the IOMMU on MT8167

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

V2:
	* removed if based on m4u_plat, and using instead the new
	has_legacy_ivrp_paddr member that was introduced in patch 2.

---
 drivers/iommu/mtk_iommu.c | 9 +++++++++
 drivers/iommu/mtk_iommu.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 78cb14ab7dd0..25b7ad1647ba 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -782,6 +782,14 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 	.larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
 };
 
+static const struct mtk_iommu_plat_data mt8167_data = {
+	.m4u_plat     = M4U_MT8167,
+	.has_4gb_mode = true,
+	.has_legacy_ivrp_paddr = true;
+	.reset_axi    = true,
+	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
+};
+
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.has_4gb_mode = true,
@@ -799,6 +807,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
+	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{}
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 4696ba027a71..72f874ec9e9c 100644
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
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
