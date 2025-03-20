Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8594221F16
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478478; cv=none; b=vF/3HhpEMXmfcbpyLfmltHdiX5cemZct6IamhKVRiZQ1r3NDneqquY3znGHjMqPS7M52yaJHvwMNA1cZmkOMzvHp7FvCJ34lHrtWPAH6QrCJ14VKb0jlI44vbmgYNi8eOvKni9OVTeovSTpb2CSQpFmk1ykK5W1rX2L/RFyZ+Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478478; c=relaxed/simple;
	bh=0VTJJDjen98TdllD9nA4Xq5F1C3OWz6PlvX6YIlAStQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RGiYDlNDFwr8k8yag2Maii6GbPZ95FL/z0xA7n+fQTTIWXJHYsTv+XMZzZJFcOiG/hXvHG0tGsqCmLGgiizhw6KqF3ZhEdBz9x0hZzO359VFwO6yFc5hMuU9FWEd4Wpxj67F26HahxxKxWUD3hpbp7hV85pRv0DQLju/YhilBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeSZFJDE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeSZFJDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478476; x=1774014476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0VTJJDjen98TdllD9nA4Xq5F1C3OWz6PlvX6YIlAStQ=;
  b=BeSZFJDELforX5zhjUQ+yQWQQPXlXIeBr/L9Nr4HgZ0QZ7PYnq/48mtT
   ROQfFeOmY1kyQeD2/ZT8J7XfT9TKfaABhandpLUOOEgLUKwvak6tvKnX+
   zcQ/GHCpkNaMY77PhizK9dBPnZ++kbz/t1eLHxzHwtzidi/v+nvL5Qezn
   +Rq86+e/7Xv5TguD1YZUwCjSTKg5YVA7+bdnbw7Oq4tDvJNvTSbqdHRMG
   RdSaLpTDy7+0egTkUwATbD+C01qzXrLcNO1Zjf+TFlbNuSxz9mZbIxTgV
   RkXB7t4xmVYmbsR0cmwRwRcXOxY0N0A20M0xeFNatbGn0oRWGGvfTil0k
   Q==;
X-CSE-ConnectionGUID: G3LRIpqVTLqGwtmw1Uqh1g==
X-CSE-MsgGUID: 0KvlUUNYRY2ItELc1O5Gqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063087"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063087"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:48 -0700
X-CSE-ConnectionGUID: oSE+ZT6eStOYO3I7ilMbdg==
X-CSE-MsgGUID: 8WBlufeeSF+nUqv32GYq7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319194"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 06:47:49 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v10 16/18] iommufd/selftest: Add a helper to get test device
Date: Thu, 20 Mar 2025 06:47:42 -0700
Message-Id: <20250320134744.5777-17-yi.l.liu@intel.com>
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

There is need to get the selftest device (sobj->type == TYPE_IDEV) in
multiple places, so have a helper to for it.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 36 ++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index c26730375a72..691e7a23f300 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -994,39 +994,49 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
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

