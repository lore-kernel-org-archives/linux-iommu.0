Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595AB214F9
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689179344; x=1720715344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jIdl4nwk/bl5DCIlD8ga9fxZjK7V9Y4xrVQlxsm0KRQ=;
  b=AliyNxZFRmgH0nFuwKsplYFTotJTqcug4EVBrVe4SDZEpUydAjCDupLI
   0/tad7fDTQGIUxIYEDQt2qLtoov249CWMgXorzAK1cZJNPiFfJYZyQMX+
   0rFnx7Fn23XPiVkll+CGXMM9WuSkTfiU6chUe5loRsloAjaiLo3TsxqHG
   Yq617FSIXe+8fQF0FGqP4vQk76adrPmDSMKBsmlEDwuAcalNf+feF2lA4
   NhWVjjM7Uyh4uevL9kjzedwGReeMj5UVgym3CU5klZjdCntEFdBZM2gEV
   dGCQxDFwbsPYoqB3TA0BL2PrPTY50KvKGk5KIeDFEE8Csjh7HC/p4vM2X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431072737"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="431072737"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 09:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="715639031"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="715639031"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga007.jf.intel.com with ESMTP; 12 Jul 2023 09:29:01 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"Robin Murphy" <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	"Will Deacon" <will@kernel.org>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v10 3/7] iommu/vt-d: Add domain_flush_pasid_iotlb()
Date: Wed, 12 Jul 2023 09:33:51 -0700
Message-Id: <20230712163355.3177511-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

The VT-d spec requires to use PASID-based-IOTLB invalidation descriptor
to invalidate IOTLB and the paging-structure caches for a first-stage
page table. Add a generic helper to do this.

RID2PASID is used if the domain has been attached to a physical device,
otherwise real PASIDs that the domain has been attached to will be used.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ddff43def3ab..40685cbfaf0e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1467,6 +1467,24 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
+/*
+ * The VT-d spec requires to use PASID-based-IOTLB Invalidation to
+ * invalidate IOTLB and the paging-structure-caches for a first-stage
+ * page table.
+ */
+static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
+				     struct dmar_domain *domain, u64 addr,
+				     unsigned long npages, bool ih)
+{
+	u16 did = domain_id_iommu(domain, iommu);
+	unsigned long flags;
+
+	spin_lock_irqsave(&domain->lock, flags);
+	if (!list_empty(&domain->devices))
+		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, npages, ih);
+	spin_unlock_irqrestore(&domain->lock, flags);
+}
+
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 				  struct dmar_domain *domain,
 				  unsigned long pfn, unsigned int pages,
@@ -1484,7 +1502,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		ih = 1 << 6;
 
 	if (domain->use_first_level) {
-		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, pages, ih);
+		domain_flush_pasid_iotlb(iommu, domain, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
 
@@ -1554,7 +1572,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		u16 did = domain_id_iommu(dmar_domain, iommu);
 
 		if (dmar_domain->use_first_level)
-			qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, 0, -1, 0);
+			domain_flush_pasid_iotlb(iommu, dmar_domain, 0, -1, 0);
 		else
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						 DMA_TLB_DSI_FLUSH);
-- 
2.25.1

