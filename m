Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C9623C9
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 04:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716870474; cv=none; b=jRtIuI1JC3CnO67VeQUNU0ctGGnYH8Eb3OHkS5L2R3oimal9Uef4fugwkfgIfFLYwOz0sMD3RGfY7b1xGCaKxqgHqb/8+14jjImgB+oTQywcRd547Ryb1BecH9zSp5sZcKOs27VoAs6qofSMDzfedMrnSSe+j+YE0XgSOMCbU1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716870474; c=relaxed/simple;
	bh=JCNsiH2D0vh3Vv9zlcQCeIQfB1PxnXtbdN9Go4lozBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pWZGWRuQ/t+TJaKMcSszKYDBAVjMATFtNM0AzaU+Aw6sQ4J6Sn0qyEjdSO91woWaKCQ8aSNBgB2+ZcDpdnI2Ms8p+Bgn5zuWorr7cSXxa4MfQtQuGo7HnfCNxBYcp/oF9Sj061FU6eDb2FYihSXf9quyo6SbwJC0ULCb8m/aqhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6fp9+cL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6fp9+cL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716870473; x=1748406473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JCNsiH2D0vh3Vv9zlcQCeIQfB1PxnXtbdN9Go4lozBY=;
  b=k6fp9+cLamNQm75nhU9pTpi4CBVz0msUnpoPMrGYx90kqQlxxN5CMkAf
   xU2hYXsciY4XIr+QHggLK3jxsMrfz8VsZCZSlel2BCkpT2OH54gOGAwvi
   GVSIF2rbdXE0T37MraDDjB4RO+PZpoT6qIZCtnQVgiiloxPCOFoNLeCxg
   GNsLl2Zv6kmfANnbiASBqzBKpD9lPC2MhyCYpJkDWsh9UYmOBa5dMN1yK
   wsd/7psBR86LMXlgYUmiueRTpuCCVPMfv0zSIkLORLix9Znk4e1uaEbx7
   jpuOQhqUYZqbEdBWEbWlP58hi5sSl/fbGCh5rGTBF//HJQOaQvMX4qGfL
   A==;
X-CSE-ConnectionGUID: KmXa8DOURIu7jVaGOjtCgg==
X-CSE-MsgGUID: f6ysdAAqTrqJ6PmRJVnvSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13381111"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13381111"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 21:27:52 -0700
X-CSE-ConnectionGUID: hNhDtzs5R1aQ43gxieMjtg==
X-CSE-MsgGUID: 6M2XNb6ORK+I29qQ3xiAng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="72345885"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 27 May 2024 21:27:50 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu: Return right value in iommu_sva_bind_device()
Date: Tue, 28 May 2024 12:25:28 +0800
Message-Id: <20240528042528.71396-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_sva_bind_device() should return either a sva bond handle or an
ERR_PTR value in error cases. Existing drivers (idxd and uacce) only
check the return value with IS_ERR(). This could potentially lead to
a kernel NULL pointer dereference issue if the function returns NULL
instead of an error pointer.

In reality, this doesn't cause any problems because iommu_sva_bind_device()
only returns NULL when the kernel is not configured with CONFIG_IOMMU_SVA.
In this case, iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) will
return an error, and the device drivers won't call iommu_sva_bind_device()
at all.

Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7bc8dff7cf6d..17b3f36ad843 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1533,7 +1533,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
-- 
2.34.1

