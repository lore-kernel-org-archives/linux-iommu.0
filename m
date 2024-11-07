Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3742101B7
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982166; cv=none; b=dtHLEg1rKfBP+W2qzRXvhEBIkCwdTypK+o7IoJiCb7/cnGQX0Dt/ZnRZecGvgOs3w3vJ4dqadjNAh3Y77ZbOzcDIqUnNs6/Yym1K1hS9JeY2dP1FIBxOSH68sYV6edX5PYQxR7PlzEBxK/CiQ31HcfIiyfPNUFNv+R3eGaRhcgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982166; c=relaxed/simple;
	bh=0dXEP774t5JUA/b7B8Un96vzXSbyWCFBwGmkRxdccvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jU2+hZqbEf5/hhwOJGNt0Ye/8L2nvhTyrYC9ZVXrGqbDK4WOYrqoQ4rLk5+Zsl+auoaiNm7aqKkUkDjAKFXIlaRTqY5y/50KUOvkHXZMvXk7/1nHwZmu1KzfWG9bOA1r60A9wpxfQz1n9GMZyyv4FvQWG1XoIdLJK9Q+Xp8DkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQcZkrMJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQcZkrMJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730982164; x=1762518164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0dXEP774t5JUA/b7B8Un96vzXSbyWCFBwGmkRxdccvQ=;
  b=cQcZkrMJKTCH6ZmkXNAsuCBvTIK9smArQh+FhkTJivwbPNeGzRCLBONm
   E/dBto8vOZrjViqjoa2ES/3g0j+WE5omsbsEpXexwU7u45Y+yQ1zECB7z
   9Yv6uNN+snKm8Ud1d18APZavtu8DOb4XV8CMttYQKjSdwxE66jcGQZ0qN
   d1Dk0OrBAdyYExId/v2a12bOJDGjXDC/2XPFxrRe896kNhs9u/BSI3eJx
   j81RWPPFOm0KdSLLIlVUsUKHrYT0x6+yl/rRxNO0mqjafqS1KHhOhPEmm
   gyZPntOQTcbVc2janxr2a5E6f65hA0kosheXW0lOynSM021O5+jo1rZcA
   A==;
X-CSE-ConnectionGUID: xQpzXrfHQxC3zQjHXrIXew==
X-CSE-MsgGUID: 2Astav2+S7emzC1nWRZhsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34744655"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="34744655"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 04:22:40 -0800
X-CSE-ConnectionGUID: BdZorJjoTL28SMYbp1/B1Q==
X-CSE-MsgGUID: 15guzmw/S8W0eSbELT7wTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="90180601"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 04:22:41 -0800
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
Subject: [PATCH v6 10/13] iommu/vt-d: Make identity_domain_set_dev_pasid() to handle domain replacement
Date: Thu,  7 Nov 2024 04:22:31 -0800
Message-Id: <20241107122234.7424-11-yi.l.liu@intel.com>
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

Let identity_domain_set_dev_pasid() call the pasid replace helpers hence
be able to do domain replacement.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 06a7c4bf31e0..f69ea5b48ee8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1778,6 +1778,17 @@ static int domain_setup_second_level(struct intel_iommu *iommu,
 						pasid);
 }
 
+static int domain_setup_passthrough(struct intel_iommu *iommu,
+				    struct device *dev, ioasid_t pasid,
+				    struct iommu_domain *old)
+{
+	if (!old)
+		return intel_pasid_setup_pass_through(iommu, dev, pasid);
+	return intel_pasid_replace_pass_through(iommu, dev,
+						iommu_domain_did(old, iommu),
+						pasid);
+}
+
 static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev,
@@ -4425,11 +4436,17 @@ static int identity_domain_set_dev_pasid(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
+	int ret;
 
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
-	return intel_pasid_setup_pass_through(iommu, dev, pasid);
+	ret = domain_setup_passthrough(iommu, dev, pasid, old);
+	if (ret)
+		return ret;
+
+	domain_remove_dev_pasid(old, dev, pasid);
+	return 0;
 }
 
 static struct iommu_domain identity_domain = {
-- 
2.34.1

