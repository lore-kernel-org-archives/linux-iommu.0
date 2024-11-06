Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95327208219
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907980; cv=none; b=GP06qmvzW3r96wBcOyjXqyao7TprP0k9028PB8fiJZ7CwGse1yt97vBO2sKaflAwYV56r2Z6Z+lzgJ9CesLsI0A2yTgenpB6IR0nfV86A24EYZ0+gwpDlRAdvHJnxj3/zTmKx/XpFf9lDy7jG3RIz30Bi8q38vImSm4oHCC6pxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907980; c=relaxed/simple;
	bh=YQbNiBetTn/f7PT9oR9wqLpSCGd2nngC6kfX9asM9Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkQmPqP7uoxwV0zTZ0D/ufbkCYYWuQ+MEujm80WIHaiPeiPoO0iebhz9a8aEnxG3AAI7nBOxT6QH4joK9XYf+LG5wQfHlOXcvMkY1e+6S4vjPXp3DYtuYXppXekMywtnSpiYZj6pYkYfbrL1z/6+0qIwLOBc2LLV5ayov+YeNPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9uAJqU2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9uAJqU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730907978; x=1762443978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YQbNiBetTn/f7PT9oR9wqLpSCGd2nngC6kfX9asM9Go=;
  b=W9uAJqU2siHRz3LjJ1bHgBjZEW1c7ZZ28lSLFRf9Z1KLbQK8hJot+6BG
   W4PRjgEAsXKHMoX5RI9EHgxLB140mobp0xKpbTcVgDAo2x0kLsrKWOdTR
   bvg3d4NtzqjmmGenH0ObzE0LIFAEPsfhIUstHzh6NmVVLDtDZhfjNnGw4
   8wl1M6cvuodSzHRdVaaRsuzLlICjE+mC+o/yiSEjw6Bnw8Oa28S5mcb0j
   Imwo4Bez6LTJBYkEshITPlsEgQqCbFTd8nwaAPEVfrt1NTBELmn9cPGI0
   acCAsUOj58Rx3mn5fplm4pA0LbOmCnjsDi7Zq9jft0y7nUkyaDBjBOBRa
   g==;
X-CSE-ConnectionGUID: vS8MbOTzQ2+OvZQcu85RgA==
X-CSE-MsgGUID: q+izS6roSda5D9d2InQoZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48174313"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48174313"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 07:46:14 -0800
X-CSE-ConnectionGUID: XAytVs9dS9eK5gK9OU6qlw==
X-CSE-MsgGUID: yvY5lH2cSTG1xvi02f3EGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89468331"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 06 Nov 2024 07:46:13 -0800
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
Subject: [PATCH v5 13/13] iommu: Make set_dev_pasid op support domain replacement
Date: Wed,  6 Nov 2024 07:46:06 -0800
Message-Id: <20241106154606.9564-14-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106154606.9564-1-yi.l.liu@intel.com>
References: <20241106154606.9564-1-yi.l.liu@intel.com>
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

