Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015968825
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzQ2mmjS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700623831; x=1732159831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=abHIAVCO67I12DlkhVd7oB9ud5ZE5PyjC/pWsosPfw4=;
  b=BzQ2mmjSZoZbiMhIyTTe1JAx9MXWsqIahXGRi2cz358Ya/thXd9WhLkX
   ahRxzuKEGDpmXgJJmI9auINpdP3x8mE33eWh7im6bqZFX9nZbFZyRW+Be
   iP6UuoXbGyHV91HZ8bbX3+WT6zhOBxLzAz+AwaLMi3ZkCSbyVAjq4A1Lz
   koHGwWioLIyQJQOCu2FOLvhEfk9uM/sEXlnDbzZDAiqtH1tWJP4aMOTsC
   fPmykcBB2xPXLdGp0CUvjZHy3tH1RZr4HZchPt7Bm9z5GAWGyqvimW7s7
   4WbLQEHme8b/ki99gj8MohhjdsXKoewWgnEivVLz4Rpesa5Q465LLR7c6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391742771"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="391742771"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 19:30:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="8090161"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2023 19:30:30 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: mohd.syazwan.abdul.halim@intel.com,
	Kunwu Chan <chentao@kylinos.cn>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] iommu/vt-d: Support enforce_cache_coherency only for empty domains
Date: Wed, 22 Nov 2023 11:26:02 +0800
Message-Id: <20231122032608.165144-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122032608.165144-1-baolu.lu@linux.intel.com>
References: <20231122032608.165144-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The enforce_cache_coherency callback ensures DMA cache coherency for
devices attached to the domain.

Intel IOMMU supports enforced DMA cache coherency when the Snoop
Control bit in the IOMMU's extended capability register is set.
Supporting it differs between legacy and scalable modes.

In legacy mode, it's supported page-level by setting the SNP field
in second-stage page-table entries. In scalable mode, it's supported
in PASID-table granularity by setting the PGSNP field in PASID-table
entries.

In legacy mode, mappings before attaching to a device have SNP
fields cleared, while mappings after the callback have them set.
This means partial DMAs are cache coherent while others are not.

One possible fix is replaying mappings and flipping SNP bits when
attaching a domain to a device. But this seems to be over-engineered,
given that all real use cases just attach an empty domain to a device.

To meet practical needs while reducing mode differences, only support
enforce_cache_coherency on a domain without mappings if SNP field is
used.

Fixes: fc0051cb9590 ("iommu/vt-d: Check domain force_snooping against attached devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20231114011036.70142-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 3 +++
 drivers/iommu/intel/iommu.c | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 65d37a138c75..ce030c5b5772 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -602,6 +602,9 @@ struct dmar_domain {
 					 */
 	u8 dirty_tracking:1;		/* Dirty tracking is enabled */
 	u8 nested_parent:1;		/* Has other domains nested on it */
+	u8 has_mappings:1;		/* Has mappings configured through
+					 * iommu_map() interface.
+					 */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3531b956556c..11670cd812a3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2207,6 +2207,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			attr |= DMA_FL_PTE_DIRTY;
 	}
 
+	domain->has_mappings = true;
+
 	pteval = ((phys_addr_t)phys_pfn << VTD_PAGE_SHIFT) | attr;
 
 	while (nr_pages > 0) {
@@ -4360,7 +4362,8 @@ static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 		return true;
 
 	spin_lock_irqsave(&dmar_domain->lock, flags);
-	if (!domain_support_force_snooping(dmar_domain)) {
+	if (!domain_support_force_snooping(dmar_domain) ||
+	    (!dmar_domain->use_first_level && dmar_domain->has_mappings)) {
 		spin_unlock_irqrestore(&dmar_domain->lock, flags);
 		return false;
 	}
-- 
2.34.1

