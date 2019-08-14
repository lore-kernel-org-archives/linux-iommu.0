Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA50FC433FF
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 18:04:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD430216F4
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 18:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD430216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7AC2CDCB;
	Wed, 14 Aug 2019 18:04:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 553EDDA4
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 18:04:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 4B1F576D
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 18:04:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D864360;
	Wed, 14 Aug 2019 10:56:43 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 996813F694; 
	Wed, 14 Aug 2019 10:56:41 -0700 (PDT)
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 01/13] iommu: Remove empty iommu_tlb_range_add() callback from
	iommu_ops
Date: Wed, 14 Aug 2019 18:56:22 +0100
Message-Id: <20190814175634.21081-2-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190814175634.21081-1-will@kernel.org>
References: <20190814175634.21081-1-will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Vijay Kilary <vkilari@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>,
	Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Jon Masters <jcm@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
	Will Deacon <will@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Commit add02cfdc9bc ("iommu: Introduce Interface for IOMMU TLB Flushing")
added three new TLB flushing operations to the IOMMU API so that the
underlying driver operations can be batched when unmapping large regions
of IO virtual address space.

However, the ->iotlb_range_add() callback has not been implemented by
any IOMMU drivers (amd_iommu.c implements it as an empty function, which
incurs the overhead of an indirect branch). Instead, drivers either flush
the entire IOTLB in the ->iotlb_sync() callback or perform the necessary
invalidation during ->unmap().

Attempting to implement ->iotlb_range_add() for arm-smmu-v3.c revealed
two major issues:

  1. The page size used to map the region in the page-table is not known,
     and so it is not generally possible to issue TLB flushes in the most
     efficient manner.

  2. The only mutable state passed to the callback is a pointer to the
     iommu_domain, which can be accessed concurrently and therefore
     requires expensive synchronisation to keep track of the outstanding
     flushes.

Remove the callback entirely in preparation for extending ->unmap() and
->iotlb_sync() to update a token on the caller's stack.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/amd_iommu.c       |  6 ------
 drivers/iommu/iommu.c           |  3 ---
 drivers/vfio/vfio_iommu_type1.c |  1 -
 include/linux/iommu.h           | 15 ---------------
 4 files changed, 25 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b607a92791d3..f93b148cf55e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3196,11 +3196,6 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	domain_flush_complete(dom);
 }
 
-static void amd_iommu_iotlb_range_add(struct iommu_domain *domain,
-				      unsigned long iova, size_t size)
-{
-}
-
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -3219,7 +3214,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
-	.iotlb_range_add = amd_iommu_iotlb_range_add,
 	.iotlb_sync = amd_iommu_flush_iotlb_all,
 };
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c674d80c37f..6d7b25fe2474 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1903,9 +1903,6 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 		if (!unmapped_page)
 			break;
 
-		if (sync && ops->iotlb_range_add)
-			ops->iotlb_range_add(domain, iova, pgsize);
-
 		pr_debug("unmapped: iova 0x%lx size 0x%zx\n",
 			 iova, unmapped_page);
 
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 054391f30fa8..fad7fd8c167c 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -696,7 +696,6 @@ static size_t unmap_unpin_fast(struct vfio_domain *domain,
 		if (!unmapped) {
 			kfree(entry);
 		} else {
-			iommu_tlb_range_add(domain->domain, *iova, unmapped);
 			entry->iova = *iova;
 			entry->phys = phys;
 			entry->len  = unmapped;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fdc355ccc570..1e21431262d9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -201,7 +201,6 @@ struct iommu_sva_ops {
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
- * @iotlb_range_add: Add a given iova range to the flush queue for this domain
  * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
  * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
@@ -244,8 +243,6 @@ struct iommu_ops {
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size);
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
-	void (*iotlb_range_add)(struct iommu_domain *domain,
-				unsigned long iova, size_t size);
 	void (*iotlb_sync_map)(struct iommu_domain *domain);
 	void (*iotlb_sync)(struct iommu_domain *domain);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
@@ -476,13 +473,6 @@ static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
 		domain->ops->flush_iotlb_all(domain);
 }
 
-static inline void iommu_tlb_range_add(struct iommu_domain *domain,
-				       unsigned long iova, size_t size)
-{
-	if (domain->ops->iotlb_range_add)
-		domain->ops->iotlb_range_add(domain, iova, size);
-}
-
 static inline void iommu_tlb_sync(struct iommu_domain *domain)
 {
 	if (domain->ops->iotlb_sync)
@@ -637,11 +627,6 @@ static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
 {
 }
 
-static inline void iommu_tlb_range_add(struct iommu_domain *domain,
-				       unsigned long iova, size_t size)
-{
-}
-
 static inline void iommu_tlb_sync(struct iommu_domain *domain)
 {
 }
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
