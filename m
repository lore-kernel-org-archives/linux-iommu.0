Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7DAC74A5B
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:28:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1881B20863
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY4aMNeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1881B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A9A775489;
	Thu, 11 Jul 2019 17:28:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7B3C5530E
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:19:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 07EFC886
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
	[217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 7714A20872;
	Thu, 11 Jul 2019 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562865576;
	bh=gdNnUmlR/2I8B5vZfMEddjqrOCGw/KW1jn3IBrMtpYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bY4aMNeBGd4x150QncX48CUEFKurB6Ekj4afNWlnamHI8Xu3DhNziGpveG0Kk3fyk
	7xEx7NH5rPZeTflFABFcvOr5Ecalvs7NrDYzE/++k9quHSjhfz/EILzfTzosolgpW1
	Ci4w0sUmfByl8GhSwVKD5n791h4CqzKsrEahpoZg=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH v2 01/19] iommu: Remove empty iommu_tlb_range_add()
	callback from iommu_ops
Date: Thu, 11 Jul 2019 18:19:09 +0100
Message-Id: <20190711171927.28803-2-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190711171927.28803-1-will@kernel.org>
References: <20190711171927.28803-1-will@kernel.org>
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Will Deacon <will@kernel.org>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Jon Masters <jcm@redhat.com>, Robin Murphy <robin.murphy@arm.com>
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
index 09c9e45f7fa2..639b7ce2ba32 100644
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
index 67ee6623f9b2..0ec6e1cb6430 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1681,9 +1681,6 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 		if (!unmapped_page)
 			break;
 
-		if (sync && ops->iotlb_range_add)
-			ops->iotlb_range_add(domain, iova, pgsize);
-
 		pr_debug("unmapped: iova 0x%lx size 0x%zx\n",
 			 iova, unmapped_page);
 
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 3ddc375e7063..7fa35a83da9d 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -712,7 +712,6 @@ static size_t unmap_unpin_fast(struct vfio_domain *domain,
 		if (!unmapped) {
 			kfree(entry);
 		} else {
-			iommu_tlb_range_add(domain->domain, *iova, unmapped);
 			entry->iova = *iova;
 			entry->phys = phys;
 			entry->len  = unmapped;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8ee3fbaf5855..c5c2534ac875 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -204,7 +204,6 @@ struct iommu_sva_ops {
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
- * @iotlb_range_add: Add a given iova range to the flush queue for this domain
  * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
  * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
@@ -246,8 +245,6 @@ struct iommu_ops {
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size);
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
-	void (*iotlb_range_add)(struct iommu_domain *domain,
-				unsigned long iova, size_t size);
 	void (*iotlb_sync_map)(struct iommu_domain *domain);
 	void (*iotlb_sync)(struct iommu_domain *domain);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
@@ -420,13 +417,6 @@ static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
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
@@ -580,11 +570,6 @@ static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
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
