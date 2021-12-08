Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CFEC43217
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 12:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E24D26077B;
	Wed,  8 Dec 2021 12:08:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dqo91xcWSoPQ; Wed,  8 Dec 2021 12:08:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D8B9060654;
	Wed,  8 Dec 2021 12:08:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B012EC002F;
	Wed,  8 Dec 2021 12:08:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47120C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28215402C3
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:08:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=fail (2048-bit key) reason="fail (bad RSA signature)"
 header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RtP0iZ6bR3nN for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 12:08:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 32E0C4029F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:08:13 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2a00:c281:1230:3700:51d0:7039:5913:64d3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8C9EB1F45CA2;
 Wed,  8 Dec 2021 12:08:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638965291; bh=MaW1bAocTnYI0OuXYXK0SxPq8wDjTv9Gv1PqEfPZu2A=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=jjgMZjhwkPkAM1oPyq3VkeyrQe8sgIpKSmT5wUqN+/y1bxPSf/egn5QFQiyiWe3di
 SpmqbzqtecudsZh3h/bapXrjW01wlWQ8hUQFUcrrU6K0xE+ReV222RmQrkk1eLclgQ
 rJKR7i0ZA7k0op1HeiLw2gadna5xsAovm6d9m9P34M+1RcRp6fkiLnupQxCZyV030j
 SxKZP5tLAa0XtRwl8yOAKsnMlmkE2PcLh9wSrwYgvrclqSyhaUnNrtvDXhik5nBfP5
 B+8ekIt3CdetHeEa0xwvQ1uJbanswfW2w22fdYTl+1L1MpDKJB/joxM29gsqjCJbDh
 x+M8G8wITR4oA==
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To: iommu@lists.linux-foundation.org, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org (moderated list:MEDIATEK IOMMU DRIVER),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
 linux-kernel@vger.kernel.org (open list), dafna.hirschfeld@collabora.com,
 kernel@collabora.com, linux-media@vger.kernel.org,
 sebastian.reichel@collabora.com
Subject: [PATCH v2 3/5] iommu/mediatek: Remove the power status checking in
 tlb flush all
Date: Wed,  8 Dec 2021 14:07:42 +0200
Message-Id: <20211208120744.2415-4-dafna.hirschfeld@collabora.com>
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

To simplify the code, Remove the power status checking in the
tlb_flush_all, remove this:
   if (pm_runtime_get_if_in_use(data->dev) <= 0)
	    continue;

The mtk_iommu_tlb_flush_all is called from
a) isr
b) tlb flush range fail case
c) iommu_create_device_direct_mappings

In first two cases, the power and clock are always enabled.
In the third case tlb flush is unnecessary because in a later patch
in the series a full flush from the pm_runtime_resume callback is added.

In addition, writing the tlb control register when the iommu is not resumed
is ok and the write is ignored.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
[refactor commit log]
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index dd2c08c54df4..e30ac68fab48 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -210,15 +210,10 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 
 static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 {
-	if (pm_runtime_get_if_in_use(data->dev) <= 0)
-		return;
-
 	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 		       data->base + data->plat_data->inv_sel_reg);
 	writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
 	wmb(); /* Make sure the tlb flush all done */
-
-	pm_runtime_put(data->dev);
 }
 
 static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
