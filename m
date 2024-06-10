Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4DE12F392
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009970; cv=none; b=LR6Tad7m/tOrOSQ5fMBpIDvcdnWRDUSvtBqfuKlX4k86MljCkzujhmu44LAr3C7zwtGhcrSTrmNiv1hndnXv0rcjVya4MxcHih3Pt5ZbBH0pAUDISkrja0GzgEJjsZkQ4az1F43HKFnRcOj3RH7UnHKslNoBqBCsZn5aUK5pfOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009970; c=relaxed/simple;
	bh=v9ajyqSmZ+fyr4zUzek4FxHLrUQ5pgq0PnnoHeKwwEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4RPj3BCOx14OpG6rAa3VX0QBiKRZkOM8UulHzphMeLkkI/3PvG0uNRzwvpyyJmM+iVPGaNxXHdiuWUUtbQr+j9VWb5BxfAr4rmaXMzYE+s8mubaNvKKpWRV5WSBk62YuULKBMZOLw+jouAWcL6Kys26ay9s+EP8bF05WObXtG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBIGjEqv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBIGjEqv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009969; x=1749545969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v9ajyqSmZ+fyr4zUzek4FxHLrUQ5pgq0PnnoHeKwwEA=;
  b=GBIGjEqvuywG2yhUsNwo3KEBFxSUDlVwpYJy14LiuINipQrecguYGlqb
   7xbFExw9axAxazC/xloBx+nODZN2pbe72f6/xbl5aJ0RkRM56rtn/BEb3
   1bByWzeLFuMEvDRRkr57H49Rs7SPBfXuAURK3nKiTIlstt+LOIsoldTNV
   8sNXlVzxUS/9LC02QjIMsqMps9+BCt+3GP8B+GZMYIlSgT+q9mlHnE/q0
   iycNmvYmI+Z6W5blB677GL/IVbUhxFUw/l8X/DHym6yJJURnuy4222ETL
   LVmmlslvbKPklSWkBEU6OHYzMtqNQOrbPfQwb38HdmodQFvdsDS3N/OT+
   A==;
X-CSE-ConnectionGUID: zo38Y4RPRIGmsNN9Hcd2Fg==
X-CSE-MsgGUID: HuX5jk/TTpyFHyb2b5BOmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581855"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581855"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:59:29 -0700
X-CSE-ConnectionGUID: GkBRboXmTSyQf4zFvmmGBw==
X-CSE-MsgGUID: c0ivZk7UTYCnDo9fVTczuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43432808"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:59:24 -0700
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
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 14/21] RDMA/usnic: Use iommu_paging_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:48 +0800
Message-Id: <20240610085555.88197-15-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610085555.88197-1-baolu.lu@linux.intel.com>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

usnic_uiom_alloc_pd() allocates a paging domain for a given device.
In this case, iommu_domain_alloc(dev->bus) is equivalent to 
iommu_paging_domain_alloc(dev). Replace it as iommu_domain_alloc()
has been deprecated.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/usnic/usnic_uiom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 84e0f41e7dfa..f948b76f984d 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -443,11 +443,11 @@ struct usnic_uiom_pd *usnic_uiom_alloc_pd(struct device *dev)
 	if (!pd)
 		return ERR_PTR(-ENOMEM);
 
-	pd->domain = domain = iommu_domain_alloc(dev->bus);
-	if (!domain) {
+	pd->domain = domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain)) {
 		usnic_err("Failed to allocate IOMMU domain");
 		kfree(pd);
-		return ERR_PTR(-ENOMEM);
+		return ERR_CAST(domain);
 	}
 
 	iommu_set_fault_handler(pd->domain, usnic_uiom_dma_fault, NULL);
-- 
2.34.1

