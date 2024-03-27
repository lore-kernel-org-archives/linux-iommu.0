Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF709137C5C
	for <iommu@lists.linux.dev>; Wed, 27 Mar 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544084; cv=none; b=uvmTfCFpuqBp0F+MfFWsjDGCh/XtlH3CMhNJB9smunnU4xoI8qYIRh6Rix//+7tkwujrzQdE0unNjwe9RJK+9ICA7LavsVUxJDBtqQIy9Io4GGnLeJfGMdry2YcN/K9eaavgNSH9ulxlBMj+KM2BE7htmeImC1HzSxnxy2VPdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544084; c=relaxed/simple;
	bh=Nw+W+SdNr0QMlPMemdm1IOIa0D+ceqsV+bgMwHWTiOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=got9ayYJhAguxj+mj7KW/Sl8EIszTPF/7xRbOk4PNqcU9B8cVLnysWiBNfHhCpA5HTABBulm2nSTic23eM76bZuBgVC4DVmLlq686PVDBZm0o6ewS5oyU17TJ11xLbhcozPvuj5YPLeob85P/Ss5a4pR9qIIBqDIuisuV1kiJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7QkC2RH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7QkC2RH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711544083; x=1743080083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nw+W+SdNr0QMlPMemdm1IOIa0D+ceqsV+bgMwHWTiOg=;
  b=D7QkC2RH+0jACcOwUvClul8BXt63VxffYGSyV8nuZIjrWpNV7+DccwYj
   cpIZ4/Bhj05TtouJZaqhAtfM9dPavtF3bWO6+u9J4sWLOH6t7NO74XR6H
   bNuvLl1Il4XdIKPZOLFO6TACMjo9dMs9ICBeRVMKEOOGrfOVsmE57yN2+
   0j4MU+qc8xQDhWieqez4eEcykIWqp2kW+deme+p3WSlw8lFyaJzyYnvdf
   XwONCr1DhNBPsH+x0mXfgeJv3zo07oD8b28B9BAUww58D4nRZ+Zd2RMiJ
   85rYr0EHVgAYq6MYW2eEpnFsi9OTEPvV6Tk+gNMBFqzCACwVmI62IXkMn
   w==;
X-CSE-ConnectionGUID: EqWuNMz9QpKSDzPmGEB8Ww==
X-CSE-MsgGUID: VehJxemARYSorsYk2Yr64A==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17271799"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="17271799"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 05:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="20811209"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa003.fm.intel.com with ESMTP; 27 Mar 2024 05:54:38 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	jacob.jun.pan@intel.com
Subject: [PATCH 2/2] iommu: Undo pasid attachment only for the devices that have succeeded
Date: Wed, 27 Mar 2024 05:54:33 -0700
Message-Id: <20240327125433.248946-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327125433.248946-1-yi.l.liu@intel.com>
References: <20240327125433.248946-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no error handling now in __iommu_set_group_pasid(), it relies on
its caller to loop all the devices to undo the pasid attachment. This is
not self-contained and has unnecessary remove_dev_pasid() calls on the
devices that have not changed in the __iommu_set_group_pasid() call. this
results in unnecessary warnings by the underlying iommu drivers. Like the
Intel iommu driver, it would warn when there is no pasid attachment to
destroy in the remove_dev_pasid() callback.

The ideal way is to handle the error within __iommu_set_group_pasid(). This
not only makes __iommu_set_group_pasid() self-contained, but also avoids
unnecessary warnings.

Fixes: 16603704559c7a68 ("iommu: Add attach/detach_dev_pasid iommu interfaces")
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 681e916d285b..2a12c9c9e045 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3317,15 +3317,25 @@ EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 static int __iommu_set_group_pasid(struct iommu_domain *domain,
 				   struct iommu_group *group, ioasid_t pasid)
 {
-	struct group_device *device;
-	int ret = 0;
+	struct group_device *device, *last_gdev;
+	int ret;
 
 	for_each_group_device(group, device) {
 		ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
 		if (ret)
-			break;
+			goto err_revert;
 	}
 
+	return 0;
+
+err_revert:
+	last_gdev = device;
+	for_each_group_device(group, device) {
+		if (device == last_gdev)
+			break;
+		dev_iommu_ops(device->dev)->remove_dev_pasid(device->dev,
+							     pasid, domain);
+	}
 	return ret;
 }
 
@@ -3375,10 +3385,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	}
 
 	ret = __iommu_set_group_pasid(domain, group, pasid);
-	if (ret) {
-		__iommu_remove_group_pasid(group, pasid, domain);
+	if (ret)
 		xa_erase(&group->pasid_array, pasid);
-	}
 out_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
-- 
2.34.1

