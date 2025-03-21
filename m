Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31822B597
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577585; cv=none; b=d0U1cPXuMPLqaKd5ZTYOMs3kgIXUcgKF8aSCTKUyAMJmujaFgSDCefPqFMc+rpoccqvnxbo3uWIHRWCrcU70XC3P8gRQ62FqyY4i+FqmWpfosqCb1wWxUNtqA7gfIrEgZ9SNJ52LeqH9VWBvrTeX16sXjb/mDP9b8y1spA4qeZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577585; c=relaxed/simple;
	bh=aBC/NcuSbvqS2RRAhE3JcCdGPtHuEuA+iHdYRg5X7+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F02TWO4E5g89VYqfd24ZYni6HXyFdT1lAtOIqfAdAriJs3COKce9nNr7MKAMX/Avr7itQiTk85m3dH3WXsEqgDt9r2DKbWPcbfnoFw+WEI6h/hrH2ZWCCTsEVLgrqru3HJXK7w+BS/Xpr4k2Vk0YtGYn1LooL1w1w6+nu05WaGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5zra1Fe; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5zra1Fe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577584; x=1774113584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aBC/NcuSbvqS2RRAhE3JcCdGPtHuEuA+iHdYRg5X7+c=;
  b=Q5zra1FeK45AzQk7mVwgRUDlnRTKgUfteAdSTh/em/ZJR3M+BlbkgNo4
   QOjyHGK1Pw78u2M4BE9jnKmRyZ7XLHnSpcx9VD0lDfO0fVOGwW7jdVyiF
   u/Is3WjQWPG7GJ4dHq1zj6JCYvBTGoa+TacmLU24acSMCWSjdydqGYaq4
   wcyQ2GhzUGWwX+Yx+LlXWIrrUxAJiO+RCC9Oafuc8ybMSr+GEYlsXF9DW
   XjcVrglFcRGtOlG2yJHnQTfToMNv9JIbSD2HyQVc6WAtQUNr7ganxXwjg
   6y0UDS/Fl+zxoN1PJU7oRgePpwto6KY64kYb14wbvdhUHj2LaDdlLz8pq
   w==;
X-CSE-ConnectionGUID: o9wangWgRYeGt6pKor66WQ==
X-CSE-MsgGUID: LAiCVZD4QcOFr4Ccmf7tug==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976779"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976779"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:42 -0700
X-CSE-ConnectionGUID: fOop2U17TBe9/LJ930ArTw==
X-CSE-MsgGUID: XI63lRwQT/aJVN455nwtwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914414"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 10:19:41 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v11 01/18] iommu: Require passing new handles to APIs supporting handle
Date: Fri, 21 Mar 2025 10:19:23 -0700
Message-Id: <20250321171940.7213-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321171940.7213-1-yi.l.liu@intel.com>
References: <20250321171940.7213-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kdoc to highligt the caller of iommu_[attach|replace]_group_handle()
and iommu_attach_device_pasid() should always provide a new handle. This
can avoid race with lockless reference to the handle. e.g. the
find_fault_handler() and iommu_report_device_fault() in the PRI path.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0f4cc15ded1c..9f1db10645ee 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3365,6 +3365,9 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
  * @pasid: the pasid of the device.
  * @handle: the attach handle.
  *
+ * Caller should always provide a new handle to avoid race with the paths
+ * that have lockless reference to handle if it intends to pass a valid handle.
+ *
  * Return: 0 on success, or an error.
  */
 int iommu_attach_device_pasid(struct iommu_domain *domain,
@@ -3525,6 +3528,9 @@ EXPORT_SYMBOL_NS_GPL(iommu_attach_handle_get, "IOMMUFD_INTERNAL");
  * This is a variant of iommu_attach_group(). It allows the caller to provide
  * an attach handle and use it when the domain is attached. This is currently
  * used by IOMMUFD to deliver the I/O page faults.
+ *
+ * Caller should always provide a new handle to avoid race with the paths
+ * that have lockless reference to handle.
  */
 int iommu_attach_group_handle(struct iommu_domain *domain,
 			      struct iommu_group *group,
@@ -3594,6 +3600,9 @@ EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, "IOMMUFD_INTERNAL");
  *
  * If the currently attached domain is a core domain (e.g. a default_domain),
  * it will act just like the iommu_attach_group_handle().
+ *
+ * Caller should always provide a new handle to avoid race with the paths
+ * that have lockless reference to handle.
  */
 int iommu_replace_group_handle(struct iommu_group *group,
 			       struct iommu_domain *new_domain,
-- 
2.34.1

