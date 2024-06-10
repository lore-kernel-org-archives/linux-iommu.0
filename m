Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922607581A
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009918; cv=none; b=ShEwWi2PLLt3cI65muY/CuWGqRUL2UM9ZosQn5oFgQe1Wox8lMb9kFga7GO5UnX9LR7BSD4gZ8gz2zGffQjIT7VbNHTyUoXfeJzppZctrHEXjh2kgyKEHZm0/75UrFWVrmmqAYcAG+qeTP9hwsvgUP26ZSaQWADGNt3Ng80gU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009918; c=relaxed/simple;
	bh=qU++r+SggSyx2fIXITvVfcmJ8RsRBVMKn+9+u6WfEcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W7JZ/gZLvCipzkf5rFbT4crsjdezGQV6g72n8XZ/x3977qyBm1R4bl1Fe6kIkCSns6R9WAxGEbYbWm0V/u7rmXlGi7bEG8MM7J5OMtwlSDz3/O0HFVf4ezTPt6qS3JMFdZrl7MkKexZCIlDFPBjkEGhQD+R1O9NpbFW3MuayYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDqh5Sh7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDqh5Sh7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009917; x=1749545917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qU++r+SggSyx2fIXITvVfcmJ8RsRBVMKn+9+u6WfEcI=;
  b=UDqh5Sh7UJu55pRN7wRyZwZKdspYYSP6SyNU0YHgAtoy9tRDrRIY56DK
   xuyP9EtuLuEqqt1SPNvygddWa3NwFgem9LedY+9dzv/7++2lMxAi8m4uP
   sj+sI6tEF9P+V+5aWo4JLvLk2Tdr28Tpv97a6ZjGwyqx6Yu+N4RYxEy9v
   8AvkzFX6EPehbSjK/W58VDHFgLwMZkUEPONfokjK8swdfn5g1+yxxAcaV
   4wrutM5vrqg40/0/5epVwdaQ+YBy6/bzc21Dn6CZipaYkdh8m84o0Aq7f
   E8C+rLwNNgFeJ8Fj8goTkudsp80n4BoD6jO2D80zWWQ12bYhlvCh5u9f7
   g==;
X-CSE-ConnectionGUID: bp47OlCYSoijL+Yr4Gy40g==
X-CSE-MsgGUID: zZogchUhRf6ooDhmmCVYKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581569"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581569"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:58:37 -0700
X-CSE-ConnectionGUID: bCISEAxDQLCb2yA7Goorcw==
X-CSE-MsgGUID: H05Iq2PASIy2ktFmbvS+zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43432449"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:58:33 -0700
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
Subject: [PATCH v3 04/21] vhost-vdpa: Use iommu_paging_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:38 +0800
Message-Id: <20240610085555.88197-5-baolu.lu@linux.intel.com>
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

Replace iommu_domain_alloc() with iommu_paging_domain_alloc().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vhost/vdpa.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 63a53680a85c..e31ec9ebc4ce 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1312,26 +1312,24 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
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
+	v->domain = iommu_paging_domain_alloc(dma_dev);
+	if (IS_ERR(v->domain)) {
+		ret = PTR_ERR(v->domain);
+		v->domain = NULL;
+		return ret;
+	}
 
 	ret = iommu_attach_device(v->domain, dma_dev);
 	if (ret)
-- 
2.34.1

