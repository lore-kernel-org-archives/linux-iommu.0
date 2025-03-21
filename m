Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD122D7A5
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577589; cv=none; b=NQ/5UBkj3sPOwu4l5ectEk3fPyIfxy3ESik57Hu8UM/xSj7vejCYEqqtztgk3MiHZOAbTqedTK4eUZIWlotBHhP8ikick2sp3KlpMa3UzH0G/VRUwtOnBTolR5RpM3U441wQj54BWXDJ2o5nDV4OO8fj0fgEtLVlb01Eu4Tet3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577589; c=relaxed/simple;
	bh=n79o5dMclH+ryBe9A1K9H4D/OEmrxNlZgWX6+eBFOw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r8ln7Mqpw+9K91jI6zDnp9elnqjsN0exKvQw9cmgK+l73W3zAZlFUICfAwcmkvC/AO1r98/DkSDZe4PclzNp95w9d3hmcgeMetTRBZPl2uxEkLG15Y7bOQFH4Xxk6ywxE1VVtUlFfVWAJvxt1I/eY6L7mPZdAAd/2dQ3f9Kunj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWFPO1qT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWFPO1qT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577588; x=1774113588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n79o5dMclH+ryBe9A1K9H4D/OEmrxNlZgWX6+eBFOw8=;
  b=LWFPO1qTN7UQIA8BOeLXN/pvVMBtVFIHVyWbYNecuipN3guv5UoKA3Nf
   dyMU8LlGs/7kLoejKj5RY6WpFeIks9Xg2WylqryeKRp7vWvakPWeauF79
   NMV75I0M/wt35Ad701CYqAOOfxWEnjMTTijuEIkX7QFMNgBb4Nck9vZ/p
   fI5vo72pnKsTdRzYWza2btL4oPa4Y403CBicRaR3o4xnpPa7TkQrGSNCL
   JorR5162zOZzC5zM7j3pgy16BtrbLZep7k4x49vyskkrYmV4r14o8NH1c
   7s2yeWow7iCrL5PiNLQE6Muz9pAy57e9mjYiEnA9qZXO+JDQVSQkh1GIx
   g==;
X-CSE-ConnectionGUID: IoXhb0VvRumrhingWBfgRA==
X-CSE-MsgGUID: jmc0Jxy5S1yEUJV6h32nWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976802"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976802"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:45 -0700
X-CSE-ConnectionGUID: cv+4oc0BTzKC2D9/4mc8PA==
X-CSE-MsgGUID: acjskSCARGOcLodcfO2mRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914479"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 10:19:45 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v11 06/18] iommufd/device: Add helper to detect the first attach of a group
Date: Fri, 21 Mar 2025 10:19:28 -0700
Message-Id: <20250321171940.7213-7-yi.l.liu@intel.com>
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

The existing code detects the first attach by checking the
igroup->device_list. However, the igroup->hwpt can also be used to detect
the first attach. In future modifications, it is better to check the
igroup->hwpt instead of the device_list. To improve readbility and also
prepare for further modifications on this part, this adds a helper for it.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v10 -> v11: rename igroup_first_attach() to iommufd_group_first_attach()
            and make it as normal helper
---
 drivers/iommu/iommufd/device.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 15733b316b70..2cc3c12d301d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -329,6 +329,13 @@ iommufd_group_setup_msi(struct iommufd_group *igroup,
 }
 #endif
 
+static bool
+iommufd_group_first_attach(struct iommufd_group *igroup, ioasid_t pasid)
+{
+	lockdep_assert_held(&igroup->lock);
+	return !igroup->hwpt;
+}
+
 static int
 iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 				    struct iommufd_hwpt_paging *hwpt_paging)
@@ -344,7 +351,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 	if (rc)
 		return rc;
 
-	if (list_empty(&igroup->device_list)) {
+	if (iommufd_group_first_attach(igroup, IOMMU_NO_PASID)) {
 		rc = iommufd_group_setup_msi(igroup, hwpt_paging);
 		if (rc) {
 			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
@@ -508,7 +515,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * reserved regions are only updated during individual device
 	 * attachment.
 	 */
-	if (list_empty(&igroup->device_list)) {
+	if (iommufd_group_first_attach(igroup, pasid)) {
 		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
 		if (rc)
 			goto err_unresv;
-- 
2.34.1

