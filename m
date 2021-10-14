Return-Path: <SRS0=rAFC=PC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E16C433EF
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 05:43:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D58F610E8
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 05:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D58F610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51F3A406F9;
	Thu, 14 Oct 2021 05:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hdQpLhyODov7; Thu, 14 Oct 2021 05:43:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1A66C40779;
	Thu, 14 Oct 2021 05:43:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBB2DC0011;
	Thu, 14 Oct 2021 05:43:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BFCEC000D
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 05:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 398BC60B11
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 05:43:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i3qXwiCMQ37B for <iommu@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:43:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67F2260B10
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 05:43:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="214544039"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="214544039"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 22:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="626685279"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 13 Oct 2021 22:42:59 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 9/9] iommu/vt-d: Avoid duplicate removing in __domain_mapping()
Date: Thu, 14 Oct 2021 13:38:39 +0800
Message-Id: <20211014053839.727419-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014053839.727419-1-baolu.lu@linux.intel.com>
References: <20211014053839.727419-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Liujunjie <liujunjie23@huawei.com>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Kyung Min Park <kyung.min.park@intel.com>, iommu@lists.linux-foundation.org,
 Longpeng <longpeng2@huawei.com>
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

From: "Longpeng(Mike)" <longpeng2@huawei.com>

The __domain_mapping() always removes the pages in the range from
'iov_pfn' to 'end_pfn', but the 'end_pfn' is always the last pfn
of the range that the caller wants to map.

This would introduce too many duplicated removing and leads the
map operation take too long, for example:

  Map iova=0x100000,nr_pages=0x7d61800
    iov_pfn: 0x100000, end_pfn: 0x7e617ff
    iov_pfn: 0x140000, end_pfn: 0x7e617ff
    iov_pfn: 0x180000, end_pfn: 0x7e617ff
    iov_pfn: 0x1c0000, end_pfn: 0x7e617ff
    iov_pfn: 0x200000, end_pfn: 0x7e617ff
    ...
  it takes about 50ms in total.

We can reduce the cost by recalculate the 'end_pfn' and limit it
to the boundary of the end of this pte page.

  Map iova=0x100000,nr_pages=0x7d61800
    iov_pfn: 0x100000, end_pfn: 0x13ffff
    iov_pfn: 0x140000, end_pfn: 0x17ffff
    iov_pfn: 0x180000, end_pfn: 0x1bffff
    iov_pfn: 0x1c0000, end_pfn: 0x1fffff
    iov_pfn: 0x200000, end_pfn: 0x23ffff
    ...
  it only need 9ms now.

This also removes a meaningless BUG_ON() in __domain_mapping().

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Tested-by: Liujunjie <liujunjie23@huawei.com>
Link: https://lore.kernel.org/r/20211008000433.1115-1-longpeng2@huawei.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  6 ++++++
 drivers/iommu/intel/iommu.c | 11 ++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 52481625838c..69230fd695ea 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -710,6 +710,12 @@ static inline bool first_pte_in_page(struct dma_pte *pte)
 	return IS_ALIGNED((unsigned long)pte, VTD_PAGE_SIZE);
 }
 
+static inline int nr_pte_to_next_page(struct dma_pte *pte)
+{
+	return first_pte_in_page(pte) ? BIT_ULL(VTD_STRIDE_SHIFT) :
+		(struct dma_pte *)ALIGN((unsigned long)pte, VTD_PAGE_SIZE) - pte;
+}
+
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
 extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 16a35669a9d0..0bde0c8b4126 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2479,12 +2479,17 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 				return -ENOMEM;
 			first_pte = pte;
 
+			lvl_pages = lvl_to_nr_pages(largepage_lvl);
+
 			/* It is large page*/
 			if (largepage_lvl > 1) {
 				unsigned long end_pfn;
+				unsigned long pages_to_remove;
 
 				pteval |= DMA_PTE_LARGE_PAGE;
-				end_pfn = ((iov_pfn + nr_pages) & level_mask(largepage_lvl)) - 1;
+				pages_to_remove = min_t(unsigned long, nr_pages,
+							nr_pte_to_next_page(pte) * lvl_pages);
+				end_pfn = iov_pfn + pages_to_remove - 1;
 				switch_to_super_page(domain, iov_pfn, end_pfn, largepage_lvl);
 			} else {
 				pteval &= ~(uint64_t)DMA_PTE_LARGE_PAGE;
@@ -2506,10 +2511,6 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			WARN_ON(1);
 		}
 
-		lvl_pages = lvl_to_nr_pages(largepage_lvl);
-
-		BUG_ON(nr_pages < lvl_pages);
-
 		nr_pages -= lvl_pages;
 		iov_pfn += lvl_pages;
 		phys_pfn += lvl_pages;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
