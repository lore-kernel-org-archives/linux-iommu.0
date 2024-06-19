Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F737B
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718762198; cv=none; b=DIVFOEfYKQiN7fdcbwN8X9dpHDIDtP11zQCbqERzdG3SdJi/QQ/uJHkBSLNCB2bFC+WUkjtjiJWIDoyD9GOqnx1Yy1ZkBqk0JXMH14Pd6ym4kibI3gWlHsLqAn4w5Nx/rFYuzJMVdDUJooSTJxhArgAdduwPU+7tcvOy8CO56qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718762198; c=relaxed/simple;
	bh=n5EwU4DGRZROLJkTn6VWg800Z3mpjBTC96wV+Ky+4HY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KmXHeGMPs9+Ugte1NJqVVDYlxkBO1wMIlY4f3PKjqNAof9HKugAX1p/3XjScLk982p6IpbrJmLlS0te10mJoFuj2I8XeOjji5LHulGnNg7OtnUFwZqHLDOMpHivirjZYv6EFTKZU9hhfHSe0zId3dxttcCq/uEMKrt1z/SLvrIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zfv2L1tF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zfv2L1tF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718762197; x=1750298197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n5EwU4DGRZROLJkTn6VWg800Z3mpjBTC96wV+Ky+4HY=;
  b=Zfv2L1tF3Ag9nTm/u3UP/KhFR/zwcoOGad86qCD4IdWy/bjXbN+wh3CL
   C/ilHBEv/kUhwU25iyHwaFkp3WZ+dYQTn9lbpMM2aKb9KtwLKEj4gvXR8
   pg1CXr1TrdaCbb4YBA0oaVJdnO/QIuI6mUarswGXfTGRZsPANw+Ay+l1Y
   cIsSAuH4w9FpPfedg2Mp6hcgOT7Sx2PW1/NYzitSX6PRJig82RLsiGyd7
   tYAuMYZkAHDe6q144FmN4BlEJ3Hf0WJ9KNXxJgfEthVaDHt/qvOKiFgQH
   8w14/wgvhRaiDvmu8ziZ0GNqCca7uVxnKDxrtAcZMDBeurZESgjgXvl/n
   w==;
X-CSE-ConnectionGUID: YuvyCXoBR4CJaUbwY3suyQ==
X-CSE-MsgGUID: 6Z9dEGVyQoGKwb9gfmv3Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="18593934"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="18593934"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 18:56:36 -0700
X-CSE-ConnectionGUID: ZP8y2tRJR+GLYYzWDxzcCw==
X-CSE-MsgGUID: Uzo/rQ7YQ5u00dUMe//DOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="72958898"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 18 Jun 2024 18:56:22 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
Date: Wed, 19 Jun 2024 09:53:45 +0800
Message-Id: <20240619015345.182773-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a domain is attached to a device, the required cache tags are
assigned to the domain so that the related caches could be flushed
whenever it is needed. The device TLB cache tag is created selectively 
by checking the ats_enabled field of the device's iommu data. This
creates an ordered dependency between attach and ATS enabling paths.

The device TLB cache tag will not be created if device's ATS is enabled
after the domain attachment. This causes some devices, for example
intel_vpu, to malfunction.

Create device TLB cache tags for a domain as long as the ats_supported
field of the attached device is true. In the cache invalidation paths,
the ats_enable field is checked and the device TLB invalidation requests
are issued only when the ATS is really enabled on the device.

Fixes: 3b1d9e2b2d68 ("iommu/vt-d: Add cache tag assignment interface")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/cache.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index e8418cdd8331..ec6770f556b9 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -112,7 +112,7 @@ static int __cache_tag_assign_domain(struct dmar_domain *domain, u16 did,
 	int ret;
 
 	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_IOTLB);
-	if (ret || !info->ats_enabled)
+	if (ret || !info->ats_supported)
 		return ret;
 
 	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_DEVTLB);
@@ -129,7 +129,7 @@ static void __cache_tag_unassign_domain(struct dmar_domain *domain, u16 did,
 
 	cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_IOTLB);
 
-	if (info->ats_enabled)
+	if (info->ats_supported)
 		cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_DEVTLB);
 }
 
@@ -140,7 +140,7 @@ static int __cache_tag_assign_parent_domain(struct dmar_domain *domain, u16 did,
 	int ret;
 
 	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_NESTING_IOTLB);
-	if (ret || !info->ats_enabled)
+	if (ret || !info->ats_supported)
 		return ret;
 
 	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_NESTING_DEVTLB);
@@ -157,7 +157,7 @@ static void __cache_tag_unassign_parent_domain(struct dmar_domain *domain, u16 d
 
 	cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_NESTING_IOTLB);
 
-	if (info->ats_enabled)
+	if (info->ats_supported)
 		cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_NESTING_DEVTLB);
 }
 
@@ -309,6 +309,9 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 			info = dev_iommu_priv_get(tag->dev);
 			sid = PCI_DEVID(info->bus, info->devfn);
 
+			if (!info->ats_enabled)
+				break;
+
 			if (tag->pasid == IOMMU_NO_PASID)
 				qi_flush_dev_iotlb(iommu, sid, info->pfsid,
 						   info->ats_qdep, addr, mask);
@@ -356,6 +359,9 @@ void cache_tag_flush_all(struct dmar_domain *domain)
 			info = dev_iommu_priv_get(tag->dev);
 			sid = PCI_DEVID(info->bus, info->devfn);
 
+			if (!info->ats_enabled)
+				break;
+
 			qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep,
 					   0, MAX_AGAW_PFN_WIDTH);
 			quirk_extra_dev_tlb_flush(info, 0, MAX_AGAW_PFN_WIDTH,
-- 
2.34.1

