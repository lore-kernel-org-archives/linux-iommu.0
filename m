Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7497207A0D
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907978; cv=none; b=G6QX9yLDdYU7n1t+KTGKpy/Gc6c4Soi9S85jcdC7LZVpadLnjwEIrgvbqPagsfACJDXLXLbhULJMDSIOluB4NRlIsXre/ffnsuP0Y7eri645Iwe8crzvKYcSAZPJDhpxEfMV10OtgpWyrVROfY5iPphh8OCPjzn+MmMKyj2ouuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907978; c=relaxed/simple;
	bh=0dXEP774t5JUA/b7B8Un96vzXSbyWCFBwGmkRxdccvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mfv9vjSbXxYb6R3kAr5VEspOBb+SnSbScgXY/+u7SrHOcIzceUuFz08ebOxCSpOIMdpg1zezMnVlaawZjSdefqiUU+EM0/OepnaMPWhFEVRW4NKiFfpIAEqVbDnRFuBYz8qnJH1WQJmm2sXi+U5TkhPzbBvBgjGstWuBDjegiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IiYFLfty; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IiYFLfty"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730907977; x=1762443977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0dXEP774t5JUA/b7B8Un96vzXSbyWCFBwGmkRxdccvQ=;
  b=IiYFLftywvchFl4vHH9eQpIBDzMdAPdjisMdLOa+SxnGSUngERqbJecW
   1HYm/caVOBhCypKeqKiLSyrMIxyZDNfB7HdaDpQCP+tm5kt2EixdsbIQo
   G4+j7d1jJPBYVDoq37EZXSReDkhCb347IKbR9vQBEl7ebdsGm/BFS6L3/
   8ZfgD1S2QN5cz6dYY6ohUeFyArD/KMzjODa/n3fxpFqrVd+x9fft8GIzy
   YLM98qXQFWRaHdAxgopawbkM+5GJo36Fa4vMessclqKhxe1dE38OwL+xh
   6av/nQaFi9H5eiJGEKufXrooj3kEE9PDfum+andVdB6DjFFl3QHrRYOb6
   w==;
X-CSE-ConnectionGUID: kuykzM5HSZmr5Mr4fpYeVw==
X-CSE-MsgGUID: lY/7Zj9vSsON7tBZDabl5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48174285"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48174285"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 07:46:12 -0800
X-CSE-ConnectionGUID: mOUaC4exRKCMIAIOCTJ1dA==
X-CSE-MsgGUID: R5+WFddhR7CzyRvmDmKaIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89468254"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 06 Nov 2024 07:46:11 -0800
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
Subject: [PATCH v5 10/13] iommu/vt-d: Make identity_domain_set_dev_pasid() to handle domain replacement
Date: Wed,  6 Nov 2024 07:46:03 -0800
Message-Id: <20241106154606.9564-11-yi.l.liu@intel.com>
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

