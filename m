Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229702BAEC
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726336; cv=none; b=B2WunQF95h289QYIfCojyGPelZ0/Gkvdz4edtozWyKLvAT8mAb6Prqu3OaOo6+VVxKhhoxh1Y2CTeUvrbj3kIJSLHmwF1bUaNZdvR+6wdN4mUEzSJGBgNgPUi+qlODX8ou5bcK3amDgiMFiiPGltFA6pVkoCWQHoG3JLM7sHC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726336; c=relaxed/simple;
	bh=u/P60XXxvc/aKGZS2PlwXnm0m7BLoXj5ROiBmf3ixK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSH6efu9Jamtzik+TAvec2boMUqcgCR1JtWVhATBexfCLTH5lXh/fcAqaD2Xte9UK7hO7zgMYFs0mdgouCaITWpv2pu9AWAIEEdQMt3QVY8+J56yq1KwQdmQ+HGc2hNQ+G1yNzmiR4GN2ZXhjPnLFsq71EpqPywqL74yYMUP8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ew7fqA1t; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ew7fqA1t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730726335; x=1762262335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u/P60XXxvc/aKGZS2PlwXnm0m7BLoXj5ROiBmf3ixK4=;
  b=ew7fqA1tZJrQpajObck/OGfZJzdj2sTC8C4p5ia1aGEOuwvDmSUgtQsR
   yOS4TXf0CbDAU08QLuniaO+JUidqk6g7Fo/tVYDG7y0+Fwl3byrNyF/k1
   Rr3X/qehMKHZtndY7wIzJi4xmzOMU5y3YBj6M+TppxLAKbDteDZQ5wj2S
   oRybkHzXkfjjsK4qGeUgnwImplDEFvPyVBOMIdb4D9aaYKPj4xQ4HZPZ/
   UHBEEYqgB+YwgWv3wVpxoeuwp5ej00b1zIz5ONwRRQpZ1bg9PRfcOoUhG
   t3pB1ld3yk4N++WPfak9zyZlAZdNlEEk+sX7ZJt2AU/LbBlPTJtCet7hi
   Q==;
X-CSE-ConnectionGUID: PP5dM8NoT5iGbj+XrJWiww==
X-CSE-MsgGUID: mcD3YmW3RXKq557b4zYm2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41003753"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="41003753"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:18:53 -0800
X-CSE-ConnectionGUID: aE68rGloQouWHOe33CowQQ==
X-CSE-MsgGUID: CZh3E5RlSwamQZBUn66jnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83999499"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 04 Nov 2024 05:18:50 -0800
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
	will@kernel.org
Subject: [PATCH v4 07/13] iommu/vt-d: Limit intel_iommu_set_dev_pasid() for paging domain
Date: Mon,  4 Nov 2024 05:18:36 -0800
Message-Id: <20241104131842.13303-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104131842.13303-1-yi.l.liu@intel.com>
References: <20241104131842.13303-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_iommu_set_dev_pasid() is only supposed to be used by paging domain,
so limit it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 29a3d9de109c..58df1cbc1590 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4349,6 +4349,9 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	struct dev_pasid_info *dev_pasid;
 	int ret;
 
+	if (WARN_ON_ONCE(!(domain->type & __IOMMU_DOMAIN_PAGING)))
+		return -EINVAL;
+
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
@@ -4377,8 +4380,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 
 	domain_remove_dev_pasid(old, dev, pasid);
 
-	if (domain->type & __IOMMU_DOMAIN_PAGING)
-		intel_iommu_debugfs_create_dev_pasid(dev_pasid);
+	intel_iommu_debugfs_create_dev_pasid(dev_pasid);
 
 	return 0;
 
-- 
2.34.1

