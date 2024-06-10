Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1577119
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009950; cv=none; b=TduXdOxldkgpHu3asNDD5ilo7HDxdfhGKbnWSjWiTm2N9p+/8/2EDcoeuCFfs8VS3BXwTzx+N4FK5us+hJLsd2g576yrfAUFfjyKNK4wl/MIXUzZC6rfVFms1jKWRyEpMEtDibv8yOG/0utqIMFXU+jvW+/jshTwAtB648X1OGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009950; c=relaxed/simple;
	bh=I+6ZV6/EEpnAgWEguwHFARLKzGNGpw6wFQ/PVZkM/0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+KJCCpAd81ok9kMWp+5FLUgO06KLHOxNkX6g5v4mrB/2X0ZLL/KAbPrwRhrcq6y8QI2g0rb13ASHhupSYwCmM0WtYCbsaMZ4MpQrqm5cFUvb2iuHOtFoHFvZHfNRwNeeANgjgF4NRm9w5mG8bxazvS4JQGBb7WM5dmLvnohC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cb8HUsia; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cb8HUsia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009949; x=1749545949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I+6ZV6/EEpnAgWEguwHFARLKzGNGpw6wFQ/PVZkM/0g=;
  b=Cb8HUsiavp6loa1sEd+Q9+rmPxBhSitBblWJ6EWmKGqiOa+aD+ZvkXCn
   YTHexH7TmDZdMpHSPVQHAGlGyTXb9hgR6WBxvwzmsiMCaUB/65ZwMAZdD
   kbs/tAmUfSa9f0FMV9+UzRBsNf2nNBtqStIsEcLnNWTJAVxBFlpiEMvLq
   V0TZONnMccoTDYGO+j+517l9uXhlnyzJZQajSlt9qncIlgHn2Js1vDeie
   6twBgUy2IuroOcBN9grU0N4MN5Iyi5Ovk+nB9uuYvn6SvB+YcvxV53EtX
   h4ffxQ6qiBGD5kHgEJONDIbIB8JEyLPRRCPlMr4t8Gi52isVTvFTxiEjA
   A==;
X-CSE-ConnectionGUID: j3Zam5A+Tia8prqIanwy0A==
X-CSE-MsgGUID: uIR5BWH3S2+a/ANDSUXPQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581717"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581717"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:59:08 -0700
X-CSE-ConnectionGUID: DWaGHBPtRWWyKoZXzOPdmw==
X-CSE-MsgGUID: mAUB1mHyQdCuNi096HBmIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43432626"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:59:03 -0700
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
Subject: [PATCH v3 10/21] wifi: ath10k: Use iommu_paging_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:44 +0800
Message-Id: <20240610085555.88197-11-baolu.lu@linux.intel.com>
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

An iommu domain is allocated in ath10k_fw_init() and is attached to
ar_snoc->fw.dev in the same function. Use iommu_paging_domain_alloc() to
make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 8530550cf5df..0fe47d51013c 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1635,10 +1635,10 @@ static int ath10k_fw_init(struct ath10k *ar)
 
 	ar_snoc->fw.dev = &pdev->dev;
 
-	iommu_dom = iommu_domain_alloc(&platform_bus_type);
-	if (!iommu_dom) {
+	iommu_dom = iommu_paging_domain_alloc(ar_snoc->fw.dev);
+	if (IS_ERR(iommu_dom)) {
 		ath10k_err(ar, "failed to allocate iommu domain\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(iommu_dom);
 		goto err_unregister;
 	}
 
-- 
2.34.1

