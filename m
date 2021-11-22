Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F3EC433F5
	for <iommu@archiver.kernel.org>; Mon, 22 Nov 2021 10:44:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A6ACE40010;
	Mon, 22 Nov 2021 10:44:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ah7WU_b0ZK_h; Mon, 22 Nov 2021 10:44:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4BA7040186;
	Mon, 22 Nov 2021 10:44:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6110BC003E;
	Mon, 22 Nov 2021 10:44:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1058FC0012
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 10:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4F5E40172
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 10:44:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w6yApcCHygQM for <iommu@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:44:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3290640010
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 10:44:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: dafna) with ESMTPSA id 9ACCA1F44822
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1637577862; bh=BZwKyzVx4ruuAqlnDN1dIueQvzsa4RZzFJANK5WOaYE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eZEc8ECeOmsw4ezw2hpNmvicqyp8cDuBNRLXFHOI2d19wIHaibjoEtA5Yv2PqKAjV
 YKZ/CbZsVsqJ6w/5VeW06fsPymIpCst9vxkAARiQpPKdjiabtO4oR9PYSM6HoCKvJB
 GjYyAoKdv3XDQ+B9SvA4/4JCVZfRRLgMGoJBpGB8sp0PQ1/TPM22EFIz8Qd6Cl2Icx
 S0LxEdhn4hV2jBYPlXnYC4/Ues5/XExzqaCx8liG7pUQIvC//aonPhpuhlLwC21iaM
 8lZjy+3kwbNn45qUk+Rk1NJmNSWkJB5WjZjlPjNNycq/4lpHA24O65A6UBKmj5padv
 Q9CDSLcHfaLZg==
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 2/2] iommu/mediatek: always check runtime PM status in tlb
 flush range callback
Date: Mon, 22 Nov 2021 12:44:00 +0200
Message-Id: <20211122104400.4160-3-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122104400.4160-1-dafna.hirschfeld@collabora.com>
References: <20211122104400.4160-1-dafna.hirschfeld@collabora.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:MEDIATEK IOMMU DRIVER" <linux-mediatek@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 Will Deacon <will@kernel.org>, linux-media@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Sebastian Reichel <sebastian.reichel@collabora.com>

In case of v4l2_reqbufs() it is possible, that a TLB flush is done
without runtime PM being enabled. In that case the "Partial TLB flush
timed out, falling back to full flush" warning is printed.

Commit c0b57581b73b ("iommu/mediatek: Add power-domain operation")
introduced has_pm as optimization to avoid checking runtime PM
when there is no power domain attached. But without the PM domain
there is still the device driver's runtime PM suspend handler, which
disables the clock. Thus flushing should also be avoided when there
is no PM domain involved.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 28dc4b95b6d9..b0535fcfd1d7 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -227,16 +227,13 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 					   size_t granule,
 					   struct mtk_iommu_data *data)
 {
-	bool has_pm = !!data->dev->pm_domain;
 	unsigned long flags;
 	int ret;
 	u32 tmp;
 
 	for_each_m4u(data) {
-		if (has_pm) {
-			if (pm_runtime_get_if_in_use(data->dev) <= 0)
-				continue;
-		}
+		if (pm_runtime_get_if_in_use(data->dev) <= 0)
+			continue;
 
 		spin_lock_irqsave(&data->tlb_lock, flags);
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
@@ -261,8 +258,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
 		spin_unlock_irqrestore(&data->tlb_lock, flags);
 
-		if (has_pm)
-			pm_runtime_put(data->dev);
+		pm_runtime_put(data->dev);
 	}
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
