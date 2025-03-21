Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8CC22DF90
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577596; cv=none; b=mYizkMIyKLhQzkmxV3q5Buld+wnFTRBRiHeAKeWKh7Ssz64XXEp0vFVwF9Bulnvu7AQmHgyPcZa9JKCvnqiqS1ruVbaPzy7uapcxO6HaLZwViolsgPXOTN3yj/JczZpU/fRExRLySa2zg/DrnW9ZuYSBshkEoDA/8tfeMEz738w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577596; c=relaxed/simple;
	bh=fn+fSONz047kHZeJmQioGFKY8peQ2x09wkjiSKqtaxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dp5COm6EKFq8ZTbFc+S9yuJUGYrR4BMGv6ellN526e0T5IjawsugqKKeE8L9kj9n8zGRTfXxjkBbGeLiiLBsYGMzYgsWX9lkJayH4iVg/v6uyGEGKa3hDJY0ZONPYqgX2GWEao0eworOdvwCORVjFWrNze4RG90Rp1T6IRj12d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WgQgQuz+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WgQgQuz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577595; x=1774113595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fn+fSONz047kHZeJmQioGFKY8peQ2x09wkjiSKqtaxs=;
  b=WgQgQuz+ojogwF3Gud8E+zZRskxjsofZJ10X90PU9YpT4qfWrW9BaeFB
   s+mqGgFEf6bKGcmug5lwjdP5rrei5BOrMv2vsJkgMiwzasYRoVpgWl5FV
   ycezHUvfhKtDWy8EwYat/rqN38iTdC0NgQbZfr42f5e5r30thbAfB8U2n
   NoEbqVe9r+8K8Dk2JJCOXu9u5RAQoh8M5B3ekoBOT+Y8LXZK7/3cBpXfX
   AFkIAWFEdQiZtseK/CmkMUJFZiMJQfPjv/+UowaQpGe9Y6ZPOM+Kfwg3c
   iq11CumKPp/UsKP0xpjFGIoHSz/Nf3ZvHTektgEWBalLs4xuNbvpFYSni
   g==;
X-CSE-ConnectionGUID: gaUXo2uIQCSIZV3naTN0tA==
X-CSE-MsgGUID: hQ8KNL+iTy2q39cZBhGVBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976840"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976840"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:48 -0700
X-CSE-ConnectionGUID: YU00xP3OROiUhidn8HTxuQ==
X-CSE-MsgGUID: qLMkRCm0TtiCF+JKwe3mOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914528"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 10:19:47 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v11 16/18] iommufd/selftest: Add a helper to get test device
Date: Fri, 21 Mar 2025 10:19:38 -0700
Message-Id: <20250321171940.7213-17-yi.l.liu@intel.com>
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

There is need to get the selftest device (sobj->type == TYPE_IDEV) in
multiple places, so have a helper to for it.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 36 ++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index aa3da0adc4e1..04a4b84f5fa1 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -996,39 +996,49 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
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

