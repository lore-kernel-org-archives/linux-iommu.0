Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB815442A
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743168892; cv=none; b=ObfiVw5OuGiXix+fC14IbpHibRfI5INOOqzvCQaAZVcnZy+vnGot+BaexcEYEoe8HBYU0pMBobOaiiVKWBw78bsXNQabDZKfi2Igl7BEhLpjfTR4BYKO9KqRUljxldkQZPipNezUQ/PuUe3uz+T4GgWOAncsIMl38ExDv5PNw+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743168892; c=relaxed/simple;
	bh=XCwh1uEJ0J/A3rllBR8n0wvphPTwsZ5EFGk97RhCIHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZIOrF1eLVYW8K7EuEHiGFeASoV7fPK2S4CHw8BpP6ngwKDT0j32FvV7fOkAx78/W9ku+zq6pB6lUJ7lPPNp6ARl19g9EfeiWngHg3sAMjHJb/OAZp1iJkjlW7W5okBuW+hfq5TatPMgwinE7u9edzzuNsKW8Qa1G99UHZ2+I7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtY3ZPwm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtY3ZPwm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743168891; x=1774704891;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XCwh1uEJ0J/A3rllBR8n0wvphPTwsZ5EFGk97RhCIHk=;
  b=KtY3ZPwmLRHo07xaVf2nXhALd/L52cTaoR8/oHsgQVJulvgfBDf7Al3T
   xoGnb/6Ir76s6KCWmdP5JH3rzwdOBEbZxx2C3Seh30Iaspm8qXlroRZwT
   JnsKi/NzlR5078QmwRgkQNaK9Nd1Uni+Qje642G0DjMEUl5U5mPejjWCY
   6hxtposQiSUjlAt/UXkJx3jF7JoMMV/RBrn+uUTRnR2bW7jnC9HtRTg4k
   aef1I0Q2oVafhGClCfNSqdWFBT6IBdGgGFeSEkQRPxvHuC31aV0u0TjY6
   LVW/4MYe3EbCPucE+SUJOaiwJFj1SeTEPijbMVuCo2hPWY/4x3zOxyuob
   Q==;
X-CSE-ConnectionGUID: b9QdeSJjQEKYZH3CxOXJwQ==
X-CSE-MsgGUID: EcfP5z1/T82zL8ODAa1kJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="55903826"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="55903826"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 06:34:50 -0700
X-CSE-ConnectionGUID: FfukD6GwT0qYR0OLb/besQ==
X-CSE-MsgGUID: 1PPZl8USR7eVdySaoCojgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="125265942"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa006.fm.intel.com with ESMTP; 28 Mar 2025 06:34:49 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com,
	Lai Yi <yi1.lai@linux.intel.com>
Subject: [PATCH] iommufd: Test attach before detaching pasid
Date: Fri, 28 Mar 2025 06:34:48 -0700
Message-Id: <20250328133448.22052-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if the pasid has been attached before going further in the detach
path. This makes this path more robust. Add a selftest as well.

Reported-by: Lai Yi <yi1.lai@linux.intel.com>
Closes: https://lore.kernel.org/linux-iommu/Z+X0tzxhiaupJT7b@ly-workstation/#t
Fixes: c0e301b2978d ("iommufd/device: Add pasid_attach array to track per-PASID attach")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 7 +++++++
 tools/testing/selftests/iommu/iommufd.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2307daad65c0..375dd262f431 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -644,6 +644,11 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 
 	mutex_lock(&igroup->lock);
 	attach = xa_load(&igroup->pasid_attach, pasid);
+	if (WARN_ON(!attach)) {
+		mutex_unlock(&igroup->lock);
+		return NULL;
+	}
+
 	hwpt = attach->hwpt;
 	hwpt_paging = find_hwpt_paging(hwpt);
 
@@ -1001,6 +1006,8 @@ void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid)
 	struct iommufd_hw_pagetable *hwpt;
 
 	hwpt = iommufd_hw_pagetable_detach(idev, pasid);
+	if (!hwpt)
+		return;
 	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 	refcount_dec(&idev->obj.users);
 }
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 7eb7ee149f2b..1a8e85afe9aa 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3074,6 +3074,12 @@ TEST_F(iommufd_device_pasid, pasid_attach)
 	uint32_t pasid = 100;
 	uint32_t viommu_id;
 
+	/*
+	 * Negative, detach pasid without attaching, this is not expected.
+	 * But it should not result in failure anyway.
+	 */
+	test_cmd_pasid_detach(pasid);
+
 	/* Allocate two nested hwpts sharing one common parent hwpt */
 	test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
 			    IOMMU_HWPT_ALLOC_NEST_PARENT,
-- 
2.34.1

