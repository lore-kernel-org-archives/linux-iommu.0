Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557D6210192
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982164; cv=none; b=ibTF6S8x7BD36LcluM8tv3NIDtQJngbkHBezARoH1YPBBCXrDBgBcu8ag9/pTkKxtj9yGBfNWvSxJ+3HALjwljy3Mw941/OUltaKAs6NHgggkbEkZvsSGviNCGl8PK8ikwt5j1eQMROKTmaJmVOygkZJTkBhsmZ/LObtfvfDDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982164; c=relaxed/simple;
	bh=StPLIHdHMILZf4wA2ehuHqX9QaXNphD0GtF6wSM9b0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lG0dw3nNxCh6wtVH9Op5mWi1rpt9Om64rKPKBodrquP7PWqG3Ca9FsUKFkphHEJJ2RI7mgIw4wUFjbTIN+PHCsVJulHWLavXCHMAut0yVV5rAon/riqqZAT4oCt6I3SIUMVe8xr5txJK6cR+NS0/PsotWxoWrSLFu4tf7xVqpQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Az+RVAdV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Az+RVAdV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730982163; x=1762518163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=StPLIHdHMILZf4wA2ehuHqX9QaXNphD0GtF6wSM9b0E=;
  b=Az+RVAdV9oeqeWlVXyebGBTyVAFt9xIWThEjyWfYUn2mveFGuieiSUs3
   8N0rtxZNRiEUfyPL64J0Fghmv/KKkofJoyMLa5ffCZW9Lk3f4P87XeNkN
   HR1qkXfnUlGzN/iiXZ+WoIDL5g0QsKXDs3sCsJK3ERIVQTY9nHlitl3Ts
   UybA2/4iWZT3EyyUUoqw0fHpEdyZJ5mGbh2f8gwqBir76z5g9CxocBu60
   0aX/9/Tyb47HcO7RlirJ2B5BddNQr4KrSKwXtgWwDNOO4xnT8QPAJlcjK
   CJPt5u+4/mcxFEizwXAKd4GNt7Mata2y1bqxnOi3Dgy8wJtTApyv82xTd
   w==;
X-CSE-ConnectionGUID: rvSc0MdhR4yb5OCF6+t6xQ==
X-CSE-MsgGUID: h/zrhUxbRn+joY8/KAOrVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34744640"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="34744640"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 04:22:39 -0800
X-CSE-ConnectionGUID: ERIkXcjETGyUlfyBWEEsWg==
X-CSE-MsgGUID: 8gF9pmLZTCulZ/6kCHo00A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="90180591"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 04:22:40 -0800
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
Subject: [PATCH v6 08/13] iommu/vt-d: Limit intel_iommu_set_dev_pasid() for paging domain
Date: Thu,  7 Nov 2024 04:22:29 -0800
Message-Id: <20241107122234.7424-9-yi.l.liu@intel.com>
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

intel_iommu_set_dev_pasid() is only supposed to be used by paging domain,
so limit it.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6b7f48119502..3c1b92fa5877 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4156,6 +4156,9 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	struct dev_pasid_info *dev_pasid;
 	int ret;
 
+	if (WARN_ON_ONCE(!(domain->type & __IOMMU_DOMAIN_PAGING)))
+		return -EINVAL;
+
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
@@ -4184,8 +4187,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 
 	domain_remove_dev_pasid(old, dev, pasid);
 
-	if (domain->type & __IOMMU_DOMAIN_PAGING)
-		intel_iommu_debugfs_create_dev_pasid(dev_pasid);
+	intel_iommu_debugfs_create_dev_pasid(dev_pasid);
 
 	return 0;
 
-- 
2.34.1

