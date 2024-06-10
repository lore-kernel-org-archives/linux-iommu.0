Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E4762F8
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009929; cv=none; b=HIB1OFE9nvcSZnazmnYJdhn+Nw1soAXPncYtzdOTxLdUl8rGjv28uSp+KfbUthOQu8FeudgDkmV1PferdyuNjO6eWI8sumgzoVvWPPK/On9+1bfwVneEVp6OLZ14l6WNTF2SIBguR9UMx7nh3V/2n9ofon5LSg0n9itM9St8/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009929; c=relaxed/simple;
	bh=GbpYXxZBS+r4Y0EiK3BFmXVZKaFfLeJ2IAlI0t0Upno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFajLn3cU5viqNEC91e9Yj+a/c2BmIJmRbYjH99jwMmkD4gEMWv2vy9slIoAzonUlxfYHHQsJtAdpoJf3UFKmJzkhuomc3M7hJw5Bz9XtBC8G+WgaSzhBFYoMjXr1ZPs7FUzsvOxtWpDPQoX3VSF6Wfp1uyG5deLZQHjjozm5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3VsvgX2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3VsvgX2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009928; x=1749545928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GbpYXxZBS+r4Y0EiK3BFmXVZKaFfLeJ2IAlI0t0Upno=;
  b=Z3VsvgX2vVlLgjm1BsrPRPQJpDPhKtvMcNfQA/5PX7bE2VOa2mBCi06A
   zZl2RiRitOfEw+89RTsGZmmfBlc51vDd5F8kFZiEIWKq3MB8K/UUSarvs
   v0q16NOutn6IrzS641kmPdqif32vItkT1X8DZkOMmjDwNuoenZC7gQ90m
   +Hme+MigYqwSLCsz1CBoIcueCEHTGuf+HdD6KmQGRKouMN/Ma0dbByzr2
   88TGXY+zBt275/ZaTYK3mPpGlij479nqFm1ZIiS+6WtGX+ELjy3lN0HYM
   l+saF0Srs+tuZE5Ox4EgHJDGqFAh4pLY4RMQ0yIvLG77t15lFR2hTxZid
   g==;
X-CSE-ConnectionGUID: SZLojCcBRASBbUI4WOf3BA==
X-CSE-MsgGUID: SxCLtjOqRu2ETPqOgFKiGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581619"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581619"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:58:47 -0700
X-CSE-ConnectionGUID: VamhjrgFQlaSd3fZomawuA==
X-CSE-MsgGUID: APBKRNmnS5KOzuWJvg3h1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43432531"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:58:43 -0700
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 06/21] drm/nouveau/tegra: Use iommu_paging_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:40 +0800
Message-Id: <20240610085555.88197-7-baolu.lu@linux.intel.com>
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

In nvkm_device_tegra_probe_iommu(), a paging domain is allocated for @dev
and attached to it on success. Use iommu_paging_domain_alloc() to make it
explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
index 87caa4a72921..763c4c2925f9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -120,8 +120,8 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *tdev)
 	mutex_init(&tdev->iommu.mutex);
 
 	if (device_iommu_mapped(dev)) {
-		tdev->iommu.domain = iommu_domain_alloc(&platform_bus_type);
-		if (!tdev->iommu.domain)
+		tdev->iommu.domain = iommu_paging_domain_alloc(dev);
+		if (IS_ERR(tdev->iommu.domain))
 			goto error;
 
 		/*
-- 
2.34.1

