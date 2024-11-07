Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DF7212183
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982167; cv=none; b=pQpQIuU0DowVwLraUJ6OP23dY9Xz9IauaoPU64teQ8R/MZQg82FG0SJ6h9RY/XHvotieX9NUV8kMvxXRkBOE7+xbZdm3JwE3kMh/D0fQenkaZrTx8AdYVtkNb8gDSGbHZNQDBDpBYzHefYIlYW7/9ynmPURCL+704af21EKWX3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982167; c=relaxed/simple;
	bh=YQbNiBetTn/f7PT9oR9wqLpSCGd2nngC6kfX9asM9Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQLm4IYSa3usvTLIK0WC8vLOpas20YH6Zk55qZaj4+935X2V6SYYX+qu2ZQa2kCbXwXv51ue5UF65foxMSE4pjIAq8Di+pWQYTKuC0ZiRjjOUvhjudUhReSF7cF6Yy0toOOK3FsG4BSjNBcVqUUfqiw4QrAp45heR+k5YVbM2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZ1/r+Kb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZ1/r+Kb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730982166; x=1762518166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YQbNiBetTn/f7PT9oR9wqLpSCGd2nngC6kfX9asM9Go=;
  b=lZ1/r+Kb1sj9p/6e67SXj1CqrrPo1SUxzHi1ePO36rAqAHvPPQK3vdPm
   BfH/taM59usLflmoj21Aub63o9AMBhhxdvTVs5FbG18GJddFUi/ch6Xxo
   0H9C8oZeCnNE9JMBaZ/XXO/IWYKucPpfJ6x8h7lhlY3XMyzYTOgXnKj8c
   jKLpd028vZoaIfOaDrAwAoayo/ZzDVfaz0cpGuSBKEk1G5skACKvbZAz8
   +/HAO0tsGR5MbhfIQvi+1xoa3M5ZKV8xgfvKBUwSAPIZGas3O/U6IrucK
   Rc5tyzxnWEDJ13KemhDswolF6AECC1uj9BGsMBGSGxiHgEo2fhKCVPRMq
   A==;
X-CSE-ConnectionGUID: /NKF8LePQeavLeIclD98DQ==
X-CSE-MsgGUID: QHv/VOwxTGGkan0vjRJoKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34744678"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="34744678"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 04:22:45 -0800
X-CSE-ConnectionGUID: WnZG3+jnR1228Auuhpb6bg==
X-CSE-MsgGUID: TxScV+IWSwGO3atxxPsj7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="90180627"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 04:22:46 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	willy@infradead.org
Subject: [PATCH v6 13/13] iommu: Make set_dev_pasid op support domain replacement
Date: Thu,  7 Nov 2024 04:22:34 -0800
Message-Id: <20241107122234.7424-14-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107122234.7424-1-yi.l.liu@intel.com>
References: <20241107122234.7424-1-yi.l.liu@intel.com>
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
is non-NULL. Till now, all the set_dev_pasid callbacks can handle the old
parameter and can keep the old config when failed, so update the kdoc of
set_dev_pasid op.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
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
index 56653af5edcb..0c3bfb66dc7c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -614,7 +614,8 @@ struct iommu_ops {
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

