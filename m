Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D4167D8C
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960980; cv=none; b=Lrjmz/P30U034DoOIXzTXh3k1iYOJNbMy3JvsXGWXkzjzkP6yC/n32kbpc0MQgu+Oa3wXX6CtUhYh3Hom9hTvRgc3hq525v98mLiVV2cLzECYpZnTKQYHSBo6A9R/weEIcaMDdZJsoAbGMZzuneT0fPmSiKn+U8964LfUFvW4Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960980; c=relaxed/simple;
	bh=hTV3zLZE5NKCbs8//lAHn/CtYF9pijNjI3EBc1agx30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4rqiDwhf6scYmxNnoAOx+fcwkYH/Qa0AoD14VXdwABA8BU8axDiQezjMfrt8jXN1/t6PMIBcYa3qov2Fz5ADH9vXffJKI77s/ZqiPN0jzuiXj1Xt7KNVm8TZ3dW3pmeY/uvDFeJUtC0bWeiU3J6z4+YYktImHYm+Une/8qsAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nn4bNbVy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nn4bNbVy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960979; x=1748496979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hTV3zLZE5NKCbs8//lAHn/CtYF9pijNjI3EBc1agx30=;
  b=Nn4bNbVyfWKhqgeHV7gWX9hs07K47VC8XiQrMRMQ+omEEKSXxlmQljE2
   zqVZYKWEAP89UrYZAwWS752r2jKQWpbVvx4WZbsjadgJGcbc/HOBsf3GT
   N1PDaYpXMkZjxCJOzekgk2xSzGmEuhMPjTxLC+BJ0C8VubUl6otbB4Cua
   wVjrvUqW2h0508Xpz7LjLQl4RhplGypMOi2TNrZsKqF0OuPc78wrkJG5X
   zkz9yi1YN0lUEA0yzSPrpR7gcOjtfERdTk8sexee7zSfoMh0fS0GwALhe
   gnNb1VBoj1FS3i1MImSs/GQ22BYLyqrtNu27yUQnN8GEk68fpxN1OFP+P
   w==;
X-CSE-ConnectionGUID: lrWe4BfoTE2ueknDWkvdpA==
X-CSE-MsgGUID: ijVYVTxCSaSamA5dJepw8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13568937"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13568937"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:35:44 -0700
X-CSE-ConnectionGUID: +cDPAFDtQritcQaJ3GGFSA==
X-CSE-MsgGUID: nDbXwaPeTiGGxvK7O/Ioeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257672"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:35:39 -0700
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
Subject: [PATCH 09/20] media: nvidia: tegra: Use iommu_paging_domain_alloc()
Date: Wed, 29 May 2024 13:32:39 +0800
Message-Id: <20240529053250.91284-10-baolu.lu@linux.intel.com>
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

An iommu domain is allocated in tegra_vde_iommu_init() and is attached to
vde->dev. Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/media/platform/nvidia/tegra-vde/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/nvidia/tegra-vde/iommu.c b/drivers/media/platform/nvidia/tegra-vde/iommu.c
index 5521ed3e465f..5a41b5364238 100644
--- a/drivers/media/platform/nvidia/tegra-vde/iommu.c
+++ b/drivers/media/platform/nvidia/tegra-vde/iommu.c
@@ -78,9 +78,9 @@ int tegra_vde_iommu_init(struct tegra_vde *vde)
 		arm_iommu_release_mapping(mapping);
 	}
 #endif
-	vde->domain = iommu_domain_alloc(&platform_bus_type);
-	if (!vde->domain) {
-		err = -ENOMEM;
+	vde->domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(vde->domain)) {
+		err = PTR_ERR(vde->domain);
 		goto put_group;
 	}
 
-- 
2.34.1

