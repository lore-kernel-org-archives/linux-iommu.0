Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6F4C43460
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 00:46:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F3B61107
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 00:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F3B61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58462845F6;
	Thu, 15 Apr 2021 00:46:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lXXygwRnmL7d; Thu, 15 Apr 2021 00:46:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25447845C1;
	Thu, 15 Apr 2021 00:46:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F234CC000B;
	Thu, 15 Apr 2021 00:46:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B6FCC000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 00:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5BECF40F59
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 00:46:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GxVcw67fLQ57 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 00:46:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCEBD40F56
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 00:46:43 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FLLFf3sFvz16KDb;
 Thu, 15 Apr 2021 08:44:22 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.151.207) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 15 Apr 2021 08:46:31 +0800
From: "Longpeng(Mike)" <longpeng2@huawei.com>
To: <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iommu/vt-d: Force to flush iotlb before creating superpage
Date: Thu, 15 Apr 2021 08:46:28 +0800
Message-ID: <20210415004628.1779-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.151.207]
X-CFilter-Loop: Reflected
Cc: Kevin Tian <kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 stable@vger.kernel.org, Alex
 Williamson <alex.williamson@redhat.com>, Gonglei <arei.gonglei@huawei.com>,
 longpeng2@huawei.com
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

The translation caches may preserve obsolete data when the
mapping size is changed, suppose the following sequence which
can reveal the problem with high probability.

1.mmap(4GB,MAP_HUGETLB)
2.
  while (1) {
   (a)    DMA MAP   0,0xa0000
   (b)    DMA UNMAP 0,0xa0000
   (c)    DMA MAP   0,0xc0000000
             * DMA read IOVA 0 may failure here (Not present)
             * if the problem occurs.
   (d)    DMA UNMAP 0,0xc0000000
  }

The page table(only focus on IOVA 0) after (a) is:
 PML4: 0x19db5c1003   entry:0xffff899bdcd2f000
  PDPE: 0x1a1cacb003  entry:0xffff89b35b5c1000
   PDE: 0x1a30a72003  entry:0xffff89b39cacb000
    PTE: 0x21d200803  entry:0xffff89b3b0a72000

The page table after (b) is:
 PML4: 0x19db5c1003   entry:0xffff899bdcd2f000
  PDPE: 0x1a1cacb003  entry:0xffff89b35b5c1000
   PDE: 0x1a30a72003  entry:0xffff89b39cacb000
    PTE: 0x0          entry:0xffff89b3b0a72000

The page table after (c) is:
 PML4: 0x19db5c1003   entry:0xffff899bdcd2f000
  PDPE: 0x1a1cacb003  entry:0xffff89b35b5c1000
   PDE: 0x21d200883   entry:0xffff89b39cacb000 (*)

Because the PDE entry after (b) is present, it won't be
flushed even if the iommu driver flush cache when unmap,
so the obsolete data may be preserved in cache, which
would cause the wrong translation at end.

However, we can see the PDE entry is finally switch to
2M-superpage mapping, but it does not transform
to 0x21d200883 directly:

1. PDE: 0x1a30a72003
2. __domain_mapping
     dma_pte_free_pagetable
       Set the PDE entry to ZERO
     Set the PDE entry to 0x21d200883

So we must flush the cache after the entry switch to ZERO
to avoid the obsolete info be preserved.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Gonglei (Arei) <arei.gonglei@huawei.com>

Fixes: 6491d4d02893 ("intel-iommu: Free old page tables before creating superpage")
Cc: <stable@vger.kernel.org> # v3.0+
Link: https://lore.kernel.org/linux-iommu/670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com/
Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
v1 -> v2:
  - add Joerg
  - reconstruct the solution base on the Baolu's suggestion
---
 drivers/iommu/intel/iommu.c | 52 +++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ee09323..881c9f2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2289,6 +2289,41 @@ static inline int hardware_largepage_caps(struct dmar_domain *domain,
 	return level;
 }
 
+/*
+ * Ensure that old small page tables are removed to make room for superpage(s).
+ * We're going to add new large pages, so make sure we don't remove their parent
+ * tables. The IOTLB/devTLBs should be flushed if any PDE/PTEs are cleared.
+ */
+static void switch_to_super_page(struct dmar_domain *domain,
+				 unsigned long start_pfn,
+				 unsigned long end_pfn, int level)
+{
+	unsigned long lvl_pages = lvl_to_nr_pages(level);
+	struct dma_pte *pte = NULL;
+	int i;
+
+	while (start_pfn <= end_pfn) {
+		if (!pte)
+			pte = pfn_to_dma_pte(domain, start_pfn, &level);
+
+		if (dma_pte_present(pte)) {
+			dma_pte_free_pagetable(domain, start_pfn,
+					       start_pfn + lvl_pages - 1,
+					       level + 1);
+
+			for_each_domain_iommu(i, domain)
+				iommu_flush_iotlb_psi(g_iommus[i], domain,
+						      start_pfn, lvl_pages,
+						      0, 0);
+		}
+
+		pte++;
+		start_pfn += lvl_pages;
+		if (first_pte_in_page(pte))
+			pte = NULL;
+	}
+}
+
 static int
 __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		 unsigned long phys_pfn, unsigned long nr_pages, int prot)
@@ -2329,22 +2364,11 @@ static inline int hardware_largepage_caps(struct dmar_domain *domain,
 				return -ENOMEM;
 			/* It is large page*/
 			if (largepage_lvl > 1) {
-				unsigned long nr_superpages, end_pfn;
+				unsigned long end_pfn;
 
 				pteval |= DMA_PTE_LARGE_PAGE;
-				lvl_pages = lvl_to_nr_pages(largepage_lvl);
-
-				nr_superpages = nr_pages / lvl_pages;
-				end_pfn = iov_pfn + nr_superpages * lvl_pages - 1;
-
-				/*
-				 * Ensure that old small page tables are
-				 * removed to make room for superpage(s).
-				 * We're adding new large pages, so make sure
-				 * we don't remove their parent tables.
-				 */
-				dma_pte_free_pagetable(domain, iov_pfn, end_pfn,
-						       largepage_lvl + 1);
+				end_pfn = ((iov_pfn + nr_pages) & level_mask(largepage_lvl)) - 1;
+				switch_to_super_page(domain, iov_pfn, end_pfn, largepage_lvl);
 			} else {
 				pteval &= ~(uint64_t)DMA_PTE_LARGE_PAGE;
 			}
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
