Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398E5C433EF
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 10:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA34542544;
	Thu, 26 May 2022 10:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zo0KSSgqy6Te; Thu, 26 May 2022 10:35:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 94CC542510;
	Thu, 26 May 2022 10:35:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79E76C0039;
	Thu, 26 May 2022 10:35:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8EC2C002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 10:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 973FD42510
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 10:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kJVdAK60Oz_q for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 10:35:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 92E094253A
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 10:35:50 +0000 (UTC)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L844y05jYz687hH;
 Thu, 26 May 2022 18:32:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 12:35:47 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 11:35:43 +0100
To: <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hch@lst.de>,
 <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
Subject: [PATCH v2 2/4] dma-iommu: Add iommu_dma_opt_mapping_size()
Date: Thu, 26 May 2022 18:28:32 +0800
Message-ID: <1653560914-82185-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1653560914-82185-1-git-send-email-john.garry@huawei.com>
References: <1653560914-82185-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
 liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add the IOMMU callback for DMA mapping API dma_opt_mapping_size(), which
allows the drivers to know the optimal mapping limit and thus limit the
requested IOVA lengths.

This value is based on the IOVA rcache range limit, as IOVAs allocated
above this limit must always be newly allocated, which may be quite slow.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/dma-iommu.c | 6 ++++++
 drivers/iommu/iova.c      | 5 +++++
 include/linux/iova.h      | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09f6e1c0f9c0..f619e41b9172 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1442,6 +1442,11 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
 	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
 }
 
+static size_t iommu_dma_opt_mapping_size(void)
+{
+	return iova_rcache_range();
+}
+
 static const struct dma_map_ops iommu_dma_ops = {
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
@@ -1462,6 +1467,7 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.map_resource		= iommu_dma_map_resource,
 	.unmap_resource		= iommu_dma_unmap_resource,
 	.get_merge_boundary	= iommu_dma_get_merge_boundary,
+	.opt_mapping_size	= iommu_dma_opt_mapping_size,
 };
 
 /*
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index db77aa675145..9f00b58d546e 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -26,6 +26,11 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
 
+unsigned long iova_rcache_range(void)
+{
+	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
+}
+
 static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
 {
 	struct iova_domain *iovad;
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 320a70e40233..c6ba6d95d79c 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -79,6 +79,8 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
 int iova_cache_get(void);
 void iova_cache_put(void);
 
+unsigned long iova_rcache_range(void);
+
 void free_iova(struct iova_domain *iovad, unsigned long pfn);
 void __free_iova(struct iova_domain *iovad, struct iova *iova);
 struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
