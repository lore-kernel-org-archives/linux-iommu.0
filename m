Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC0DCA9EB5
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 11:53:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B4021E6F
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 11:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B4021E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 548F6F19;
	Mon,  4 Nov 2019 11:53:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E82F4F16
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 11:53:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 22B39710
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 11:53:00 +0000 (UTC)
X-UUID: 42a4009e2207450cbb59ebf4ff4dbb3e-20191104
X-UUID: 42a4009e2207450cbb59ebf4ff4dbb3e-20191104
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
	(envelope-from <chao.hao@mediatek.com>)
	(Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
	with ESMTP id 1206833269; Mon, 04 Nov 2019 19:52:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
	mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Mon, 4 Nov 2019 19:52:55 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
	(172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Mon, 4 Nov 2019 19:52:51 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
	Brugger <matthias.bgg@gmail.com>
Subject: [RESEND,PATCH 06/13] iommu/mediatek: Change get the way of m4u_group
Date: Mon, 4 Nov 2019 19:52:31 +0800
Message-ID: <20191104115238.2394-7-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191104115238.2394-1-chao.hao@mediatek.com>
References: <20191104115238.2394-1-chao.hao@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: Anan Sun <anan.sun@mediatek.com>, devicetree@vger.kernel.org,
	Cui Zhang <cui.zhang@mediatek.com>,
	Jun Yan <jun.yan@mediatek.com>, wsd_upstream@mediatek.com,
	linux-kernel@vger.kernel.org, Chao Hao <chao.hao@mediatek.com>,
	iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
	Miles Chen <miles.chen@mediatek.com>, linux-arm-kernel@lists.infradead.org,
	Guangming Cao <guangming.cao@mediatek.com>
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

1. Redefine mtk_iommu_domain structure, it will include iommu_group
and iommu_domain. Different mtk_iommu_domains can be distinguished by
ID. When we realize multiple mtk_iommu_domains, every mtk_iommu_domain
can describe one iova region.
2. In theory, every device has one iommu_group, so this patch will
get iommu_group by checking device. All the devices belong to the same
m4u_group currently, so they also use the same mtk_iommu_domain(id=0).

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index f264fa8c16a0..27995b2b29a6 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -117,12 +117,16 @@
 #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
 
 struct mtk_iommu_domain {
+	u32				id;
 	struct iommu_domain		domain;
+	struct iommu_group		*group;
+	struct list_head		list;
 };
 
 struct mtk_iommu_pgtable {
 	struct io_pgtable_cfg	cfg;
 	struct io_pgtable_ops	*iop;
+	struct list_head	m4u_dom_v2;
 };
 
 static struct mtk_iommu_pgtable *share_pgtable;
@@ -173,6 +177,41 @@ static struct mtk_iommu_data *mtk_iommu_get_m4u_data(void)
 	return NULL;
 }
 
+static u32 get_domain_id(void)
+{
+	/* only support one mtk_iommu_domain currently */
+	return 0;
+}
+
+static u32 mtk_iommu_get_domain_id(void)
+{
+	return get_domain_id();
+}
+
+static struct mtk_iommu_domain *get_mtk_domain(struct device *dev)
+{
+	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
+	struct mtk_iommu_domain *dom;
+	u32 domain_id = mtk_iommu_get_domain_id();
+
+	list_for_each_entry(dom, &data->pgtable->m4u_dom_v2, list) {
+		if (dom->id == domain_id)
+			return dom;
+	}
+	return NULL;
+}
+
+static struct iommu_group *mtk_iommu_get_group(struct device *dev)
+{
+	struct mtk_iommu_domain *dom;
+
+	dom = get_mtk_domain(dev);
+	if (dom)
+		return dom->group;
+
+	return NULL;
+}
+
 static struct mtk_iommu_pgtable *mtk_iommu_get_pgtable(void)
 {
 	return share_pgtable;
@@ -334,6 +373,8 @@ static struct mtk_iommu_pgtable *create_pgtable(struct mtk_iommu_data *data)
 	if (!pgtable)
 		return ERR_PTR(-ENOMEM);
 
+	INIT_LIST_HEAD(&pgtable->m4u_dom_v2);
+
 	pgtable->cfg = (struct io_pgtable_cfg) {
 		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
 			IO_PGTABLE_QUIRK_NO_PERMS |
@@ -388,6 +429,7 @@ static int mtk_iommu_attach_pgtable(struct mtk_iommu_data *data,
 static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 {
 	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	struct mtk_iommu_domain *dom;
 
 	if (type != IOMMU_DOMAIN_DMA)
@@ -405,12 +447,15 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (iommu_get_dma_cookie(&dom->domain))
 		goto  free_dom;
 
+	dom->group = data->m4u_group;
+	dom->id = mtk_iommu_get_domain_id();
 	/* Update our support page sizes bitmap */
 	dom->domain.pgsize_bitmap = pgtable->cfg.pgsize_bitmap;
 
 	dom->domain.geometry.aperture_start = 0;
 	dom->domain.geometry.aperture_end = DMA_BIT_MASK(32);
 	dom->domain.geometry.force_aperture = true;
+	list_add_tail(&dom->list, &pgtable->m4u_dom_v2);
 
 	return &dom->domain;
 
@@ -566,6 +611,7 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 	}
 
 	/* All the client devices are in the same m4u iommu-group */
+	data->m4u_group = mtk_iommu_get_group(dev);
 	if (!data->m4u_group) {
 		data->m4u_group = iommu_group_alloc();
 		if (IS_ERR(data->m4u_group))
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
