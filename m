Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F5BC433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 12:01:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0557F61216
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 12:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0557F61216
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CE83B4063B;
	Thu, 23 Sep 2021 12:01:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HMSzi66boGc5; Thu, 23 Sep 2021 12:01:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 645EF40192;
	Thu, 23 Sep 2021 12:01:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D6A0C0011;
	Thu, 23 Sep 2021 12:01:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10469C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F03454063B
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id joLWfc4rNCeb for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 12:01:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ECBC140243
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:01:15 +0000 (UTC)
X-UUID: 0910dc122d474a15a1ae037b6dd89fee-20210923
X-UUID: 0910dc122d474a15a1ae037b6dd89fee-20210923
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1928541220; Thu, 23 Sep 2021 20:01:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Sep 2021 20:01:10 +0800
Received: from localhost.localdomain (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Sep 2021 20:01:09 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 13/33] iommu/mediatek: Remove the power status checking in
 tlb flush all
Date: Thu, 23 Sep 2021 19:58:20 +0800
Message-ID: <20210923115840.17813-14-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210923115840.17813-1-yong.wu@mediatek.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, yen-chang.chen@mediatek.com,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
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

To simplify the code, Remove the power status checking in the
tlb_flush_all, remove this:
   if (pm_runtime_get_if_in_use(data->dev) <= 0)
	    continue;

After this patch, the mtk_iommu_tlb_flush_all will be called from
a) isr
b) pm runtime resume callback
c) tlb flush range fail case
d) iommu_create_device_direct_mappings
   -> iommu_flush_iotlb_all
In first three cases, the power and clock always are enabled; d) is direct
mapping, the tlb flush is unnecessay since we already have tlb_flush_all
in the pm_runtime_resume callback. When the iommu's power status is
changed to active, the tlb always is clean.

In addition, there still are 2 reasons that don't add PM status checking
in the tlb flush all:
a) Write tlb flush all register also is ok even though the HW has no
power and clocks. Write ignore.
b) pm_runtime_get_if_in_use(m4udev) is 0 when the tlb_flush_all
is called frm pm_runtime_resume cb. From this point, we can not add
this code above in this tlb_flush_all.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e9e94944ed91..4a33b6c6b1db 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -204,10 +204,14 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 	return container_of(dom, struct mtk_iommu_domain, domain);
 }
 
-static void mtk_iommu_tlb_do_flush_all(struct mtk_iommu_data *data)
+static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 {
 	unsigned long flags;
 
+	/*
+	 * No need get power status since the HW PM status nearly is active
+	 * when entering here.
+	 */
 	spin_lock_irqsave(&data->tlb_lock, flags);
 	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 		       data->base + data->plat_data->inv_sel_reg);
@@ -216,16 +220,6 @@ static void mtk_iommu_tlb_do_flush_all(struct mtk_iommu_data *data)
 	spin_unlock_irqrestore(&data->tlb_lock, flags);
 }
 
-static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
-{
-	if (pm_runtime_get_if_in_use(data->dev) <= 0)
-		return;
-
-	mtk_iommu_tlb_do_flush_all(data);
-
-	pm_runtime_put(data->dev);
-}
-
 static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 					   struct mtk_iommu_data *data)
 {
@@ -263,7 +257,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 		if (ret) {
 			dev_warn(data->dev,
 				 "Partial TLB flush timed out, falling back to full flush\n");
-			mtk_iommu_tlb_do_flush_all(data);
+			mtk_iommu_tlb_flush_all(data);
 		}
 
 		if (has_pm)
@@ -993,7 +987,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	 *
 	 * Thus, Make sure the tlb always is clean after each PM resume.
 	 */
-	mtk_iommu_tlb_do_flush_all(data);
+	mtk_iommu_tlb_flush_all(data);
 
 	/*
 	 * Uppon first resume, only enable the clk and return, since the values of the
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
