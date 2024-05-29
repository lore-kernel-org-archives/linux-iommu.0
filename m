Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B1C169385
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 05:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960984; cv=none; b=U/zSqDXbiqLFmnqKW8eIwjvIiz9hoQLsvRq89k94Ryhpuvrk2l9IYVHzl3mJe5korKPRf8PlnYkCY1+21d7AMkZXAiECEENQYwvnOY7rs5Ubra9mE2Up690vQdJBANhYR9IHBSPmIgN4PTcZC+Ao7fxomgQR7gX//G7PhSdYMOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960984; c=relaxed/simple;
	bh=b4g7oPuUpFCf7ehXVGbGAAANzK1lpGoRJJpR32Cbgc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FwX2NvDVpo+VPNcMlH4yPoq7bGPUn+Exeb9aJyeb518qyNJW/fMGIf5JDBJcL5szsZiNfZB7lwQ3u/M1/UGPpJsvPozYiVspRLOi0Xdbxs3GEO/Fe/hY9+RETEJeo5P8HaH4gykMNYLvwogwTkiQF8fDkrhDl3KMfAeBQKc1B70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXlvGmYd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXlvGmYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960983; x=1748496983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b4g7oPuUpFCf7ehXVGbGAAANzK1lpGoRJJpR32Cbgc4=;
  b=NXlvGmYdQkJ08XN+Wu0A7SjTu/Ob6qSqMmknHVVY92s15Osl3n642fYU
   jgWvum5ITAhZiNDvGMFKLmPaI4gqdYy2Dx3auhzmEagLB55/CC9eDwQ+P
   zdylUOjub5kaT02W/pqjnp0kk1o6u1rexoEU8Y3qvWNv3P1PX4PyyFarV
   u3c0EDuPcp2qzV/otS8J8lajlPVprFniujHqGfB1hSBV3nGZsq8vu0kps
   cVLiBDqy6k3RD+pm0dwEXNWLYH+8/YxHRdSAe8cXzGAUU/t+FHiUXK970
   p8/oEZ+KZhyQcDF6SQemw/QMLGdIegxup3EEmFnXvXwiNZSBWvd2/RZHK
   g==;
X-CSE-ConnectionGUID: fWGD30SSS/eUB6is/0s4Ug==
X-CSE-MsgGUID: /a6Z27vgSbSRHxE1rosdjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13569009"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13569009"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:35:58 -0700
X-CSE-ConnectionGUID: V3zZjpVoRS2Q2WQoWQMxtQ==
X-CSE-MsgGUID: 5T9hg/jYScSPheKhITTpNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257707"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:35:53 -0700
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
Subject: [PATCH 12/20] wifi: ath11k: Use iommu_paging_domain_alloc()
Date: Wed, 29 May 2024 13:32:42 +0800
Message-Id: <20240529053250.91284-13-baolu.lu@linux.intel.com>
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

An iommu domain is allocated in ath11k_ahb_fw_resources_init() and is
attached to ab_ahb->fw.dev in the same function.

Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index ca0f17ddebba..a469647719f9 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1001,10 +1001,10 @@ static int ath11k_ahb_fw_resources_init(struct ath11k_base *ab)
 
 	ab_ahb->fw.dev = &pdev->dev;
 
-	iommu_dom = iommu_domain_alloc(&platform_bus_type);
-	if (!iommu_dom) {
+	iommu_dom = iommu_paging_domain_alloc(ab_ahb->fw.dev);
+	if (IS_ERR(iommu_dom)) {
 		ath11k_err(ab, "failed to allocate iommu domain\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(iommu_dom);
 		goto err_unregister;
 	}
 
-- 
2.34.1

