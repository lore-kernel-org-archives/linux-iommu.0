Return-Path: <SRS0=9TsP=MM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE8FC07E9B
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 02:08:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE7E61164
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 02:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE7E61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B479402FE;
	Tue, 20 Jul 2021 02:08:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JkPR-qMRGktk; Tue, 20 Jul 2021 02:08:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1B80F40105;
	Tue, 20 Jul 2021 02:08:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 062CFC0010;
	Tue, 20 Jul 2021 02:08:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3396C000E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 02:08:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A07540127
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 02:08:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QIRKZzLYel_s for <iommu@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 02:08:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6DC38400AA
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 02:08:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="274987756"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; d="scan'208";a="274987756"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2021 19:08:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; d="scan'208";a="453891974"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 19 Jul 2021 19:08:34 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/3] iommu/vt-d: Move clflush'es from iotlb_sync_map() to
 map_pages()
Date: Tue, 20 Jul 2021 10:06:15 +0800
Message-Id: <20210720020615.4144323-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720020615.4144323-1-baolu.lu@linux.intel.com>
References: <20210720020615.4144323-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: will@kernel.org, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

As the Intel VT-d driver has switched to use the iommu_ops.map_pages()
callback, multiple pages of the same size will be mapped in a call.
There's no need to put the clflush'es in iotlb_sync_map() callback.
Move them back into __domain_mapping() to simplify the code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 48 ++++++-------------------------------
 1 file changed, 7 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6114dac8777d..8c116fe071a2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2331,9 +2331,9 @@ static int
 __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		 unsigned long phys_pfn, unsigned long nr_pages, int prot)
 {
+	struct dma_pte *first_pte = NULL, *pte = NULL;
 	unsigned int largepage_lvl = 0;
 	unsigned long lvl_pages = 0;
-	struct dma_pte *pte = NULL;
 	phys_addr_t pteval;
 	u64 attr;
 
@@ -2366,6 +2366,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			pte = pfn_to_dma_pte(domain, iov_pfn, &largepage_lvl);
 			if (!pte)
 				return -ENOMEM;
+			first_pte = pte;
+
 			/* It is large page*/
 			if (largepage_lvl > 1) {
 				unsigned long end_pfn;
@@ -2413,14 +2415,14 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		 * recalculate 'pte' and switch back to smaller pages for the
 		 * end of the mapping, if the trailing size is not enough to
 		 * use another superpage (i.e. nr_pages < lvl_pages).
-		 *
-		 * We leave clflush for the leaf pte changes to iotlb_sync_map()
-		 * callback.
 		 */
 		pte++;
 		if (!nr_pages || first_pte_in_page(pte) ||
-		    (largepage_lvl > 1 && nr_pages < lvl_pages))
+		    (largepage_lvl > 1 && nr_pages < lvl_pages)) {
+			domain_flush_cache(domain, first_pte,
+					   (void *)pte - (void *)first_pte);
 			pte = NULL;
+		}
 	}
 
 	return 0;
@@ -5561,39 +5563,6 @@ static bool risky_device(struct pci_dev *pdev)
 	return false;
 }
 
-static void clflush_sync_map(struct dmar_domain *domain, unsigned long clf_pfn,
-			     unsigned long clf_pages)
-{
-	struct dma_pte *first_pte = NULL, *pte = NULL;
-	unsigned long lvl_pages = 0;
-	int level = 0;
-
-	while (clf_pages > 0) {
-		if (!pte) {
-			level = 0;
-			pte = pfn_to_dma_pte(domain, clf_pfn, &level);
-			if (WARN_ON(!pte))
-				return;
-			first_pte = pte;
-			lvl_pages = lvl_to_nr_pages(level);
-		}
-
-		if (WARN_ON(!lvl_pages || clf_pages < lvl_pages))
-			return;
-
-		clf_pages -= lvl_pages;
-		clf_pfn += lvl_pages;
-		pte++;
-
-		if (!clf_pages || first_pte_in_page(pte) ||
-		    (level > 1 && clf_pages < lvl_pages)) {
-			domain_flush_cache(domain, first_pte,
-					   (void *)pte - (void *)first_pte);
-			pte = NULL;
-		}
-	}
-}
-
 static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 				       unsigned long iova, size_t size)
 {
@@ -5603,9 +5572,6 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	struct intel_iommu *iommu;
 	int iommu_id;
 
-	if (!dmar_domain->iommu_coherency)
-		clflush_sync_map(dmar_domain, pfn, pages);
-
 	for_each_domain_iommu(iommu_id, dmar_domain) {
 		iommu = g_iommus[iommu_id];
 		__mapping_notify_one(iommu, dmar_domain, pfn, pages);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
