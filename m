Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95198158D67
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943105; cv=none; b=PtiCKQtgif66Ymn1IFvGDFu+1do8jgM0z3hYbiFYh2qSLSe3mA0UqOkiNexa9FCy8rS+M8NCzEiu4oY6MAg6vKEuFTS1v3f3wXKhKHg7228WF1fFyL3CjPTwCd9LG9JhTUHzYpFuWzLfPYinmItLJ76E/ucQrjXGFWH/iYHN4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943105; c=relaxed/simple;
	bh=2el32v6PbFM1izdUwswDL+IqdAUipzm4KhD0i1uLmf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C4E2rJFsMizPy/xGVQNrTICE3CYe7u5EsfzQqxAMTZl7jOWkoPdXlty2JgNXoDukNNwEOPzNILR3yoQ2BQDeAOw002Ipk03TNETZRQ04JMUTGZP/VT8V4vQJ3VHBBj4Pv97UrDYi1PLKnqZ7T1dyimcSdiOjh3i0D01UzV1mPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PstxdpEs; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PstxdpEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943104; x=1745479104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2el32v6PbFM1izdUwswDL+IqdAUipzm4KhD0i1uLmf4=;
  b=PstxdpEstR8NfGhR/O0wb+QdH3hWy6Yp3GxG9e72Rt77DaLAhJ172bXP
   kzAHicCS7Ss1Ewx5t3DWozi+P4ad6de9Kuk85fvZPldO7if/Qw9EJTCs7
   e2v+lxraGWkZE7EBEl8pJtBv4boTjO/l1RdCzfGO4ZY2HY8woa5gciMDF
   j1yu3vTWkKawuwUAhDIoINOdv5JNFI5SWTJCKCqMxQP6nw3aUYAoCu+PI
   1LC6THwr6IIv443QLcx7455XEp3DVVEWAAESzl1Oe/GMGwPcH+6+3TJgs
   QQLq4Xdi/pusualiAHA5sYXJUancj9GIL1hZaDQjXcGfqqNXGqhAtPrVB
   g==;
X-CSE-ConnectionGUID: zyZtjbnDT9CeWT17egmwtQ==
X-CSE-MsgGUID: qOe8QHikTU6fdcVGVskQbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073145"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073145"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:23 -0700
X-CSE-ConnectionGUID: kD0RiTELTke+w+KJLVu7hg==
X-CSE-MsgGUID: BzGPy8T7TQ61KN/nLZrW8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24665014"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:21 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/18] iommu/vt-d: Remove caching mode check before device TLB flush
Date: Wed, 24 Apr 2024 15:16:32 +0800
Message-Id: <20240424071644.178250-7-baolu.lu@linux.intel.com>
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

The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
implementation caches not-present or erroneous translation-structure
entries except for the first-stage translation. The caching mode is
irrelevant to the device TLB, therefore there is no need to check it
before a device TLB invalidation operation.

Remove two caching mode checks before device TLB invalidation in the
driver. The removal of these checks doesn't change the driver's behavior
in critical map/unmap paths. Hence, there is no functionality or
performance impact, especially since commit <29b32839725f> ("iommu/vt-d:
Do not use flush-queue when caching-mode is on") has already disabled
flush-queue for caching mode. Therefore, caching mode will never call
intel_flush_iotlb_all().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20240415013835.9527-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4a2afe89b464..002fee5fcb80 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1502,11 +1502,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	else
 		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
 
-	/*
-	 * In caching mode, changes of pages from non-present to present require
-	 * flush. However, device IOTLB doesn't need to be flushed in this case.
-	 */
-	if (!cap_caching_mode(iommu->cap) || !map)
+	if (!map)
 		iommu_flush_dev_iotlb(domain, addr, mask);
 }
 
@@ -1580,8 +1576,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						 DMA_TLB_DSI_FLUSH);
 
-		if (!cap_caching_mode(iommu->cap))
-			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
+		iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
 	}
 
 	if (dmar_domain->nested_parent)
-- 
2.34.1

