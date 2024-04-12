Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A554F20A
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909722; cv=none; b=t3/RxYZ2i1yzZ9Q2paRSvOqX9GkJBe4e78Z2P/kxiQFDQOJvMTbiVFK1smZgG07EGS6VH5RiVoFToy9OttHuuzfJ49Byw0hkdnKJHPa/7rkjCYp6Hqd7aRsh1foXYGibc0ZA9xrnUsgiA12sLMFhTpVlPsVfGS5Hbr+hhXPnIrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909722; c=relaxed/simple;
	bh=qoyJpcJ2+w+2yEzQ/z6sOf/WYiiOnrEms+md8VARlN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qen4gI6set60tMYYnt0zWI1zvVcDdBSo1W8bFGafSYUP8Pd8HVL/XlgiUC3biYHWWIOUfY8yyTscvipW2RDMU7b2CuGcCeNfJTgm79dvgv4PZZOpRoLnPJcemdzvmTctg/ttqwwuu2WeGPe8cKsJdtTW7wrj2OGAOCPo4M2GHsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghC26IJH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghC26IJH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712909721; x=1744445721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qoyJpcJ2+w+2yEzQ/z6sOf/WYiiOnrEms+md8VARlN8=;
  b=ghC26IJHuQucRTltqpu28Wp5+uzoKuYALK8TAJ8crpN1uG9WOEUHZlaU
   Fdo3qPgnResiEZm6CQWNxycGdMUk4OTzv8aWp9Lt52ooITR9j7ZtrZG0n
   W7nP3nl7d65oDOawhDhgswJytsbKes0AUXRuv7xsRoV+tu6ve8y3hKEgB
   iyqPXNexz0wbTZyknY4O9bdqrwlVcVpLRNRHUS+fy43CyckhHxPdrvouE
   KRZ3a8gQ1yCC6j4f48GaHaN0yHEk8pB96driJL79dKCaIpqYAcOxhLT/D
   FN7RUuty+amSLvt8NNkMQl70Pvr7weaTIyBw4C8ZgXxsfF87eQOkR+Nt8
   g==;
X-CSE-ConnectionGUID: ok+Ki8ePQBeFed5h0+IUrg==
X-CSE-MsgGUID: 2+P/l6F/Slq7u1sbS+Fy6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8465034"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8465034"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:15:19 -0700
X-CSE-ConnectionGUID: 6JbL2KX/QNCZ8hE7I5tECg==
X-CSE-MsgGUID: VbfGTSwmT2aRO1XYXZUWkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="52137757"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa002.jf.intel.com with ESMTP; 12 Apr 2024 01:15:18 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	jacob.jun.pan@intel.com
Subject: [PATCH v2 01/12] iommu: Pass old domain to set_dev_pasid op
Date: Fri, 12 Apr 2024 01:15:05 -0700
Message-Id: <20240412081516.31168-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412081516.31168-1-yi.l.liu@intel.com>
References: <20240412081516.31168-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support domain replacement for pasid, the underlying iommu driver needs
to know the old domain hence be able to clean up the existing attachment.
It would be much convenient for iommu layer to pass down the old domain.
Otherwise, iommu drivers would need to track domain for pasids by themselves,
this would duplicate code among the iommu drivers. Or iommu drivers would
rely group->pasid_array to get domain, which may not always the correct
one.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 3 ++-
 drivers/iommu/intel/svm.c   | 3 ++-
 drivers/iommu/iommu.c       | 3 ++-
 include/linux/iommu.h       | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 45c75a8a0ef5..df49aed3df5e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4626,7 +4626,8 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 }
 
 static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
-				     struct device *dev, ioasid_t pasid)
+				     struct device *dev, ioasid_t pasid,
+				     struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c1bed89b1026..ac8733b61470 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -315,7 +315,8 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 }
 
 static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t pasid)
+				   struct device *dev, ioasid_t pasid,
+				   struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3183b0ed4cdb..701b02a118db 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3321,7 +3321,8 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	int ret;
 
 	for_each_group_device(group, device) {
-		ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
+		ret = domain->ops->set_dev_pasid(domain, device->dev,
+						 pasid, NULL);
 		if (ret)
 			goto err_revert;
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 40dd439307e8..1e5e9249c93f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -631,7 +631,7 @@ struct iommu_ops {
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
-			     ioasid_t pasid);
+			     ioasid_t pasid, struct iommu_domain *old);
 
 	int (*map_pages)(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
-- 
2.34.1

