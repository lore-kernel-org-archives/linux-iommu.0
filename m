Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231E5191F72
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 05:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230852; cv=none; b=tMt7HtaUogjD3MSj1xWA0uNQqNQUusOBdzFat3ClHPttW4CACYSwVnBYqmub/vQGaHF6XQiL+bx7mMZAd+Y1s/iDQZaIrf2SBg2Yn3XzSLc5/Fwu8p7Y13xsLLhEWCcYZfJ/wjhOa02LjrpVIu/s9Sojl6m9wihmy/uDNz6V1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230852; c=relaxed/simple;
	bh=7iKgbnql9TVwiX7VYuXhhW+8bsWx4PXvI9Qt1OiOP40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nu+noVJHBu1w7tXvkcKvUJRJ7vj4pzwx7pomzP7CiKGUQFLZxa+YeT2s6svvYgUEaRvhnHN4idz+9fwC1Or4abrREm7ljrM1MTPPFdJnfE8nzz0mZc6/gKY6t2Z6bbkR/7z/7loBl+986mRffcCDoCd8o918bQN06B6KajXeAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwIIGNUx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwIIGNUx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729230851; x=1760766851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7iKgbnql9TVwiX7VYuXhhW+8bsWx4PXvI9Qt1OiOP40=;
  b=NwIIGNUxYURgL5HFVinTPDrcLh9yKfvpD3gdvJbpL3nVgTOz/brfiP1m
   pQdmO0WXS3AE2R5lw4F+ImZm8N+PdkWXG10EIl3vz2nt40I5K054iBJrn
   0mU954QM2rzS3GOxSjOliCDUAhDELyAk6ntxWlV8+hRkEngAPr/vwpr8g
   MvSL9s2KRIGY1hNlPiKhOnU2wBo+t1nyWQE26rlXc2vmRTnwI6M1qwHq0
   xTerhviDUrlaiq27aiEC69d+wXypwehroj1XaOROpPullmeJyb1aFBB61
   uOPXU4Gaa+rnUzc7XJOND7YOOgh4VV5mX+w86jHM2xK4I26dbv8AOeYXV
   w==;
X-CSE-ConnectionGUID: B/o9OKRGTy+nTxNE1DKDmQ==
X-CSE-MsgGUID: 4S6UN/i8Ru6uWR9mCCNKjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28708843"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28708843"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 22:54:10 -0700
X-CSE-ConnectionGUID: krBm4ja6THG1wuQiigxGDw==
X-CSE-MsgGUID: 9BBr2ac4SoebUnQl2Ofn8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="79188602"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 17 Oct 2024 22:54:09 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	will@kernel.org
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com
Subject: [PATCH v3 9/9] iommu: Make set_dev_pasid op support domain replacement
Date: Thu, 17 Oct 2024 22:54:02 -0700
Message-Id: <20241018055402.23277-10-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018055402.23277-1-yi.l.liu@intel.com>
References: <20241018055402.23277-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu core is going to support domain replacement for pasid, it needs
to make the set_dev_pasid op support replacing domain and keep the old
domain config in the failure case.

AMD iommu driver does not support domain replacement for pasid yet, so it
would fail the set_dev_pasid op to keep the old config if the input @old
is non-NULL.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/amd/pasid.c | 3 +++
 include/linux/iommu.h     | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index d1dfc745f55e..8c73a30c2800 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -109,6 +109,9 @@ int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
 	unsigned long flags;
 	int ret = -EINVAL;
 
+	if (old)
+		return -EOPNOTSUPP;
+
 	/* PASID zero is used for requests from the I/O device without PASID */
 	if (!is_pasid_valid(dev_data, pasid))
 		return ret;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32dce80aa7fd..27f923450a7c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -616,7 +616,8 @@ struct iommu_ops {
  * * EBUSY	- device is attached to a domain and cannot be changed
  * * ENODEV	- device specific errors, not able to be attached
  * * <others>	- treated as ENODEV by the caller. Use is discouraged
- * @set_dev_pasid: set an iommu domain to a pasid of device
+ * @set_dev_pasid: set or replace an iommu domain to a pasid of device. The pasid of
+ *                 the device should be left in the old config in error case.
  * @map_pages: map a physically contiguous set of pages of the same size to
  *             an iommu domain.
  * @unmap_pages: unmap a number of pages of the same size from an iommu domain
-- 
2.34.1

