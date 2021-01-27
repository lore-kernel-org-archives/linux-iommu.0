Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE295C433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 20:00:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B98464DB4
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 20:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B98464DB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 340E022D22;
	Wed, 27 Jan 2021 20:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p0jQop1i8nRJ; Wed, 27 Jan 2021 20:00:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6198E22902;
	Wed, 27 Jan 2021 20:00:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4620BC08A1;
	Wed, 27 Jan 2021 20:00:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77298C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6DBFC86C43
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wg40H0lDfBpp for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 20:00:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8783386C1A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:41 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69F4264DA3;
 Wed, 27 Jan 2021 20:00:40 +0000 (UTC)
Subject: [PATCH RFC 3/9] iommu/vt-d: Add iotlb_sync_map callback
From: Chuck Lever <chuck.lever@oracle.com>
To: baolu.lu@linux.intel.com
Date: Wed, 27 Jan 2021 15:00:39 -0500
Message-ID: <161177763962.1311.15577661784296014186.stgit@manet.1015granger.net>
In-Reply-To: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Cc: isaacm@codeaurora.org, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, will@kernel.org
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

From: Lu Baolu <baolu.lu@linux.intel.com>

Some Intel VT-d hardware implementations don't support memory coherency
for page table walk (presented by the Page-Walk-coherency bit in the
ecap register), so that software must flush the corresponding CPU cache
lines explicitly after each page table entry update.

The iommu_map_sg() code iterates through the given scatter-gather list
and invokes iommu_map() for each element in the scatter-gather list,
which calls into the vendor IOMMU driver through iommu_ops callback. As
the result, a single sg mapping may lead to multiple cache line flushes,
which leads to the degradation of I/O performance after the commit
<c588072bba6b5> ("iommu/vt-d: Convert intel iommu driver to the iommu
ops").

Fix this by adding iotlb_sync_map callback and centralizing the clflush
operations after all sg mappings.

Fixes: c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
Reported-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/linux-iommu/D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
[ cel: removed @first_pte, which is no longer used ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/iommu/intel/iommu.c |   90 +++++++++++++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f665322a0991..013097b6d55f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2298,9 +2298,9 @@ static int
 __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		 unsigned long phys_pfn, unsigned long nr_pages, int prot)
 {
-	struct dma_pte *first_pte = NULL, *pte = NULL;
 	unsigned int largepage_lvl = 0;
 	unsigned long lvl_pages = 0;
+	struct dma_pte *pte = NULL;
 	phys_addr_t pteval;
 	u64 attr;
 
@@ -2322,7 +2322,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			largepage_lvl = hardware_largepage_caps(domain, iov_pfn,
 					phys_pfn, nr_pages);
 
-			first_pte = pte = pfn_to_dma_pte(domain, iov_pfn, &largepage_lvl);
+			pte = pfn_to_dma_pte(domain, iov_pfn, &largepage_lvl);
 			if (!pte)
 				return -ENOMEM;
 			/* It is large page*/
@@ -2383,34 +2383,14 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		 * recalculate 'pte' and switch back to smaller pages for the
 		 * end of the mapping, if the trailing size is not enough to
 		 * use another superpage (i.e. nr_pages < lvl_pages).
+		 *
+		 * We leave clflush for the leaf pte changes to iotlb_sync_map()
+		 * callback.
 		 */
 		pte++;
 		if (!nr_pages || first_pte_in_page(pte) ||
-		    (largepage_lvl > 1 && nr_pages < lvl_pages)) {
-			domain_flush_cache(domain, first_pte,
-					   (void *)pte - (void *)first_pte);
+		    (largepage_lvl > 1 && nr_pages < lvl_pages))
 			pte = NULL;
-		}
-	}
-
-	return 0;
-}
-
-static int
-domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
-	       unsigned long phys_pfn, unsigned long nr_pages, int prot)
-{
-	int iommu_id, ret;
-	struct intel_iommu *iommu;
-
-	/* Do the real mapping first */
-	ret = __domain_mapping(domain, iov_pfn, phys_pfn, nr_pages, prot);
-	if (ret)
-		return ret;
-
-	for_each_domain_iommu(iommu_id, domain) {
-		iommu = g_iommus[iommu_id];
-		__mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
 	}
 
 	return 0;
@@ -4943,7 +4923,6 @@ static int intel_iommu_map(struct iommu_domain *domain,
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	u64 max_addr;
 	int prot = 0;
-	int ret;
 
 	if (iommu_prot & IOMMU_READ)
 		prot |= DMA_PTE_READ;
@@ -4969,9 +4948,8 @@ static int intel_iommu_map(struct iommu_domain *domain,
 	/* Round up size to next multiple of PAGE_SIZE, if it and
 	   the low bits of hpa would take us onto the next page */
 	size = aligned_nrpages(hpa, size);
-	ret = domain_mapping(dmar_domain, iova >> VTD_PAGE_SHIFT,
-			     hpa >> VTD_PAGE_SHIFT, size, prot);
-	return ret;
+	return __domain_mapping(dmar_domain, iova >> VTD_PAGE_SHIFT,
+				hpa >> VTD_PAGE_SHIFT, size, prot);
 }
 
 static size_t intel_iommu_unmap(struct iommu_domain *domain,
@@ -5478,6 +5456,57 @@ static bool risky_device(struct pci_dev *pdev)
 	return false;
 }
 
+static void clflush_sync_map(struct dmar_domain *domain, unsigned long clf_pfn,
+			     unsigned long clf_pages)
+{
+	struct dma_pte *first_pte = NULL, *pte = NULL;
+	unsigned long lvl_pages = 0;
+	int level = 0;
+
+	while (clf_pages > 0) {
+		if (!pte) {
+			level = 0;
+			pte = pfn_to_dma_pte(domain, clf_pfn, &level);
+			if (WARN_ON(!pte))
+				return;
+			first_pte = pte;
+			lvl_pages = lvl_to_nr_pages(level);
+		}
+
+		if (WARN_ON(!lvl_pages || clf_pages < lvl_pages))
+			return;
+
+		clf_pages -= lvl_pages;
+		clf_pfn += lvl_pages;
+		pte++;
+
+		if (!clf_pages || first_pte_in_page(pte) ||
+		    (level > 1 && clf_pages < lvl_pages)) {
+			domain_flush_cache(domain, first_pte,
+					   (void *)pte - (void *)first_pte);
+			pte = NULL;
+		}
+	}
+}
+
+static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
+				       unsigned long iova, size_t size)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	unsigned long pages = aligned_nrpages(iova, size);
+	unsigned long pfn = iova >> VTD_PAGE_SHIFT;
+	struct intel_iommu *iommu;
+	int iommu_id;
+
+	if (!dmar_domain->iommu_coherency)
+		clflush_sync_map(dmar_domain, pfn, pages);
+
+	for_each_domain_iommu(iommu_id, dmar_domain) {
+		iommu = g_iommus[iommu_id];
+		__mapping_notify_one(iommu, dmar_domain, pfn, pages);
+	}
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5490,6 +5519,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.aux_detach_dev		= intel_iommu_aux_detach_device,
 	.aux_get_pasid		= intel_iommu_aux_get_pasid,
 	.map			= intel_iommu_map,
+	.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
 	.unmap			= intel_iommu_unmap,
 	.flush_iotlb_all        = intel_flush_iotlb_all,
 	.iotlb_sync		= intel_iommu_tlb_sync,


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
