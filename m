Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4415383B
	for <iommu@lists.linux.dev>; Wed,  9 Oct 2024 04:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728447397; cv=none; b=TtrHks7tjCdxyMGjCcQc3/HpOv8TreBvCA+IlhPf4X7FwAaCIo6f44msnKo5eNiuafoB+zK2bsHozURozBBr9GJQ3JoTAeVNgp9+RQP3EpkmcMKOAK+KVxfWJwzozHOxCPRULWts3UOvrQUE2OMon78hhECTxObTz0edk+AZvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728447397; c=relaxed/simple;
	bh=FpKlHHeM/6cKsSb3+hXN3Hii4hdbUz8GYyXvQvDxPug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiqRb2Owce51pb4dvgpzmU13gnJZTH4k3vI7dRsuc39bzPltTQ23W65Vgq3aYYP+UF1UsrXoX7WI/CJaSEGMkB2XtVyonCwNw9e8LmLsMaK0qah7dGwQSmXgu/ZEK2pal+CMdJ4APZARKNhXjfiqEIwlZy2RIt7wbtPRXwbAckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzZTvHMn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzZTvHMn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728447396; x=1759983396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FpKlHHeM/6cKsSb3+hXN3Hii4hdbUz8GYyXvQvDxPug=;
  b=PzZTvHMnW6bxkpcUyDINBNkVIvsKEOsnk9KoIZzOrcakHz61O81nwLpU
   jYjrhFY9gvKnU0WdJ4M5ZmhxR4lYoGPNTqqiOrSRyBd/Az9MuEpOPyiVZ
   f9LhIuPNCJS3R991EAUQlymixHvtxhkwxGkLPHY9hQgOaJMw+Sv8RtGdm
   BNwC28l9ZKqh32x1uhyY2CGI7hGRJbepwn9+eBPXtpscBJrhA1Ez3xY0Q
   3o3mzT1WHTcPoK1uv1kgulLhv512ATDuDvgnb8T62wcu3i16hiSQIEtfR
   2nHGFCoUh7Y2fNC32msk82sPS/dAM3xAL/ahlW4zgvrEIMbZ5rLaE0w37
   Q==;
X-CSE-ConnectionGUID: OniDKe6HSfGsxzsYhMF+5g==
X-CSE-MsgGUID: manOUOcoSfeMG8r1OTiUYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="53126982"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="53126982"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 21:16:36 -0700
X-CSE-ConnectionGUID: gBR1ztROQv6F5nsORJFsxQ==
X-CSE-MsgGUID: IuHfSUqBTXCGAYv8AkG3CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="80095696"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 08 Oct 2024 21:16:30 -0700
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
	Lyude Paul <lyude@redhat.com>,
	Beleswar Padhi <b-padhi@ti.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 1/4] remoteproc: Use iommu_paging_domain_alloc()
Date: Wed,  9 Oct 2024 12:11:44 +0800
Message-ID: <20241009041147.28391-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009041147.28391-1-baolu.lu@linux.intel.com>
References: <20241009041147.28391-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An iommu domain is allocated in rproc_enable_iommu() and is attached to
rproc->dev.parent in the same function.

Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Beleswar Padhi <b-padhi@ti.com>
---
 drivers/remoteproc/remoteproc_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index f276956f2c5c..eb66f78ec8b7 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -109,10 +109,10 @@ static int rproc_enable_iommu(struct rproc *rproc)
 		return 0;
 	}
 
-	domain = iommu_domain_alloc(dev->bus);
-	if (!domain) {
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain)) {
 		dev_err(dev, "can't alloc iommu domain\n");
-		return -ENOMEM;
+		return PTR_ERR(domain);
 	}
 
 	iommu_set_fault_handler(domain, rproc_iommu_fault, rproc);
-- 
2.43.0

