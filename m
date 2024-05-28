Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3D17E8FB
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716872228; cv=none; b=rcJhtPHNF7r3SjbYtqEs4TzJDAETxU8QIVb7Hfs3KxmzPLuyrxOZm30FcpVb68ckqkd71d7giGVn1RW8bL7NyMhvPLAksmkuYH4EK4rt/3DXUOwASdajb0RCTe6Y1mZkw/AKj6pbxdsvYmR8dp2j7AfLV1DifDoT8vFBj52DSNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716872228; c=relaxed/simple;
	bh=ba3iMqZ2mVcpdjFj398KFn5b1Uae31zCbUmpsYwDZxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YsN4R+ugrO2/Of68ZZJYH1fh1a2/zelEpPgjamdGQGAfhBY0u2h5oIgBh2W+lCZ/TcUGkfF2Mhj9Iv1qR+/jrEUyXoMCs5mtJeBukyDPBn8siwTfMWRIKBUVM0JYqfQ4Q/wCuJ0OJKRs3uImjf38wDx4Z7fGJQ2QvDTzZuBkNMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFLjRmuW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFLjRmuW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716872227; x=1748408227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ba3iMqZ2mVcpdjFj398KFn5b1Uae31zCbUmpsYwDZxI=;
  b=fFLjRmuW5eN0hJzXfdZgshSYP5TE73NK9dP4YMpqcZsjNKxPdqotYVcP
   k5BrTmwEl/1flwU1jVSkevbRyAU/F6AT5V/5nzm0VGllFJmyclwAhXyk2
   l1gWKge1d+l5gPWquChqtxxsHxUCxZ3AKbVG1PTI6bjGI9zxwJypnMrp+
   0q/Z5NdyhhDdUzb3LXXSoOn4DkD7h6S4o22wSESNvwHcmOcm5lbZE8ZOS
   80Fbu/5K5rNRCIi/3ItlQxVbjJI2ORgcYyJoyozDNW4N10B9hx7Ue7z1D
   JL326M7a7isKhiirh+oFJ3PEAhD4fZ1xliHP4Q+2NAgpvCcxd00ZVQ3Cj
   w==;
X-CSE-ConnectionGUID: wAXVdjI0QWW97gimNMxMCg==
X-CSE-MsgGUID: oUpTbjtaTxSavP9b7nJXnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13319869"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13319869"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 21:57:07 -0700
X-CSE-ConnectionGUID: T6MY8SfYRwK0ifOZ/jp4XQ==
X-CSE-MsgGUID: A2aBLC5SSEqrUGX//ypULA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="34840002"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 27 May 2024 21:57:05 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu: Make iommu_sva_domain_alloc() static
Date: Tue, 28 May 2024 12:54:58 +0800
Message-Id: <20240528045458.81458-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_sva_domain_alloc() is only called in iommu-sva.c, hence make it
static.

On the other hand, iommu_sva_domain_alloc() should not return NULL anymore
after commit <80af5a452024> ("iommu: Add ops->domain_alloc_sva()"), the
removal of inline code avoids potential confusion.

Fixes: 80af5a452024 ("iommu: Add ops->domain_alloc_sva()")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h     | 8 --------
 drivers/iommu/iommu-sva.c | 6 ++++--
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7bc8dff7cf6d..5cdd3d41b87b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1527,8 +1527,6 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
-struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
-					    struct mm_struct *mm);
 #else
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
@@ -1553,12 +1551,6 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
 }
 
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
-
-static inline struct iommu_domain *
-iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
-{
-	return NULL;
-}
 #endif /* CONFIG_IOMMU_SVA */
 
 #ifdef CONFIG_IOMMU_IOPF
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 18a35e798b72..25e581299226 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -10,6 +10,8 @@
 #include "iommu-priv.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
+static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
+						   struct mm_struct *mm);
 
 /* Allocate a PASID for the mm within range (inclusive) */
 static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct device *dev)
@@ -277,8 +279,8 @@ static int iommu_sva_iopf_handler(struct iopf_group *group)
 	return 0;
 }
 
-struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
-					    struct mm_struct *mm)
+static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
+						   struct mm_struct *mm)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
-- 
2.34.1

