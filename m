Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F4DC433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 12:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2EBB140A08;
	Wed,  8 Dec 2021 12:08:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aD63pG2bXQK2; Wed,  8 Dec 2021 12:08:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B05D44029F;
	Wed,  8 Dec 2021 12:08:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B4B8C0038;
	Wed,  8 Dec 2021 12:08:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CE71C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26750401B4
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:08:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=fail (2048-bit key) reason="fail (bad RSA signature)"
 header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GjDYjdER_l_4 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 12:08:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DFEB8401F6
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:08:11 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2a00:c281:1230:3700:51d0:7039:5913:64d3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 43A021F45C96;
 Wed,  8 Dec 2021 12:08:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638965290; bh=rAjPBWxPWs9ZhCznZcphsRB07TQmg0ZmOocuWwcZPdo=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=f/vO251EHLPyVm053WAAlGD5ZluE01MipX147UdEpPozfAvQUmA0GqCw/VG28eiYz
 K/eQk54EWsarB1kn5sV9dfYT6JoIcy8m5QVHzuHmBHlPEdSHMbeUMukUBU82RcbuB2
 /6fJwiOUO54WsU/BwTZWMYAjcpwpTBlJSVj23je4jk7Be1kW11P/Mkp23k7Z2xRw/u
 ggeknqvodXEDZaOBbZjeqGVHGfQTVsAxUS/k6PHaDlfo8XpxsPhNPYOK0Km99EGPmE
 u1KPL9AA+Ifi4xcOUazYlQKMfFmfd1HQrtkbsq4zirX6c+YeICbbbrpSJ+g0VnLjq5
 GXYmErfCY16Jw==
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To: iommu@lists.linux-foundation.org, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org (moderated list:MEDIATEK IOMMU DRIVER),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
 linux-kernel@vger.kernel.org (open list), dafna.hirschfeld@collabora.com,
 kernel@collabora.com, linux-media@vger.kernel.org,
 sebastian.reichel@collabora.com
Subject: [PATCH v2 2/5] iommu/mediatek: Always check runtime PM status in tlb
 flush range callback
Date: Wed,  8 Dec 2021 14:07:41 +0200
Message-Id: <20211208120744.2415-3-dafna.hirschfeld@collabora.com>
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
index 342aa562ab6a..dd2c08c54df4 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -225,16 +225,13 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
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
@@ -259,8 +256,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
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
