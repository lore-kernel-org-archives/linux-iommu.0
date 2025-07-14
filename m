Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6781D1FDA82
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 04:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468773; cv=none; b=Fql40DGB7LhuvbxGjDbRJs6stayWHH2eoA8u00ppCSU5y7QXL3FQQNGKdzCn77WOimAfU4Re4ew2rr0rT4dNfD0BiCTlvg95ltspGKlRo8/a3LLqVsfc7yETKfSphLGVdoXmo0H6qg6H9CYeq0JppQ7IuV2+LDYTKDWo2pSTvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468773; c=relaxed/simple;
	bh=DwUhOZ8kbcjWYIdLnos9Z/vLhWxZdh9oLPf3cntU9Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgFwUwDlzwPac6YYZCOZPgAnCmGKdNZt04gu2BkwRaY0UJzH+1ZyBSxFAl9us01OvNdr9U8ACN+0S1oZKVh7BTg2cC2jxz8X7HgtpD9AOJxvX4PEqvKYR9luv2JlEJ1E3A8jfZIXWuuETjyBk7Qoq+izpoxE8KcdFokOSLa05hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSx1sGxX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSx1sGxX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468771; x=1784004771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DwUhOZ8kbcjWYIdLnos9Z/vLhWxZdh9oLPf3cntU9Sk=;
  b=hSx1sGxXRHAZ10W2nJT5saRgEVhggKfOyOXW4VioqfKHCVt/V4XwyP41
   8L2yKJJxj9WR5dTCx+EuGywCJ0A7agUJoPXHeydyfTl5WnWI+/jChFEfq
   /nlOQCZXvnqGXVKMo/pMQaXQtIFsIUR299dCf0avpUcBF3UIUYgmkQdjZ
   sRC9Y9FLL7iXNni+2lZC9JS8+aPGhUdet0AORFAtR4CdHt1QrS0bXeC3b
   sIVtmqAmb05NMowQxOAH6phavcdTMmwLR9MNxUSM9bQWGK1IINkEh4hyr
   ra5f0BesZC8c98JNnQ/NYye+PiCmIIvPkQdjMtVLCLGVUay3PeWBZzT8k
   w==;
X-CSE-ConnectionGUID: FoKgVuUVScO+eLv9uUbncg==
X-CSE-MsgGUID: C89WEON/QdGZpkkNOa28/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765040"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765040"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:52:49 -0700
X-CSE-ConnectionGUID: PKVbN8MVQQK2OS1dUDJbXQ==
X-CSE-MsgGUID: 7dT/4QJATLiy2tFd5rfK7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166146"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:52:49 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] iommu/vt-d: Optimize iotlb_sync_map for non-caching/non-RWBF modes
Date: Mon, 14 Jul 2025 12:50:19 +0800
Message-ID: <20250714045028.958850-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714045028.958850-1-baolu.lu@linux.intel.com>
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iotlb_sync_map iommu ops allows drivers to perform necessary cache
flushes when new mappings are established. For the Intel iommu driver,
this callback specifically serves two purposes:

- To flush caches when a second-stage page table is attached to a device
  whose iommu is operating in caching mode (CAP_REG.CM==1).
- To explicitly flush internal write buffers to ensure updates to memory-
  resident remapping structures are visible to hardware (CAP_REG.RWBF==1).

However, in scenarios where neither caching mode nor the RWBF flag is
active, the cache_tag_flush_range_np() helper, which is called in the
iotlb_sync_map path, effectively becomes a no-op.

Despite being a no-op, cache_tag_flush_range_np() involves iterating
through all cache tags of the iommu's attached to the domain, protected
by a spinlock. This unnecessary execution path introduces overhead,
leading to a measurable I/O performance regression. On systems with NVMes
under the same bridge, performance was observed to drop from approximately
~6150 MiB/s down to ~4985 MiB/s.

Introduce a flag in the dmar_domain structure. This flag will only be set
when iotlb_sync_map is required (i.e., when CM or RWBF is set). The
cache_tag_flush_range_np() is called only for domains where this flag is
set. This flag, once set, is immutable, given that there won't be mixed
configurations in real-world scenarios where some IOMMUs in a system
operate in caching mode while others do not. Theoretically, the
immutability of this flag does not impact functionality.

Reported-by: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2115738
Link: https://lore.kernel.org/r/20250701171154.52435-1-ioanna-maria.alifieraki@canonical.com
Fixes: 129dab6e1286 ("iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20250703031545.3378602-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 19 ++++++++++++++++++-
 drivers/iommu/intel/iommu.h |  3 +++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 148b944143b8..b23efb70b52c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1796,6 +1796,18 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 					  (pgd_t *)pgd, flags, old);
 }
 
+static bool domain_need_iotlb_sync_map(struct dmar_domain *domain,
+				       struct intel_iommu *iommu)
+{
+	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
+		return true;
+
+	if (rwbf_quirk || cap_rwbf(iommu->cap))
+		return true;
+
+	return false;
+}
+
 static int dmar_domain_attach_device(struct dmar_domain *domain,
 				     struct device *dev)
 {
@@ -1833,6 +1845,8 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (ret)
 		goto out_block_translation;
 
+	domain->iotlb_sync_map |= domain_need_iotlb_sync_map(domain, iommu);
+
 	return 0;
 
 out_block_translation:
@@ -3954,7 +3968,10 @@ static bool risky_device(struct pci_dev *pdev)
 static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 				      unsigned long iova, size_t size)
 {
-	cache_tag_flush_range_np(to_dmar_domain(domain), iova, iova + size - 1);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+
+	if (dmar_domain->iotlb_sync_map)
+		cache_tag_flush_range_np(dmar_domain, iova, iova + size - 1);
 
 	return 0;
 }
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 2d1afab5eedc..61f42802fe9e 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -614,6 +614,9 @@ struct dmar_domain {
 	u8 has_mappings:1;		/* Has mappings configured through
 					 * iommu_map() interface.
 					 */
+	u8 iotlb_sync_map:1;		/* Need to flush IOTLB cache or write
+					 * buffer when creating mappings.
+					 */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
-- 
2.43.0

