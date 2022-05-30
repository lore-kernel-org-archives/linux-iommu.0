Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10016C433EF
	for <iommu@archiver.kernel.org>; Mon, 30 May 2022 12:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A8C6440A8E;
	Mon, 30 May 2022 12:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SBAzOCPv0RLg; Mon, 30 May 2022 12:14:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4311C400A8;
	Mon, 30 May 2022 12:14:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2194AC0032;
	Mon, 30 May 2022 12:14:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 874D1C002D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 12:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73B54840F0
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 12:14:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kIvGiPDHd-c7 for <iommu@lists.linux-foundation.org>;
 Mon, 30 May 2022 12:14:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C72628406E
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 12:14:37 +0000 (UTC)
X-UUID: 22fd0f51a2e848de9f119297234c6976-20220530
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5, REQID:f08fdcd2-853f-44dd-ba56-f596366d4959, OB:0,
 LO
 B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:0
X-CID-META: VersionHash:2a19b09, CLOUDID:acf30548-4fb1-496b-8f1d-39e733fed1ea,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
 ,QS:0,BEC:nil
X-UUID: 22fd0f51a2e848de9f119297234c6976-20220530
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <yf.wang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 527559544; Mon, 30 May 2022 20:14:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Mon, 30 May 2022 20:14:30 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Mon, 30 May 2022 20:14:29 +0800
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "open list:IOMMU DRIVERS"
 <iommu@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, 
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>
Subject: [PATCH] iommu/dma: Fix race condition during iova_domain
 initialization
Date: Mon, 30 May 2022 20:07:45 +0800
Message-ID: <20220530120748.31733-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-MTK: N
Cc: wsd_upstream@mediatek.com, Yunfei Wang <yf.wang@mediatek.com>,
 Libo Kang <Libo.Kang@mediatek.com>, Miles
 Chen <miles.chen@mediatek.com>, Ning Li <ning.li@mediatek.com>
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
From: "yf.wang--- via iommu" <iommu@lists.linux-foundation.org>
Reply-To: yf.wang@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Yunfei Wang <yf.wang@mediatek.com>

When many devices share the same iova domain, iommu_dma_init_domain()
may be called at the same time. The checking of iovad->start_pfn will
all get false in iommu_dma_init_domain() and both enter init_iova_domain()
to do iovad initialization.

Fix this by protecting init_iova_domain() with iommu_dma_cookie->mutex.

Exception backtrace:
rb_insert_color(param1=0xFFFFFF80CD2BDB40, param3=1) + 64
init_iova_domain() + 180
iommu_setup_dma_ops() + 260
arch_setup_dma_ops() + 132
of_dma_configure_id() + 468
platform_dma_configure() + 32
really_probe() + 1168
driver_probe_device() + 268
__device_attach_driver() + 524
__device_attach() + 524
bus_probe_device() + 64
deferred_probe_work_func() + 260
process_one_work() + 580
worker_thread() + 1076
kthread() + 332
ret_from_fork() + 16

Signed-off-by: Ning Li <ning.li@mediatek.com>
Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
---
 drivers/iommu/dma-iommu.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09f6e1c0f9c0..b38c5041eeab 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -63,6 +63,7 @@ struct iommu_dma_cookie {
 
 	/* Domain for flush queue callback; NULL if flush queue not in use */
 	struct iommu_domain		*fq_domain;
+	struct mutex			mutex;
 };
 
 static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
@@ -309,6 +310,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 	if (!domain->iova_cookie)
 		return -ENOMEM;
 
+	mutex_init(&domain->iova_cookie->mutex);
 	return 0;
 }
 
@@ -549,26 +551,33 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	}
 
 	/* start_pfn is always nonzero for an already-initialised domain */
+	mutex_lock(&cookie->mutex);
 	if (iovad->start_pfn) {
 		if (1UL << order != iovad->granule ||
 		    base_pfn != iovad->start_pfn) {
 			pr_warn("Incompatible range for DMA domain\n");
-			return -EFAULT;
+			ret = -EFAULT;
+			goto done_unlock;
 		}
 
-		return 0;
+		ret = 0;
+		goto done_unlock;
 	}
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 	ret = iova_domain_init_rcaches(iovad);
 	if (ret)
-		return ret;
+		goto done_unlock;
 
 	/* If the FQ fails we can simply fall back to strict mode */
 	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
 		domain->type = IOMMU_DOMAIN_DMA;
 
-	return iova_reserve_iommu_regions(dev, domain);
+	ret = iova_reserve_iommu_regions(dev, domain);
+
+done_unlock:
+	mutex_unlock(&cookie->mutex);
+	return ret;
 }
 
 /**
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
