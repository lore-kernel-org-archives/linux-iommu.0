Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D787C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 17:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C556880BB3;
	Mon, 14 Feb 2022 17:35:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jK9v5_9_1gWg; Mon, 14 Feb 2022 17:35:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A3AA28134A;
	Mon, 14 Feb 2022 17:35:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B62CC001A;
	Mon, 14 Feb 2022 17:35:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D884C000B;
 Mon, 14 Feb 2022 17:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0ECBD80C68;
 Mon, 14 Feb 2022 17:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lHQ1ftdHky5i; Mon, 14 Feb 2022 17:35:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1FCAC815AB;
 Mon, 14 Feb 2022 17:35:07 +0000 (UTC)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JyBDj5LyQz6H6y8;
 Tue, 15 Feb 2022 01:34:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 18:35:05 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 17:35:01 +0000
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v5 5/5] iova: Add iova_len argument to
 iova_domain_init_rcaches()
Date: Tue, 15 Feb 2022 01:29:06 +0800
Message-ID: <1644859746-20279-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1644859746-20279-1-git-send-email-john.garry@huawei.com>
References: <1644859746-20279-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: mst@redhat.com, jasowang@redhat.com, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, hch@lst.de
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

Add max opt argument to iova_domain_init_rcaches(), and use it to set the
rcaches range.

Also fix up all users to set this value (at 0, meaning use default),
including a wrapper for that, iova_domain_init_rcaches_default().

For dma-iommu.c we derive the iova_len argument from the IOMMU group
max opt DMA size.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/dma-iommu.c            | 15 ++++++++++++++-
 drivers/iommu/iova.c                 | 19 ++++++++++++++++---
 drivers/vdpa/vdpa_user/iova_domain.c |  4 ++--
 include/linux/iova.h                 |  3 ++-
 4 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 908272f0153e..7afa2226c6bd 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -525,6 +525,8 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	unsigned long order, base_pfn;
 	struct iova_domain *iovad;
+	size_t max_opt_dma_size;
+	unsigned long iova_len = 0;
 	int ret;
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
@@ -560,7 +562,18 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	}
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
-	ret = iova_domain_init_rcaches(iovad);
+
+	max_opt_dma_size = iommu_group_get_max_opt_dma_size(dev->iommu_group);
+	if (max_opt_dma_size) {
+		unsigned long shift = __ffs(1UL << order);
+
+		iova_len = roundup_pow_of_two(max_opt_dma_size);
+		iova_len >>= shift;
+		if (!iova_len)
+			iova_len = 1;
+	}
+
+	ret = iova_domain_init_rcaches(iovad, iova_len);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index f6eb93c737cb..f05aae044e25 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -705,12 +705,20 @@ static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
 	mag->pfns[mag->size++] = pfn;
 }
 
-int iova_domain_init_rcaches(struct iova_domain *iovad)
+static unsigned long iova_len_to_rcache_max(unsigned long iova_len)
+{
+	return order_base_2(iova_len) + 1;
+}
+
+int iova_domain_init_rcaches(struct iova_domain *iovad, unsigned long iova_len)
 {
 	unsigned int cpu;
 	int i, ret;
 
-	iovad->rcache_max_size = 6; /* Arbitrarily high default */
+	if (iova_len)
+		iovad->rcache_max_size = iova_len_to_rcache_max(iova_len);
+	else
+		iovad->rcache_max_size = 6; /* Arbitrarily high default */
 
 	iovad->rcaches = kcalloc(iovad->rcache_max_size,
 				 sizeof(struct iova_rcache),
@@ -754,7 +762,12 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 	free_iova_rcaches(iovad);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iova_domain_init_rcaches);
+
+int iova_domain_init_rcaches_default(struct iova_domain *iovad)
+{
+	return iova_domain_init_rcaches(iovad, 0);
+}
+EXPORT_SYMBOL_GPL(iova_domain_init_rcaches_default);
 
 /*
  * Try inserting IOVA range starting with 'iova_pfn' into 'rcache', and
diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 22f7d43f8a68..74471bc463ec 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -514,12 +514,12 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
 	spin_lock_init(&domain->iotlb_lock);
 	init_iova_domain(&domain->stream_iovad,
 			PAGE_SIZE, IOVA_START_PFN);
-	ret = iova_domain_init_rcaches(&domain->stream_iovad);
+	ret = iova_domain_init_rcaches_default(&domain->stream_iovad);
 	if (ret)
 		goto err_iovad_stream;
 	init_iova_domain(&domain->consistent_iovad,
 			PAGE_SIZE, bounce_pfns);
-	ret = iova_domain_init_rcaches(&domain->consistent_iovad);
+	ret = iova_domain_init_rcaches_default(&domain->consistent_iovad);
 	if (ret)
 		goto err_iovad_consistent;
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 02f7222fa85a..56281434ce0c 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -95,7 +95,8 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn);
-int iova_domain_init_rcaches(struct iova_domain *iovad);
+int iova_domain_init_rcaches(struct iova_domain *iovad, unsigned long iova_len);
+int iova_domain_init_rcaches_default(struct iova_domain *iovad);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 #else
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
