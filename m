Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47D8C433DB
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 11:54:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F5E2311D
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 11:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F5E2311D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 13EB98553B;
	Tue, 26 Jan 2021 11:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cBcQBkk8r-fp; Tue, 26 Jan 2021 11:53:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 52FF985507;
	Tue, 26 Jan 2021 11:53:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BA0AC08A1;
	Tue, 26 Jan 2021 11:53:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EC6CC013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 11:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 09DFD2040D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 11:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ey+-SLmm-ka for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 11:53:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id DB30D203BB
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 11:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611662034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
 bh=HK5zgv0TzAJp0znH+yS6WzPBPy1aDuG2HqE9/6xDyzU=;
 b=d2djHxGJbxdRemqJ7LWPLJqML9M6K6ZbanUgKXOOCxs17M6sWVfMoP9NxvRpaXlTkMhkE+
 /IpUIyHY5LI5hGqFtCfCxgW5MHZfaFHJJrCkXT9vyaVEJQoY9/azTx09RA/ZzjxR9ieUcc
 Q+aAauSjVtC/pFaYkSGEFkoV3CMVlZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-rV-Y6hZ2N0a7k4l6cWv2BQ-1; Tue, 26 Jan 2021 06:53:51 -0500
X-MC-Unique: rV-Y6hZ2N0a7k4l6cWv2BQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 754CB801FCC;
 Tue, 26 Jan 2021 11:53:49 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-72.pek2.redhat.com
 [10.72.12.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4319110023AB;
 Tue, 26 Jan 2021 11:53:44 +0000 (UTC)
From: Lianbo Jiang <lijiang@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dma-iommu: use static-key to minimize the impact in
 the fast-path
Date: Tue, 26 Jan 2021 19:53:36 +0800
Message-Id: <20210126115337.20068-2-lijiang@redhat.com>
In-Reply-To: <20210126115337.20068-1-lijiang@redhat.com>
References: <20210126115337.20068-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: thomas.lendacky@amd.com, will@kernel.org, hch@infradead.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Let's move out the is_kdump_kernel() check from iommu_dma_deferred_attach()
to iommu_dma_init(), and use the static-key in the fast-path to minimize
the impact in the normal case.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Co-developed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4078358ed66e..c80056f6c9f9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -51,6 +51,8 @@ struct iommu_dma_cookie {
 	struct iommu_domain		*fq_domain;
 };
 
+static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
+
 void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 		struct iommu_domain *domain)
 {
@@ -383,9 +385,6 @@ static int iommu_dma_deferred_attach(struct device *dev,
 {
 	const struct iommu_ops *ops = domain->ops;
 
-	if (!is_kdump_kernel())
-		return 0;
-
 	if (unlikely(ops->is_attach_deferred &&
 			ops->is_attach_deferred(domain, dev)))
 		return iommu_attach_device(domain, dev);
@@ -535,7 +534,8 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	size_t iova_off = iova_offset(iovad, phys);
 	dma_addr_t iova;
 
-	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
+	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
+	    iommu_dma_deferred_attach(dev, domain))
 		return DMA_MAPPING_ERROR;
 
 	size = iova_align(iovad, size + iova_off);
@@ -693,7 +693,8 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 
 	*dma_handle = DMA_MAPPING_ERROR;
 
-	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
+	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
+	    iommu_dma_deferred_attach(dev, domain))
 		return NULL;
 
 	min_size = alloc_sizes & -alloc_sizes;
@@ -976,7 +977,8 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	unsigned long mask = dma_get_seg_boundary(dev);
 	int i;
 
-	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
+	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
+	    iommu_dma_deferred_attach(dev, domain))
 		return 0;
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
@@ -1424,6 +1426,9 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 static int iommu_dma_init(void)
 {
+	if (is_kdump_kernel())
+		static_branch_enable(&iommu_deferred_attach_enabled);
+
 	return iova_cache_get();
 }
 arch_initcall(iommu_dma_init);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
