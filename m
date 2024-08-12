Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0C14C5BA
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723446858; cv=none; b=BVPty5j6rf4qEUflk51AjD4tlXVKHuZa+Nc56XAtODHqxS/1uWzxCTNcO7sXSL6pH0iqdFM3xkSOs+56pMNk5y0g+MsktH+r+Z5BOuiRXI+JoEGdWIJNd9UfX8HvMKoQs5jGmqjLDt92ET+pXQ8R0RHaRLdMLq8B2pRuMoYekKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723446858; c=relaxed/simple;
	bh=ugPZI6M1TvdJVOqkCaWpsQPcKmLp14vmdPpzyb0jTXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gsbTgDZP9H1qYb5THLGxBdUNDfAwN0v3kUgkAkR3dJHF8Bc803vCtGuX+EtXrnD5zoIiz+4CPZkPqVBwUhOcHTipBZqstZ06tD8+g2DVFHbakOu1KFT/ny1WtGW8MQQnDML1xvaOitmi7Tbn9H4OrqCAREazTSJrkCvdVuhrVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEtQoajw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEtQoajw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723446857; x=1754982857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ugPZI6M1TvdJVOqkCaWpsQPcKmLp14vmdPpzyb0jTXA=;
  b=fEtQoajwEwEBBPvt9JNuAolVRFSpRZBXjBQtobHiiJMGmykqBBmUb8Ji
   dUU3DlKZQYsKoEJHFTQyVSvaht0chuDNuvzNN3B88gQUgJcxlxUdy6TVV
   YHdMElkJ7mOzoQP6Q3llcwXsnRzEKRrUj1mN2ACfSbzpMYyN5cJSC/KN0
   VOGMYLlDrrzsrsY4Pi5ZKteK54Hkd8t/fmIaNH9OspWjL60ZMFpWyqhVw
   5OanrckripR/V6eOnc6LepHYkxgIkfpPY0QXkpH/BJfWxmKXVrQYUZxKD
   utlqtTCuEJnw1/nYH6PtBeP1YJVPJmnv3qGieZIC2AfdNRh07ZRupPGXx
   g==;
X-CSE-ConnectionGUID: 2YfQBSQmSNyRRR0mKKXiOQ==
X-CSE-MsgGUID: 4KMJKSkMQF6sCnOm2anNkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21711563"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21711563"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:14:17 -0700
X-CSE-ConnectionGUID: 20gV+VxOTN66vkWjO4j+TA==
X-CSE-MsgGUID: j+8tsWuwRpO5z66lvcz4BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="57823816"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 12 Aug 2024 00:14:11 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-media@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 2/3] drm/rockchip: Use iommu_paging_domain_alloc()
Date: Mon, 12 Aug 2024 15:10:33 +0800
Message-Id: <20240812071034.9443-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812071034.9443-1-baolu.lu@linux.intel.com>
References: <20240812071034.9443-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit <421be3ee36a4> ("drm/rockchip: Refactor IOMMU initialisation") has
refactored rockchip_drm_init_iommu() to pass a device that the domain is
allocated for. Replace iommu_domain_alloc() with
iommu_paging_domain_alloc() to retire the former.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20240610085555.88197-19-baolu.lu@linux.intel.com
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 44d769d9234d..11e5d10de4d7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -103,13 +103,17 @@ static int rockchip_drm_init_iommu(struct drm_device *drm_dev)
 	struct rockchip_drm_private *private = drm_dev->dev_private;
 	struct iommu_domain_geometry *geometry;
 	u64 start, end;
+	int ret;
 
 	if (IS_ERR_OR_NULL(private->iommu_dev))
 		return 0;
 
-	private->domain = iommu_domain_alloc(private->iommu_dev->bus);
-	if (!private->domain)
-		return -ENOMEM;
+	private->domain = iommu_paging_domain_alloc(private->iommu_dev);
+	if (IS_ERR(private->domain)) {
+		ret = PTR_ERR(private->domain);
+		private->domain = NULL;
+		return ret;
+	}
 
 	geometry = &private->domain->geometry;
 	start = geometry->aperture_start;
-- 
2.34.1

