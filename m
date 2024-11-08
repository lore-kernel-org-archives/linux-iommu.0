Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433340879
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 02:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032114; cv=none; b=P9/NvuR5oHSGkGD3niIWugYisOX6EmC7m+I4HoEhk3N5cAtwN5aQvSPsrqaw6R6NGjc88dw2gWJQ/8pb6m2H26nulGAc+6pIzcIaKcaQ3hPZNy3CNFQFEMwYxrWR8WPmAaiGxUW4puSCSkNB1Fwd0BVXu17EOBffP1iCtW94bM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032114; c=relaxed/simple;
	bh=G+Y8J+0WNqmr3G0Kd7RRpjHuNjXAsp1Hy5kAf8nBlMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhOpN/U2zhdNMaEIILgRBvGtEYzauk9BlWAN4iBr50KB+tB786s8I9A4XrMXPJh/68ctEjfjh+FSAqVMliWq55g4A0c6E1CT3eIg9OBW7xMdEe3ycefx+qYPXDg+9DECONGM/7Cpqug0/kABRJrpPmn8Dx0IXIPgNMDOMGEpY7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yw3Xejfy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yw3Xejfy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731032113; x=1762568113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G+Y8J+0WNqmr3G0Kd7RRpjHuNjXAsp1Hy5kAf8nBlMs=;
  b=Yw3XejfyUSs0SpgGzUkF5o3VS+SHbB4gi5A6g74Jgf50ozCclhlyfE9X
   Fktx6EUIl05VO7I46z5L8m/5i3b44TAxe4NiAl1d6dKhwS0f40s+1y9d/
   q2egrCJtM9pQPtTzfX5oBOSD1ciHNZqDhWojTVviGJE1evFr+3qyOXMIz
   FN8zBLQhvX/jYFr7NnBAMjV3oyfoocMsXqH0/F5TmFVYi6RLThhB7wugO
   yf3sZQDEEFUBkyVpeeSw3hXXjRLjsXzEhwif8Nm1tMYU1qDFBLtPz6/8Z
   qA2mP7ALXduZg/jXjnsZqdfBPTmvfwtAgLH61ZVFDG/Iqcpm64IIwT3qN
   w==;
X-CSE-ConnectionGUID: bdorregPTx6PbEpWY3NNTg==
X-CSE-MsgGUID: 1e8VdJPdRCecv8y9yBvRWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31007809"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31007809"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:15:12 -0800
X-CSE-ConnectionGUID: z2cZ34OcQWe+XflbuiLLvQ==
X-CSE-MsgGUID: iX6aAnVMTeGLi7lSmAl89A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="116213812"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2024 18:15:10 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] iommu/vt-d: Make intel_iommu_set_dev_pasid() to handle domain replacement
Date: Fri,  8 Nov 2024 10:13:58 +0800
Message-ID: <20241108021406.173972-8-baolu.lu@linux.intel.com>
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

Let intel_iommu_set_dev_pasid() call the pasid replace helpers hence be
able to do domain replacement.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20241107122234.7424-8-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 46 +++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 103b109e23a9..d19bd0ff5220 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1752,10 +1752,36 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	intel_context_flush_present(info, context, did, true);
 }
 
+static int __domain_setup_first_level(struct intel_iommu *iommu,
+				      struct device *dev, ioasid_t pasid,
+				      u16 did, pgd_t *pgd, int flags,
+				      struct iommu_domain *old)
+{
+	if (!old)
+		return intel_pasid_setup_first_level(iommu, dev, pgd,
+						     pasid, did, flags);
+	return intel_pasid_replace_first_level(iommu, dev, pgd, pasid, did,
+					       iommu_domain_did(old, iommu),
+					       flags);
+}
+
+static int domain_setup_second_level(struct intel_iommu *iommu,
+				     struct dmar_domain *domain,
+				     struct device *dev, ioasid_t pasid,
+				     struct iommu_domain *old)
+{
+	if (!old)
+		return intel_pasid_setup_second_level(iommu, domain,
+						      dev, pasid);
+	return intel_pasid_replace_second_level(iommu, domain, dev,
+						iommu_domain_did(old, iommu),
+						pasid);
+}
+
 static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev,
-				    u32 pasid)
+				    u32 pasid, struct iommu_domain *old)
 {
 	struct dma_pte *pgd = domain->pgd;
 	int level, flags = 0;
@@ -1770,9 +1796,9 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 	if (domain->force_snooping)
 		flags |= PASID_FLAG_PAGE_SNOOP;
 
-	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
-					     domain_id_iommu(domain, iommu),
-					     flags);
+	return __domain_setup_first_level(iommu, dev, pasid,
+					  domain_id_iommu(domain, iommu),
+					  (pgd_t *)pgd, flags, old);
 }
 
 static bool dev_is_real_dma_subdevice(struct device *dev)
@@ -1804,9 +1830,11 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (!sm_supported(iommu))
 		ret = domain_context_mapping(domain, dev);
 	else if (domain->use_first_level)
-		ret = domain_setup_first_level(iommu, domain, dev, IOMMU_NO_PASID);
+		ret = domain_setup_first_level(iommu, domain, dev,
+					       IOMMU_NO_PASID, NULL);
 	else
-		ret = intel_pasid_setup_second_level(iommu, domain, dev, IOMMU_NO_PASID);
+		ret = domain_setup_second_level(iommu, domain, dev,
+						IOMMU_NO_PASID, NULL);
 
 	if (ret)
 		goto out_block_translation;
@@ -4145,10 +4173,10 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 
 	if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
-					       dev, pasid);
+					       dev, pasid, old);
 	else
-		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
-						     dev, pasid);
+		ret = domain_setup_second_level(iommu, dmar_domain,
+						dev, pasid, old);
 	if (ret)
 		goto out_remove_dev_pasid;
 
-- 
2.43.0

