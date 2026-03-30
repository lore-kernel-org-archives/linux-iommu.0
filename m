Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BB83BBA13
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865490; cv=none; b=uFf5jfsa6rTFJA5HzEPOzMqjpz8CPMAUxTpKPvCT/zk7ME3T0Gy4qF+7RGlZpRKDG1hNHSyEMUZuDzbBCOeRwoWbP8KNLcTCeSA3DqgIsIIDHN2/515jrkBVi02zXSjTsCG6tN5wdE7ZEP5qGqJbbGhMHsv0vxkAM1uW/PggYsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865490; c=relaxed/simple;
	bh=SDRNjY/Jps9VCguyId/vKnlzor/cfLxoAmP9kkLJMtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2oV2yag/gws/N6tV5FbJ/fpj/P3FiKkOHTTLbhrSEXcKznj/YPAWTBFQJ3KXkBoGx+iVW0i4c817Vme6KGx/73eSxLn3CwOcxK29kKiAq2yHiVvEPQZy9wNSuc99T5SZcfOt6vHe4vZaDOTJsdKHZqRciW68GPs0v7inXyXJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3kAwhUf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3kAwhUf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774865488; x=1806401488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SDRNjY/Jps9VCguyId/vKnlzor/cfLxoAmP9kkLJMtQ=;
  b=Z3kAwhUfvwejUTPFLT8afrc1qQ2Vnq/cmbC1M+kOic3X5PKUO3qfPowh
   ycvCTggTGvjY1heByyD5gVX3A52HWb/7AVI4NxJ9nM6sbeEFGMoQ65+DV
   jE8ief7xQZlFMAoTWGDOyLqYqamVjXSvjsXS+cm0LWjxAvZJHPayPaEC1
   xNbgT/TRiDWT3YxDbo7CfZ5dhcN7HDrlDFU8uAI7gw4p1WEnm1/5g9IlN
   a7IYJtg5DYxVc2dsf9m7Nsgjuj/LH6UmPAwOJUBB4QkKFbNOa432UHMm/
   c3M5wAkG8aWnXCk+hEMTJKuIkub0A686o8+6hTcyDGheawiKLxQMLZ4f0
   Q==;
X-CSE-ConnectionGUID: gvrtSzCYSP++vRzAH1qleQ==
X-CSE-MsgGUID: ZQMRP2G4TWacuhfX9+riPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75921172"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75921172"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:11:28 -0700
X-CSE-ConnectionGUID: kGkOWTMwQYWJeXIr2cZu7A==
X-CSE-MsgGUID: s+511YDnRrCCgdVU3dOfSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="225913458"
Received: from spr-duan.bj.intel.com ([172.16.114.123])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:11:26 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 3/4] iommupt/vtd: Support dirty tracking on PASID
Date: Mon, 30 Mar 2026 06:11:06 -0400
Message-ID: <20260330101108.12594-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260330101108.12594-1-zhenzhong.duan@intel.com>
References: <20260330101108.12594-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support passthrough device with PASID capability in QEMU,
e.g., DSA device, kernel needs to support attaching PASID to a domain.

But attaching is not allowed if the domain is a second stage domain or
nested domain with dirty tracking.

The reason is kernel lacking support for dirty tracking on such domain
attached to PASID. By adding dirty tracking on PASID, the check can be
removed.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c  | 12 +++++++++---
 drivers/iommu/intel/nested.c |  6 +-----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 965e0330ec4b..26135ff3a289 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3618,9 +3618,6 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
-	if (domain->dirty_ops)
-		return -EINVAL;
-
 	if (context_copied(iommu, info->bus, info->devfn))
 		return -EBUSY;
 
@@ -3688,6 +3685,7 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length,
 static int domain_set_dirty_tracking(struct dmar_domain *domain, bool enable)
 {
 	struct device_domain_info *info;
+	struct dev_pasid_info *dev_pasid;
 	int ret = 0;
 
 	lockdep_assert_held(&domain->lock);
@@ -3695,6 +3693,14 @@ static int domain_set_dirty_tracking(struct dmar_domain *domain, bool enable)
 	list_for_each_entry(info, &domain->devices, link) {
 		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
 						       IOMMU_NO_PASID, enable);
+		if (ret)
+			return ret;
+	}
+
+	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
+		info = dev_iommu_priv_get(dev_pasid->dev);
+		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
+						       dev_pasid->pasid, enable);
 		if (ret)
 			break;
 	}
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 16c82ba47d30..2b979bec56ce 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -148,7 +148,6 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct iommu_domain *s2_domain = &dmar_domain->s2_domain->domain;
 	struct intel_iommu *iommu = info->iommu;
 	struct dev_pasid_info *dev_pasid;
 	int ret;
@@ -156,13 +155,10 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
-	if (s2_domain->dirty_ops)
-		return -EINVAL;
-
 	if (context_copied(iommu, info->bus, info->devfn))
 		return -EBUSY;
 
-	ret = paging_domain_compatible(s2_domain, dev);
+	ret = paging_domain_compatible(&dmar_domain->s2_domain->domain, dev);
 	if (ret)
 		return ret;
 
-- 
2.47.3

