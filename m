Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A41304BA
	for <iommu@lists.linux.dev>; Sun, 16 Feb 2025 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739677960; cv=none; b=Rr78X8vVM+RTdiTH7l2P8wSyspxIWKlDLmjEwHCmwFvWQP6ZLV2+8pApX6ZjgwcxrgaJh7ZqdkRLmeLM3Lkz1mDwKin6Kh2iu0jXe3A00t3Z6f3qdwlqZ4Kv7JegBpo8tf5vMkyMsllcAUz4J4bn4hbRLO+Ri3BZqhnraGKqgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739677960; c=relaxed/simple;
	bh=CJzbEnknzPocPc4M3RTt9CW2uobhawdW+G/1I8r/IIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xi0d9RfYPCb2/x0jCHjVnWrtwkCmY3FMoOVXOnoYc5IIZBpGQkNhvfk6Er5ma95uUvsKml9+G6u8Lxq+JuYnI5Gl+CviYjvk6VNeRBJeYdaMhn7LJKboeaWQQ2xnCYteQSZaWbyRRV0813p0ZV2k2k7EGf8x6j1q0brCsocbLXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNYhcxnm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNYhcxnm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739677958; x=1771213958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CJzbEnknzPocPc4M3RTt9CW2uobhawdW+G/1I8r/IIA=;
  b=QNYhcxnmpX+JB3Mwh4Z4W3JomcBzoGrvL78L3XodDfDMUblFtU3OExn2
   cTPJfrPqAxGAHKEg7ndbXx0gYpdD6BAaAU1YPoZ/wYTxbAA14JhIj9Sgj
   jDskZKpu6OOgZVzd2I2ro1c5FQDVZ6FzOxIblwyTVcFqDf6Y20/lIgUKv
   jfzHiFo05do8P1LN2jZNnJRXn89izhcBsGYKhuZSZFZ8hjJNXp/5mAmk2
   X9+6NxbLBDOd+vNUi2MLSmTJwO9FH60vLmz8dRbahuhGbLpLR95pxBwxd
   AuAUIYdyLb+YUui5/HPtLZBQ7Ymu1gN6npGhQOp6DiWkANArcUKkFGM0d
   Q==;
X-CSE-ConnectionGUID: j6R5nH6eTVuZJcB5puFbPw==
X-CSE-MsgGUID: xgOs/sEVRmu4awZ6gYdOeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="57919361"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="57919361"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 19:52:36 -0800
X-CSE-ConnectionGUID: aEo/mw5xQl+ZE9vP7wpnNg==
X-CSE-MsgGUID: egXHtb0ER9Sx47vT1O6zjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="113544800"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 15 Feb 2025 19:52:37 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	jgg@nvidia.com
Cc: yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v7 11/13] iommufd/selftest: Add a helper to get test device
Date: Sat, 15 Feb 2025 19:52:26 -0800
Message-Id: <20250216035228.23831-12-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216035228.23831-1-yi.l.liu@intel.com>
References: <20250216035228.23831-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is need to get the selftest device (sobj->type == TYPE_IDEV) in
multiple places, so have a helper to for it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 69c17f545e70..1c6cf66da411 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -970,29 +970,39 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
-/* Replace the mock domain with a manually allocated hw_pagetable */
-static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
-					    unsigned int device_id, u32 pt_id,
-					    struct iommu_test_cmd *cmd)
+static struct selftest_obj *
+iommufd_test_get_self_test_device(struct iommufd_ctx *ictx, u32 id)
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
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, device_id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
 
 	rc = iommufd_device_replace(sobj->idev.idev, &pt_id);
 	if (rc)
@@ -1002,7 +1012,7 @@ static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
 out_dev_obj:
-	iommufd_put_object(ucmd->ictx, dev_obj);
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
 	return rc;
 }
 
-- 
2.34.1

