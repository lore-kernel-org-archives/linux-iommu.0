Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB31C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 11:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C889A40285;
	Tue,  7 Dec 2021 11:22:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LwKCTtepm9Vq; Tue,  7 Dec 2021 11:22:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 74B5D40104;
	Tue,  7 Dec 2021 11:22:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DC18C001E;
	Tue,  7 Dec 2021 11:22:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D157C0012;
 Tue,  7 Dec 2021 11:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DCE8606B9;
 Tue,  7 Dec 2021 11:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id roViV2fZU2Gx; Tue,  7 Dec 2021 11:22:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99E72606A3;
 Tue,  7 Dec 2021 11:22:44 +0000 (UTC)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J7d8N6mKtz67sBW;
 Tue,  7 Dec 2021 19:18:28 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 12:22:40 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 11:22:38 +0000
To: <joro@8bytes.org>, <will@kernel.org>
Subject: [PATCH v2] iova: Move fast alloc size roundup into alloc_iova_fast()
Date: Tue, 7 Dec 2021 19:17:26 +0800
Message-ID: <1638875846-23993-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

It really is a property of the IOVA rcache code that we need to alloc a
power-of-2 size, so relocate the functionality to resize into
alloc_iova_fast(), rather than the callsites.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Differences to v1:
- Separate out from original series which conflicts with Robin's IOVA FQ work:
  https://lore.kernel.org/linux-iommu/1632477717-5254-1-git-send-email-john.garry@huawei.com/
- Add tags - thanks!

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b42e38a0dbe2..84dee53fe892 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -442,14 +442,6 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 
 	shift = iova_shift(iovad);
 	iova_len = size >> shift;
-	/*
-	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
-	 * will come back to bite us badly, so we have to waste a bit of space
-	 * rounding up anything cacheable to make sure that can't happen. The
-	 * order of the unadjusted size will still match upon freeing.
-	 */
-	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
-		iova_len = roundup_pow_of_two(iova_len);
 
 	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
 
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 9e8bc802ac05..ff567cbc42f7 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -497,6 +497,15 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 	unsigned long iova_pfn;
 	struct iova *new_iova;
 
+	/*
+	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
+	 * will come back to bite us badly, so we have to waste a bit of space
+	 * rounding up anything cacheable to make sure that can't happen. The
+	 * order of the unadjusted size will still match upon freeing.
+	 */
+	if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
+		size = roundup_pow_of_two(size);
+
 	iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
 	if (iova_pfn)
 		return iova_pfn;
diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 1daae2608860..2b1143f11d8f 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -292,14 +292,6 @@ vduse_domain_alloc_iova(struct iova_domain *iovad,
 	unsigned long iova_len = iova_align(iovad, size) >> shift;
 	unsigned long iova_pfn;
 
-	/*
-	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
-	 * will come back to bite us badly, so we have to waste a bit of space
-	 * rounding up anything cacheable to make sure that can't happen. The
-	 * order of the unadjusted size will still match upon freeing.
-	 */
-	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
-		iova_len = roundup_pow_of_two(iova_len);
 	iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true);
 
 	return iova_pfn << shift;
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
