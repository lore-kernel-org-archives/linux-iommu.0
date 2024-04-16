Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321E515B96E
	for <iommu@lists.linux.dev>; Tue, 16 Apr 2024 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254932; cv=none; b=uMLhA2fNZh9sBadQVRB3tHJNmyMMJpWfyIU9wmkeh2Im10p0YnZ4MPKZwuyxHdgaS2reESy8Tk4fGgm3gOz3buDDL3XW8G3F4RStlDOHvh+NbrNMuz3YBIHxUAdX0bpcVuBCHDxewFe+YmKgW+KlCUXqKUU0zW4WDmB2qxeEnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254932; c=relaxed/simple;
	bh=Z4N9WjZXB3Uq7GgVWrBbRtPl6f+yBep/k+sWPTppZwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PoI6QENmHEtbvDODBAdkUCJqf4KUIO6JOO1IIMmpkx2kZwq7dmV5McqV86WEJpobnUttSynpU871xu2PRQfLhif4epvG8kNnXSl2avCb7tPdh0K8ftq1Il8z684JOpzVKiP016bUtgJLEeKE21rbGQm05wxUlbz023zNjT+bo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdmJgpIK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdmJgpIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713254927; x=1744790927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z4N9WjZXB3Uq7GgVWrBbRtPl6f+yBep/k+sWPTppZwU=;
  b=KdmJgpIKQZRuTMsbgCsXWoBG5NdPnvxPm66cnqKkf5AEVXwDCHRzfkxh
   B4AJhy6/3cuonmbHc/4KlhrU8PXX0FhlYIppVZdBTXLvYHxj9DtrXhoKn
   IiKJhV+a1CZnfto9iZQk26PCELCKRqAXmpcfOP3oiJq534gOIAz0liwkq
   C4Qt0vdWrNoODaWu7+16zDqGc4WP4NiCFgwjco8iTDq3zEehWLyjNzfhI
   V6jBAbBL9IyYvtV/778p3I5LivNJNh0b0Hu4nVfK58pzbd/uiaDE51rBS
   fr2D8C1ySmY4DSBtrLnkx1O4YfXBhcASxnp/PbEtbJbNQAgqyR1NC4rTT
   Q==;
X-CSE-ConnectionGUID: Vc9r3mn7Q8+ViyMXZp3BPw==
X-CSE-MsgGUID: YRqhl+QAT5GeLcTrVP61rQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12466525"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="12466525"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 01:08:46 -0700
X-CSE-ConnectionGUID: +VKNFbdXT/i4PH7AfuCYlg==
X-CSE-MsgGUID: kawcI395Sd+K5pNvLYc6cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22077831"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 16 Apr 2024 01:08:44 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 11/12] iommu: Add ops->domain_alloc_sva()
Date: Tue, 16 Apr 2024 16:06:55 +0800
Message-Id: <20240416080656.60968-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416080656.60968-1-baolu.lu@linux.intel.com>
References: <20240416080656.60968-1-baolu.lu@linux.intel.com>
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
Link: https://lore.kernel.org/r/20240311090843.133455-15-vasant.hegde@amd.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h     |  3 +++
 drivers/iommu/iommu-sva.c | 16 +++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2e925b5eba53..8aabe83af8f2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -518,6 +518,7 @@ static inline int __iommu_copy_struct_from_user_array(
  *                     Upon failure, ERR_PTR must be returned.
  * @domain_alloc_paging: Allocate an iommu_domain that can be used for
  *                       UNMANAGED, DMA, and DMA_FQ domain types.
+ * @domain_alloc_sva: Allocate an iommu_domain for Shared Virtual Addressing.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -558,6 +559,8 @@ struct iommu_ops {
 		struct device *dev, u32 flags, struct iommu_domain *parent,
 		const struct iommu_user_data *user_data);
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
+	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
+						 struct mm_struct *mm);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 640acc804e8c..18a35e798b72 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -108,8 +108,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	/* Allocate a new domain and set it on device pasid. */
 	domain = iommu_sva_domain_alloc(dev, mm);
-	if (!domain) {
-		ret = -ENOMEM;
+	if (IS_ERR(domain)) {
+		ret = PTR_ERR(domain);
 		goto out_free_handle;
 	}
 
@@ -283,9 +283,15 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
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
-- 
2.34.1

