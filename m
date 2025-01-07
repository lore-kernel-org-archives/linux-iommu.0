Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE72E156C72
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216392; cv=none; b=dCGDHj3vGAnGbJp3YwJsHCo+P0oXmF0lhvxmNQfa8qKwLuKHhy6UAqtf+pHtS2lm3/56NL366JRqeuLagoBwXfLzwbpgQJK9TOx+embikWdjf07Ft5zjOCQgwVXec3hrU/NV07UWR412ADgVB3Une4kEQBUrXrDoX6ldw2aTqVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216392; c=relaxed/simple;
	bh=v+gxzQLhRCnWzXpALBvau/2zPFAHrctBAqPx1vmEuJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwE/DL0lsq3DcEhnqp4yu5KGhzjKSC7LSY9GoHW42SJnE1BQTI5aWDKRv5+M2xGFNEZD20fAX/33UtBLSLTmBeHzWzp51l4Gx14DvvNvYxOcYSnsmh6BvjUtgnnOX+INEWk3CJRLoFNXQ3pjfX70tgWLSSFkCRvU2BYQqquQvaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U571tiTi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U571tiTi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736216390; x=1767752390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v+gxzQLhRCnWzXpALBvau/2zPFAHrctBAqPx1vmEuJg=;
  b=U571tiTirA0x4R4pi/3tAIQKA+H73tsTFCoyrSG+5ULdd5Cgt0fM9LLO
   NnmlOJK5rXro48U8C27cWO9EQ9luN8aDncdo5ynyj9Q0KlRWywOB2DbaD
   Du6AABxESqG1puCw2+8hfienymWLdE3iM1VRk3ecsFbHKhiUbTAu/B+P9
   dZPpDzF2ZSbo5Pbnk67FaJDF/4yJtwm+TR+MdXnGtIVRVG13E14Z454QE
   m6s1zX1ARhy0jUpvUVzTBB1j4YBiXcRJRu2PZXDoulg1Fpqp2NbM/MEv+
   u2p65GZMjAaQdo2B54cwYZdFld2Vt6exLHvpmbcqJVN8l7Wx/VP6KSvr9
   A==;
X-CSE-ConnectionGUID: CCdHNhlZTMC5NPQpLW10BA==
X-CSE-MsgGUID: fyeMjR8HSwm2cytwEgGYJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="47800772"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="47800772"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 18:19:49 -0800
X-CSE-ConnectionGUID: pGU9cDq0SM2DIioAKDeepw==
X-CSE-MsgGUID: s5k6qgkYRfC2hXvFf6wa2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="102442937"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa009.jf.intel.com with ESMTP; 06 Jan 2025 18:19:48 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kees Bakker <kees@ijzerbout.nl>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] iommu/vt-d: Remove domain_alloc_paging()
Date: Tue,  7 Jan 2025 10:17:43 +0800
Message-ID: <20250107021746.6908-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107021746.6908-1-baolu.lu@linux.intel.com>
References: <20250107021746.6908-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

This is duplicated by intel_iommu_domain_alloc_paging_flags(), just remove
it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Link: https://lore.kernel.org/r/0-v1-b101d00c5ee5+17645-vtd_paging_flags_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8f75c11a3ec4..113c66dcc32e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4446,21 +4446,6 @@ static struct iommu_domain identity_domain = {
 	},
 };
 
-static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu = info->iommu;
-	struct dmar_domain *dmar_domain;
-	bool first_stage;
-
-	first_stage = first_level_by_default(iommu);
-	dmar_domain = paging_domain_alloc(dev, first_stage);
-	if (IS_ERR(dmar_domain))
-		return ERR_CAST(dmar_domain);
-
-	return &dmar_domain->domain;
-}
-
 const struct iommu_ops intel_iommu_ops = {
 	.blocked_domain		= &blocking_domain,
 	.release_domain		= &blocking_domain,
@@ -4469,7 +4454,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc_paging_flags = intel_iommu_domain_alloc_paging_flags,
 	.domain_alloc_sva	= intel_svm_domain_alloc,
-	.domain_alloc_paging	= intel_iommu_domain_alloc_paging,
 	.domain_alloc_nested	= intel_iommu_domain_alloc_nested,
 	.probe_device		= intel_iommu_probe_device,
 	.release_device		= intel_iommu_release_device,
-- 
2.43.0

