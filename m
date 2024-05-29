Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823B167DBD
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960981; cv=none; b=TMwnMKAhlxfWkQ3QAm3DznrbNsJpUOHbKPgvIiHLCH6qPrZiynzvhoR2J1E7zU6Vb72pp8iCXYsuKs9T/j/O86QYFSXTjzPRbDgABqN74Gj1Qs/JWulvhaNvVzRuZoC4+NgkyaxP/8eYSZNXyrq7X+T2j5k/WvSmkPOhyXE+vMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960981; c=relaxed/simple;
	bh=sQhpQrDpkr5d6QzI9UDmfi+nhpzVyW1CcaBVDpyFpuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OUEeOcttJtF93Se1g8xN08/D61h0h6Teep8v+qkaQ7O0jsKZe924ykH80hx6wypz6WB9uUDof5YB2VxAKw/PuBSZOpx4EB2S1ZopJQwlodEsEUsuCsEy/t568nLcezAZAvLfxxwAinDph/2TGNUoGzaRpkD5cQGAbRk8z72pO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KiL+s0AP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KiL+s0AP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960980; x=1748496980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sQhpQrDpkr5d6QzI9UDmfi+nhpzVyW1CcaBVDpyFpuE=;
  b=KiL+s0APhHa4cQk7rUlYR/EqLgvuj1hDt3yVBexi1tmL78/kydZGGxyt
   Zpj+5ARBuGzNCKyx3dtTf2FzVrZhY2TvhZmjdVObrROJcKEfH9pn4L80U
   8piDyhcwC+wDwWcBcgUmbGsxopq9irKlaWOTmT0D6+hbkD7qkGiJHPIPs
   q8mEpIBAL+7CH18DzcKYvpvYM5pWjPXeWhFFyKqANFCtLoSM7GqETZ3FA
   soefGYOe8XG65N992RdniAVp7iz2fE+DmUV/R53C2hIY07ZCBmRSEA1qH
   IA/nmXj2ENO42w6Lhg13g6PaJZ/0G4nctUGlwNP0HirGRuQpSzmFIe+Wl
   Q==;
X-CSE-ConnectionGUID: xed0ZlxTSTGbX1NLxE7YpA==
X-CSE-MsgGUID: Gh3NyLRgQSC4PXaXwJACUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13568967"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13568967"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:35:49 -0700
X-CSE-ConnectionGUID: ibSOuVsuTWmBLKtjWng6DA==
X-CSE-MsgGUID: w/ltsPfbRAaZqzlQJES1fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257682"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:35:44 -0700
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
Subject: [PATCH 10/20] media: venus: firmware: Use iommu_paging_domain_alloc()
Date: Wed, 29 May 2024 13:32:40 +0800
Message-Id: <20240529053250.91284-11-baolu.lu@linux.intel.com>
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

An iommu domain is allocated in venus_firmware_init() and is attached to
core->fw.dev in the same function. Use iommu_paging_domain_alloc() to
make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/media/platform/qcom/venus/firmware.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index fe7da2b30482..66a18830e66d 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -316,10 +316,10 @@ int venus_firmware_init(struct venus_core *core)
 
 	core->fw.dev = &pdev->dev;
 
-	iommu_dom = iommu_domain_alloc(&platform_bus_type);
-	if (!iommu_dom) {
+	iommu_dom = iommu_paging_domain_alloc(core->fw.dev);
+	if (IS_ERR(iommu_dom)) {
 		dev_err(core->fw.dev, "Failed to allocate iommu domain\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(iommu_dom);
 		goto err_unregister;
 	}
 
-- 
2.34.1

