Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1863A1CD
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725241877; cv=none; b=OGZV4Py+iXMmAeSfxEU1+zI/c/B7cfmTDe0JHaWyYl7sWP+cb96Wk0anzE0xPbSMP6e1dRDdHI6qHFBzikLSKqBP3BWkhsSqsp2DIcIpUeH6jG1Mi8KBgdS/xkAmgf1Kov5b+MJeHvyOkRNnKEZG4+JvPspscyllmCh+0ZJ66fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725241877; c=relaxed/simple;
	bh=HTJQcN0FE2N5DQLr1jAt6JXd6rKNx9aVQY3dPFxGnc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNBRgwzVc200sOdS2ryXsIUqaFGMyoe0Z8NIraAk0Z/KrM4p1vopk5RS7PVT3og6lzyekss1LwpL5CKVNJ+AXS/2B1bRXIH9TgE85SCu9ozicXWFaQhLMpX1bso0mvWesohodirQzZlwBaWaVEkUqLmbyyrYw7bsltw98SUAg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hX50AjA1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hX50AjA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725241874; x=1756777874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HTJQcN0FE2N5DQLr1jAt6JXd6rKNx9aVQY3dPFxGnc4=;
  b=hX50AjA1/yxKdY4gKUGsUq+GlsaEssl3kECaA/6JfiTDgi2326xMj4od
   56y7SsxXoXFl63BRWHmD2bu6unJ1HyI4JxBU1eXGqI+Rv27bmjWhXm8AU
   X/LFt4CWZCHxIr61kQXuY+83J1GDEWBsuGtEfHoVvgod6Pk/yC2BDKo6G
   XzUX97Z8+ZBszvLTQeoHNrE3dfZkCW3AolOTWYfHqJhPZ7MM5HLd72F3N
   gcAFYIwJl5PWHamuowe0vtQ/epK2Hu9PQr3F8six/oxkvcJ5nlaHhPRFo
   rif5MbNml2uujIpy+QNsN+Y9Qc0xIZyniJkjUlNq6dC2K33ZGcmws1ScZ
   A==;
X-CSE-ConnectionGUID: 5eWwmdgsT/S0bw+cuQIspQ==
X-CSE-MsgGUID: On+ygqsdQ4eQSslltajkSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="41307691"
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="41307691"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 18:51:14 -0700
X-CSE-ConnectionGUID: Nl7Pj8i9TO6XqEwIgHlq0Q==
X-CSE-MsgGUID: +vkijvTkTzO3htP32F9nBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="64817664"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 01 Sep 2024 18:51:08 -0700
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 2/3] drm/rockchip: Use iommu_paging_domain_alloc()
Date: Mon,  2 Sep 2024 09:46:59 +0800
Message-Id: <20240902014700.66095-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902014700.66095-1-baolu.lu@linux.intel.com>
References: <20240902014700.66095-1-baolu.lu@linux.intel.com>
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
Acked-by: Andy Yan <andyshrk@163.com>
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

