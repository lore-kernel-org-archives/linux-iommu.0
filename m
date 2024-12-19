Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E982253EF
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614872; cv=none; b=kYcS+8/8YLeY8L2K5Q9Fb0TcIIyrsnnGN3TYSJPld/+OcdHburmaZ/9HHcSYbjh3SRzYKaVPw3YobMBLNpWkwbmyPRYWCPcmzVt/GxcEZiJ5kGgLGG2agDKk2h4HX198PCuAl1mwiDBC1Xi+PPX8Fo024Z9dojuEaX3EVazi4Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614872; c=relaxed/simple;
	bh=r7+2DdeuXx5T1lcG1uB3C0ENDY1ARqHstTFIOHdQ33g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJ1MQ0wyJrYIbQrs4kZ3UVZZx3PDAcdyFkayZa9ibIAfXP5/tf4pzY9/zf+OxOT6K1JZY1wBMecQqCAToWw2+3kR2h6X2Guczuk3O5baLREnaPkuFYDJY8htxKUhg1ywFSrCGILTwnzapxPzWQQAyW9F/h9gX8N10n+dg5zZMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GEc9Nz4v; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GEc9Nz4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614871; x=1766150871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r7+2DdeuXx5T1lcG1uB3C0ENDY1ARqHstTFIOHdQ33g=;
  b=GEc9Nz4vjlMsmE3QOsXD+MxH1WUzhvFOzftiNi8AajWr+mgxZeTBzcvl
   rlYXOtbrg0kA4zz1G3BeaGUBXZtz+v71Z63Y11yD+4viCmp5viceZIzh1
   alGpli2a7NH+t1iWxP/RDh982I4rYJsZ3EILdPV3KgBrUoCc3CAk1/yWJ
   tF92xXMr/ftHAffDP3SZHGm5HXL0gJz9ASDXg6f35Ul4YkYzxJ0Hyb8v/
   Gv5oLlJ5bvo74rSpWNtHp83AOHUeB6lOuQjaNqVzbeyvQfxUXQtkjbQ9E
   9KCL/8TIbOJRalAl+i1lGZgu/zoj96NMBZqDHqpC8yFm5GPftzFuTwoIJ
   Q==;
X-CSE-ConnectionGUID: /qZnGKpATgmiuFttir0qmw==
X-CSE-MsgGUID: Ib6XqTIbS5Sm50qkX/kh+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46542255"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46542255"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:27:49 -0800
X-CSE-ConnectionGUID: uqCcvotBSoWP1nA5c2WNTw==
X-CSE-MsgGUID: +uTfwj3FS7qeStUGSRgXLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103177305"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2024 05:27:49 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v6 02/14] iommufd: Refactor __fault_domain_replace_dev() to be a wrapper of iommu_replace_group_handle()
Date: Thu, 19 Dec 2024 05:27:34 -0800
Message-Id: <20241219132746.16193-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219132746.16193-1-yi.l.liu@intel.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a wrapper of iommu_attach_group_handle(), so making a wrapper for
iommu_replace_group_handle() for further code refactor. No functional change
intended.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/fault.c | 50 ++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 1fe804e28a86..d09f4594c67a 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -151,33 +151,23 @@ void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
 	kfree(handle);
 }
 
-static int __fault_domain_replace_dev(struct iommufd_device *idev,
-				      struct iommufd_hw_pagetable *hwpt,
-				      struct iommufd_hw_pagetable *old)
+static int
+__fault_domain_replace_dev(struct iommufd_device *idev,
+			   struct iommufd_hw_pagetable *hwpt,
+			   struct iommufd_hw_pagetable *old)
 {
-	struct iommufd_attach_handle *handle, *curr = NULL;
+	struct iommufd_attach_handle *handle;
 	int ret;
 
-	if (old->fault)
-		curr = iommufd_device_get_attach_handle(idev);
-
-	if (hwpt->fault) {
-		handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-		if (!handle)
-			return -ENOMEM;
-
-		handle->idev = idev;
-		ret = iommu_replace_group_handle(idev->igroup->group,
-						 hwpt->domain, &handle->handle);
-	} else {
-		ret = iommu_replace_group_handle(idev->igroup->group,
-						 hwpt->domain, NULL);
-	}
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
 
-	if (!ret && curr) {
-		iommufd_auto_response_faults(old, curr);
-		kfree(curr);
-	}
+	handle->idev = idev;
+	ret = iommu_replace_group_handle(idev->igroup->group,
+					 hwpt->domain, &handle->handle);
+	if (ret)
+		kfree(handle);
 
 	return ret;
 }
@@ -188,6 +178,7 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 {
 	bool iopf_off = !hwpt->fault && old->fault;
 	bool iopf_on = hwpt->fault && !old->fault;
+	struct iommufd_attach_handle *curr;
 	int ret;
 
 	if (iopf_on) {
@@ -196,13 +187,24 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 			return ret;
 	}
 
-	ret = __fault_domain_replace_dev(idev, hwpt, old);
+	curr = iommufd_device_get_attach_handle(idev);
+
+	if (hwpt->fault)
+		ret = __fault_domain_replace_dev(idev, hwpt, old);
+	else
+		ret = iommu_replace_group_handle(idev->igroup->group,
+						 hwpt->domain, NULL);
 	if (ret) {
 		if (iopf_on)
 			iommufd_fault_iopf_disable(idev);
 		return ret;
 	}
 
+	if (curr) {
+		iommufd_auto_response_faults(old, curr);
+		kfree(curr);
+	}
+
 	if (iopf_off)
 		iommufd_fault_iopf_disable(idev);
 
-- 
2.34.1

