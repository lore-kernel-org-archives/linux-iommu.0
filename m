Return-Path: <SRS0=ORUS=OZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AF2C433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Oct 2021 15:23:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D31615E3
	for <iommu@archiver.kernel.org>; Tue,  5 Oct 2021 15:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61D31615E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F5A683CCF;
	Tue,  5 Oct 2021 15:23:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DYeVVXWfMSE0; Tue,  5 Oct 2021 15:23:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2DE7483A3C;
	Tue,  5 Oct 2021 15:23:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18D4AC000F;
	Tue,  5 Oct 2021 15:23:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A3C7C000D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 15:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C7A9403FB
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 15:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yr--Cmg9gLp5 for <iommu@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 15:23:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A5CD4048B
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 15:23:30 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HP1Y11zrmzGp6H;
 Tue,  5 Oct 2021 23:22:29 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 5 Oct 2021 23:23:27 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 5 Oct 2021 23:23:27 +0800
From: "Longpeng(Mike)" <longpeng2@huawei.com>
To: <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>, <will@kernel.org>,
 <joro@8bytes.org>
Subject: [PATCH v2 2/2] iommu/vt-d: avoid duplicated removing in
 __domain_mapping
Date: Tue, 5 Oct 2021 23:23:08 +0800
Message-ID: <20211005152308.1061-3-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20211005152308.1061-1-longpeng2@huawei.com>
References: <20211005152308.1061-1-longpeng2@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Cc: "Longpeng\(Mike\)" <longpeng2@huawei.com>, iommu@lists.linux-foundation.org,
 arei.gonglei@huawei.com, linux-kernel@vger.kernel.org
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

__domain_mapping() always removes the pages in the range from
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

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 drivers/iommu/intel/iommu.c | 12 +++++++-----
 include/linux/intel-iommu.h |  6 ++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d75f59a..87cbf34 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2354,12 +2354,18 @@ static void switch_to_super_page(struct dmar_domain *domain,
 				return -ENOMEM;
 			first_pte = pte;
 
+			lvl_pages = lvl_to_nr_pages(largepage_lvl);
+			BUG_ON(nr_pages < lvl_pages);
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
@@ -2381,10 +2387,6 @@ static void switch_to_super_page(struct dmar_domain *domain,
 			WARN_ON(1);
 		}
 
-		lvl_pages = lvl_to_nr_pages(largepage_lvl);
-
-		BUG_ON(nr_pages < lvl_pages);
-
 		nr_pages -= lvl_pages;
 		iov_pfn += lvl_pages;
 		phys_pfn += lvl_pages;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index a590b00..623b407 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -713,6 +713,12 @@ static inline bool first_pte_in_page(struct dma_pte *pte)
 	return !((unsigned long)pte & ~VTD_PAGE_MASK);
 }
 
+static inline int nr_pte_to_next_page(struct dma_pte *pte)
+{
+	return first_pte_in_page(pte) ? BIT_ULL(VTD_STRIDE_SHIFT) :
+		(struct dma_pte *)ALIGN((unsigned long)pte, VTD_PAGE_SIZE) - pte;
+}
+
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
 extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
 
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
