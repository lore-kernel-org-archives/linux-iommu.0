Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C432B14AD09
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 02:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333098; cv=none; b=ObTxJstVOQCPBs8I6G+6x/xBTCplIJ4crwhe7fTD3HlXW7jvPk8gSwzzxB1jiSndN10vPgYZnM8hlT6MOewashzxMXfP1ssAUbBg9nkmhEmRBDr2+COfgur3tLyhTiFTk8EQgXMxPAb/oVawxJM0yuS2TXPJXt1xfqzRAxTiVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333098; c=relaxed/simple;
	bh=+OAkQ+xgV6iFnsM2Piz46SFV5ZnSYjQLnEdHmWb5riU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6zK7K9Dfs15eaWui5FNTMoj27ZLoCSTbAjBFRcW8vEHzO4JlBCB5d1LSRNUDlIy86O4KAbdpMTjgH3ys71rHxs4Q5bNkBRTYjGPQBgcAaNKRDXdXPo+en1yZsiGgz3DcZ2YdXWhaFVquFSMjATPw/STccSflS/L4rS0Jiy3LsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXMxDa+6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXMxDa+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711333096; x=1742869096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+OAkQ+xgV6iFnsM2Piz46SFV5ZnSYjQLnEdHmWb5riU=;
  b=lXMxDa+6iFrC7dNFH2kd5vdK7M5ueGsDCXsNITeiAHUrE3o6niBolrVZ
   0PLnyKqv5j8M4DA1BNkk1N5Rhh040jNeh4dKtStbiDVgBoKpbv43U+h2r
   pezD3NQdM/TATcz5lNluUt3yta8T+Lepx4N56tr9BWEJ6Z1JPwyC18V/l
   ZK3a2pLcURD5OA32Zohe8Cp/anhxZbrzbu3uh/MHqJbCj5uUTlmdaBBSD
   nw0uyz5AYFFvLXlCRtRHFZYuQ6XWk+mqm+4Y8DzRXATIse8fNVMYgxhiO
   TzWn9xNW0zdiaG+KY5LtnpSXTYttlQqYVe0Wgrna/oe9XLsH0coTLT+3D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9271360"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9271360"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:18:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15353954"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2024 19:18:12 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 05/12] iommu/vt-d: Use cache_tag_flush_range() in tlb_sync
Date: Mon, 25 Mar 2024 10:16:58 +0800
Message-Id: <20240325021705.249769-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325021705.249769-1-baolu.lu@linux.intel.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tlb_sync callback is called by the iommu core to flush a range of
caches for the affected domain. Use cache_tag_flush_range() in this
callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4ce98f23917c..1c03d2dafb9d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4112,25 +4112,8 @@ static size_t intel_iommu_unmap_pages(struct iommu_domain *domain,
 static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 				 struct iommu_iotlb_gather *gather)
 {
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	unsigned long iova_pfn = IOVA_PFN(gather->start);
-	size_t size = gather->end - gather->start;
-	struct iommu_domain_info *info;
-	unsigned long start_pfn;
-	unsigned long nrpages;
-	unsigned long i;
-
-	nrpages = aligned_nrpages(gather->start, size);
-	start_pfn = mm_to_dma_pfn_start(iova_pfn);
-
-	xa_for_each(&dmar_domain->iommu_array, i, info)
-		iommu_flush_iotlb_psi(info->iommu, dmar_domain,
-				      start_pfn, nrpages,
-				      list_empty(&gather->freelist), 0);
-
-	if (dmar_domain->nested_parent)
-		parent_domain_flush(dmar_domain, start_pfn, nrpages,
-				    list_empty(&gather->freelist));
+	cache_tag_flush_range(to_dmar_domain(domain), gather->start,
+			      gather->end, list_empty(&gather->freelist));
 	put_pages_list(&gather->freelist);
 }
 
-- 
2.34.1

