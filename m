Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBAF169AEC
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 05:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960985; cv=none; b=JMR7oyvH233mxxCeDTstuQXWXvaC70mNFp641XjXppVunTxgojxR1T51QzIphnjcOCT75izgpHAv68dGJCdTqwyLS7DcieDW0zPataEIlBQNLMddeRz9E7xK3+hUvkUrGOESAGK/EvTdkZIeRzcsdkeQqrNfk2JIAWEZL6wDfPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960985; c=relaxed/simple;
	bh=5ePUNFSt1UVyBK/XkIEBW5JIdBwW2K6T9xjoabFYw84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Js+kjjR2XEzvKJoS/IEEWqhLoU6Sq4q9HQzkVg3nRryMdX87px8kdF2dr/NJXILgg2trJrCvzH8yw7iEtnEysuIUFuZSvkaYWqloBbjzQsaJCbD98VIljO59VL/J5G+G+l9/Vqwy7SLcXxyyx7eMfwTnFoacauuha1t0XOhlRgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMnOS6tX; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMnOS6tX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960984; x=1748496984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ePUNFSt1UVyBK/XkIEBW5JIdBwW2K6T9xjoabFYw84=;
  b=kMnOS6tX3wmP0oUIdvbnVbifCbcNJFz650bbAHL8ZYJj/Ma6HRbozqlx
   rAHZBASn7GEqgR7Efe2WZKZOS8jOVl2/WzJ9rQhA77fb+ys+8WMl0GteB
   sRsVb8M8MaqjtYoeqWGIe36cF9H90meBuK0kxcQ0RASGR9URaxD8lZMfF
   pKG1zr9VJdZaN5ikRTmC3VbCNu/VJ9xY6bMVrtnhTH8XrT+PsnlWV3h61
   NexWuAqvTn949yNd6KdDiw8X57PEhp8OZBPU6v8kICqxCmkeZRg7Iq71S
   f4Gn3PmgvO2hDRTAYne/ePK9cZnbi3GeDSG7RNjh+D25sZGgRf0vedYiL
   A==;
X-CSE-ConnectionGUID: g/IpSzoeQEi1al8zbVffjA==
X-CSE-MsgGUID: zyo+ihH5RMeNZr+IfwW7yw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13569069"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13569069"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:36:18 -0700
X-CSE-ConnectionGUID: bMLT6m7ZQya8CnSU5hJh7Q==
X-CSE-MsgGUID: X6Uf2wUXQVWNu0/eZhCs2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257765"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:36:12 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 16/20] iommu/vt-d: Add domain_alloc_paging support
Date: Wed, 29 May 2024 13:32:46 +0800
Message-Id: <20240529053250.91284-17-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529053250.91284-1-baolu.lu@linux.intel.com>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move paging domain allocation code out from intel_iommu_domain_alloc().
The intel_iommu_domain_alloc()  is still remaining to allocate an identity
domain. However, it will soon disappear as we are about to convert the
identity domain to a global static one.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 50 ++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ccde5f5972e4..eb8e08699b80 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3708,35 +3708,8 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 
 static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 {
-	struct dmar_domain *dmar_domain;
-	struct iommu_domain *domain;
-
-	switch (type) {
-	case IOMMU_DOMAIN_DMA:
-	case IOMMU_DOMAIN_UNMANAGED:
-		dmar_domain = alloc_domain(type);
-		if (!dmar_domain) {
-			pr_err("Can't allocate dmar_domain\n");
-			return NULL;
-		}
-		if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
-			pr_err("Domain initialization failed\n");
-			domain_exit(dmar_domain);
-			return NULL;
-		}
-
-		domain = &dmar_domain->domain;
-		domain->geometry.aperture_start = 0;
-		domain->geometry.aperture_end   =
-				__DOMAIN_MAX_ADDR(dmar_domain->gaw);
-		domain->geometry.force_aperture = true;
-
-		return domain;
-	case IOMMU_DOMAIN_IDENTITY:
+	if (type == IOMMU_DOMAIN_IDENTITY)
 		return &si_domain->domain;
-	default:
-		return NULL;
-	}
 
 	return NULL;
 }
@@ -3791,6 +3764,26 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	return domain;
 }
 
+static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
+{
+	struct dmar_domain *dmar_domain;
+	struct device_domain_info *info;
+	struct intel_iommu *iommu;
+
+	/* Do not support the legacy iommu_domain_alloc() interface. */
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
+	info = dev_iommu_priv_get(dev);
+	iommu = info->iommu;
+	dmar_domain = paging_domain_alloc(dev,
+			sm_supported(iommu) && ecap_flts(iommu->ecap));
+	if (IS_ERR(dmar_domain))
+		return ERR_CAST(dmar_domain);
+
+	return &dmar_domain->domain;
+}
+
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
@@ -4650,6 +4643,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.domain_alloc_sva	= intel_svm_domain_alloc,
+	.domain_alloc_paging	= intel_iommu_domain_alloc_paging,
 	.probe_device		= intel_iommu_probe_device,
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
-- 
2.34.1

