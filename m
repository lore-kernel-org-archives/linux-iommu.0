Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5B142645
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466131; cv=none; b=ukAxNOVaG33Spu0XNdtumNB4E4/6pzyWbfEyPvv6mB8ey1zr0J30EKwUo/87McjZ7KJoL55Euq45Dgdb14SqfBXY7Ubg6gcihXky3MW0nuNIHaIl3BvQt7Uq77QU5QlITSHfmkmpz8lXVvNEj+Kpk3NbRHitVa45gCAJUYNuIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466131; c=relaxed/simple;
	bh=2RzKLZKa9aMbeh8zX7gRXSDK8Hv/vXOsjqYlhYXqS5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQAJUiazOzQHsh+Rq0Eq08452QYWy276TWePS506RYNhJlf65JZezThn6lR1IO+45k2+E1lhzH64R2pgj6f+r2bSZtFrxTi2W3gzC10hn2q9kW9z7mI17T2nUrsoh4pXZ44tCkZeMKBhqFbxTXnfbkmViRpyU1/QlxSYffZhRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rlr5wSER; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rlr5wSER"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466130; x=1749002130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2RzKLZKa9aMbeh8zX7gRXSDK8Hv/vXOsjqYlhYXqS5Y=;
  b=Rlr5wSERCUw83JfXhbs+Omrm4rtb/+gcPRz0hO3x0ZF1YrKqkerdTWqp
   gPUnZSeQ9jHmszYUsCdMRN3SGiczN/HLb9XxCU9VITe0pevRHLYHrS4oo
   WPPTvSYu6cFALpYJR+odRyoHqEcdJlcA7ln367zSMeuguxIYKcVwkS6fp
   Xfat8PRH9GP4GASsu6Z5Lbd4B3dxU523o3i9Vu181k1V3Tj+IphzybGmY
   nJYsBmLBHpe6LxTVL9AvGldRTGbO+bznbb7uP5Bmn9463OHxWRY0516a5
   9bnXduyqP6NXffabY/pO/vFSiY7oe9jIzkro4n4UqKoOGswyjKGdUDT3B
   g==;
X-CSE-ConnectionGUID: PLMPrhMtTWClrCAaxL4FJw==
X-CSE-MsgGUID: 8I6S66bqTTeZc6scM/DDXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25385177"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25385177"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:55:30 -0700
X-CSE-ConnectionGUID: 8Ijzyl4kRVWuMkWYuL3Cgg==
X-CSE-MsgGUID: wQRiAP+zTimow0SHenz+fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37662048"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:55:26 -0700
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
Subject: [PATCH v2 19/22] drm/rockchip: Use iommu_paging_domain_alloc()
Date: Tue,  4 Jun 2024 09:51:31 +0800
Message-Id: <20240604015134.164206-20-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604015134.164206-1-baolu.lu@linux.intel.com>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
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
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index ab55d7132550..52126ffb9280 100644
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

