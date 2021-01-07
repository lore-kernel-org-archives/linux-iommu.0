Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B77C433DB
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 12:29:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77CF23358
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 12:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77CF23358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 986FA865C1;
	Thu,  7 Jan 2021 12:29:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AdTIzHdRE1o7; Thu,  7 Jan 2021 12:29:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D9C4484E42;
	Thu,  7 Jan 2021 12:29:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C781FC088B;
	Thu,  7 Jan 2021 12:29:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF1A8C013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 12:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BAFA0233A6
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 12:29:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZwhkjRfOrhmT for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 12:29:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by silver.osuosl.org (Postfix) with ESMTP id D9CB1232FA
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 12:29:40 +0000 (UTC)
X-UUID: a179893b427c46adb591d83809fc8caf-20210107
X-UUID: a179893b427c46adb591d83809fc8caf-20210107
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 7058970; Thu, 07 Jan 2021 20:29:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 Jan 2021 20:29:35 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Jan 2021 20:29:34 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 1/7] iommu: Move iotlb_sync_map out from __iommu_map
Date: Thu, 7 Jan 2021 20:29:03 +0800
Message-ID: <20210107122909.16317-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210107122909.16317-1-yong.wu@mediatek.com>
References: <20210107122909.16317-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 David Laight <David.Laight@ACULAB.COM>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com,
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

In the end of __iommu_map, It alway call iotlb_sync_map.

This patch moves iotlb_sync_map out from __iommu_map since it is
unnecessary to call this for each sg segment especially iotlb_sync_map
is flush tlb all currently. Add a little helper _iommu_map for this.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ffeebda8d6de..c304a6a30d42 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2426,9 +2426,6 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 		size -= pgsize;
 	}
 
-	if (ops->iotlb_sync_map)
-		ops->iotlb_sync_map(domain);
-
 	/* unroll mapping in case something went wrong */
 	if (ret)
 		iommu_unmap(domain, orig_iova, orig_size - size);
@@ -2438,18 +2435,31 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	return ret;
 }
 
+static int _iommu_map(struct iommu_domain *domain, unsigned long iova,
+		      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	const struct iommu_ops *ops = domain->ops;
+	int ret;
+
+	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
+	if (ret == 0 && ops->iotlb_sync_map)
+		ops->iotlb_sync_map(domain);
+
+	return ret;
+}
+
 int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	      phys_addr_t paddr, size_t size, int prot)
 {
 	might_sleep();
-	return __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
+	return _iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(iommu_map);
 
 int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
 	      phys_addr_t paddr, size_t size, int prot)
 {
-	return __iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
+	return _iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
 }
 EXPORT_SYMBOL_GPL(iommu_map_atomic);
 
@@ -2533,6 +2543,7 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			     struct scatterlist *sg, unsigned int nents, int prot,
 			     gfp_t gfp)
 {
+	const struct iommu_ops *ops = domain->ops;
 	size_t len = 0, mapped = 0;
 	phys_addr_t start;
 	unsigned int i = 0;
@@ -2563,6 +2574,8 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			sg = sg_next(sg);
 	}
 
+	if (ops->iotlb_sync_map)
+		ops->iotlb_sync_map(domain);
 	return mapped;
 
 out_err:
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
