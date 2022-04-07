Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3075C433FE
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 07:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E18D40345;
	Thu,  7 Apr 2022 07:59:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DuvPLBicHSuf; Thu,  7 Apr 2022 07:59:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 28E3C41780;
	Thu,  7 Apr 2022 07:59:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FBE6C001D;
	Thu,  7 Apr 2022 07:59:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4634C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 07:59:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B37AF83E62
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 07:59:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 834IJ0-TXXsk for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 07:59:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1553812A0
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 07:59:44 +0000 (UTC)
X-UUID: 77ac7411a9bf4493b08bcdb50855fdf4-20220407
X-UUID: 77ac7411a9bf4493b08bcdb50855fdf4-20220407
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 861565307; Thu, 07 Apr 2022 15:59:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 7 Apr 2022 15:59:39 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 15:59:37 +0800
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v6 12/34] iommu/mediatek: Remove the granule in the tlb flush
Date: Thu, 7 Apr 2022 15:57:04 +0800
Message-ID: <20220407075726.17771-13-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220407075726.17771-1-yong.wu@mediatek.com>
References: <20220407075726.17771-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>
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
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The MediaTek IOMMU doesn't care about granule when tlb flushing.
Remove this variable.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e7008a20ec74..1f3fe3276aa0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -219,7 +219,6 @@ static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 }
 
 static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
-					   size_t granule,
 					   struct mtk_iommu_data *data)
 {
 	struct list_head *head = data->hw_list;
@@ -541,8 +540,7 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	size_t length = gather->end - gather->start + 1;
 
-	mtk_iommu_tlb_flush_range_sync(gather->start, length, gather->pgsize,
-				       dom->data);
+	mtk_iommu_tlb_flush_range_sync(gather->start, length, dom->data);
 }
 
 static void mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
@@ -550,7 +548,7 @@ static void mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
-	mtk_iommu_tlb_flush_range_sync(iova, size, size, dom->data);
+	mtk_iommu_tlb_flush_range_sync(iova, size, dom->data);
 }
 
 static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
