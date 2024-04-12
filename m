Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5AB51C49
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909741; cv=none; b=oIFZ9i8+McgO2SYcLi54i04Lp8wpGQJYJSEDh2sFucRNfdlO3eGuo555I0h05yOOujw+sExvTp5NIer1V5vUTUU4z8ulSfuA3CKpp59xF2eOU5F1EjwfjdApxvECPjEmxPG7U+ZTtq+NS8Y8vzZkIKo4x0ZKD13BGxphIcZ7qW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909741; c=relaxed/simple;
	bh=P1lzQYpZeJqGVZFZCQ+jo9tmCkUyhO8d2a1+/TbV4Ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ndv/3WQTHwvTIcx6K07pofaDlmKyKkaF9M8CuxNnbJnNY9LMOt2QJ4LabRXBvrS6+/emt/rQ6SzghEYF8iMFmFwZ3dR0Jo+JWHB7EuJSGlWloo1g04DJGOO8TJwd8Bc4txMYFLe+tHgbi118aVk0jmi2t09iQgzKMaeFORY6A8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HMaIyPrF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HMaIyPrF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712909741; x=1744445741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P1lzQYpZeJqGVZFZCQ+jo9tmCkUyhO8d2a1+/TbV4Ks=;
  b=HMaIyPrFvfM26TRSIdB0OqPamhcmF1yNU1HnyWdLOGh0A1O92oNGrXfz
   Eeb5bHsDen1jBf7PlAO7fq500Gw5g08Hj9ttUMVQP4K/laDugXNr1XH8Z
   kvuGsXzpag6UbJze5r+Jw2n9LyqxcydHN2ZbDvqlTsp1vRcNx3z0ODDoL
   vUpkbOxRBlaQGy5mcGZc5yUPHkD9IxDjPfK3RYowqgbvhKV4KZefS8/g7
   3S4SJGYAPIe+tyGi3ZlzZZQNYgC9ZKyrIrrg0N+msehztYzZZH7C7gfSa
   Y982iNitMk/V9tyBGrta+B26+ds/oqG5BS4PNfGNDM6REJD3z7rCEvM+l
   Q==;
X-CSE-ConnectionGUID: 30Ewj15hQgSFdbLKsDH55g==
X-CSE-MsgGUID: 8MdQNTYUQ6GnUzNHiIjYsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8465126"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8465126"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:15:39 -0700
X-CSE-ConnectionGUID: 6n2xSq2YStuTo4ubur7/nQ==
X-CSE-MsgGUID: Bg9fkzQeTj6dD7KrThMF+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="52137885"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa002.jf.intel.com with ESMTP; 12 Apr 2024 01:15:38 -0700
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
Subject: [PATCH v2 12/12] iommu/vt-d: Add set_dev_pasid callback for nested domain
Date: Fri, 12 Apr 2024 01:15:16 -0700
Message-Id: <20240412081516.31168-13-yi.l.liu@intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

This allows the upper layers to set a nested type domain to a PASID of a
device if the PASID feature is supported by the IOMMU hardware.

The set_dev_pasid callback for non-nested domain has already be there, so
this only needs to add it for nested domains. Note that the S2 domain with
dirty tracking capability is not supported yet as no user for now.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c  | 23 +++++++++++++++++++----
 drivers/iommu/intel/iommu.h  |  3 +++
 drivers/iommu/intel/nested.c | 15 +++++++++++++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9e79ffdd47db..052b90917ced 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -319,6 +319,11 @@ static int domain_type_is_si(struct dmar_domain *domain)
 	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
 }
 
+static int domain_type_is_nested(struct dmar_domain *domain)
+{
+	return domain->domain.type == IOMMU_DOMAIN_NESTED;
+}
+
 static int domain_pfn_supported(struct dmar_domain *domain, unsigned long pfn)
 {
 	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
@@ -4626,9 +4631,9 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	intel_drain_pasid_prq(dev, pasid);
 }
 
-static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
-				     struct device *dev, ioasid_t pasid,
-				     struct iommu_domain *old)
+int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid,
+			      struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
@@ -4650,7 +4655,15 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (old)
 		intel_iommu_remove_dev_pasid(dev, pasid, old);
 
-	ret = prepare_domain_attach_device(domain, dev);
+	/*
+	 * Nested type domain should adjust its parent domain according
+	 * to iommu capability.
+	 */
+	if (domain_type_is_nested(dmar_domain))
+		ret = prepare_domain_attach_device(
+				&dmar_domain->s2_domain->domain, dev);
+	else
+		ret = prepare_domain_attach_device(domain, dev);
 	if (ret)
 		return ret;
 
@@ -4664,6 +4677,8 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 
 	if (domain_type_is_si(dmar_domain))
 		ret = intel_pasid_setup_pass_through(iommu, dev, pasid);
+	else if (domain_type_is_nested(dmar_domain))
+		ret = intel_pasid_setup_nested(iommu, dev, pasid, dmar_domain);
 	else if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 404d2476a877..3dfd183c9736 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1082,6 +1082,9 @@ void device_block_translation(struct device *dev);
 int prepare_domain_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 void domain_update_iommu_cap(struct dmar_domain *domain);
+int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid,
+			      struct iommu_domain *old);
 
 int dmar_ir_support(void);
 
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index a7d68f3d518a..7cb124cc0ca0 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -70,6 +70,20 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	return 0;
 }
 
+static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t pasid,
+				      struct iommu_domain *old)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+
+	if (iommu->agaw < dmar_domain->s2_domain->agaw)
+		return -EINVAL;
+
+	return intel_iommu_set_dev_pasid(domain, dev, pasid, old);
+}
+
 static void intel_nested_domain_free(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
@@ -170,6 +184,7 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 
 static const struct iommu_domain_ops intel_nested_domain_ops = {
 	.attach_dev		= intel_nested_attach_dev,
+	.set_dev_pasid		= intel_nested_set_dev_pasid,
 	.free			= intel_nested_domain_free,
 	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
 };
-- 
2.34.1

