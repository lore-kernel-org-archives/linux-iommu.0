Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109122F1C
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441033; cv=none; b=UgjSf16O+Q20gDXaGaMNQh4yEsV1s2J24GPfiqM8Y0tq9N39FP7mLrHzX64vlzGROcUc84cYpb/0SPuvppV/KrL1te4mnGUVQy4No6Z6KPCzcrmP11MjYQhwEjOPjnPaCkHRfN1IlXx6WRnv97ms9DhzcDxT99KQVYa8tjUp8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441033; c=relaxed/simple;
	bh=QXRPhjyeTJAXjPvsuowDft2z1JMupmKnRIyGAGOAty0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qVL7ec1T3eb913X+smK9BDJqKTQ8iWkPkdRihfdhejiFA2Uu8UfgbGBRfJ2yvxQFQA0rdx8bxMJrz9dr2h55pVVlc0rWezwC7zM+elZvPZfMUztfm8do6xk/GJF9+lebU4JYxWFZzMtO/fvr5JJ0oAxeNl3wWpnHuTNLAj9Oc9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZtLy5Ko; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZtLy5Ko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720441031; x=1751977031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QXRPhjyeTJAXjPvsuowDft2z1JMupmKnRIyGAGOAty0=;
  b=LZtLy5KoiDhJSyaxBtu3RbkZwv8TtVwE64kjgCg9z30JUYk5GfAXvSrh
   +QEffM1v5s2ln2XgVVMGNq3pK5YWvvz0dhXnyF7OEze43BXa3XEZfuGwO
   f+MfkJB5ELEGnwfB69x7jx41OxW9CH6Q8PMXEdQ1/5nqLPcdCpmZFVmDJ
   U3LljzOno3hU8oFT4V+3ZfocGAFBumZOXudVIcGFHpKjwk3K1S3e8iNPV
   lFVXPJ9bGodxJTCSTW70ew1LQVbXRz+5IS3gXXnWQoSQA7nrz/7oBJJGd
   JYxWfm8DRMgb3GjBk7ZdyhsscmpwZY3kg/uE+OFtIvknOrIaYMIYINuny
   Q==;
X-CSE-ConnectionGUID: 9GzxTLXiRjeRv24sBSUk0w==
X-CSE-MsgGUID: PbJz2ClhStCQSoEQfvi2qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17843939"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17843939"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 05:17:10 -0700
X-CSE-ConnectionGUID: AuI47fOlTlC7raMfskdFXg==
X-CSE-MsgGUID: b41/eL8ARr+xZ4B1Tr+nyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="51908113"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 08 Jul 2024 05:17:08 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Louis Maliyam <louispm@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix aligned pages in calculate_psi_aligned_address()
Date: Mon,  8 Jul 2024 20:14:17 +0800
Message-Id: <20240708121417.18705-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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
---
 drivers/iommu/intel/cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index e8418cdd8331..113834742107 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -246,6 +246,7 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
 		 */
 		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
 		mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
+		aligned_pages = 1UL << mask;
 	}
 
 	*_pages = aligned_pages;
-- 
2.34.1

