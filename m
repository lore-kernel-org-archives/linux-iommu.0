Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143A328B6
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347470; cv=none; b=N2VyukEZMqKdVzxRHQs9S+FEzqtjJs5shVOrUDwsk2VkuzsFUUqraZfNCQLYWvRNY1yWzkCmkFzG861giiIYDFsK2/bAi8+qR00p8OkxtT3z/Ux3zfRyChTUxP4+Mh0ZwL/pfaG+i1dfh8lPKbSJAeJkA9C3zNtJfNcUdDEu7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347470; c=relaxed/simple;
	bh=dlUwIJT2xzI/BgUkqgsg8fXAbIQo5TBtMtcnfZmezRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uomvDfsuf6prIq4MTy2ctmCv3CBWeER2x9kvNW1VtUvoBne9K/rrM0ng2asOeY4N2Y9dyv6VzREW9SHLIWRGEZHAv7dwsX0zAtaLqYstq2dHsPquNljzCuHK9UgrewADxKBWo9EFwKpzwaEXRXAa23G04SaYTMXUzfs8CmJ/nFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWFfbH2g; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWFfbH2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347468; x=1739883468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dlUwIJT2xzI/BgUkqgsg8fXAbIQo5TBtMtcnfZmezRM=;
  b=FWFfbH2gc5UYxD1u7QoDjEqejneqJFVEt5kuQPikIR5vMPyN+4dK8nx+
   PpVbIomA+0USZ9dI2ZW9CnzU6atY65qQHWlOAG/C7cr+qNz89Py3Ak0Rt
   XlJM245P7iJlgSD8uceJrfk/cskSgyyJDBSk36wLqyzAepkjBQk2/kEz6
   2XDWZYLL2HeSMs0uBW9+89fA9RfMg/yGg+jvpJ+IacH1uw04xcNR8LgiZ
   eQyMufKvtmNjaHgOEUU0HnmMdxdkKVL+qIZW0V7qqz5OpFy3SyvjGkZ/J
   qFA+8GYsX/wXJczhan79/oB94/2yiaKgzkRR+/wnldkTny5BSNSnnRJmO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2296443"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2296443"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4449286"
Received: from zhaojia-mobl2.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.255.28.137])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:46 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 05/13] iommu: Add ops->domain_alloc_sva()
Date: Mon, 19 Feb 2024 20:57:15 +0800
Message-Id: <20240219125723.1645703-6-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219125723.1645703-1-tina.zhang@intel.com>
References: <20240219125723.1645703-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

Make a new op that receives the device and the mm_struct that the SVA
domain should be created for. Unlike domain_alloc_paging() the dev
argument is never NULL here.

This allows drivers to fully initialize the SVA domain and allocate the
mmu_notifier during allocation. It allows the notifier lifetime to follow
the lifetime of the iommu_domain.

Since we have only one call site, upgrade the new op to return ERR_PTR
instead of NULL.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[Removed smmu3 related changes - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Tina Zhang <tina.zhang@intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/iommu-sva.c |  4 ++--
 drivers/iommu/iommu.c     | 12 +++++++++---
 include/linux/iommu.h     |  3 +++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index c3fc9201d0be..446ce5a0cae8 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -99,8 +99,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	/* Allocate a new domain and set it on device pasid. */
 	domain = iommu_sva_domain_alloc(dev, mm);
-	if (!domain) {
-		ret = -ENOMEM;
+	if (IS_ERR(domain)) {
+		ret = PTR_ERR(domain);
 		goto out_free_handle;
 	}
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d14413916f93..f9a2b8363ad9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3629,9 +3629,15 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
 
-	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
-	if (!domain)
-		return NULL;
+	if (ops->domain_alloc_sva) {
+		domain = ops->domain_alloc_sva(dev, mm);
+		if (IS_ERR(domain))
+			return domain;
+	} else {
+		domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
+		if (!domain)
+			return ERR_PTR(-ENOMEM);
+	}
 
 	domain->type = IOMMU_DOMAIN_SVA;
 	mmgrab(mm);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1ea2a820e1eb..be5b51fc3af4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -419,6 +419,7 @@ static inline int __iommu_copy_struct_from_user_array(
  *                     Upon failure, ERR_PTR must be returned.
  * @domain_alloc_paging: Allocate an iommu_domain that can be used for
  *                       UNMANAGED, DMA, and DMA_FQ domain types.
+ * @domain_alloc_sva: Allocate an iommu_domain for Shared Virtual Addressing.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -459,6 +460,8 @@ struct iommu_ops {
 		struct device *dev, u32 flags, struct iommu_domain *parent,
 		const struct iommu_user_data *user_data);
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
+	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
+						 struct mm_struct *mm);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
-- 
2.34.1

