Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFBB19DF73
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538983; cv=none; b=dpKzA2KtlTIFHclvVc+JIwrC2oJxgB/Sjmu58MrHeB1q0MJYT23XRPkzcXKe4dxJM+ciarlOvu211XUeM1LO71S41mnUkuGIohf97caeaWp1uoBo7z3tYuSyKFGU8ureRRfK2rbf/uVFfthcLZSgS51lEOtnoJJkrTfXUZXJ+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538983; c=relaxed/simple;
	bh=I1LSP78yDNgAjrCn+EJFU50y+ogRvO1jzAZ7VOjf5lE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYkfK5ImXLyQ7cIIyqxv3PNFv/4mYmxRlbOGqUhX7pTeKYl9tNGMBC3G+dDu5hYc+Cfc1gZGuYEbO1bg6sDnZbElfNF5B+FEAArUOBBGBZdoKMEuQmm/Eml5KkdjsZmPlHsgq/HQCPBqF2FCvNuMr1aRZYvxf/mTc5P5CGNAFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WB+jQZ0X; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WB+jQZ0X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720538983; x=1752074983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I1LSP78yDNgAjrCn+EJFU50y+ogRvO1jzAZ7VOjf5lE=;
  b=WB+jQZ0Xh88ZnT++ur0Rm/Hhe0ueYkYXgH4vFgFQp1CR3TjZPtQVN2QA
   ZrrOltLa9O+ThQMownWHLzl3ogRtKK6cX0zhgWwaoQqwhOlvsZih9D3U4
   Rx95Y9jnH0GRWduJ5cnLotKG3D3jHvSdeEqQ9RzDfcmqAxge3D/RZuegQ
   Qr9tBxPxVbQlsdm3SwovzK3X/Qw1jJOPElbn8cJhfHJMlcb2Mp97qyARt
   z5LUTEv0fA/Z2kA+p2wjgh164oYQG7ajmO2WK0kjQRF9en+8dJ9CFr2yp
   MNQqb5A6m6VkfFk+4uZPqy9GpnDaAn55j/di38uVS+vdDOJChATS5QFx1
   Q==;
X-CSE-ConnectionGUID: NvOX1Py4S2OAH3Mc99hFgQ==
X-CSE-MsgGUID: Uqs4t3+LQg6B65tZUWnS/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="40321162"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="40321162"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 08:29:42 -0700
X-CSE-ConnectionGUID: pHa/3vIaT1OtFt9meugppA==
X-CSE-MsgGUID: F954ZRBNQvC3XygO4fD3Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="48618961"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 09 Jul 2024 08:29:40 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Louis Maliyam <louispm@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/2] iommu/vt-d: Fix aligned pages in calculate_psi_aligned_address()
Date: Tue,  9 Jul 2024 23:26:43 +0800
Message-Id: <20240709152643.28109-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709152643.28109-1-baolu.lu@linux.intel.com>
References: <20240709152643.28109-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper calculate_psi_aligned_address() is used to convert an arbitrary
range into a size-aligned one.

The aligned_pages variable is calculated from input start and end, but is
not adjusted when the start pfn is not aligned and the mask is adjusted,
which results in an incorrect number of pages returned.

The number of pages is used by qi_flush_piotlb() to flush caches for the
first-stage translation. With the wrong number of pages, the cache is not
synchronized, leading to inconsistencies in some cases.

Fixes: c4d27ffaa8eb ("iommu/vt-d: Add cache tag invalidation helpers")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 0a3bb38a5289..44e92638c0cd 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -246,6 +246,7 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
 		 */
 		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
 		mask = shared_bits ? __ffs(shared_bits) : MAX_AGAW_PFN_WIDTH;
+		aligned_pages = 1UL << mask;
 	}
 
 	*_pages = aligned_pages;
-- 
2.34.1

