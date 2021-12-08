Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42096C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 12:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA2C24039D;
	Wed,  8 Dec 2021 12:08:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yR7rtSDvOiAc; Wed,  8 Dec 2021 12:08:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A258E40364;
	Wed,  8 Dec 2021 12:08:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F854C006F;
	Wed,  8 Dec 2021 12:08:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74934C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 683454029F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:08:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=fail (2048-bit key) reason="fail (bad RSA signature)"
 header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IYzMjblZodtu for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 12:08:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63D454027C
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2a00:c281:1230:3700:51d0:7039:5913:64d3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D7C771F45CC9;
 Wed,  8 Dec 2021 12:08:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638965293; bh=aF1CmfT7rFK3gT9NbxPrEgiL2o8vrik2HcU3n2bTSNo=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=VifOHbOVseprUORLm78HIaWVplsXqc6xsRubtS5k+E23fEBezt4y3wyUY22YQMeTC
 4T8i/Bbt1hmWrGpaxcbpd948DLgu2JNMoH+MBYGaP3ndJfROIUe1n9tLV6swmgzfna
 fUNocaZxkbyRb115W7JNy42KjU8cErEcB23/sf/YGBeYMboaQetxDUshIbMYbUDkUU
 ztPqbX4TdFyKt1C4rLJw86MwIDZvwtFadZZHTNZNTeZFyDvLPknMt3eR2NhFk8uQv6
 F7npF9bv0Zh0+vofFrsfle4VDiyt7VSauq5w5MaWAnNKV5V6iaKBOwNKJc0aFOneNY
 taK39LGvmkOEA==
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To: iommu@lists.linux-foundation.org, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org (moderated list:MEDIATEK IOMMU DRIVER),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
 linux-kernel@vger.kernel.org (open list), dafna.hirschfeld@collabora.com,
 kernel@collabora.com, linux-media@vger.kernel.org,
 sebastian.reichel@collabora.com
Subject: [PATCH v2 4/5] iommu/mediatek: Add tlb_lock in tlb_flush_all
Date: Wed,  8 Dec 2021 14:07:43 +0200
Message-Id: <20211208120744.2415-5-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
References: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
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

From: Yong Wu <yong.wu@mediatek.com>

The tlb_flush_all touches the registers controlling tlb operations.
Protect it with the tlb_lock spinlock.
This also require the range_sync func to release that spinlock before
calling tlb_flush_all.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
[refactor commit log]
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e30ac68fab48..195a411e3087 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -210,10 +210,14 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 
 static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->tlb_lock, flags);
 	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 		       data->base + data->plat_data->inv_sel_reg);
 	writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
 	wmb(); /* Make sure the tlb flush all done */
+	spin_unlock_irqrestore(&data->tlb_lock, flags);
 }
 
 static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
@@ -242,14 +246,16 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 		/* tlb sync */
 		ret = readl_poll_timeout_atomic(data->base + REG_MMU_CPE_DONE,
 						tmp, tmp != 0, 10, 1000);
+
+		/* Clear the CPE status */
+		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
+		spin_unlock_irqrestore(&data->tlb_lock, flags);
+
 		if (ret) {
 			dev_warn(data->dev,
 				 "Partial TLB flush timed out, falling back to full flush\n");
 			mtk_iommu_tlb_flush_all(data);
 		}
-		/* Clear the CPE status */
-		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
-		spin_unlock_irqrestore(&data->tlb_lock, flags);
 
 		pm_runtime_put(data->dev);
 	}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
