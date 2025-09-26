Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB294262FC7
	for <iommu@lists.linux.dev>; Fri, 26 Sep 2025 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854648; cv=none; b=NdxQsuGCn9arIUrmLv68z0bengdq3sQGRNPXHHqBzWLzYoajYgJPiZCuwBnkQhsDN3RqnzFOTbNCCWoi7NEY0hewrFAFpQvwQJtYsZxZd7Gj2i24Hr5Er34Kg9EXQmTUGmQ0BaQcPzbF4CQla4uXey4kj11QsC335XX7pChF5Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854648; c=relaxed/simple;
	bh=G+ZNWyhNDZ5SJ4NU2vX1gGBSoCE5lXQnpYps0DuuM4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTrANsXJJO/3f9Bs7o6YEjJ8w8DQVTniJ5tQlzsdFa6O9INMNMLrhfUNPrl3jL4ZlnilvzzJl4d9RhXTPEuc713Pg4vSGWQMOsPnqVRXNYJWGZyrWoWAf3b+ULhWVIZn1pp/eykYN2KcrVRpHq7+kFB367fsXtLCw9a0NS3zoFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXuzvvKu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXuzvvKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758854647; x=1790390647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G+ZNWyhNDZ5SJ4NU2vX1gGBSoCE5lXQnpYps0DuuM4c=;
  b=EXuzvvKuWqcC57eo/tZuO8xP1PtkSOxmpLnTko4An/oLYoHpNoqYKrc/
   AA6v9Z+OnTxZ0GqmLpuIqFIX2Tgbd7TKzpGyn2oHzgLXeTSXC6N+4nu56
   tf8WdOAWAEeWtKI6I1tXhcAZxsDTvjkswkvFjSwJ6ERCihx09m+0pQp6B
   txrXTnwdS3uFPQHEY+EmabUVqxUin9OkgboHYtr0atPwbBeT6th+g/3nj
   BXZejN9LwQearFEYwr1FqgWgMn+KrlYWEGDMbP1/S1s+o6Iz2thIscyYS
   qWtDOW6E0fkwUhQjUnkWcxbMCGJU4OI1K5yWnz3KFweVa99VosbqW+YfS
   g==;
X-CSE-ConnectionGUID: fzclgFiNTLayURr0S2q08w==
X-CSE-MsgGUID: 5w7IWEegRhuZeg7scywJNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61354319"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="61354319"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 19:44:05 -0700
X-CSE-ConnectionGUID: pzjo42XoQ4OSPhizOvOqqA==
X-CSE-MsgGUID: w+WTvpYGT2W/CIgLXQWOKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177948781"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa009.fm.intel.com with ESMTP; 25 Sep 2025 19:44:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Disallow dirty tracking if incoherent page walk
Date: Fri, 26 Sep 2025 10:41:30 +0800
Message-ID: <20250926024130.157514-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926024130.157514-1-baolu.lu@linux.intel.com>
References: <20250926024130.157514-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dirty page tracking relies on the IOMMU atomically updating the dirty bit
in the paging-structure entry. For this operation to succeed, the paging-
structure memory must be coherent between the IOMMU and the CPU. In
another word, if the iommu page walk is incoherent, dirty page tracking
doesn't work.

The Intel VT-d specification, Section 3.10 "Snoop Behavior" states:

"Remapping hardware encountering the need to atomically update A/EA/D bits
 in a paging-structure entry that is not snooped will result in a non-
 recoverable fault."

To prevent an IOMMU from being incorrectly configured for dirty page
tracking when it is operating in an incoherent mode, mark SSADS as
supported only when both ecap_slads and ecap_smpwc are supported.

Fixes: f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domains")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20250924083447.123224-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d09b92871659..2c261c069001 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -541,7 +541,8 @@ enum {
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
 				 ecap_pasid((iommu)->ecap))
 #define ssads_supported(iommu) (sm_supported(iommu) &&                 \
-				ecap_slads((iommu)->ecap))
+				ecap_slads((iommu)->ecap) &&           \
+				ecap_smpwc(iommu->ecap))
 #define nested_supported(iommu)	(sm_supported(iommu) &&			\
 				 ecap_nest((iommu)->ecap))
 
-- 
2.43.0

