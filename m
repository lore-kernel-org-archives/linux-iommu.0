Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFDA63A9
	for <iommu@lists.linux.dev>; Tue, 30 May 2023 05:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425115; x=1716961115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ZqasWAA5mVjNHn5DIUADADIinyg0cr8B//uQHoZisM=;
  b=IBdoqvqhANAZ7x0L9oHnaR705ancvy92ZW2kpn2n4WEx3mvjri7ycVkn
   D+Mxq185+/SEEGGgUMlI9Ruetuv94bOaW/KHwayMwFkLzLcgpYmCL4vxL
   wJo1PyTXmRr+1wAzsTeHK7vM/C+fABrz6HWjq7LnfxOR4N13jDvD3kFvI
   kkToG7EzDsC8zi9RM2gsS9iocxIbk9VBFJu8t5u9llmsVaJl66EumLRZS
   B6mWNMhkARSUMq8JKCYr+YZYUMcEW2kh1B3UKUQv3P3mkgHVZHYZxcl+7
   hreZja7Nw4PnM2EMjdUjsBBxnuXK9Nq9203CTEI/xJ6d7o2maxRqRmHGO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579645"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579645"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369467"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369467"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:38:32 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCHES 03/17] iommu: Add helper to set iopf handler for domain
Date: Tue, 30 May 2023 13:37:10 +0800
Message-Id: <20230530053724.232765-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530053724.232765-1-baolu.lu@linux.intel.com>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid open code everywhere. No intentional functionality change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 10 ++++++++++
 drivers/iommu/iommu.c |  3 +--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fce7ad81206f..f554328528bc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -273,6 +273,16 @@ static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
 	return domain->type & __IOMMU_DOMAIN_DMA_API;
 }
 
+static inline void
+iommu_domain_set_iopf_handler(struct iommu_domain *domain,
+		enum iommu_page_response_code (*handler)(struct iommu_fault *fault,
+							 void *data),
+		void *data)
+{
+	domain->iopf_handler = handler;
+	domain->fault_data = data;
+}
+
 enum iommu_cap {
 	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU_CACHE is supported */
 	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 13a2e0e26884..fd65ed1d3642 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3419,8 +3419,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	domain->type = IOMMU_DOMAIN_SVA;
 	mmgrab(mm);
 	domain->mm = mm;
-	domain->iopf_handler = iommu_sva_handle_iopf;
-	domain->fault_data = mm;
+	iommu_domain_set_iopf_handler(domain, iommu_sva_handle_iopf, mm);
 
 	return domain;
 }
-- 
2.34.1

