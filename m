Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD1413B29F
	for <iommu@lists.linux.dev>; Sun, 16 Feb 2025 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739677961; cv=none; b=KMxrcABhK+HYJHJ4boMgBz4X+Cn7xm7i4ppEfifOeUdHMmcdNaNqRGD6y1KEwcoGkKYs3dYArJw86zEvhDZTkk/I+v770syp5XXMlI0/yYLsiSGxUVPF+b7SAeC8V9dDG2KHj9XDtLUhpYJONzKW1mtvIUXDhJUZBWtvauKQADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739677961; c=relaxed/simple;
	bh=EEcon3OEP7uWZagzTyUJNzjMDopQosNfCYYBM4GXW7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOkDMLcO2sgPKoUXVHe7PvjKnRY2I78+QgExkrsJQAvu/1MM7TyN7A4AJYU8fwKzGciXgSbU4WhB0pd+VBVuwR8acuEZ9kwdqSa8qYELMm/+uhjCPM+e1ODBXYEOhUxW/B0RFxEPJzix4IRDXmGxEj1rwByWjAV7awkyr/6FYoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWitaSeB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWitaSeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739677959; x=1771213959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EEcon3OEP7uWZagzTyUJNzjMDopQosNfCYYBM4GXW7I=;
  b=dWitaSeBFxwMM51iPRWA5zWwsRw59eKi9vqZZng91656oYxfM+7DDLh0
   /6dvaWpDmMGD71d4z7ypxiA8WvFNCjc0Gy+0tRaTn2jzKModq/CPIh6TQ
   ptO0HA6L0eUSPbBWYCqfCg9yB+GPK+dV2tSv1LygaBIxszd27mT470OIl
   wIiKceJJ0ZoSY3vk+l5XN6Rs0yip7JaPcdx+htjvfX75yPAahnN1OGQAy
   PJ8ZvVnDxQ9cIjrI1cuFkL/DVn+DMGyJ2arF2McByxdvcMTiHq81zeZCr
   nN3iULXigzsobUxTN3lJggct+Vfe6+3yYPOanSsU1rASmuCWh0Z21CxRy
   g==;
X-CSE-ConnectionGUID: e1pan3UyROCzYbSj/XZPlg==
X-CSE-MsgGUID: MTquO0niS2CruERxmUZOjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="57919368"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="57919368"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 19:52:36 -0800
X-CSE-ConnectionGUID: AHF3d1t1QPu3C2BsPgi8fw==
X-CSE-MsgGUID: PD8nDehEQZ2U7DCMpLTL0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="113544805"
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
Subject: [PATCH v7 12/13] iommufd/selftest: Add test ops to test pasid attach/detach
Date: Sat, 15 Feb 2025 19:52:27 -0800
Message-Id: <20250216035228.23831-13-yi.l.liu@intel.com>
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

This adds 4 test ops for pasid attach/replace/detach testing. There are
ops to attach/detach pasid, and also op to check the attached domain of
a pasid.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  30 ++++++
 drivers/iommu/iommufd/selftest.c     | 154 +++++++++++++++++++++++++++
 2 files changed, 184 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index bdc979557272..b3af7db97bc0 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -24,6 +24,10 @@ enum {
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 	IOMMU_TEST_OP_TRIGGER_IOPF,
 	IOMMU_TEST_OP_DEV_CHECK_CACHE,
+	IOMMU_TEST_OP_PASID_ATTACH,
+	IOMMU_TEST_OP_PASID_REPLACE,
+	IOMMU_TEST_OP_PASID_DETACH,
+	IOMMU_TEST_OP_PASID_CHECK_DOMAIN,
 };
 
 enum {
@@ -146,6 +150,32 @@ struct iommu_test_cmd {
 			__u32 id;
 			__u32 cache;
 		} check_dev_cache;
+		struct {
+			__u32 pasid;
+			__u32 pt_id;
+			/* @id is stdev_id for IOMMU_TEST_OP_PASID_ATTACH
+			 * pasid#1024 is for special test, avoid use it
+			 * in normal case.
+			 */
+		} pasid_attach;
+		struct {
+			__u32 pasid;
+			__u32 pt_id;
+			/* @id is stdev_id for IOMMU_TEST_OP_PASID_ATTACH
+			 * pasid#1024 is for special test, avoid use it
+			 * in normal case.
+			 */
+		} pasid_replace;
+		struct {
+			__u32 pasid;
+			/* @id is stdev_id for IOMMU_TEST_OP_PASID_DETACH */
+		} pasid_detach;
+		struct {
+			__u32 pasid;
+			__u32 hwpt_id;
+			__u64 out_result_ptr;
+			/* @id is stdev_id for IOMMU_TEST_OP_HWPT_GET_DOMAIN */
+		} pasid_check;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 1c6cf66da411..f17964e2aa5f 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -200,10 +200,29 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
 	return 0;
 }
 
