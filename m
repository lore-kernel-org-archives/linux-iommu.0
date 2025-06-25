Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0171DBB13
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750827847; cv=none; b=FCm0bmlzKP6S6Z0AU2kQ+TB+XMjB4PueX0EadUCXZmm3ZP8EOk/nG0R8vkxKLIys12wRA5vu/TLHp46LxzE3gRWpK9F8Li8UlHLJyC0DOe/pBxnisEi5PM7YNJyzn2F+UuOKkiti7jAWF1Pc9gIq0oDqaTrlZ+Y5IwERBq8/m24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750827847; c=relaxed/simple;
	bh=VI1KQdVhT4iTCZzmMmQQUoZ5wVMsmhnujrwjoo8Ak2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8qKFpr60hZvaYLq/FCjRjbbK2rHUI7kLwEwKiLmBiLY9Yr7pDrd23ZcNiSi7stZqfpZH/XQETWLjd2YSRQGk/Tx3D4o8cfEXLFRIKq3r5H4amvv32TOZNgixKdkYtl8eEG25ab6SFp4vZViCwpJH/4yH4mJfjmunu5e5BaG4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8gO54Vg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8gO54Vg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750827846; x=1782363846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VI1KQdVhT4iTCZzmMmQQUoZ5wVMsmhnujrwjoo8Ak2w=;
  b=F8gO54Vgz7R+Txp7MrewmYXV9pL34suxfuUm5WoGrqcoEWDcriCB5VCp
   suQh4oWH3aHnBZ95rMyXzh7FsXTdjTa0SFYeJ8neFx3iSjRDiksUToguW
   SCfPqJVLA716Bw7ncpO+YFfWA1sypkBtxdF7icMvJxyo5YMwRGY3dgN0x
   NAQpwwPTvNGglaTS+8mKOKraBDCZAS5LTmBs0OMp5lY64N8gbh/IyYqrm
   PlCC7FGZaVYoyemlxUH9JExD1DjoyZvHWmCu128FlKNC06NRSPmojkFDP
   S48CzUZ1N3ZL1AxHhEdE5J1UoVl59ckcY/rG3IRHP2cjkHKlk3DZzLAi8
   w==;
X-CSE-ConnectionGUID: 5k3h5DtbRtC/wQikWFefjg==
X-CSE-MsgGUID: cuJ9EdTOSsGCJSJszLaEqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="56760104"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="56760104"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 22:04:06 -0700
X-CSE-ConnectionGUID: 7VaUwAh5QjSfxzy5ZCq4Ew==
X-CSE-MsgGUID: 4+/NXHdYSmWiUxLEDbYVpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="152284687"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa007.jf.intel.com with ESMTP; 24 Jun 2025 22:04:04 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] iommu/vt-d: Assign devtlb cache tag on ATS enablement
Date: Wed, 25 Jun 2025 13:01:35 +0800
Message-ID: <20250625050135.3129955-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit <4f1492efb495> ("iommu/vt-d: Revert ATS timing change to fix boot
failure") placed the enabling of ATS in the probe_finalize callback. This
occurs after the default domain attachment, which is when the ATS cache
tag is assigned. Consequently, the device TLB cache tag is missed when the
domain is attached, leading to the device TLB not being invalidated in the
iommu_unmap paths.

Fix this by assigning the CACHE_TAG_DEVTLB cache tag when ATS is enabled.

Fixes: 4f1492efb495 ("iommu/vt-d: Revert ATS timing change to fix boot failure")
Cc: stable@vger.kernel.org
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/iommu/intel/cache.c |  5 ++---
 drivers/iommu/intel/iommu.c | 11 ++++++++++-
 drivers/iommu/intel/iommu.h |  2 ++
 3 files changed, 14 insertions(+), 4 deletions(-)

Change log:
v2:
 - The v1 solution has a flaw: ATS will never be enabled for drivers with
   driver_managed_dma enabled, as their devices are not expected to be
   automatically attached to the default domain.

v1: https://lore.kernel.org/linux-iommu/20250620060802.3036137-1-baolu.lu@linux.intel.com/

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index fc35cba59145..47692cbfaabd 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -40,9 +40,8 @@ static bool cache_tage_match(struct cache_tag *tag, u16 domain_id,
 }
 
 /* Assign a cache tag with specified type to domain. */
-static int cache_tag_assign(struct dmar_domain *domain, u16 did,
-			    struct device *dev, ioasid_t pasid,
-			    enum cache_tag_type type)
+int cache_tag_assign(struct dmar_domain *domain, u16 did, struct device *dev,
+		     ioasid_t pasid, enum cache_tag_type type)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7aa3932251b2..148b944143b8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3780,8 +3780,17 @@ static void intel_iommu_probe_finalize(struct device *dev)
 	    !pci_enable_pasid(to_pci_dev(dev), info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
-	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev))
+	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
 		iommu_enable_pci_ats(info);
+		/* Assign a DEVTLB cache tag to the default domain. */
+		if (info->ats_enabled && info->domain) {
+			u16 did = domain_id_iommu(info->domain, iommu);
+
+			if (cache_tag_assign(info->domain, did, dev,
+					     IOMMU_NO_PASID, CACHE_TAG_DEVTLB))
+				iommu_disable_pci_ats(info);
+		}
+	}
 	iommu_enable_pci_pri(info);
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 3ddbcc603de2..2d1afab5eedc 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1289,6 +1289,8 @@ struct cache_tag {
 	unsigned int users;
 };
 
+int cache_tag_assign(struct dmar_domain *domain, u16 did, struct device *dev,
+		     ioasid_t pasid, enum cache_tag_type type);
 int cache_tag_assign_domain(struct dmar_domain *domain,
 			    struct device *dev, ioasid_t pasid);
 void cache_tag_unassign_domain(struct dmar_domain *domain,
-- 
2.43.0

