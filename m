Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1435C4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 12:22:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E4E260FC3
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 12:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E4E260FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C1A583A41;
	Wed, 11 Aug 2021 12:22:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1pSdJjl4oZSy; Wed, 11 Aug 2021 12:22:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 198BE83A72;
	Wed, 11 Aug 2021 12:22:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB2ECC000E;
	Wed, 11 Aug 2021 12:22:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67EA7C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6486F82F84
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:22:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4BN1_r8nYoUF for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:22:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E2D083A8A
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 12:22:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BD2E13A1;
 Wed, 11 Aug 2021 05:22:40 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8C283F718;
 Wed, 11 Aug 2021 05:22:37 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v4 24/24] iommu: Allow enabling non-strict mode dynamically
Date: Wed, 11 Aug 2021 13:21:38 +0100
Message-Id: <d652966348c78457c38bf18daf369272a4ebc2c9.1628682049.git.robin.murphy@arm.com>
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

Allocating and enabling a flush queue is in fact something we can
reasonably do while a DMA domain is active, without having to rebuild it
from scratch. Thus we can allow a strict -> non-strict transition from
sysfs without requiring to unbind the device's driver, which is of
particular interest to users who want to make selective relaxations to
critical devices like the one serving their root filesystem.

Disabling and draining a queue also seems technically possible to
achieve without rebuilding the whole domain, but would certainly be more
involved. Furthermore there's not such a clear use-case for tightening
up security *after* the device may already have done whatever it is that
you don't trust it not to do, so we only consider the relaxation case.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Actually think about concurrency, rework most of the fq data
    accesses to be (hopefully) safe and comment it all

v4: Squash in simplified iommu_dma_init_fq() refactor, clean up previous
    barrier from init_iova_flush_queue(), drop rogue header change
    (turns out there's a whole other rabbit hole of iova_fq cleanup to
    venture down after this...)

---
 drivers/iommu/dma-iommu.c | 47 ++++++++++++++++++++++++++-------------
 drivers/iommu/iommu.c     | 17 ++++++++++----
 drivers/iommu/iova.c      | 11 ++++-----
 include/linux/dma-iommu.h |  6 +++++
 4 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 01fa83229118..27f98a29f49a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -310,6 +310,30 @@ static bool dev_is_untrusted(struct device *dev)
 	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
 }
 
+/* sysfs updates are serialised by the mutex of the group owning @domain */
+int iommu_dma_init_fq(struct iommu_domain *domain)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	int ret;
+
+	if (cookie->fq_domain)
+		return 0;
+
+	ret = init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
+				    iommu_dma_entry_dtor);
+	if (ret) {
+		pr_warn("iova flush queue initialization failed\n");
+		return ret;
+	}
+	/*
+	 * Prevent incomplete iovad->fq being observable. Pairs with path from
+	 * __iommu_dma_unmap() through iommu_dma_free_iova() to queue_iova()
+	 */
+	smp_wmb();
+	WRITE_ONCE(cookie->fq_domain, domain);
+	return 0;
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -364,15 +388,8 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 
 	/* If the FQ fails we can simply fall back to strict mode */
-	if (domain->type == IOMMU_DOMAIN_DMA_FQ && !cookie->fq_domain) {
-		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
-					  iommu_dma_entry_dtor)) {
-			pr_warn("iova flush queue initialization failed\n");
-			domain->type = IOMMU_DOMAIN_DMA;
-		} else {
-			cookie->fq_domain = domain;
-		}
-	}
+	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
+		domain->type = IOMMU_DOMAIN_DMA;
 
 	return iova_reserve_iommu_regions(dev, domain);
 }
@@ -447,17 +464,17 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 }
 
 static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
-		dma_addr_t iova, size_t size, struct page *freelist)
+		dma_addr_t iova, size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct iova_domain *iovad = &cookie->iovad;
 
 	/* The MSI case is only ever cleaning up its most recent allocation */
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
 		cookie->msi_iova -= size;
-	else if (cookie->fq_domain)	/* non-strict mode */
+	else if (gather && gather->queued)
 		queue_iova(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad),
