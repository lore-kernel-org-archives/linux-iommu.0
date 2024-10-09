Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE336AEC
	for <iommu@lists.linux.dev>; Wed,  9 Oct 2024 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728451384; cv=none; b=sk1P63/hHqWkUIDbiU75ebX+Z+lCcfzwzZZF+wW3jXaR3WB5jSbyGDOp/y3AmFQQyYGLTL+sDox2uXjw8mTB3V1hzuxymtE9rZbP3dGmvlfJEPbbTOb7PVVug0HP8WRlsYkqF6pJPPBGuliI/akU5R9ctBtIUYkelIfJDShtmCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728451384; c=relaxed/simple;
	bh=w3PPIcZwXTtAKnKKRRVV9XXKOS2j2nBVQnXlZqyMfJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cfj+F+uh2U/vJbGOHvS3vdG9Qz+ntQMn6ZX8E7DkFTo6h9LpvjESylaV8DpiQIVY2LIZRo3vyJXDMCrl+Mgzq6a05AGQQDryHQnmm5wEYI05BP3hY09Arqix274wv9kQW1sCSlywdI5hvqdtqZofPQCdDrgf16Y4SX5KUpKoUDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kp8U92pP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kp8U92pP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728451381; x=1759987381;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w3PPIcZwXTtAKnKKRRVV9XXKOS2j2nBVQnXlZqyMfJU=;
  b=kp8U92pPS8rNCdJZwtdm2p7os4AdvQCM7YDl/gv5OhPA96e6tR58wDUd
   s+TYWIGA+XySICrGz1tSKtdQ/3cJIZ3OwEcfPUW/p1fvwnzbrYVRmSOOr
   yZJRUC34xcwqZyRK9ipQ+cqk4TG/aIE3pit7/VGZgL/r+9PNhmFFmsFdc
   mIMxnC7VdEGhaF315nueT9vnWz/vU8G2V6/Q1K5AxAsWeLAtNuV5FFc9q
   LBGYEEDm+VLpN6f+Ro63XwSGRL6lihGJVfSX6NrPmAJ6w1RLCK8YAHUZv
   0hzuWWytVLZSIXZpFmNxPeE78BRQpB/vauWQg1JYn9eEYz9xE0NCBLgTA
   w==;
X-CSE-ConnectionGUID: eLIGST5zSnyUZVD3oP/u6g==
X-CSE-MsgGUID: EBSPNe28Q3+CEMH1ruKT0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31618886"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="31618886"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 22:23:00 -0700
X-CSE-ConnectionGUID: aWEDTwahTVaHHa3uQWONCw==
X-CSE-MsgGUID: lD2mgc04SuqHskhy6WU2Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="80708184"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 08 Oct 2024 22:22:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 1/1] iommu: Remove iommu_present()
Date: Wed,  9 Oct 2024 13:18:08 +0800
Message-ID: <20241009051808.29455-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last callsite of iommu_present() is removed by commit <45c690aea8ee>
("drm/tegra: Use iommu_paging_domain_alloc()"). Remove it to avoid dead
code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 include/linux/iommu.h |  6 ------
 drivers/iommu/iommu.c | 25 -------------------------
 2 files changed, 31 deletions(-)

Change log:
v2:
 - Remove Fixes tag.

v1: https://lore.kernel.org/linux-iommu/20240930004235.69368-1-baolu.lu@linux.intel.com/

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bd722f473635..62d1b85c80d3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -785,7 +785,6 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 }
 
 extern int bus_iommu_probe(const struct bus_type *bus);
-extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
 extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
@@ -1081,11 +1080,6 @@ struct iommu_iotlb_gather {};
 struct iommu_dirty_bitmap {};
 struct iommu_dirty_ops {};
 
-static inline bool iommu_present(const struct bus_type *bus)
-{
-	return false;
-}
-
 static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	return false;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e617a2c5..7bfd2caaf33b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1840,31 +1840,6 @@ int bus_iommu_probe(const struct bus_type *bus)
 	return 0;
 }
 
-/**
- * iommu_present() - make platform-specific assumptions about an IOMMU
- * @bus: bus to check
- *
- * Do not use this function. You want device_iommu_mapped() instead.
- *
- * Return: true if some IOMMU is present and aware of devices on the given bus;
- * in general it may not be the only IOMMU, and it may not have anything to do
- * with whatever device you are ultimately interested in.
- */
-bool iommu_present(const struct bus_type *bus)
-{
-	bool ret = false;
-
-	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
-		if (iommu_buses[i] == bus) {
-			spin_lock(&iommu_device_lock);
-			ret = !list_empty(&iommu_device_list);
-			spin_unlock(&iommu_device_lock);
-		}
-	}
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iommu_present);
-
 /**
  * device_iommu_capable() - check for a general IOMMU capability
  * @dev: device to which the capability would be relevant, if available
-- 
2.43.0

