Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B0521ABB4
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 05:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740546095; cv=none; b=Nwph5V65Dld23Aum9Oe6CDOTRCcKQyXk/quvtAYWLftVwLPqJNk7zhZcJYo0qR9fp9nGOi9tq8iYAN5VZjX0a7xwX66FRTm/TSV3j7j49TAf3L9vKHrK1HS5wkf88yy3Ht7GSD681FCJx65rRnI04U/MBoKPfste0sHeh79tOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740546095; c=relaxed/simple;
	bh=gkSUUJjj6Xnifj1eoReYlVI2f25meA3LCe+uaLR5yks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rihBbjhm+iWOdZrnRqEbKpM8jQLMVT1kJymmlfdWBfh8bBDgt0gM+trErLX9OFoNo1WfJT7XecB9xceDWC2fM3tUv5ZQcTddobcHsIg1si94H6QNA03Vc1LSJ4iwTnEStF5J36WxBA9O3IhzAcL+yaZDNOPay3RPGOs8zogkbD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwIbFSXN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwIbFSXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740546094; x=1772082094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gkSUUJjj6Xnifj1eoReYlVI2f25meA3LCe+uaLR5yks=;
  b=EwIbFSXN9kjx8hhkemWPmZl5th+CfvdRlIeBiodoSaqlEpi12Rpz76kY
   k1SQv61FFHYZ1MslJxCwHpBfccSp4lrYHBsA0Piv7oJ+Ns32Nunvn9Kcl
   507xx2E9/IUvSAzIh8Is5KCaOYW6pktb1ev4yGJDPoq0DxdoK6CAH5Vrp
   pNZ951JiZZ6ORNxb3+c+S7RsE2vcE+sfBOT2Ec12u4jLkBflbkGNRqtRu
   mcgRvsVs+Ot6yMrudfkFe0Uao15539+q4O7aqOGzZNZufB0oosDcG8mXs
   K4vjrAqoQTxvRSOIBToCmJaBZhj0Pe7eVgeR6hWX2RdVQk2XTnC7rFLxY
   g==;
X-CSE-ConnectionGUID: +WW1v7fcSX6c2b69o5U3xQ==
X-CSE-MsgGUID: gnrOsvsEQbS+r2ivlxXOhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41396684"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41396684"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:01:33 -0800
X-CSE-ConnectionGUID: OQ0E6aw/Qhuy9UFsmbsQAA==
X-CSE-MsgGUID: ZivpG5VVThepP7GRO30WQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116385398"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 25 Feb 2025 21:01:33 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH 1/2] iommufd/selftest: Add a helper to get test device
Date: Tue, 25 Feb 2025 21:01:29 -0800
Message-Id: <20250226050130.5814-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226050130.5814-1-yi.l.liu@intel.com>
References: <20250226050130.5814-1-yi.l.liu@intel.com>
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
index f7d67bc15359..20a48cb067e6 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -968,29 +968,39 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
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
@@ -1000,7 +1010,7 @@ static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
 out_dev_obj:
-	iommufd_put_object(ucmd->ictx, dev_obj);
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
 	return rc;
 }
 
-- 
2.34.1

