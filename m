Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A87EF02
	for <iommu@lists.linux.dev>; Thu, 28 Mar 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629005; cv=none; b=X7xM7SW5GdC732pNz0dF6w/YhbjCFcDBgcQ33B6GcoTlMgMAdPiTBwH3ICtZW8PLmmiaBiJSFIDRYvnWQs1RAhRQFQ0oEt4T3QCMuKWx3sDIE4Mi9fXq7jPt/N9c13K2s+KA8nPK3LjHaa2QreZlzN3XpiMJyPaY4IztEIerMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629005; c=relaxed/simple;
	bh=doQiQ6NCWuBCzJW6kT22Il2riGnEmrGzKwob8mpTTpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L75t9DYcIo/W2basUB0HZfzNNqNvVMpjkEnt7Psx7pjcJ7K5tP3TmFpnU/AFjvXcUfz6UN9uk84ZyGfP/hN8+0whmDg1tV+G2Bh1xoVSL4vQIEWwW4dSY9NPStINfaal8j267NdfwkdUehGzYSj6BGKKHZnO8I1dn0XG6hb8L7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhPMOlE/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhPMOlE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711629003; x=1743165003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=doQiQ6NCWuBCzJW6kT22Il2riGnEmrGzKwob8mpTTpg=;
  b=YhPMOlE/G9m1jUXFBZxkuHVNyZd5tepdQFMRaqpUwnEDPgVOUTG0HnQJ
   sVxMFB2LcVu9ReiHmzaN5QennsZCAlEKwHYDvPSqUvdrkhUBjINkLhh7L
   6vcqLkFPmzd6LeKOxLY8XNavCBcpIIUGdeyJwQDLhWsYPUvyft1Nwbywk
   fkP7r5ow9P//TISz0DvZoBsBq0e+n87kfJ+9e+1mViH5Ma7oZsx/fnmg6
   Cpe4Li5baQH4g8Z9ijljWAcif09x3EU8GnCY7VXV05BNy5MPhi7XdnKB2
   YsFcx32r2HZG3Z7Vb4p2Vv3Sp8TobYrevgyRpvxQneIkUJGRkNHgzWXqj
   A==;
X-CSE-ConnectionGUID: mzkFVcp9QcmaqhwvOFmrwQ==
X-CSE-MsgGUID: nuwABsx+SNWS/tsYtVoXdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18212542"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="18212542"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 05:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="17038477"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 28 Mar 2024 05:30:01 -0700
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
Subject: [PATCH v2 1/2] iommu: Undo pasid attachment only for the devices that have succeeded
Date: Thu, 28 Mar 2024 05:29:57 -0700
Message-Id: <20240328122958.83332-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328122958.83332-1-yi.l.liu@intel.com>
References: <20240328122958.83332-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no error handling now in __iommu_set_group_pasid(), it relies on
its caller to loop all the devices to undo the pasid attachment. This is
not self-contained and has drawbacks. It would result in unnecessary
remove_dev_pasid() calls on the devices that have not been attached to the
new domain. But the remove_dev_pasid() callback would get the new domain
from the group->pasid_array. So for such devices, the iommu driver won't
find the attachment under the domain, hence unable to do cleanup. This may
not be a real problem today. But it depends on the implementation of the
underlying iommu driver. e.g. the intel iommu driver would warn for such
devices. Such warnings are unnecessary.

To solve the above problem, it is necessary to handle the error within
__iommu_set_group_pasid(). It only loops the devices that have attached
to the new domain, and undo it.

Fixes: 16603704559c ("iommu: Add attach/detach_dev_pasid iommu interfaces")
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 098869007c69..bb3244df525e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3317,15 +3317,26 @@ EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
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
+		const struct iommu_ops *ops = dev_iommu_ops(device->dev);
+
+		if (device == last_gdev)
+			break;
+		ops->remove_dev_pasid(device->dev, pasid);
+	}
 	return ret;
 }
 
@@ -3374,10 +3385,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	}
 
 	ret = __iommu_set_group_pasid(domain, group, pasid);
-	if (ret) {
-		__iommu_remove_group_pasid(group, pasid);
+	if (ret)
 		xa_erase(&group->pasid_array, pasid);
-	}
 out_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
-- 
2.34.1

