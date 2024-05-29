Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1224D161904
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960977; cv=none; b=sOZ+ifh8ilKy/0ggaCg+UjcUQEOqHXYYcUE1YH4aF0C1yuW9c4W4LdmPM9NPVomV2TT10McOLYGaJbvX1wdAvcVyLmkXjvruf9GJ6X918Xm04HeY0m0jLtBzak3Ru0Tq+yr4LCGGXNgtrHewR5M2vGoVeVmwPLK9iyeeKlGz+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960977; c=relaxed/simple;
	bh=btq9QncSBgyBYPM+1ZLAyc+X7006n3UNtW5/Bz7GLZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VW43jlaO2SQAT9JuBQPHlKwoMOTigMWnSfCY3eu2xAAe0B+LXC4HrNbUWSUX6G2+uM6c6MFiCajCESEFIjTUKxjH4pSjANP2p9xIB4N27BidShmp2+b3NG4EPaXxgacGFv+iqbvbV8ZiJiwQFOP25jhHnpDsCsgeRe0OAhQ+0qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSJaA/z+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSJaA/z+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960976; x=1748496976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=btq9QncSBgyBYPM+1ZLAyc+X7006n3UNtW5/Bz7GLZE=;
  b=MSJaA/z+6Dh/y/cp+Io0xjXSO57DJG/IFWBxpvcIg05MJ79YmvJvkBk8
   o3nwE+ptBuPiL+XZi57kEDRXfawIZ+nDSf+1huhwfxVKO7kcUeL0u9+6K
   5JEbPHwOpQLDB8p14bYbrqs6E18yG848RG8TFA5VKG6YCYIpiTZQyq93k
   MEO6qgQ2j4XAHeMIDnNuW0VyJM5IUaUUmHj39TcOTUh7UB2FIxMSJKRoo
   jKGFS0xgDl6JaEDro4OsmuG+HhdmS2CaMNaYWLf+zyVdeBzO6UQ39uT+T
   AnnkfWo3cVWgk1VEZ4z8BgyntE8e1BiIWn1Koxk757McSTcbczaFJjSZO
   w==;
X-CSE-ConnectionGUID: NRhbMmBXQAij3S/SIZMpxg==
X-CSE-MsgGUID: pfoVIMD6SaONmSybEqGX5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13568852"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13568852"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:35:30 -0700
X-CSE-ConnectionGUID: PJuAP/85SO2v/dKzt8Un2A==
X-CSE-MsgGUID: fVOd5tHsThGjTLV7SoVvmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257574"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:35:25 -0700
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
Subject: [PATCH 06/20] drm/msm: Use iommu_paging_domain_alloc()
Date: Wed, 29 May 2024 13:32:36 +0800
Message-Id: <20240529053250.91284-7-baolu.lu@linux.intel.com>
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

The domain allocated in msm_iommu_new() is for the @dev. Replace
iommu_domain_alloc() with iommu_paging_domain_alloc() to make it explicit.

Update msm_iommu_new() to always return ERR_PTR in failure cases instead
of NULL.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index d5512037c38b..f7e28d4b5f62 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -407,9 +407,9 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
 	struct msm_iommu *iommu;
 	int ret;
 
-	domain = iommu_domain_alloc(dev->bus);
-	if (!domain)
-		return NULL;
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain))
+		return ERR_CAST(domain);
 
 	iommu_set_pgtable_quirks(domain, quirks);
 
@@ -441,7 +441,7 @@ struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsig
 	struct msm_mmu *mmu;
 
 	mmu = msm_iommu_new(dev, quirks);
-	if (IS_ERR_OR_NULL(mmu))
+	if (IS_ERR(mmu))
 		return mmu;
 
 	iommu = to_msm_iommu(mmu);
-- 
2.34.1

