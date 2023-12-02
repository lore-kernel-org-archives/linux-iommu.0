Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8F13FE4
	for <iommu@lists.linux.dev>; Sat,  2 Dec 2023 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwYQrKOW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510585; x=1733046585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Lo5VlYM9pcr8va0tr3dWmZ/2vpXpVd1PrW/H2X7PBXI=;
  b=GwYQrKOWDILRtVHRF1bbBcv7mTwkb+5zWWmpKRqIg4I1BGmF+odR1HWx
   0WDBZ3xzRMq8XU91wUpr3BG/Frn+jxMCsQXZGGN7up5ZSXmFdiGaPnHN/
   oq4sNEfgSyDEbUXtGfAwpg3MtvqmObOmKOkS/VYOEn+f8nMzlWp00YA63
   yxnnCsmdq43QesaWa0+EhbF43BqrF65GsJt7efL6v21jONIDCEVkQ6m3h
   7Mjwe7ebiHT4W9915IAnPR1hrM8V8QQuTcsNEbBwE1r3ogsD1SSBKuHbY
   NimVx7V24/9/hk/BQMdD7wxDZnHAu3AzEttP6FYxtqM/qrBlz2kKnaUyM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="392459181"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="392459181"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:49:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="887937515"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="887937515"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:49:36 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.williamson@redhat.com,
	jgg@nvidia.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	yi.l.liu@intel.com,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 11/42] iommu: Add new domain op cache_invalidate_kvm
Date: Sat,  2 Dec 2023 17:20:41 +0800
Message-Id: <20231202092041.14084-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

On KVM invalidates mappings that are shared to IOMMU stage 2 paging
structures, IOMMU driver needs to invalidate hardware TLBs accordingly.

The new op cache_invalidate_kvm is called from IOMMUFD to invalidate
hardware TLBs upon receiving invalidation notifications from KVM.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 include/linux/iommu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0ce23ee399d35..0b056d5a6b3a3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -636,6 +636,9 @@ struct iommu_ops {
  *                         forward a driver specific error code to user space.
  *                         Both the driver data structure and the error code
  *                         must be defined in include/uapi/linux/iommufd.h
+ * @cache_invalidate_kvm: Synchronously flush hardware TLBs for KVM managed
+ *                        stage 2 IO page tables.
+ *                        The @domain must be IOMMU_DOMAIN_KVM.
  * @iova_to_phys: translate iova to physical address
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
@@ -665,6 +668,8 @@ struct iommu_domain_ops {
 	int (*cache_invalidate_user)(struct iommu_domain *domain,
 				     struct iommu_user_data_array *array,
 				     u32 *error_code);
+	void (*cache_invalidate_kvm)(struct iommu_domain *domain,
+				     unsigned long iova, unsigned long size);
 
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
 				    dma_addr_t iova);
-- 
2.17.1

