Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17F288D1
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032137; cv=none; b=lzLiGo2m06CZHq4GLsybCj5YW2Mt39H6tew/oNsKZPtCpH4br+6Q+Xy+7bZsZp0d73UY3lHTTKm+3+VpZ2CMSiQkCXnkZnSXR8XxGMuIqJho1tjQ3taJxPamBxvJkeDlDWMNij2mtZB37sPnu9FUuHmxguIc52xYy4l3//+wPmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032137; c=relaxed/simple;
	bh=vLIIkzIeeRGQ2f+7KVZkFTMmDLAJzpo0wxcN3DAX7KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ir3qqmgH1B+oI5vBCCeL+F3c1ku4C6gEWd6w1HvuOajMzts8uIY+PbpJX7+IZwXiD2jML/enXZZcLTb089kwJ+oPuqklW5Ld37gPnnKWlisFoKE4rDfts+02WoTlTA69jVMrDsemXr/WSTzbJf9wzQ8T9ecljUG0zEJFuxmysY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zks1Fy1P; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zks1Fy1P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731032136; x=1762568136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vLIIkzIeeRGQ2f+7KVZkFTMmDLAJzpo0wxcN3DAX7KU=;
  b=Zks1Fy1PSjlt7BxM4EMVyNKrrWgp9y28t3p0Z/w3Q1J1c04LDHHBcqZr
   a+suQo87Hpd8E8sGFNUJma+D0m5AfHTzzTar2gm7g99yEJhVK0gS9bTRM
   nRBgHaSbfcSEvxSTwcpkKc4dBjlNraEcKDzp0d0TdU4EkJ/hIEAxCLJC/
   veupvXPQtPlGCxhUv5EFwCM3P1+MoYi9qaZxVNo18tAsSiZuOT28AFdlC
   GhSCiOblBjvbjRXhRMyHsU0ARm1fo4rfWKVK8YeThqeO2T2vuTu0emFyy
   KozJNolJytKf/QiWVAJIhK6ogsV09giVNwgkArs6I40xEt1ivy7KLvEQT
   g==;
X-CSE-ConnectionGUID: E6GpnAaxT/qWQ95Ng36RzQ==
X-CSE-MsgGUID: PrMmPwJ9TgOSJ+cuQ4QDsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31007877"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31007877"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:15:24 -0800
X-CSE-ConnectionGUID: v7/dZZN8S12eEBKcucLQLw==
X-CSE-MsgGUID: fYToPKFuRmW65tzcONP0tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="116213852"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2024 18:15:22 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] iommu: Make set_dev_pasid op support domain replacement
Date: Fri,  8 Nov 2024 10:14:04 +0800
Message-ID: <20241108021406.173972-14-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108021406.173972-1-baolu.lu@linux.intel.com>
References: <20241108021406.173972-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

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
Link: https://lore.kernel.org/r/20241107122234.7424-14-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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
2.43.0

