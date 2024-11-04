Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230071AAE2E
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684506; cv=none; b=nPU6Qv0PDMOpdFeSrYdKpnclWVbvAi3NV+EwU3UvVI1NCSt++OT2gzOLj3F+s9NPxAinz+fZkbFrd8jmN0EqWiL2aHZnjWf7QzTddVSOisQmLADrdCIsme6U/cmhjq+aHlfwE1YXNwY7tISy9J3BZkpm68V2vOjEuxSzeOd+4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684506; c=relaxed/simple;
	bh=0KV7c1D1QL3EImU0brValucO34r/fOfDt8Ru1QiIY/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpE9YURNX5F4WW798zUq8H0oz0fpneLQUts78jkNZdiZVFv66bHyDBDPjNsmpI+nOjGBisebKGFSZQJ0Po3xiWm0TI2Hmg0uk3e1752VM4vSOOXx/vWfVokuX9jEHezuHonOKvy7QBdN1AfW1ZFTi6ucWVurVTSR248mZ4Aq42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bf7vh8OV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bf7vh8OV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684505; x=1762220505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0KV7c1D1QL3EImU0brValucO34r/fOfDt8Ru1QiIY/Y=;
  b=Bf7vh8OVppO50sCZz/y+wj+ZAZ3So125NlCyxzW4bBPAcCgvjCZA+vtA
   TopSeIeCVpEDaAOxKAZYjH+eMDL+TPAITVNXKNkho9zKg8JssXjbfmn3j
   M1Zf6TzWXZvK66jOouW8lCijHnYrryAXyqLP5mqGqN73R7cM6TpgkVKFL
   rkZ0ael0px+tV9/n0WEBJFMz+oP1LJpnuvAl4q/p+ycLsSYBH5J2Ki1lH
   12FD1czZ/Rer1N7OE9/SAl3iRQuDaGhb0npaOr0lcsEuyfSV6sNsPHLd+
   aU8kNOJz9os5tk9HDlx3F6HWuxxA2iz0wdjN/LI2xod/4Plcgl7x/at9B
   A==;
X-CSE-ConnectionGUID: CtQJvUUNRVabq/fRvqWCYA==
X-CSE-MsgGUID: ZEyhH7UrQ6eoki+P6hoNRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221963"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221963"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:45 -0800
X-CSE-ConnectionGUID: 9Fl6RROfT6ygxbtE+gvqkA==
X-CSE-MsgGUID: nhOoNZk+TEivkZEZGzRLlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020908"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:44 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/19] iommufd: Enable PRI when doing the iommufd_hwpt_alloc
Date: Mon,  4 Nov 2024 09:40:37 +0800
Message-ID: <20241104014040.106100-18-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joel Granados <joel.granados@kernel.org>

Add IOMMU_HWPT_FAULT_ID_VALID as part of the valid flags when doing an
iommufd_hwpt_alloc allowing the use of an iommu fault allocation
(iommu_fault_alloc) with the IOMMU_HWPT_ALLOC ioctl.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Joel Granados <joel.granados@kernel.org>
Link: https://lore.kernel.org/r/20241015-jag-iopfv8-v4-4-b696ca89ba29@kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c          | 3 ++-
 drivers/iommu/iommufd/hw_pagetable.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3a20795b3f8d..1e432729ea09 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3317,7 +3317,8 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	}
 
 	if (flags &
-	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
+	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING
+	       | IOMMU_HWPT_FAULT_ID_VALID)))
 		return ERR_PTR(-EOPNOTSUPP);
 	if (nested_parent && !nested_supported(iommu))
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index d06bf6e6c19f..8f020bc0815f 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -107,7 +107,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  const struct iommu_user_data *user_data)
 {
 	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
-				IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+				IOMMU_HWPT_FAULT_ID_VALID;
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
-- 
2.43.0

