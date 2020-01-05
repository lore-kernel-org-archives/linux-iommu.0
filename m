Return-Path: <SRS0=m4R2=22=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C07C3F68F
	for <iommu@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A76207FD
	for <iommu@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Nav1LSOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A76207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 08B0E2002F;
	Sun,  5 Jan 2020 10:47:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pFzqtmVQ5bfo; Sun,  5 Jan 2020 10:47:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BA297203D5;
	Sun,  5 Jan 2020 10:47:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FCA2C1D84;
	Sun,  5 Jan 2020 10:47:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E532CC0881
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D03AB85CC7
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eBICAqUl+hla for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jan 2020 10:47:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id D02D785C90
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:47:17 +0000 (UTC)
X-UUID: e07b8a8354b04b3db47f5fefc81ef96e-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=/GRQoslk/LSHOdzw5eAs8KczvypmvSkfZUU+7BeTfag=; 
 b=Nav1LSOT1U4hOZPHRAQOPwpEEN0ETiJqv12EqqTUB0fJjj3Z75xw1B/wWtBy/znYrmYLZPQg7NZKd7iBaDMepbdhhZSbDtHvsTn0idoI0rpiywdhIgX73fFO1lPdlqnBT7GAtdULoefecz1D3cPnyu19nY0aipfIO0CfPxDooSc=;
X-UUID: e07b8a8354b04b3db47f5fefc81ef96e-20200105
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
 (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 304849129; Sun, 05 Jan 2020 18:47:14 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:49 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:45 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 16/19] iommu/mediatek: Remove mtk_iommu_get_m4u_data api
Date: Sun, 5 Jan 2020 18:45:20 +0800
Message-ID: <20200105104523.31006-17-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200105104523.31006-1-chao.hao@mediatek.com>
References: <20200105104523.31006-1-chao.hao@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: Anan Sun <anan.sun@mediatek.com>, devicetree@vger.kernel.org,
 Jun Yan <jun.yan@mediatek.com>, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, Chao Hao <chao.hao@mediatek.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Cui Zhang <zhang.cui@mediatek.com>, linux-arm-kernel@lists.infradead.org
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

Based on previous modifications in the patchset, A mtk_iommu_data
structure represent a iommu, we will add mtk_iommu_data to mtk_iommu_domain
to show the iommu which mtk_iommu_domain belongs to, so we can get
mtk_iommu_data by mtk_iommu_domain, don't use to "mtk_iommu_get_m4u_data"
any more.

Besides, there is a small SW adjustment, we will move alloc iommu_group
into "create_iommu_group"

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 74 +++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index bfb1831afae9..9a7f2a388e3e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -115,6 +115,7 @@ struct mtk_iommu_domain {
 	u32				id;
 	struct iommu_domain		domain;
 	struct iommu_group		*group;
+	struct mtk_iommu_data		*data;
 	struct list_head		list;
 };
 
@@ -162,23 +163,6 @@ static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 
 #define for_each_m4u(data)	list_for_each_entry(data, &m4ulist, list)
 
-/*
- * There may be 1 or 2 M4U HWs, But we always expect they are in the same domain
- * for the performance.
- *
- * Here always return the mtk_iommu_data of the first probed M4U where the
- * iommu domain information is recorded.
- */
-static struct mtk_iommu_data *mtk_iommu_get_m4u_data(void)
-{
-	struct mtk_iommu_data *data;
-
-	for_each_m4u(data)
-		return data;
-
-	return NULL;
-}
-
 static u32 get_domain_id(struct mtk_iommu_data *data, u32 portid)
 {
 	u32 dom_id = 0;
@@ -397,6 +381,27 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 	}
 }
 
+static struct iommu_group *create_iommu_group(struct mtk_iommu_data *data,
+					      struct device *dev)
+{
+	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
+
+	/* Prepare for allocate mtk_iommu_domain */
+	data->m4u_group = mtk_iommu_get_group(dev);
+	if (!data->m4u_group) {
+		data->m4u_group = iommu_group_alloc();
+		if (IS_ERR(data->m4u_group))
+			dev_err(dev, "Failed to allocate M4U IOMMU group\n");
+	} else {
+		iommu_group_ref_get(data->m4u_group);
+	}
+
+	/* save the latest init device */
+	pgtable->init_dev = dev;
+
+	return data->m4u_group;
+}
+
 static struct mtk_iommu_pgtable *create_pgtable(struct mtk_iommu_data *data)
 {
 	struct mtk_iommu_pgtable *pgtable;
@@ -462,7 +467,7 @@ static int mtk_iommu_attach_pgtable(struct mtk_iommu_data *data,
 static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 {
 	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	struct mtk_iommu_data *data;
 	struct mtk_iommu_domain *dom;
 	struct device *dev;
 
@@ -471,6 +476,7 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 
 	if (pgtable) {
 		dev = pgtable->init_dev;
+		data = dev_iommu_fwspec_get(dev)->iommu_priv;
 		if (!data->m4u_group) {
 			pr_err("%s, find m4u_group failed\n", __func__);
 			return NULL;
@@ -491,6 +497,7 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (dom->id >= data->plat_data->dom_cnt)
 		goto  put_dma_cookie;
 
+	dom->data = data;
 	dom->group = data->m4u_group;
 	/* Update our support page sizes bitmap */
 	dom->domain.pgsize_bitmap = pgtable->cfg.pgsize_bitmap;
@@ -548,7 +555,8 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_data *data = dom->data;
 
 	/* The "4GB mode" M4U physically can not use the lower remap of Dram. */
 	if (data->enable_4GB)
@@ -569,27 +577,30 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
 
 static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
-	mtk_iommu_tlb_flush_all(mtk_iommu_get_m4u_data());
+	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+
+	mtk_iommu_tlb_flush_all(dom->data);
 }
 
 static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
 				 struct iommu_iotlb_gather *gather)
 {
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	size_t length = gather->end - gather->start;
 
 	if (gather->start == ULONG_MAX)
 		return;
 
 	mtk_iommu_tlb_flush_range_sync(gather->start, length, gather->pgsize,
-				       data);
+				       dom->data);
 }
 
 static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 					  dma_addr_t iova)
 {
 	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_data *data = dom->data;
 	phys_addr_t pa;
 
 	pa = pgtable->iop->iova_to_phys(pgtable->iop, iova);
@@ -636,7 +647,7 @@ static void mtk_iommu_remove_device(struct device *dev)
 
 static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 {
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
 	struct mtk_iommu_pgtable *pgtable;
 	int ret = 0;
 
@@ -652,20 +663,9 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 		}
 	}
 
-	/* All the client devices are in the same m4u iommu-group */
-	data->m4u_group = mtk_iommu_get_group(dev);
-	if (!data->m4u_group) {
-		data->m4u_group = iommu_group_alloc();
-		if (IS_ERR(data->m4u_group))
-			dev_err(dev, "Failed to allocate M4U IOMMU group\n");
-	} else {
-		iommu_group_ref_get(data->m4u_group);
-	}
+	dev_info(data->dev, "%s, init data:%d\n", __func__, data->m4u_id);
 
-	/* save the latest init device */
-	pgtable->init_dev = dev;
-
-	return data->m4u_group;
+	return create_iommu_group(data, dev);
 }
 
 static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
