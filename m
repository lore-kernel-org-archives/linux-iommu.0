Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17E224C5
	for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 09:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694682007; x=1726218007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1mB0Y+KERhzTwiTUZyoz/Hd7O5Mr0RrQQDSegOTdUTo=;
  b=m9DLwCzcGnDaIWply5BCxgULZnFafsE/rc0iQVFmbLuoVb41mU/BW4ZG
   oUL5ywfte82e9dqSiP4XTTc3v15F50P3v7VPFdlLo0fpM1hpAuo1WOoye
   HLr87r3VddnZQp7fbqIMV4IsYwF7o4O3BXyhGaCPd88SSUI+SIzpLvBjr
   qBI0m4wwFd+3vniw++c+scm/dl9ZOAss++tw96kXb554c6XS3Yz1BQxRY
   S23yEoLqjoQLxUjmWPTsKeXv4I/pfpInO3C6vL1+ut2wc7k2N/Tddgln8
   U1P8fcmbtRu4dX+P5ZlIGPY3jTXxhTuF5S6nOomwMF/OG1J+BgtSN73IM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="465266321"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="465266321"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 01:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="859612766"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="859612766"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 14 Sep 2023 01:59:51 -0700
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
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 03/12] iommu: Remove unrecoverable fault data
Date: Thu, 14 Sep 2023 16:56:29 +0800
Message-Id: <20230914085638.17307-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914085638.17307-1-baolu.lu@linux.intel.com>
References: <20230914085638.17307-1-baolu.lu@linux.intel.com>
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
---
 include/linux/iommu.h | 70 +------------------------------------------
 1 file changed, 1 insertion(+), 69 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 895405567f86..1040047982aa 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -48,69 +48,9 @@ struct iommu_dma_cookie;
 
 /* Generic fault types, can be expanded IRQ remapping fault */
 enum iommu_fault_type {
-	IOMMU_FAULT_DMA_UNRECOV = 1,	/* unrecoverable fault */
 	IOMMU_FAULT_PAGE_REQ,		/* page request fault */
 };
 
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
-};
-
 /**
  * struct iommu_fault_page_request - Page Request data
  * @flags: encodes whether the corresponding fields are valid and whether this
@@ -140,19 +80,11 @@ struct iommu_fault_page_request {
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

