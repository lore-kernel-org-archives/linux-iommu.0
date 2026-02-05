Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2E36E48C
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281524; cv=none; b=YkLsKCAOkhpKKOZy26+RMEiuuwhEIaQVPW5Y1VOK1aT91jGe3bYx92PVTmuZ8I7CcoLYxeFxEF/pDBD0ptPGZuBYRfVCs2Av4W7N9DJaFXtKAQQfHQbG0KHVcfvUmlmZLk4EcCvHswtF+XO6yKMMnJL97IF2PJdiMmKyw86LA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281524; c=relaxed/simple;
	bh=BICD/36k+pC1OlBLC4/zRhXAakMkN8TFncwB090TR58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phr+Hq2Kg6EEmKNC6qKkVRJOa7bWqS/lodM7abZHiy1ziS0JTbxxXp2X0FSbrWwoaav/AQimdX4r+lSRs+ET205F7EU7GBFGZgLjWkfcs0ccytG5/55fUNqnpZQwzAg1TjbksloRMfKQ91ckM4u8zYqh8nDJ+5ZN05Sm8QYoj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tpp6MLKZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tpp6MLKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770281525; x=1801817525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BICD/36k+pC1OlBLC4/zRhXAakMkN8TFncwB090TR58=;
  b=Tpp6MLKZ0poF23mqXLnHZbiJ6kLZySFr+ZTXio9mKLCtH0astogoqmsM
   tE0cSWSq8wrdbYIJTWWjJO/mpyttAYkG6QrxiAl18bXKYoD5ZwkQEZ4W3
   nHzMzQRfaykA2wngHoBGxvmZ1Hu/PzWQpkID7LRfwVWhlccTF2MEHJ/7W
   +3w+g3S+HKQq5eLBupGM6kse6wkHIvGcZVb0OVYmeIaBcLau9u0SVZAnj
   N3jJBONTfaXGEGi/8lZdsdRdBI69DPc7M7X/K8/t8ul7iIkGzrQ99R7OX
   hb6ejcfP58C9gjvkzY/ooW+IrOUBRPNOvAQthfUqTj9tMJXU1RKFLP3H7
   g==;
X-CSE-ConnectionGUID: NJunpDLzQzqBXfEa66xUJA==
X-CSE-MsgGUID: fSMbb/hZRwWzlO0p6gNpKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71372074"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71372074"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:52:05 -0800
X-CSE-ConnectionGUID: ikqDyeXATF6+MHV9CbtbUg==
X-CSE-MsgGUID: u53dqf3tQnOjy9znwk+eTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210391638"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa010.fm.intel.com with ESMTP; 05 Feb 2026 00:52:03 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Viktor Kleen <viktor@kleen.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Treat PAGE_SNOOP and PWSNP separately
Date: Thu,  5 Feb 2026 16:49:41 +0800
Message-ID: <20260205084941.3982847-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205084941.3982847-1-baolu.lu@linux.intel.com>
References: <20260205084941.3982847-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viktor Kleen <viktor@kleen.org>

The PASID_FLAG_PAGE_SNOOP and PASID_FLAG_PWSNP constants are identical.
This will cause the pasid code to always set both or neither of the
PGSNP and PWSNP bits in PASID table entries. However, PWSNP is a
reserved bit if SMPWC is not set in the IOMMU's extended capability
register, even if SC is supported.

This has resulted in DMAR errors when testing the iommufd code on an
Arrow Lake platform. With this patch, those errors disappear and the
PASID table entries look correct.

Fixes: 101a2854110fa ("iommu/vt-d: Follow PT_FEAT_DMA_INCOHERENT into the PASID entry")
Cc: stable@vger.kernel.org
Signed-off-by: Viktor Kleen <viktor@kleen.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20260202192109.1665799-1-viktor@kleen.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index c3c8c907983e..48d3bb6b68de 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -24,7 +24,7 @@
 
 #define PASID_FLAG_NESTED		BIT(1)
 #define PASID_FLAG_PAGE_SNOOP		BIT(2)
-#define PASID_FLAG_PWSNP		BIT(2)
+#define PASID_FLAG_PWSNP		BIT(3)
 
 /*
  * The PASID_FLAG_FL5LP flag Indicates using 5-level paging for first-
-- 
2.43.0

