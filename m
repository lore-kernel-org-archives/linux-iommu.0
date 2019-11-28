Return-Path: <SRS0=S8Y4=ZU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E831CC432C0
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 02:30:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5EFB2158A
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 02:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EFB2158A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 16424877DD;
	Thu, 28 Nov 2019 02:30:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id psMEYQb25g5K; Thu, 28 Nov 2019 02:30:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DA2AB8113D;
	Thu, 28 Nov 2019 02:30:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEE26C1DD5;
	Thu, 28 Nov 2019 02:30:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DC2FC0881
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 02:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7BC54877D3
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 02:30:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7IZpUFbl50p4 for <iommu@lists.linux-foundation.org>;
 Thu, 28 Nov 2019 02:30:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 70441877DD
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 02:30:04 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 18:30:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; d="scan'208";a="221176157"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 27 Nov 2019 18:30:01 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v2 3/8] iommu/vt-d: Implement second level page table ops
Date: Thu, 28 Nov 2019 10:25:45 +0800
Message-Id: <20191128022550.9832-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128022550.9832-1-baolu.lu@linux.intel.com>
References: <20191128022550.9832-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 ashok.raj@intel.com, kvm@vger.kernel.org, sanjay.k.kumar@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com
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

This adds the implementation of page table callbacks for
the second level page table.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 81 +++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 7752ff299cb5..96ead4e3395a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -413,6 +413,7 @@ int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 }
 
 const struct iommu_ops intel_iommu_ops;
+static const struct pgtable_ops second_lvl_pgtable_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
 {
@@ -1720,6 +1721,7 @@ static struct dmar_domain *alloc_domain(int flags)
 	domain->nid = NUMA_NO_NODE;
 	domain->flags = flags;
 	domain->has_iotlb_device = false;
+	domain->ops = &second_lvl_pgtable_ops;
 	INIT_LIST_HEAD(&domain->devices);
 
 	return domain;
@@ -2334,6 +2336,85 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	return 0;
 }
 
+static int second_lvl_domain_map_range(struct dmar_domain *domain,
+				       unsigned long iova, phys_addr_t paddr,
+				       size_t size, int prot)
+{
+	return __domain_mapping(domain, iova >> VTD_PAGE_SHIFT, NULL,
+				paddr >> VTD_PAGE_SHIFT,
+				aligned_nrpages(paddr, size), prot);
+}
+
+static struct page *
+second_lvl_domain_unmap_range(struct dmar_domain *domain,
+			      unsigned long iova, size_t size)
+{
+	unsigned long start_pfn, end_pfn, nrpages;
+
+	start_pfn = mm_to_dma_pfn(IOVA_PFN(iova));
+	nrpages = aligned_nrpages(iova, size);
+	end_pfn = start_pfn + nrpages - 1;
+
+	return dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
+				   domain->pgd, 0, start_pfn, end_pfn, NULL);
+}
+
+static phys_addr_t
+second_lvl_domain_iova_to_phys(struct dmar_domain *domain,
+			       unsigned long iova)
+{
+	struct dma_pte *pte;
+	int level = 0;
+	u64 phys = 0;
+
+	pte = pfn_to_dma_pte(domain, iova >> VTD_PAGE_SHIFT, &level);
+	if (pte)
+		phys = dma_pte_addr(pte);
+
+	return phys;
+}
+
+static void
+second_lvl_domain_flush_tlb_range(struct dmar_domain *domain,
+				  struct intel_iommu *iommu,
+				  unsigned long addr, size_t size,
+				  bool ih)
+{
+	unsigned long pages = aligned_nrpages(addr, size);
+	u16 did = domain->iommu_did[iommu->seq_id];
+	unsigned int mask;
+
+	if (pages) {
+		mask = ilog2(__roundup_pow_of_two(pages));
+		addr &= (u64)-1 << (VTD_PAGE_SHIFT + mask);
+	} else {
+		mask = MAX_AGAW_PFN_WIDTH;
+		addr = 0;
+	}
+
+	/*
+	 * Fallback to domain selective flush if no PSI support or the size is
+	 * too big.
+	 * PSI requires page size to be 2 ^ x, and the base address is naturally
+	 * aligned to the size
+	 */
+	if (!pages || !cap_pgsel_inv(iommu->cap) ||
+	    mask > cap_max_amask_val(iommu->cap))
+		iommu->flush.iotlb_inv(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+	else
+		iommu->flush.iotlb_inv(iommu, did, addr | ((int)ih << 6),
+				       mask, DMA_TLB_PSI_FLUSH);
+
+	iommu_flush_dev_iotlb(domain, addr, mask);
+}
+
+static const struct pgtable_ops second_lvl_pgtable_ops = {
+	.map_range		= second_lvl_domain_map_range,
+	.unmap_range		= second_lvl_domain_unmap_range,
+	.iova_to_phys		= second_lvl_domain_iova_to_phys,
+	.flush_tlb_range	= second_lvl_domain_flush_tlb_range,
+};
+
 static int domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			  struct scatterlist *sg, unsigned long phys_pfn,
 			  unsigned long nr_pages, int prot)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
