Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAFB1849
	for <iommu@lists.linux.dev>; Sat,  2 Jul 2022 02:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656727239; x=1688263239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HXVKMoFdhQcvlC95LGmOfs8ndIYoqrdegsd+kEhGg1A=;
  b=IRVd9DKNwuIcj2icJCjbcJGuff3Nsd1NQkAIpOOlQEYnTaWG539re5An
   KNZdX+TgrETobuPi8e5dDx1qQ9F8Hs9AdkW5cS/6zUPluc9lHsLyuDdkB
   P0jVLlFLwpd3YImizDXP/deRQGyaHWtvv7rU62qbO4oqa0u567CXqZTda
   v8eIUd3IBYFE/Jd4wCkJj1mhDw4g1PU/dLVKsmcPXsL60+QQCYPFv72so
   Sxy26LtWhC1aatYcF2lkXHuiXt5n4p0qJtIQq7Jm+I8Xnh0MCf18j8O+H
   LkEVOrWPk8uQaydvf/wDFXe7ttbDcQVfVQkVlqF794QWvh8phZ0HlTwgb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="281539681"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="281539681"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 19:00:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="589518283"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2022 19:00:35 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Steve Wahl <steve.wahl@hpe.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Mike Travis <mike.travis@hpe.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Russ Anderson <russ.anderson@hpe.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/6] iommu/vt-d: Remove unused domain_get_iommu()
Date: Sat,  2 Jul 2022 09:56:05 +0800
Message-ID: <20220702015610.2849494-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
References: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220702015605.b6fTya4TTB-07GaE929Vimfx5PAKHTQ-psGwOWGtX1I@z>

It is not used anywhere. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 18 ------------------
 2 files changed, 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index df64d3d9c49a..56e0d8cd2102 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -725,7 +725,6 @@ extern int dmar_ir_support(void);
 
 void *alloc_pgtable_page(int node);
 void free_pgtable_page(void *vaddr);
-struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index da6cfea0f0d6..781e060352e6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -445,24 +445,6 @@ int iommu_calculate_agaw(struct intel_iommu *iommu)
 	return __iommu_calculate_agaw(iommu, DEFAULT_DOMAIN_ADDRESS_WIDTH);
 }
 
-/* This functionin only returns single iommu in a domain */
-struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
-{
-	int iommu_id;
-
-	/* si_domain and vm domain should not get here. */
-	if (WARN_ON(!iommu_is_dma_domain(&domain->domain)))
-		return NULL;
-
-	for_each_domain_iommu(iommu_id, domain)
-		break;
-
-	if (iommu_id < 0 || iommu_id >= g_num_of_iommus)
-		return NULL;
-
-	return g_iommus[iommu_id];
-}
-
 static inline bool iommu_paging_structure_coherency(struct intel_iommu *iommu)
 {
 	return sm_supported(iommu) ?
-- 
2.25.1

