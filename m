Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6587FC10
	for <iommu@lists.linux.dev>; Mon, 22 Jan 2024 05:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705902527; cv=none; b=XtkAw+o3m4xfkMsF1H4ODcuxgFFHOTtEXycGCpDLEk7DlwlsHfA0EsIreuSS08HrTpBSUVsB3irLI5r6BKwS18Jp+z6fImUhhenRFQWvf5Jrjz7qPhmIsfjXZbBNse2PXQlqpvtL8lEycGru4D/MzAV9yg8Ogd+a5rpVLh88OPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705902527; c=relaxed/simple;
	bh=zVzhxvqRR0BI96qQJ4hq4Lg0Tgi2Dc/PHhg3c81/aoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=So1MQ5U/vG217HPXxh/Wfm90f2Ku+YFySn+aZHQ5eJdOU5rN0q4Ly4ZRaFMK2rNDThXMh5tQYvtuMFmVl7+P7clJu76tMk0zM3UYuV5piu+ofphn6lv0j4O2HxNDO6qq5xwRyVO1+BfD+/u0Yu9O5glg8RcVYDCcQtPwVf6e4/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/p6gTnQ; arc=none smtp.client-ip=134.134.136.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/p6gTnQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705902525; x=1737438525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zVzhxvqRR0BI96qQJ4hq4Lg0Tgi2Dc/PHhg3c81/aoQ=;
  b=M/p6gTnQMT+Zdu3ub7XsTOKq0qH4LjanyWsSNhhwCyWRMtUbxkhBqhpG
   6MZpx3nSqcX1K2hG699DiHhfLVrT7NCcJZn35aRS5BIABtTbnlBPQIRoW
   BBHejs1/dijzsSAe8nxOJExtIbnZhe+7LnCwudv7ugPKxSqkfUPs5CBU4
   spBsU5HiKjL6SbzGnx6FIMl/kDazzDeqkzl6pU32Q2FiixXI8GvCi+rrf
   6aIm0vQPYsY6UB7esMGa1kSm11MEA6f1ZjXqjV0Q3sVxBuRrQqTXSRaus
   MU8Qdmw2k1/OmACpYIJcmAVOb1gm2F4UP0QPd0WCrQrk/WMYCjuXhgTtR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="467487078"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="467487078"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 21:48:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="1116763888"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1116763888"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jan 2024 21:48:41 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v10 03/16] iommu: Remove unrecoverable fault data
Date: Mon, 22 Jan 2024 13:42:55 +0800
Message-Id: <20240122054308.23901-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122054308.23901-1-baolu.lu@linux.intel.com>
References: <20240122054308.23901-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The unrecoverable fault data is not used anywhere. Remove it to avoid
dead code.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Yan Zhao <yan.y.zhao@intel.com>
Tested-by: Longfang Liu <liulongfang@huawei.com>
---
 include/linux/iommu.h | 72 ++-----------------------------------------
 1 file changed, 2 insertions(+), 70 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 472a8ce029b1..c960c4fae3bc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -50,67 +50,7 @@ struct iommu_dma_cookie;
 
 /* Generic fault types, can be expanded IRQ remapping fault */
 enum iommu_fault_type {
-	IOMMU_FAULT_DMA_UNRECOV = 1,	/* unrecoverable fault */
-	IOMMU_FAULT_PAGE_REQ,		/* page request fault */
-};
-
-enum iommu_fault_reason {
-	IOMMU_FAULT_REASON_UNKNOWN = 0,
-
-	/* Could not access the PASID table (fetch caused external abort) */
-	IOMMU_FAULT_REASON_PASID_FETCH,
-
-	/* PASID entry is invalid or has configuration errors */
-	IOMMU_FAULT_REASON_BAD_PASID_ENTRY,
-
-	/*
-	 * PASID is out of range (e.g. exceeds the maximum PASID
-	 * supported by the IOMMU) or disabled.
-	 */
-	IOMMU_FAULT_REASON_PASID_INVALID,
-
-	/*
-	 * An external abort occurred fetching (or updating) a translation
-	 * table descriptor
-	 */
-	IOMMU_FAULT_REASON_WALK_EABT,
-
-	/*
-	 * Could not access the page table entry (Bad address),
-	 * actual translation fault
-	 */
-	IOMMU_FAULT_REASON_PTE_FETCH,
-
-	/* Protection flag check failed */
-	IOMMU_FAULT_REASON_PERMISSION,
-
-	/* access flag check failed */
-	IOMMU_FAULT_REASON_ACCESS,
-
-	/* Output address of a translation stage caused Address Size fault */
-	IOMMU_FAULT_REASON_OOR_ADDRESS,
-};
-
-/**
- * struct iommu_fault_unrecoverable - Unrecoverable fault data
- * @reason: reason of the fault, from &enum iommu_fault_reason
- * @flags: parameters of this fault (IOMMU_FAULT_UNRECOV_* values)
- * @pasid: Process Address Space ID
- * @perm: requested permission access using by the incoming transaction
- *        (IOMMU_FAULT_PERM_* values)
- * @addr: offending page address
- * @fetch_addr: address that caused a fetch abort, if any
- */
-struct iommu_fault_unrecoverable {
-	__u32	reason;
-#define IOMMU_FAULT_UNRECOV_PASID_VALID		(1 << 0)
-#define IOMMU_FAULT_UNRECOV_ADDR_VALID		(1 << 1)
-#define IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID	(1 << 2)
-	__u32	flags;
-	__u32	pasid;
-	__u32	perm;
-	__u64	addr;
-	__u64	fetch_addr;
+	IOMMU_FAULT_PAGE_REQ = 1,	/* page request fault */
 };
 
 /**
@@ -142,19 +82,11 @@ struct iommu_fault_page_request {
 /**
  * struct iommu_fault - Generic fault data
  * @type: fault type from &enum iommu_fault_type
- * @padding: reserved for future use (should be zero)
- * @event: fault event, when @type is %IOMMU_FAULT_DMA_UNRECOV
  * @prm: Page Request message, when @type is %IOMMU_FAULT_PAGE_REQ
- * @padding2: sets the fault size to allow for future extensions
  */
 struct iommu_fault {
 	__u32	type;
-	__u32	padding;
-	union {
-		struct iommu_fault_unrecoverable event;
-		struct iommu_fault_page_request prm;
-		__u8 padding2[56];
-	};
+	struct iommu_fault_page_request prm;
 };
 
 /**
-- 
2.34.1

