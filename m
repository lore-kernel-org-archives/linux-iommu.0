Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B547EEE4
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009924; cv=none; b=BfUYdj6+1lKogK7/NKW46Pnr07eeV+56q3XafXCh1oAcgROvi8zGf5tq1EXkr68azsolKkrkb68CR6l1Yyt1KtrJGsJXnjKwFBVM9kfM8vQun9SoQCbKlzNU0t0HZRLEaThSuO25nRdE5o+jXX1aWrrzq1KTvqn9/94K042xh3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009924; c=relaxed/simple;
	bh=4msQrWBVL2b4JwUEKLRwKbzNTovn+5JwozhskLlkUwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W3J/qQ/YHuUUu9k8EEXb6/lJcahScwgGF64Zk8HNs6i4kVizTuv2aH9oC2gPm9NvbWfe96Gj+hJ5q0FPtBqUVG9/atCawhhldJ/2FKY0M9qzLXXCvAmUGPHimuV/xOcN+qqHyh+em58KdZYD2eqKI+lthbfsbDvLUHH3k5sNH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7HDjUR2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7HDjUR2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009922; x=1749545922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4msQrWBVL2b4JwUEKLRwKbzNTovn+5JwozhskLlkUwI=;
  b=d7HDjUR2zssFsZv52TcBLbF8eLWtAHq9MIOH7EiqudbkjQrKNPD1sL8N
   jNCqj+wE43yx8Y+MaEHNnBjfIPpSb19Dv6tfeSvhxfGl7TC89sIoeJPST
   lH20AcLcmxhXn84b++D3LdaNcZmyAOKqRfaxyKTFJJIcE0Pt5k7/Ns9G/
   +dCyUW+GHovKoGeuCnyyjl2ArO/BsYIKHqDmWa9gHMRuqCbmQCdJrCvbW
   BQMiRNh2TgCX05VIouNa4/VJhcljXdyPRoCuEb6uGh+PzEFtrkc2fUM7A
   amA0HgHxNGTJe5QYWFuKb3s0dhH1SiFILwvg0wKm4xESXLK3GBkvALETU
   A==;
X-CSE-ConnectionGUID: zj3txD3ZQbyOTFvt+NdZGQ==
X-CSE-MsgGUID: KRSDZrL6QTqApzqODiJx8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581598"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581598"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:58:42 -0700
X-CSE-ConnectionGUID: 3haueZ8xSc2KYY4kPv/lrg==
X-CSE-MsgGUID: cSDsjgrOSmyakXpWAx+X+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43432474"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:58:38 -0700
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
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 05/21] drm/msm: Use iommu_paging_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:39 +0800
Message-Id: <20240610085555.88197-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610085555.88197-1-baolu.lu@linux.intel.com>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The domain allocated in msm_iommu_new() is for the @dev. Replace
iommu_domain_alloc() with iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/msm_iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index d5512037c38b..2a94e82316f9 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -407,10 +407,13 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
 	struct msm_iommu *iommu;
 	int ret;
 
-	domain = iommu_domain_alloc(dev->bus);
-	if (!domain)
+	if (!device_iommu_mapped(dev))
 		return NULL;
 
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain))
+		return ERR_CAST(domain);
+
 	iommu_set_pgtable_quirks(domain, quirks);
 
 	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
-- 
2.34.1

