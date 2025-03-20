Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3A221739
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478473; cv=none; b=jZrr4gw1IXfduwqOKiZKD+ILpq2piFcy+9wx+8H/AoW7gxzXnZ8ZYgXlv9S2be7ioxKhtta6C0cH9i0Pu/HKjkaoFsi5xwr6eSEKrF5udpF1m8IMogu0klYuMSiI3olfuNyDum/Q8nt3bIwFVX4X1rnmmkLYRjt5Kyv45zBwXQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478473; c=relaxed/simple;
	bh=kCNLedjU3EzVnwVAx/E47A8FhusvS8Kt+cgCPjYSXjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4m7Gir7v2w8mn0lyB8AWofIYKZpKcPvfyx3kPoh9WcEzO8FRByrY5KrxYQeoVEuPphPWUQ/1rvjGtFCCbySWjSQdULMn7ZUJ0bSLB4BHeFYTC/ZjBGqoT6URSQ0NiEb72/JILAq3VvbVjusHdhPYv3Aba95fpwN7qmmdlC5JqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGZbNKiO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGZbNKiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478471; x=1774014471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kCNLedjU3EzVnwVAx/E47A8FhusvS8Kt+cgCPjYSXjg=;
  b=TGZbNKiO7xxY6ycyDJhj93S+8PEv2JJodW7F6ioAGDiBFMUg5m1APAnU
   qQP0bRBSSVqOO5cSH7GB9c151OuGSRIa31ax3QULdunelwEi66kVOhPIN
   cAdJrSDcTjRebYMjNpnRTd1zo3OEc6LqMo5FHWIu4ZcCJRLeE8YNtdZeW
   ox/OY4zFtY8IMsppjkK/gqZvofE0oGov68IxusjOJjB/ouJoGrJAJQSjq
   f81X98O2s2G0bkv/0t8U2i4tGm++oTrTI4JCzRmT9ElGJMCpp8k6C3yGB
   uBkPRlBE9YrkFHkpOful1xV0q4wzHVskVG2jsR2njiFM1y8Cdn62jpIfB
   w==;
X-CSE-ConnectionGUID: BtFIRy/kStC0fWlFCB6ufQ==
X-CSE-MsgGUID: hu3QWAAqQtmR+SFNuQNp0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063052"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063052"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:47 -0700
X-CSE-ConnectionGUID: 0dIKzfjbRI6PqOGMTlvEJQ==
X-CSE-MsgGUID: +TMlnWJVTUOA8in3PxYZpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319154"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 06:47:47 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v10 06/18] iommufd/device: Add helper to detect the first attach of a group
Date: Thu, 20 Mar 2025 06:47:32 -0700
Message-Id: <20250320134744.5777-7-yi.l.liu@intel.com>
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

The existing code detects the first attach by checking the
igroup->device_list. However, the igroup->hwpt can also be used to detect
the first attach. In future modifications, it is better to check the
igroup->hwpt instead of the device_list. To improve readbility and also
prepare for further modifications on this part, this adds a helper for it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v9 -> v10: It is patch 07 of v9, it's reworked hence renamed as well.
---
 drivers/iommu/iommufd/device.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ac54d734b819..9db36346328f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -444,6 +444,13 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	return 0;
 }
 
+static inline bool
+igroup_first_attach(struct iommufd_group *igroup, ioasid_t pasid)
+{
+	lockdep_assert_held(&igroup->lock);
+	return !igroup->hwpt;
+}
+
 static int
 iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 				    struct iommufd_hwpt_paging *hwpt_paging)
@@ -459,7 +466,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 	if (rc)
 		return rc;
 
-	if (list_empty(&igroup->device_list)) {
+	if (igroup_first_attach(igroup, IOMMU_NO_PASID)) {
 		rc = iommufd_group_setup_msi(igroup, hwpt_paging);
 		if (rc) {
 			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
@@ -623,7 +630,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * reserved regions are only updated during individual device
 	 * attachment.
 	 */
-	if (list_empty(&igroup->device_list)) {
+	if (igroup_first_attach(igroup, pasid)) {
 		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
 		if (rc)
 			goto err_unresv;
-- 
2.34.1