+static bool pasid_1024_attached;
+
 static int mock_domain_set_dev_pasid_nop(struct iommu_domain *domain,
 					 struct device *dev, ioasid_t pasid,
 					 struct iommu_domain *old)
 {
+	/*
+	 * First attach with pasid 1024 succ, second attach would fail.
+	 * This is helpful to test the case in which the iommu core needs
+	 * to rollback to old domain due to driver failure.
+	 */
+	if (pasid == 1024) {
+		if (domain->type == IOMMU_DOMAIN_BLOCKED) {
+			pasid_1024_attached = false;
+		} else if (pasid_1024_attached) {
+			pasid_1024_attached = false;
+			// Fake an error to fail the replacement
+			return -ENOMEM;
+		} else {
+			pasid_1024_attached = true;
+		}
+	}
+
 	return 0;
 }
 
@@ -1631,6 +1650,132 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
 	return 0;
 }
 
+static int iommufd_test_pasid_attach(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+	int rc;
+
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	rc = iommufd_device_pasid_attach(sobj->idev.idev,
+					 cmd->pasid_attach.pasid,
+					 &cmd->pasid_attach.pt_id);
+	if (rc)
+		goto out_dev_obj;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		iommufd_device_pasid_detach(sobj->idev.idev,
+					    cmd->pasid_attach.pasid);
+
+out_dev_obj:
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return rc;
+}
+
+static int iommufd_test_pasid_replace(struct iommufd_ucmd *ucmd,
+				      struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+	int rc;
+
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	rc = iommufd_device_pasid_replace(sobj->idev.idev,
+					  cmd->pasid_attach.pasid,
+					  &cmd->pasid_attach.pt_id);
+	if (rc)
+		goto out_dev_obj;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_dev_obj:
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return rc;
+}
+
+static int iommufd_test_pasid_detach(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	iommufd_device_pasid_detach(sobj->idev.idev,
+				    cmd->pasid_detach.pasid);
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return 0;
+}
+
+static inline struct iommufd_hw_pagetable *
+iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
+{
+	struct iommufd_object *pt_obj;
+
+	pt_obj = iommufd_get_object(ucmd->ictx, id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(pt_obj))
+		return ERR_CAST(pt_obj);
+
+	if (pt_obj->type != IOMMUFD_OBJ_HWPT_NESTED &&
+	    pt_obj->type != IOMMUFD_OBJ_HWPT_PAGING) {
+		iommufd_put_object(ucmd->ictx, pt_obj);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return container_of(pt_obj, struct iommufd_hw_pagetable, obj);
+}
+
+static int iommufd_test_pasid_check_domain(struct iommufd_ucmd *ucmd,
+					   struct iommu_test_cmd *cmd)
+{
+	struct iommu_domain *attached_domain, *expect_domain = NULL;
+	struct iommufd_hw_pagetable *hwpt = NULL;
+	struct iommu_attach_handle *handle;
+	struct selftest_obj *sobj;
+	struct mock_dev *mdev;
+	bool result;
+	int rc = 0;
+
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	mdev = sobj->idev.mock_dev;
+
+	handle = iommu_attach_handle_get(mdev->dev.iommu_group,
+					 cmd->pasid_check.pasid, 0);
+	if (IS_ERR(handle))
+		attached_domain = NULL;
+	else
+		attached_domain = handle->domain;
+
+	if (cmd->pasid_check.hwpt_id) {
+		hwpt = iommufd_get_hwpt(ucmd, cmd->pasid_check.hwpt_id);
+		if (IS_ERR(hwpt)) {
+			rc = PTR_ERR(hwpt);
+			goto out_put_dev;
+		}
+		expect_domain = hwpt->domain;
+	}
+
+	result = (attached_domain == expect_domain) ? 1 : 0;
+	if (copy_to_user(u64_to_user_ptr(cmd->pasid_check.out_result_ptr),
+			 &result, sizeof(result)))
+		rc = -EFAULT;
+	if (hwpt)
+		iommufd_put_object(ucmd->ictx, &hwpt->obj);
+out_put_dev:
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return rc;
+}
+
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
 	struct selftest_obj *sobj = to_selftest_obj(obj);
@@ -1712,6 +1857,14 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 					  cmd->dirty.flags);
 	case IOMMU_TEST_OP_TRIGGER_IOPF:
 		return iommufd_test_trigger_iopf(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_ATTACH:
+		return iommufd_test_pasid_attach(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_REPLACE:
+		return iommufd_test_pasid_replace(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_DETACH:
+		return iommufd_test_pasid_detach(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_CHECK_DOMAIN:
+		return iommufd_test_pasid_check_domain(ucmd, cmd);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1759,6 +1912,7 @@ int __init iommufd_test_init(void)
 
 	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
 	mock_iommu.iommu_dev.max_pasids = (1 << 20);
+	pasid_1024_attached = false;
 
 	return 0;
 
-- 
2.34.1

