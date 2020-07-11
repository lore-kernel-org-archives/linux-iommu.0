Return-Path: <SRS0=PEfB=AW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF8CC433E2
	for <iommu@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7177920720
	for <iommu@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="guSC6q38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7177920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5617A88D5B;
	Sat, 11 Jul 2020 06:52:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fWii3d2jFFQd; Sat, 11 Jul 2020 06:52:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BA7C488A6C;
	Sat, 11 Jul 2020 06:52:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4327C08A6;
	Sat, 11 Jul 2020 06:52:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E930AC088E
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D3A4E88810
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:52:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lS0Qkw0ik6fn for <iommu@lists.linux-foundation.org>;
 Sat, 11 Jul 2020 06:52:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id CBCD888334
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:52:39 +0000 (UTC)
X-UUID: be68c517f8804365b67975553d85335d-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=SMQQ6cvreFHKCw1lLAb1UVMLyz1zf9fnxfMshvwqUfA=; 
 b=guSC6q38+9QwXABxM65BAHlvWbYGuWwOSNjAq3gVbylThxWz8vExLcdQoqYrQx6K0v5HbutmfTtRD0CLkv3Vr4NCfga3wLDMw2XrznWXrZEW7MsGki1jlwBanHqM/c6b/EbeDW8k6EyE3LyJfJfehVAYdmsDz+fUxwztqz7XeUg=;
X-UUID: be68c517f8804365b67975553d85335d-20200711
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 475382782; Sat, 11 Jul 2020 14:52:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:52:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:52:24 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 18/21] iommu/mediatek: Add support for multi domain
Date: Sat, 11 Jul 2020 14:48:43 +0800
Message-ID: <20200711064846.16007-19-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

Some HW IP(ex: CCU) require the special iova range. That means the
iova got from dma_alloc_attrs for that devices must locate in his
special range. In this patch, we allocate a special iova_range for
each a special requirement and create each a iommu domain for each
a iova_range.

meanwhile we still use one pagetable which support 16GB iova.

After this patch, If the iova range of a master is over 4G, the master
should:
a) Declare its special dma_ranges in its dtsi node. For example, If we
preassign the iova 4G-8G for vcodec, then the vcodec dtsi node should:
	dma-ranges = <0x1 0x0 0x1 0x0 0x1 0x0>;  /* 4G ~ 8G */
b) Update the dma_mask:
 dma_set_mask_and_coherent(dev, DMA_BIT_MASK(33));

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 49 ++++++++++++++++++++++++++++++++-------
 drivers/iommu/mtk_iommu.h |  3 ++-
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 766c9e73d541..7dfd8071a858 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -361,6 +361,14 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 {
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 
+	/* Use the exist domain as there is one m4u pgtable here. */
+	if (data->m4u_dom) {
+		dom->iop = data->m4u_dom->iop;
+		dom->cfg = data->m4u_dom->cfg;
+		dom->domain.pgsize_bitmap = data->m4u_dom->cfg.pgsize_bitmap;
+		return 0;
+	}
+
 	dom->cfg = (struct io_pgtable_cfg) {
 		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
 			IO_PGTABLE_QUIRK_NO_PERMS |
@@ -386,6 +394,8 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 
 static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 {
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	const struct mtk_iommu_iova_region *region;
 	struct mtk_iommu_domain *dom;
 
 	if (type != IOMMU_DOMAIN_DMA)
@@ -401,8 +411,10 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (mtk_iommu_domain_finalise(dom))
 		goto  put_dma_cookie;
 
-	dom->domain.geometry.aperture_start = 0;
-	dom->domain.geometry.aperture_end = DMA_BIT_MASK(32);
+	region = data->plat_data->iova_region + data->cur_domid;
+	dom->domain.geometry.aperture_start = region->iova_base;
+	dom->domain.geometry.aperture_end = region->iova_base +
+						region->size - 1;
 	dom->domain.geometry.force_aperture = true;
 
 	return &dom->domain;
@@ -540,19 +552,31 @@ static void mtk_iommu_release_device(struct device *dev)
 static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 {
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iommu_group *group;
+	int domid;
 
 	if (!data)
 		return ERR_PTR(-ENODEV);
 
-	/* All the client devices are in the same m4u iommu-group */
-	if (!data->m4u_group) {
-		data->m4u_group = iommu_group_alloc();
-		if (IS_ERR(data->m4u_group))
+	domid = MTK_M4U_TO_DOM(fwspec->ids[0]);
+	if (domid >= data->plat_data->iova_region_nr) {
+		dev_err(dev, "domain id(%d/%d) is error.\n", domid,
+			data->plat_data->iova_region_nr);
+		return ERR_PTR(-EINVAL);
+	}
+
+	group = data->m4u_group[domid];
+	if (!group) {
+		group = iommu_group_alloc();
+		if (IS_ERR(group))
 			dev_err(dev, "Failed to allocate M4U IOMMU group\n");
+		data->m4u_group[domid] = group;
 	} else {
-		iommu_group_ref_get(data->m4u_group);
+		iommu_group_ref_get(group);
 	}
-	return data->m4u_group;
+	data->cur_domid = domid;
+	return group;
 }
 
 static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
@@ -581,14 +605,21 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
 				       struct list_head *head)
 {
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
-	const struct mtk_iommu_iova_region *resv;
+	const struct mtk_iommu_iova_region *resv, *curdom;
 	struct iommu_resv_region *region;
 	int prot = IOMMU_WRITE | IOMMU_READ;
 	unsigned int i;
 
+	curdom = data->plat_data->iova_region + data->cur_domid;
 	for (i = 0; i < data->plat_data->iova_region_nr; i++) {
 		resv = data->plat_data->iova_region + i;
 
+		/* Only reserve when the region is in the current domain */
+		if (resv->iova_base <= curdom->iova_base ||
+		    resv->iova_base + resv->size >=
+					curdom->iova_base + curdom->size)
+			continue;
+
 		region = iommu_alloc_resv_region(resv->iova_base, resv->size,
 						 prot, IOMMU_RESV_RESERVED);
 		if (!region)
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index bb929b875d8c..11795b8d82ff 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -65,7 +65,7 @@ struct mtk_iommu_data {
 	phys_addr_t			protect_base; /* protect memory base */
 	struct mtk_iommu_suspend_reg	reg;
 	struct mtk_iommu_domain		*m4u_dom;
-	struct iommu_group		*m4u_group;
+	struct iommu_group		*m4u_group[MTK_M4U_DOM_NR_MAX];
 	bool                            enable_4GB;
 	spinlock_t			tlb_lock; /* lock for tlb range flush */
 
@@ -73,6 +73,7 @@ struct mtk_iommu_data {
 	const struct mtk_iommu_plat_data *plat_data;
 	struct device			*smicomm_dev;
 
+	unsigned int			cur_domid;
 	struct list_head		list;
 	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
 };
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
