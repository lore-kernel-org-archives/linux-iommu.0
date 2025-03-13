Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CE26738F
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869361; cv=none; b=hwU7OcgOo4uHCE/eSalV48jNdsWTQWzjrv2bntYK1uzVgkSMvXsi63qo26GlvaC/CQq7WNFHSEIfKKnG47X8ctOWjjaqTb2P2Gx+ZEr2bh4Akv73hOprw5N4CTqrY4qyLOaejutYrUBWm8wyZeoenU4qA9iloDtARu7Lv1ZIwNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869361; c=relaxed/simple;
	bh=lG5knTOfXIC2vULK0k9mseLvVhz4zuyvs3u0OHSb/Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m9x4lj9KumLWuJX3hY5+rJV+JR8AsIWmYuMjbMcMKuqOzlXn83JxwSMYHdxQ6A8yC/X1SxcvfjzwfE/qlRTK9NHVsmfbHycbFEOu/Sjy5Dh0wx21qamQE011wC1+8P13xGSfyKUXIZfCy5rh7t5xRwqqZTMn4fMB7y2tk0S4q00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+ZHuLfH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+ZHuLfH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869360; x=1773405360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lG5knTOfXIC2vULK0k9mseLvVhz4zuyvs3u0OHSb/Zs=;
  b=N+ZHuLfHWEhshfeN8bGX/9dx9bqy/VFyQypX+dTqRT4awi75WXa43Xql
   Oxi80QqzkbWkOjoUbmN5DXFwH/rTEwVvQ7qf8i23dfBPwJAK2YbF1G9C0
   OQ7wBTwrbJGKkR4dq+iNm33Bm1Asi4Nm8pGYbhAggne+o+kO+1H8LXIrX
   9hgiLoJ6Ils3FKFQILO0p0GrE7x8QBXjR8p6w9UXOc4akoL9x1tmC21rm
   RMdyR1dMcQHt+kYiPHmcrP5sAoBfbZ34BFoSCP5sQr7qjrfnB4+iW4Dzz
   ukemhOqkAqKnDUonUMYMYQpqE6L0YkTeRrvLM5VjqPHIIiVN2cGRkXiAN
   Q==;
X-CSE-ConnectionGUID: usMGS4nXRPiFDcx9SBIbIw==
X-CSE-MsgGUID: qVCm2piLQS6VOga/3Wox8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863993"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863993"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:42 -0700
X-CSE-ConnectionGUID: P8x4AZNVRoegmBdJS7Wa6A==
X-CSE-MsgGUID: +xuDpVlbRJS39XB+peHiaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005559"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:42 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 19/21] iommufd/selftest: Add a helper to get test device
Date: Thu, 13 Mar 2025 05:35:30 -0700
Message-Id: <20250313123532.103522-20-yi.l.liu@intel.com>
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

There is need to get the selftest device (sobj->type == TYPE_IDEV) in
multiple places, so have a helper to for it.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 36 ++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 29faf3fac8e6..d5b662d1671b 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -970,39 +970,49 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
-/* Replace the mock domain with a manually allocated hw_pagetable */
-static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
-					    unsigned int device_id, u32 pt_id,
-					    struct iommu_test_cmd *cmd)
+static struct selftest_obj *
+iommufd_test_get_selftest_obj(struct iommufd_ctx *ictx, u32 id)
 {
 	struct iommufd_object *dev_obj;
 	struct selftest_obj *sobj;
-	int rc;
 
 	/*
 	 * Prefer to use the OBJ_SELFTEST because the destroy_rwsem will ensure
 	 * it doesn't race with detach, which is not allowed.
 	 */
-	dev_obj =
-		iommufd_get_object(ucmd->ictx, device_id, IOMMUFD_OBJ_SELFTEST);
+	dev_obj = iommufd_get_object(ictx, id, IOMMUFD_OBJ_SELFTEST);
 	if (IS_ERR(dev_obj))
-		return PTR_ERR(dev_obj);
+		return ERR_CAST(dev_obj);
 
 	sobj = to_selftest_obj(dev_obj);
 	if (sobj->type != TYPE_IDEV) {
-		rc = -EINVAL;
-		goto out_dev_obj;
+		iommufd_put_object(ictx, dev_obj);
+		return ERR_PTR(-EINVAL);
 	}
+	return sobj;
+}
+
+/* Replace the mock domain with a manually allocated hw_pagetable */
+static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
+					    unsigned int device_id, u32 pt_id,
+					    struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+	int rc;
+
+	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, device_id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
 
 	rc = iommufd_device_replace(sobj->idev.idev, IOMMU_NO_PASID, &pt_id);
 	if (rc)
-		goto out_dev_obj;
+		goto out_sobj;
 
 	cmd->mock_domain_replace.pt_id = pt_id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
-out_dev_obj:
-	iommufd_put_object(ucmd->ictx, dev_obj);
+out_sobj:
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
 	return rc;
 }
 
-- 
2.34.1

