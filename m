Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849110E6
	for <iommu@lists.linux.dev>; Mon, 30 Sep 2024 00:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657227; cv=none; b=jgB1JsfvLJFg1CxgAlWHIoFiXTMgIUMYFsPvwXGFbnd+ea4y8QUxWv/0AgSpaLdYNlBznQQNrPJDEqlyeNt1y1V2+8RCtLWIbuMYJ8Q4M8F6/lgGuYmACn3Rz9bhScUFjf6jlXSx9RGKAbYPc52Xowt9nSBtmsrdLmwwyf0YfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657227; c=relaxed/simple;
	bh=tkLECTB+l1Q6yRxTTrW2xT7OlIctPpTL1rDsIqZoMXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+F26tvguNC+D5PS21y5pcQRDJLCDt6SXnjLzrSeO0SiTapq+csQIgMVjt5on76iJf4Vx+WlJQKGizHGzNM+09WC9mEx6lmr6YsaxIItYpiF/c+JZnS1Ll/1iov901YRkmHidl2Caq9cNeJPzSPtUNX2jz/gz8TiDdMu/aGUXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U40dk/Gw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U40dk/Gw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727657226; x=1759193226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tkLECTB+l1Q6yRxTTrW2xT7OlIctPpTL1rDsIqZoMXM=;
  b=U40dk/GwXkjyLSlFEXGdDM5ZtiFBT+OLCmHR44b+9yxm+O4RthHaZZf3
   Dr85AW2S3UNQsREvrke45OQk8AoxIyB4BbBawo6STKUebQHlF8AI+rGQV
   oryQsr8+/Vus52IPvkfn3vr59xUo2Co5SBGz6GzKaX/argYyi1ZYeHaaW
   8tqN3Tg9kF9Qr0M3Z0p21Sa4tl67ZdAhJegvI02w/nzL7QaF4suS+n379
   VF4jbn16dhBsdYs7bkb3TXdyyW2ChUJevijgCoSRIkoI8jWIfSoceYslv
   9JcoYcYtcD/eV1IGCuzQgRk8QOsMWBj4QDh3nzorQWPaRiR6/LxbqCj1q
   g==;
X-CSE-ConnectionGUID: 9ZSNg9ujSXCSRNqWTcr1Wg==
X-CSE-MsgGUID: S6fASKzGQE2CFL5C1Itljw==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26237286"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="26237286"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 17:47:05 -0700
X-CSE-ConnectionGUID: gck1bmcAQiiXN2htoZ+DIw==
X-CSE-MsgGUID: Bo96lJY5TSKfH9n6pHI06w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="110610850"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2024 17:47:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 1/1] iommu: Remove iommu_present()
Date: Mon, 30 Sep 2024 08:42:35 +0800
Message-ID: <20240930004235.69368-1-baolu.lu@linux.intel.com>
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

Fixes: 45c690aea8ee ("drm/tegra: Use iommu_paging_domain_alloc()")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/iommu.h |  6 ------
 drivers/iommu/iommu.c | 25 -------------------------
 2 files changed, 31 deletions(-)

Change log:
- Originally posted here
  https://lore.kernel.org/r/20240610085555.88197-21-baolu.lu@linux.intel.com
  After several patches in that series were merged, this patch is
  targeted for 6.12-rc.

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

