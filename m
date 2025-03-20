Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC851EDA38
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478469; cv=none; b=pL2yD4amDswMa8ksOPS93JXs0J8rC72pLqcj0jgb2NJ544Aw53H0NvxV2dWGauAwlPRXMvGuyh0nZo/GE1DDfO9etCtdPT6gqv8hrjrWFMSheJ8hUhPerrvLW1nzjE4zG8c6UgrLOlzRJ4oQG/aevvwmKx9HxhjGpvW/k9U4/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478469; c=relaxed/simple;
	bh=sJI7TZAnG5+79Q5t/SAWRhz61HsJbtuNVHfYUwpeeEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dss4nUC/cOI8U0kxwexKbra9GiQaUNmmqCVMgfrpL+BeIJ8Nk6pnJ+8yhQuuuSJnTrrDXqD5Lo9y4qTEngUdXRyLYy4XsUTT/9E0XdXZY1Y6Pn8LC0e1nn2f3F9HmbLo8BHY7kwyQ6XVjN66Ng2brQfzTEdGS+g5K1IFbSfuNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqkkCCXQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqkkCCXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478467; x=1774014467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sJI7TZAnG5+79Q5t/SAWRhz61HsJbtuNVHfYUwpeeEg=;
  b=CqkkCCXQQtUJ2HOiYAAfiTykkVObPD3CvntSp3hNChILPiaGC39AcW4Z
   MxvUKe81KybZDNcTCxWxi9BSFkpO4iG74G5REztRSiBgDtVlCVJPbfaYm
   kyle7uVOKpFJEc2W0UUx69qujM2Q/pC75GIoCYlyx8BF0sn70Qest9XzF
   o8BG+QFpx+P2Aj8yqY8CiMN4V88nO+JSGPvNnBrGBua/hYNNRWhOnjtyA
   O3S8b02myRORAcLwKFqCPDTH51aXfSVi91ACt1RU7+9lX8NBEoi24HFk4
   avi8E5O3JUN892tqh7xF4ACUmusJh33X81ep1HBOQgujk/fI95n/Vhe0R
   g==;
X-CSE-ConnectionGUID: cAB+sMKDRGKdUtTSGr7Hng==
X-CSE-MsgGUID: tW3TueocS4amRbn1pKyNrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063037"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063037"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:46 -0700
X-CSE-ConnectionGUID: eX39VqM1QhutARm+ZLSxHQ==
X-CSE-MsgGUID: 7XnNO38bRSKBQmCAFEDl5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319132"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 06:47:46 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v10 01/18] iommu: Require passing new handles to APIs supporting handle
Date: Thu, 20 Mar 2025 06:47:27 -0700
Message-Id: <20250320134744.5777-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320134744.5777-1-yi.l.liu@intel.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kdoc to highligt the caller of iommu_[attach|replace]_group_handle()
and iommu_attach_device_pasid() should always provide a new handle.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0ee17893810f..cffd96e3efd2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3352,6 +3352,9 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
  * @pasid: the pasid of the device.
  * @handle: the attach handle.
  *
+ * Caller should always provide a new handle to avoid race with the paths
+ * that have lockless reference to handle if it intends to pass a valid handle.
+ *
  * Return: 0 on success, or an error.
  */
 int iommu_attach_device_pasid(struct iommu_domain *domain,
@@ -3512,6 +3515,9 @@ EXPORT_SYMBOL_NS_GPL(iommu_attach_handle_get, "IOMMUFD_INTERNAL");
  * This is a variant of iommu_attach_group(). It allows the caller to provide
  * an attach handle and use it when the domain is attached. This is currently
  * used by IOMMUFD to deliver the I/O page faults.
+ *
+ * Caller should always provide a new handle to avoid race with the paths
+ * that have lockless reference to handle.
  */
 int iommu_attach_group_handle(struct iommu_domain *domain,
 			      struct iommu_group *group,
@@ -3581,6 +3587,9 @@ EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, "IOMMUFD_INTERNAL");
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