-				(unsigned long)freelist);
+				(unsigned long)gather->freelist);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
@@ -476,14 +493,14 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 	dma_addr -= iova_off;
 	size = iova_align(iovad, size + iova_off);
 	iommu_iotlb_gather_init(&iotlb_gather);
-	iotlb_gather.queued = cookie->fq_domain;
+	iotlb_gather.queued = READ_ONCE(cookie->fq_domain);
 
 	unmapped = iommu_unmap_fast(domain, dma_addr, size, &iotlb_gather);
 	WARN_ON(unmapped != size);
 
-	if (!cookie->fq_domain)
+	if (!iotlb_gather.queued)
 		iommu_iotlb_sync(domain, &iotlb_gather);
-	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
+	iommu_dma_free_iova(cookie, dma_addr, size, &iotlb_gather);
 }
 
 static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 480ad6a538a9..135d274d6d9f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3203,6 +3203,14 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 		goto out;
 	}
 
+	/* We can bring up a flush queue without tearing down the domain */
+	if (type == IOMMU_DOMAIN_DMA_FQ && prev_dom->type == IOMMU_DOMAIN_DMA) {
+		ret = iommu_dma_init_fq(prev_dom);
+		if (!ret)
+			prev_dom->type = IOMMU_DOMAIN_DMA_FQ;
+		goto out;
+	}
+
 	/* Sets group->default_domain to the newly allocated domain */
 	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
 	if (ret)
@@ -3243,9 +3251,9 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 }
 
 /*
- * Changing the default domain through sysfs requires the users to ubind the
- * drivers from the devices in the iommu group. Return failure if this doesn't
- * meet.
+ * Changing the default domain through sysfs requires the users to unbind the
+ * drivers from the devices in the iommu group, except for a DMA -> DMA-FQ
+ * transition. Return failure if this isn't met.
  *
  * We need to consider the race between this and the device release path.
  * device_lock(dev) is used here to guarantee that the device release path
@@ -3321,7 +3329,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 	/* Check if the device in the group still has a driver bound to it */
 	device_lock(dev);
-	if (device_is_bound(dev)) {
+	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
+	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
 		pr_err_ratelimited("Device is still bound to driver\n");
 		ret = -EBUSY;
 		goto out;
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 2ad73fb2e94e..0af42fb93a49 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -121,8 +121,6 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 		spin_lock_init(&fq->lock);
 	}
 
-	smp_wmb();
-
 	iovad->fq = queue;
 
 	timer_setup(&iovad->fq_timer, fq_flush_timeout, 0);
@@ -633,17 +631,20 @@ void queue_iova(struct iova_domain *iovad,
 		unsigned long pfn, unsigned long pages,
 		unsigned long data)
 {
-	struct iova_fq *fq = raw_cpu_ptr(iovad->fq);
+	struct iova_fq *fq;
 	unsigned long flags;
 	unsigned idx;
 
 	/*
 	 * Order against the IOMMU driver's pagetable update from unmapping
 	 * @pte, to guarantee that iova_domain_flush() observes that if called
-	 * from a different CPU before we release the lock below.
+	 * from a different CPU before we release the lock below. Full barrier
+	 * so it also pairs with iommu_dma_init_fq() to avoid seeing partially
+	 * written fq state here.
 	 */
-	smp_wmb();
+	smp_mb();
 
+	fq = raw_cpu_ptr(iovad->fq);
 	spin_lock_irqsave(&fq->lock, flags);
 
 	/*
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 758ca4694257..24607dc3c2ac 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -20,6 +20,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain);
 
 /* Setup call for arch DMA mapping code */
 void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
+int iommu_dma_init_fq(struct iommu_domain *domain);
 
 /* The DMA API isn't _quite_ the whole story, though... */
 /*
@@ -54,6 +55,11 @@ static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
 {
 }
 
+static inline int iommu_dma_init_fq(struct iommu_domain *domain)
+{
+	return -EINVAL;
+}
+
 static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
 {
 	return -ENODEV;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
