Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED97AC4320A
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 12:22:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7057610F8
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 12:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7057610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8210F40568;
	Wed, 11 Aug 2021 12:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tcRhB5lPKSx2; Wed, 11 Aug 2021 12:22:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5DF2B4055D;
	Wed, 11 Aug 2021 12:22:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E89EC000E;
	Wed, 11 Aug 2021 12:22:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E1E4C001A
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75B22839E7
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:22:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NeZbBr5awCV7 for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:22:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id A48C183422
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:22:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B85A13D5;
 Wed, 11 Aug 2021 05:22:19 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 705EC3F718;
 Wed, 11 Aug 2021 05:22:17 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v4 14/24] iommu: Indicate queued flushes via gather data
Date: Wed, 11 Aug 2021 13:21:28 +0100
Message-Id: <bf5f8e2ad84e48c712ccbf80fa8c610594c7595f.1628682049.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628682048.git.robin.murphy@arm.com>
References: <cover.1628682048.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, rajatja@google.com,
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

Since iommu_iotlb_gather exists to help drivers optimise flushing for a
given unmap request, it is also the logical place to indicate whether
the unmap is strict or not, and thus help them further optimise for
whether to expect a sync or a flush_all subsequently. As part of that,
it also seems fair to make the flush queue code take responsibility for
enforcing the really subtle ordering requirement it brings, so that we
don't need to worry about forgetting that if new drivers want to add
flush queue support, and can consolidate the existing versions.

While we're adding to the kerneldoc, also fill in some info for
@freelist which was overlooked previously.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: New
---
 drivers/iommu/dma-iommu.c | 1 +
 drivers/iommu/iova.c      | 7 +++++++
 include/linux/iommu.h     | 8 +++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e28396cea6eb..d63b30a7dc82 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -474,6 +474,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 	dma_addr -= iova_off;
 	size = iova_align(iovad, size + iova_off);
 	iommu_iotlb_gather_init(&iotlb_gather);
+	iotlb_gather.queued = cookie->fq_domain;
 
 	unmapped = iommu_unmap_fast(domain, dma_addr, size, &iotlb_gather);
 	WARN_ON(unmapped != size);
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b6cf5f16123b..2ad73fb2e94e 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -637,6 +637,13 @@ void queue_iova(struct iova_domain *iovad,
 	unsigned long flags;
 	unsigned idx;
 
+	/*
+	 * Order against the IOMMU driver's pagetable update from unmapping
+	 * @pte, to guarantee that iova_domain_flush() observes that if called
+	 * from a different CPU before we release the lock below.
+	 */
+	smp_wmb();
+
 	spin_lock_irqsave(&fq->lock, flags);
 
 	/*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 141779d76035..f7679f6684b1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -161,16 +161,22 @@ enum iommu_dev_features {
  * @start: IOVA representing the start of the range to be flushed
  * @end: IOVA representing the end of the range to be flushed (inclusive)
  * @pgsize: The interval at which to perform the flush
+ * @freelist: Removed pages to free after sync
+ * @queued: Indicates that the flush will be queued
  *
  * This structure is intended to be updated by multiple calls to the
  * ->unmap() function in struct iommu_ops before eventually being passed
- * into ->iotlb_sync().
+ * into ->iotlb_sync(). Drivers can add pages to @freelist to be freed after
+ * ->iotlb_sync() or ->iotlb_flush_all() have cleared all cached references to
+ * them. @queued is set to indicate when ->iotlb_flush_all() will be called
+ * later instead of ->iotlb_sync(), so drivers may optimise accordingly.
  */
 struct iommu_iotlb_gather {
 	unsigned long		start;
 	unsigned long		end;
 	size_t			pgsize;
 	struct page		*freelist;
+	bool			queued;
 };
 
 /**
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
