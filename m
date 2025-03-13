Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC18266F15
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869352; cv=none; b=t0FEj68Uw/SLCg13moyXbcU2IV8Gw/UYfuVPyWce75NUDdw5P8x+tyKduvcI2OjTgsS13Pzq66ucUb6ift35t85prCD/oBgezO8PJO5kM6uukZ7PSNL20mgpGqcHnbbNHSwE8mWMQP3wLbmwSldQx/Nauy+NqLwK34FhZJtZkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869352; c=relaxed/simple;
	bh=y71wEjWBwpf3j4LqMfwc6MGlgwb+UmxmGMIvCrUOlyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uE3FSlIMVYVgUB27pWIUsCl3ZbMkwb2DzE6IbhlCO0E8ihYlnqdpQ18HUGxuRqNZRQ6m/YebZFwN8KQXgHthkiv0L4KsFiVgupjqDa2aUkGE4H+fEtuhwrfoFp6/Sxfz2Xb0Ka7ikwHwIsib2Jg5hxwdhAVoSVFp3vSTvPK02ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7wB6iXH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7wB6iXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869351; x=1773405351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y71wEjWBwpf3j4LqMfwc6MGlgwb+UmxmGMIvCrUOlyw=;
  b=I7wB6iXHyIMTvZgp/OKhWv81UBs7J2+dM6XRVgXBf1tKQYfzM0kH2CoF
   Df/c4bpbjbC4I5vZegwHmu8FComl7mTKTDjPgkpNdTSSoTVQq+4NqF1kv
   uDDX7tpv6ILpzSva4YOJIP3RP6pGEWQALWjc6NM0xx53RYHWR0k+cNXU2
   lVlxBRjHAYnTXlioHIrEPbMvMTWySz0G/Pl5sx8J8sTRqjo5kktkunN4i
   GBHJEth2XJ7mdpO9+UHPvzP7mEebRGltyXzCGbuwt39CkkNFJGFLMqbJE
   4bpQIOugoyZuGpe+nJKESddw1CZToEQ1bT6OtriTzyrOfWrFDSvhRXDeN
   Q==;
X-CSE-ConnectionGUID: WRIYz9KQTT2wi0SuvaizMg==
X-CSE-MsgGUID: Hcu8Z9V7Q+6kjTdjXX3PiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863952"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863952"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:37 -0700
X-CSE-ConnectionGUID: z4WHX0/oQNSmFHL6LARm8A==
X-CSE-MsgGUID: ICZwbRATSP2k94ScsO/vhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005509"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:38 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 06/21] iommufd/device: Replace idev->igroup with local variable
Date: Thu, 13 Mar 2025 05:35:17 -0700
Message-Id: <20250313123532.103522-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313123532.103522-1-yi.l.liu@intel.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With more use of the fields of igroup, use a local vairable instead of
using the idev->igroup heavily.

No functional change expected.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 43 ++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index be5226d2883e..ac54d734b819 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -448,18 +448,19 @@ static int
 iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 				    struct iommufd_hwpt_paging *hwpt_paging)
 {
+	struct iommufd_group *igroup = idev->igroup;
 	int rc;
 
-	lockdep_assert_held(&idev->igroup->lock);
+	lockdep_assert_held(&igroup->lock);
 
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt,
 						 idev->dev,
-						 &idev->igroup->sw_msi_start);
+						 &igroup->sw_msi_start);
 	if (rc)
 		return rc;
 
-	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_group_setup_msi(idev->igroup, hwpt_paging);
+	if (list_empty(&igroup->device_list)) {
+		rc = iommufd_group_setup_msi(igroup, hwpt_paging);
 		if (rc) {
 			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
 						  idev->dev);
@@ -599,11 +600,12 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
 	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
+	struct iommufd_group *igroup = idev->igroup;
 	int rc;
 
-	mutex_lock(&idev->igroup->lock);
+	mutex_lock(&igroup->lock);
 
-	if (idev->igroup->hwpt != NULL && idev->igroup->hwpt != hwpt) {
+	if (igroup->hwpt && igroup->hwpt != hwpt) {
 		rc = -EINVAL;
 		goto err_unlock;
 	}
@@ -621,39 +623,40 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * reserved regions are only updated during individual device
 	 * attachment.
 	 */
-	if (list_empty(&idev->igroup->device_list)) {
+	if (list_empty(&igroup->device_list)) {
 		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
 		if (rc)
 			goto err_unresv;
-		idev->igroup->hwpt = hwpt;
+		igroup->hwpt = hwpt;
 	}
 	refcount_inc(&hwpt->obj.users);
-	list_add_tail(&idev->group_item, &idev->igroup->device_list);
-	mutex_unlock(&idev->igroup->lock);
+	list_add_tail(&idev->group_item, &igroup->device_list);
+	mutex_unlock(&igroup->lock);
 	return 0;
 err_unresv:
 	if (attach_resv)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 err_unlock:
-	mutex_unlock(&idev->igroup->lock);
+	mutex_unlock(&igroup->lock);
 	return rc;
 }
 
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 {
-	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
+	struct iommufd_group *igroup = idev->igroup;
+	struct iommufd_hw_pagetable *hwpt = igroup->hwpt;
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
 
-	mutex_lock(&idev->igroup->lock);
+	mutex_lock(&igroup->lock);
 	list_del(&idev->group_item);
-	if (list_empty(&idev->igroup->device_list)) {
+	if (list_empty(&igroup->device_list)) {
 		iommufd_hwpt_detach_device(hwpt, idev, pasid);
-		idev->igroup->hwpt = NULL;
+		igroup->hwpt = NULL;
 	}
 	if (hwpt_paging && pasid == IOMMU_NO_PASID)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
-	mutex_unlock(&idev->igroup->lock);
+	mutex_unlock(&igroup->lock);
 
 	/* Caller must destroy hwpt */
 	return hwpt;
@@ -725,7 +728,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	unsigned int num_devices;
 	int rc;
 
-	mutex_lock(&idev->igroup->lock);
+	mutex_lock(&igroup->lock);
 
 	if (igroup->hwpt == NULL) {
 		rc = -EINVAL;
@@ -738,7 +741,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	}
 
 	if (hwpt == igroup->hwpt) {
-		mutex_unlock(&idev->igroup->lock);
+		mutex_unlock(&igroup->lock);
 		return NULL;
 	}
 
@@ -769,7 +772,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	if (num_devices > 1)
 		WARN_ON(refcount_sub_and_test(num_devices - 1,
 					      &old_hwpt->obj.users));
-	mutex_unlock(&idev->igroup->lock);
+	mutex_unlock(&igroup->lock);
 
 	/* Caller must destroy old_hwpt */
 	return old_hwpt;
@@ -777,7 +780,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	if (attach_resv)
 		iommufd_group_remove_reserved_iova(igroup, hwpt_paging);
 err_unlock:
-	mutex_unlock(&idev->igroup->lock);
+	mutex_unlock(&igroup->lock);
 	return ERR_PTR(rc);
 }
 
-- 
2.34.1

