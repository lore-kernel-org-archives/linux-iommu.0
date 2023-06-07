Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AF7C
	for <iommu@lists.linux.dev>; Wed,  7 Jun 2023 03:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686110011; x=1717646011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2oi385LpKq1ZlutXYkuJeGeLsStTSAV0zDtArWRKxVY=;
  b=jxfucnoRA/igVBPR7jw/5756qnPELVsXdqeTb0uL0dTlGWAtXcOz3iZA
   OhtioQQHPMaHRWGGIgPIqBNTUYuVKS/Mi3SG23JTcl+WRj20oAohQ4cWt
   x6DlFwlU8X3xXiHx599Q0IQ2fGGgnYOo74uLI5dJqHyuPHO49J4TCMMZm
   wBPadY0MkKeN5fpCNeP+JBk2SaTnc61uqjnhxTkAzdP9Ekq0oKiBgiA3L
   9EvdyIqS6B50imPp/UBdky30yQ11SeZ3Y+aaJ7ef3GgxTUgFLlIZ1NsFE
   mCwE4Vm0OUHR6W9pKOmz6EoCCsg7rK65qpM/ernAJ8FUTMyB4c49oY8+3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="385186357"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="385186357"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 20:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="799125371"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="799125371"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2023 20:53:28 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Remove rmrr check in domain attaching device path
Date: Wed,  7 Jun 2023 11:51:45 +0800
Message-Id: <20230607035145.343698-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607035145.343698-1-baolu.lu@linux.intel.com>
References: <20230607035145.343698-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core code now prevents devices with RMRR regions from being assigned
to user space. There is no need to check for this condition in individual
drivers. Remove it to avoid duplicate code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 58 -------------------------------------
 1 file changed, 58 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8096273b034c..4efc87e74455 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2458,30 +2458,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	return 0;
 }
 
-static bool device_has_rmrr(struct device *dev)
-{
-	struct dmar_rmrr_unit *rmrr;
-	struct device *tmp;
-	int i;
-
-	rcu_read_lock();
-	for_each_rmrr_units(rmrr) {
-		/*
-		 * Return TRUE if this RMRR contains the device that
-		 * is passed in.
-		 */
-		for_each_active_dev_scope(rmrr->devices,
-					  rmrr->devices_cnt, i, tmp)
-			if (tmp == dev ||
-			    is_downstream_to_pci_bridge(dev, tmp)) {
-				rcu_read_unlock();
-				return true;
-			}
-	}
-	rcu_read_unlock();
-	return false;
-}
-
 /**
  * device_rmrr_is_relaxable - Test whether the RMRR of this device
  * is relaxable (ie. is allowed to be not enforced under some conditions)
@@ -2511,34 +2487,6 @@ static bool device_rmrr_is_relaxable(struct device *dev)
 		return false;
 }
 
-/*
- * There are a couple cases where we need to restrict the functionality of
- * devices associated with RMRRs.  The first is when evaluating a device for
- * identity mapping because problems exist when devices are moved in and out
- * of domains and their respective RMRR information is lost.  This means that
- * a device with associated RMRRs will never be in a "passthrough" domain.
- * The second is use of the device through the IOMMU API.  This interface
- * expects to have full control of the IOVA space for the device.  We cannot
- * satisfy both the requirement that RMRR access is maintained and have an
- * unencumbered IOVA space.  We also have no ability to quiesce the device's
- * use of the RMRR space or even inform the IOMMU API user of the restriction.
- * We therefore prevent devices associated with an RMRR from participating in
- * the IOMMU API, which eliminates them from device assignment.
- *
- * In both cases, devices which have relaxable RMRRs are not concerned by this
- * restriction. See device_rmrr_is_relaxable comment.
- */
-static bool device_is_rmrr_locked(struct device *dev)
-{
-	if (!device_has_rmrr(dev))
-		return false;
-
-	if (device_rmrr_is_relaxable(dev))
-		return false;
-
-	return true;
-}
-
 /*
  * Return the required default domain type for a specific device.
  *
@@ -4146,12 +4094,6 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	int ret;
 
-	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
-	    device_is_rmrr_locked(dev)) {
-		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
-		return -EPERM;
-	}
-
 	if (info->domain)
 		device_block_translation(dev);
 
-- 
2.34.1

