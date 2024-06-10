Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59328287C
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009965; cv=none; b=nQT+SYGBAxCgAObAU12Cc40YHvgoFSiGkpyaWhMM/3mDCvt98Fr0GwqNqPxtX/FPWAZFW2u4g7fU5v7RZdJ13fSMDqhmjrDkI6LrJOu36zuDyEsedAS+gWtqYVH4QI/TOIxj+qsKB3c9DwPqnA/uR9EHGrjwKCf6Pd6+n+Iu80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009965; c=relaxed/simple;
	bh=sM71nWFg3cNfoT7YtYLr4iW7aTMKAR3F9pN2mUDECnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EdsMnYQxhKwxSl8rMdYfS/mpLXa+lo2FjA7ODj+ZEOnQBdJea5mslNKdXJxwPJ9XLz6sIbQfCo6YxsADP1gjeRBZwf0avfxbEQC/UzHlslRZbADosMqlxBxtzcFtay2PXZmbj6OV9VI9P9P5o8+Rz4wTqZwutZSMvLhc4nGJ4Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QV6akDqk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QV6akDqk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009963; x=1749545963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sM71nWFg3cNfoT7YtYLr4iW7aTMKAR3F9pN2mUDECnk=;
  b=QV6akDqkEoR2hyoX9lxL3OrqpMKYCgkFZvkMOwiDXfpvjbBy4mm9L6Ot
   9fBikzyuO4Pr2jn/Hzx01/u1EWuioK9KRqt5o9yNLRkzlEj2O192inyi2
   doK52F/Go9eOUSwCTMrZq1ywzonntRIsi7KVdfJhDAvxjI3H88I25I4kO
   dEDrJEGQRwS9N3SiSU9FXMmCjN8rh9iwdj+SmNOjDJRqR+IxSp7ehZgo8
   quyCnZGvjDyWShXk4JXmN0mXL+S7JF+pFI2ionbtQ4igwx6j8CWuzGs+O
   AA0YoHVX37PhYEf0mxKP+4JUwN4zZoE3QTGkOVhByQr6jylDejTrgPN4l
   Q==;
X-CSE-ConnectionGUID: 1W/tybznTdGzBg975zuL9w==
X-CSE-MsgGUID: /r2+ag3RTP6JNlYUm6lbLA==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581829"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581829"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:59:23 -0700
X-CSE-ConnectionGUID: pUWAnATbSkmzoSbiD3n7dw==
X-CSE-MsgGUID: EcaT65n0R1+t1siUeF7hbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43432756"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:59:19 -0700
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
Subject: [PATCH v3 13/21] soc/fsl/qbman: Use iommu_paging_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:47 +0800
Message-Id: <20240610085555.88197-14-baolu.lu@linux.intel.com>
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

An iommu domain is allocated in portal_set_cpu() and is attached to
pcfg->dev in the same function.

Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/soc/fsl/qbman/qman_portal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index e23b60618c1a..456ef5d5c199 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -48,9 +48,10 @@ static void portal_set_cpu(struct qm_portal_config *pcfg, int cpu)
 	struct device *dev = pcfg->dev;
 	int ret;
 
-	pcfg->iommu_domain = iommu_domain_alloc(&platform_bus_type);
-	if (!pcfg->iommu_domain) {
+	pcfg->iommu_domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(pcfg->iommu_domain)) {
 		dev_err(dev, "%s(): iommu_domain_alloc() failed", __func__);
+		pcfg->iommu_domain = NULL;
 		goto no_iommu;
 	}
 	ret = fsl_pamu_configure_l1_stash(pcfg->iommu_domain, cpu);
-- 
2.34.1

