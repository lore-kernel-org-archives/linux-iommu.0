Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C4515EFD6
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960975; cv=none; b=a5slb1W/Mjkj/6Ezm0qGSxPd+L1cbXNT+3s8POC69Pw7+sUKJjBlDyuwXXo+7dmwm6X82tFmJzEeJ2DdBlX3/VMeXU/rC8+CTg21u8kxKfzopjiVAFnO8dQ5aUZWc/beR9igYNoeYC4LLUa4FEJSvp57qQaHgwf7FrvT4tn+2fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960975; c=relaxed/simple;
	bh=ybhIC+9D0FzFiBqGh0zAWkB79mgKE5w60y1oFabl/b8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RyAAJ8WEumtLxLsKL8a3Odfmkn9RkeW5+R6/xwILbMaHjYRx67gFpDoWopWDiiToaq/plIgRxt/Yir2UoGlmysAgT4kVLBbz2/g067PaMRVvWnH9HY9M4wCpQBss5pH0JueN3yUpfqqRdwFtytoFB4iExsL1mZ66gv4hoIdmzEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpP+mhqc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpP+mhqc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960974; x=1748496974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ybhIC+9D0FzFiBqGh0zAWkB79mgKE5w60y1oFabl/b8=;
  b=TpP+mhqcl5XxarurC0AhOdrZrriImZKgHvXbxqfeS4wd3KpghLKn5Seb
   anYcpbetdNMmWNgwcUDziKvmS+glrgrvwYesaMy5w9zWrfSjR5fMFuq7+
   bRFJBsMMsIpOxGxZ2g5ZkT281KuOK/VBXw3YK+VKlZP5lgZ21LU7LUQJy
   Lp46CEtqcP1yGDn1W0Dzxfa5R8xpPQ5CNI5SWgAbwcL64tLkXza5ffvAt
   IgAMBJvZR9GWsF3RmXy0lbTH7Nb9mCkKI3VYJSOZmuHEFQ8E2eYhoq8g+
   beW6Ky+nJVvlmAxSWTmt2nkMDX0QUfrp8jZ66rk5aI2zy3MGhyeRTVG1q
   A==;
X-CSE-ConnectionGUID: PDVbiSiCR5yQtMt4mjviJw==
X-CSE-MsgGUID: ixlYcd/ITmuFuvwxM3Y1Kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13568807"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13568807"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:35:20 -0700
X-CSE-ConnectionGUID: Lx3ESut/QGCW7lfZ/TNLuA==
X-CSE-MsgGUID: oyY1KD/nRaOxmUib4QeiUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257522"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:35:15 -0700
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
Subject: [PATCH 04/20] vhost-vdpa: Use iommu_user_domain_alloc()
Date: Wed, 29 May 2024 13:32:34 +0800
Message-Id: <20240529053250.91284-5-baolu.lu@linux.intel.com>
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

Replace iommu_domain_alloc() with iommu_user_domain_alloc().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vhost/vdpa.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 63a53680a85c..7784218fd9d2 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1312,26 +1312,21 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	struct device *dma_dev = vdpa_get_dma_dev(vdpa);
-	const struct bus_type *bus;
 	int ret;
 
 	/* Device want to do DMA by itself */
 	if (ops->set_map || ops->dma_map)
 		return 0;
 
-	bus = dma_dev->bus;
-	if (!bus)
-		return -EFAULT;
-
 	if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY)) {
 		dev_warn_once(&v->dev,
 			      "Failed to allocate domain, device is not IOMMU cache coherent capable\n");
 		return -ENOTSUPP;
 	}
 
-	v->domain = iommu_domain_alloc(bus);
-	if (!v->domain)
-		return -EIO;
+	v->domain = iommu_user_domain_alloc(dma_dev, 0);
+	if (IS_ERR(v->domain))
+		return PTR_ERR(v->domain);
 
 	ret = iommu_attach_device(v->domain, dma_dev);
 	if (ret)
-- 
2.34.1

