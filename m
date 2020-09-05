Return-Path: <SRS0=R2i3=CO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32318C2BBD0
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 08:13:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB22D2074D
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 08:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bkGz1rCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB22D2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C27C32052C;
	Sat,  5 Sep 2020 08:13:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TLRx64ZThc2L; Sat,  5 Sep 2020 08:13:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5F9FD20380;
	Sat,  5 Sep 2020 08:13:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 475A7C088B;
	Sat,  5 Sep 2020 08:13:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9F3EC0052
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 08:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D6F9620390
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 08:13:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h+o42mUQ2Vpv for <iommu@lists.linux-foundation.org>;
 Sat,  5 Sep 2020 08:13:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by silver.osuosl.org (Postfix) with ESMTP id A4E7820380
 for <iommu@lists.linux-foundation.org>; Sat,  5 Sep 2020 08:13:38 +0000 (UTC)
X-UUID: 381da0d9dfc14e219da206127e3f36d9-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=l8Aq+TVie3k2Aq8o0+LpX7YhzFPWXC7lxDHgVz1jlN4=; 
 b=bkGz1rChh67LqdQ67gfHpVcgAJ7yNbvPtp57KCbXZF0M+rEzthCI2pnA0M1Pv0no3n3ws3EYwimYcsdacuULKf1YrJpZDx815yDfXkD/FV2Q6gZWuJC1sVzw6ymzdazX6x/ii0egxQ7fmGXHqjAX5DjTJdHGunSgunJ5fo3pr0Y=;
X-UUID: 381da0d9dfc14e219da206127e3f36d9-20200905
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 202941406; Sat, 05 Sep 2020 16:13:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:13:31 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:13:31 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 15/23] iommu/mediatek: Add iova reserved function
Date: Sat, 5 Sep 2020 16:09:12 +0800
Message-ID: <20200905080920.13396-16-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 72F648CDE297A7F1184FD55C1EE483861396E92899FD3A72EB0D9BDF248D4C5D2000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

For multiple iommu_domains, we need to reserve some iova regions. Take a
example, If the default iova region is 0 ~ 4G, but the 0x4000_0000 ~
0x43ff_ffff is only for the special CCU0 domain. Thus we should exclude
this region for the default iova region.

This patch adds iova reserved flow. It's a preparing patch for supporting
multi-domain.

Signed-off-by: Anan sun <anan.sun@mediatek.com>
Signed-off-by: Chao Hao <chao.hao@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 28 ++++++++++++++++++++++++++++
 drivers/iommu/mtk_iommu.h |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d22772ec64c8..5b63732044de 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -153,6 +153,11 @@ static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 
 #define for_each_m4u(data)	list_for_each_entry(data, &m4ulist, list)
 
+struct mtk_iommu_iova_region {
+	dma_addr_t		iova_base;
+	unsigned long long	size;
+};
+
 /*
  * There may be 1 or 2 M4U HWs, But we always expect they are in the same domain
  * for the performance.
@@ -539,6 +544,27 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
+static void mtk_iommu_get_resv_regions(struct device *dev,
+				       struct list_head *head)
+{
+	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
+	const struct mtk_iommu_iova_region *resv;
+	struct iommu_resv_region *region;
+	int prot = IOMMU_WRITE | IOMMU_READ;
+	unsigned int i;
+
+	for (i = 0; i < data->plat_data->iova_region_nr; i++) {
+		resv = data->plat_data->iova_region + i;
+
+		region = iommu_alloc_resv_region(resv->iova_base, resv->size,
+						 prot, IOMMU_RESV_RESERVED);
+		if (!region)
+			return;
+
+		list_add_tail(&region->list, head);
+	}
+}
+
 static const struct iommu_ops mtk_iommu_ops = {
 	.domain_alloc	= mtk_iommu_domain_alloc,
 	.domain_free	= mtk_iommu_domain_free,
@@ -553,6 +579,8 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.release_device	= mtk_iommu_release_device,
 	.device_group	= mtk_iommu_device_group,
 	.of_xlate	= mtk_iommu_of_xlate,
+	.get_resv_regions = mtk_iommu_get_resv_regions,
+	.put_resv_regions = generic_iommu_put_resv_regions,
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 };
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index ae7909815cdb..d45c13c9d324 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -44,10 +44,15 @@ enum mtk_iommu_plat {
 	M4U_MT8183,
 };
 
+struct mtk_iommu_iova_region;
+
 struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat m4u_plat;
 	u32                 flags;
 	u32                 inv_sel_reg;
+
+	unsigned int        iova_region_nr;
+	const struct mtk_iommu_iova_region   *iova_region;
 	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
 };
 
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
