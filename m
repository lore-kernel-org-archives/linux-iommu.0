Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F2142640
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466126; cv=none; b=TI5kYWaq8RKPYGpzGRpwJbcQjsiYn2fjBeivFOzhYS4ejwAe7Xe1XAt0jUADoGtv07LODTyJpttQbHiDrvtZgPq8mUYK5vVP3mHz/goYP1r6tw0W3ZblxfMv69iW2NmRgb+u1v6PHCRB+LOPxKCLOP+f12szTjTs+qEqf5sOo9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466126; c=relaxed/simple;
	bh=9YhH5rA1b+ID5Xo/cB0X+5j1j2KZOf2zs+wByq5adpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hfMYeIoevkjh7svtPnvWTcwDToDhmDFEBCCPOZy/A8F9DnHXtUStYz2JXrPqSq64dyjx2zXlsPUU2H2O/DCzhHOjckT70H4ZhF4+Uja/ssr1R/PzV5fccipu38vzsuvVm6NJBQHZVPuSlI+n7B1FPl+mVVpk859Rubaqv8t2SgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nn7l0nOS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nn7l0nOS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466125; x=1749002125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9YhH5rA1b+ID5Xo/cB0X+5j1j2KZOf2zs+wByq5adpQ=;
  b=Nn7l0nOSktkuJJtwluKnuA5MVDsA8MaGFRnzT2tU/5W8dCN3Kjq3b8gy
   O0Msoco0kgrCd+2NnOOaFHjMPl674zrJI8ZGnGTC6c+qukWjMC3jpifwR
   L4hI2LddPywPwrPTOCcOWEbG9wYoIsjV+at7aF3LrxvOiISWUzuZc7jXa
   HKCRgdxIyi57TG99mCMTj4255oo/CADnlxL3y8SCOeUO79BO0vA3nQQFB
   SdaKJC7iCTsozBsMreoDFgWn6AXLZzK3DnaFAHJQt8U5WUF53hFE42/lh
   6C/vO7gvibvU/wBDVkcwG0gqXtAHKYzK2it4eeT4CMJUzELe9r1y3dGCE
   g==;
X-CSE-ConnectionGUID: xZeYYaIgRqaY7xp/arPnKw==
X-CSE-MsgGUID: guo5Rgd5Q6qwCw+WIgbfAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25385157"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25385157"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:55:25 -0700
X-CSE-ConnectionGUID: T4omcRksRbOOdlHyphpw8A==
X-CSE-MsgGUID: c7zTJVNbQXuNhzYvb42Urw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37662045"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:55:21 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 18/22] ARM: dma-mapping: Use iommu_paging_domain_alloc()
Date: Tue,  4 Jun 2024 09:51:30 +0800
Message-Id: <20240604015134.164206-19-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604015134.164206-1-baolu.lu@linux.intel.com>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since arm_iommu_create_mapping() now accepts the device, let's replace
iommu_domain_alloc() with iommu_paging_domain_alloc() to retire the former.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/arm/mm/dma-mapping.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 52f9c56cc3cb..88c2d68a69c9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1585,9 +1585,11 @@ arm_iommu_create_mapping(struct device *dev, dma_addr_t base, u64 size)
 
 	spin_lock_init(&mapping->lock);
 
-	mapping->domain = iommu_domain_alloc(dev->bus);
-	if (!mapping->domain)
+	mapping->domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(mapping->domain)) {
+		err = PTR_ERR(mapping->domain);
 		goto err4;
+	}
 
 	kref_init(&mapping->kref);
 	return mapping;
-- 
2.34.1

