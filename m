Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99481ECE59D
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 03:33:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7813D20663
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 03:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7813D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6005AC79;
	Wed, 16 Oct 2019 03:33:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 167A3BA0
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 03:33:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 46C6814D
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 03:33:42 +0000 (UTC)
X-UUID: 9b3a021651fe4c8b987019d54e8d0414-20191016
X-UUID: 9b3a021651fe4c8b987019d54e8d0414-20191016
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
	with ESMTP id 940793888; Wed, 16 Oct 2019 11:33:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
	mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Wed, 16 Oct 2019 11:33:37 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
	(172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Wed, 16 Oct 2019 11:33:36 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH v4 2/7] iommu/mediatek: Add a new tlb_lock for tlb_flush
Date: Wed, 16 Oct 2019 11:33:07 +0800
Message-ID: <1571196792-12382-3-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571196792-12382-1-git-send-email-yong.wu@mediatek.com>
References: <1571196792-12382-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, chao.hao@mediatek.com,
	edison.hsieh@mediatek.com, linux-kernel@vger.kernel.org,
	Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	linux-mediatek@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The commit 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API
TLB sync") help move the tlb_sync of unmap from v7s into the iommu
framework. It helps add a new function "mtk_iommu_iotlb_sync", But it
lacked the lock, then it will cause the variable "tlb_flush_active"
may be changed unexpectedly, we could see this warning log randomly:

mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to
full flush

The HW requires tlb_flush/tlb_sync in pairs strictly, this patch adds
a new tlb_lock for tlb operations to fix this issue.

Fixes: 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API TLB
sync")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 23 ++++++++++++++++++++++-
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 76b9388..c2f6c78 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -219,22 +219,37 @@ static void mtk_iommu_tlb_sync(void *cookie)
 static void mtk_iommu_tlb_flush_walk(unsigned long iova, size_t size,
 				     size_t granule, void *cookie)
 {
+	struct mtk_iommu_data *data = cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->tlb_lock, flags);
 	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, false, cookie);
 	mtk_iommu_tlb_sync(cookie);
+	spin_unlock_irqrestore(&data->tlb_lock, flags);
 }
 
 static void mtk_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
 				     size_t granule, void *cookie)
 {
+	struct mtk_iommu_data *data = cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->tlb_lock, flags);
 	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, true, cookie);
 	mtk_iommu_tlb_sync(cookie);
+	spin_unlock_irqrestore(&data->tlb_lock, flags);
 }
 
 static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
 					    unsigned long iova, size_t granule,
 					    void *cookie)
 {
+	struct mtk_iommu_data *data = cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->tlb_lock, flags);
 	mtk_iommu_tlb_add_flush_nosync(iova, granule, granule, true, cookie);
+	spin_unlock_irqrestore(&data->tlb_lock, flags);
 }
 
 static const struct iommu_flush_ops mtk_iommu_flush_ops = {
@@ -453,7 +468,12 @@ static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
 static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
 				 struct iommu_iotlb_gather *gather)
 {
-	mtk_iommu_tlb_sync(mtk_iommu_get_m4u_data());
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->tlb_lock, flags);
+	mtk_iommu_tlb_sync(data);
+	spin_unlock_irqrestore(&data->tlb_lock, flags);
 }
 
 static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
@@ -733,6 +753,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	spin_lock_init(&data->tlb_lock);
 	list_add_tail(&data->list, &m4ulist);
 
 	if (!iommu_present(&platform_bus_type))
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index fc0f16e..8cae22d 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -58,6 +58,7 @@ struct mtk_iommu_data {
 	struct iommu_group		*m4u_group;
 	bool                            enable_4GB;
 	bool				tlb_flush_active;
+	spinlock_t			tlb_lock; /* lock for tlb range flush */
 
 	struct iommu_device		iommu;
 	const struct mtk_iommu_plat_data *plat_data;
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
