Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3EB158DD1
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943114; cv=none; b=NGopcAo2oL+MndnowAxtF7n68lQ/5cJkeu1bHQ45ab3YpJCEPBoZ0H0qxhJz2fmRV+PD7vOZ1sc0JpSzmPsv7OLtiN7dxDq8MmZoGcvWVI0++FDFupQLgeFK9TpL6rAJjXfXFvyUf0xZggDSc21h7sXd6DNwWvFAusRlm/m4aA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943114; c=relaxed/simple;
	bh=KoReSuUGTuTcwo+VoCABrE1YCpjucTFHTudUH9B6IJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQ1X3rkBs+m0CGImSr17WnBkSeANe66ZjP3eTo1e6/EpfevnoYUL00thAfkKMPyWzGvdRVGR/VOAa1TrT4fLI3m3EdU1CDD5bLGZpo+OzYYOyOQ/juA9rq2B0qSzIAgUomZIILbM5k/7S/aFlDtpPooSRGwh4lA2nYWsu78BmYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJertrqk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJertrqk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943113; x=1745479113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KoReSuUGTuTcwo+VoCABrE1YCpjucTFHTudUH9B6IJ8=;
  b=QJertrqkLVIpxb6AYhgoVp2u47zLUkzLki701wU8Cv2Y3ozTrdgF0eMJ
   BiwOjX44dIu4ybRK+R2qz/sYG3g6Kx1Bi5HD+96dBhzBv5zw5Jn3GF5l7
   SiKIykw+ni2R8yB9GrSlzWLnUj5A7v7LKw1I/W0J1L71Lt6OIWajqt1xC
   lpGutAmWHFge6/hay+0dWy2D1+kVYRK7ObLaKL3eVqIBGq3r/Rni5ibFa
   irSFLub7IxX8C+Apx8XLL5Pq4y/PKL5zRDl+Wt3Wg0NVrilaMmgPRu3Vn
   8Is1h+cI4yR4ntvcJDfnxW3hfRXqPtH67BqVEEyp2AFBxEIjZ7YcpgZDS
   Q==;
X-CSE-ConnectionGUID: I9O1gpIBS6S+2ebNVfufsQ==
X-CSE-MsgGUID: +zsv/DH1Tg6WBDnXXwh1DA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073189"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073189"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:33 -0700
X-CSE-ConnectionGUID: Fw4NHd7KTcGeXH3lfoK7Bw==
X-CSE-MsgGUID: kVFbLdaHSpWoyBQ4XfyhTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24665360"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:30 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/18] iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all
Date: Wed, 24 Apr 2024 15:16:36 +0800
Message-Id: <20240424071644.178250-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flush_iotlb_all callback is called by the iommu core to flush
all caches for the affected domain. Use cache_tag_flush_all() in
this callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240416080656.60968-5-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 473df7cd1672..a268e2a51f4d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1557,25 +1557,7 @@ static void parent_domain_flush(struct dmar_domain *domain,
 
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct iommu_domain_info *info;
-	unsigned long idx;
-
-	xa_for_each(&dmar_domain->iommu_array, idx, info) {
-		struct intel_iommu *iommu = info->iommu;
-		u16 did = domain_id_iommu(dmar_domain, iommu);
-
-		if (dmar_domain->use_first_level)
-			domain_flush_pasid_iotlb(iommu, dmar_domain, 0, -1, 0);
-		else
-			iommu->flush.flush_iotlb(iommu, did, 0, 0,
-						 DMA_TLB_DSI_FLUSH);
-
-		iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
-	}
-
-	if (dmar_domain->nested_parent)
-		parent_domain_flush(dmar_domain, 0, -1, 0);
+	cache_tag_flush_all(to_dmar_domain(domain));
 }
 
 static void iommu_disable_protect_mem_regions(struct intel_iommu *iommu)
-- 
2.34.1

