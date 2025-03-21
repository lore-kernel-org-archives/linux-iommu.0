Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7422D7BB
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577596; cv=none; b=UVeQMq7v4PdLwXOQwvc/eqn/GAHFvctyaDvoFRIETwQ1X+n96p+kfT8NeJEZ/a7mkf7b6n799s0WrcYQd8c/JCRQNpQ4YeUCzd7PqWx7cm6DlEdVqqm8pYE1BGjNoZ3Vtb31LVA7fUVUHElRlzPB5VJUCp04JlFXLtrtG7U1t+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577596; c=relaxed/simple;
	bh=7faSAKEk7MWmlfC9h55k22kmDo22ek5bhse90DVL3nU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bs31Vckg9to4XJ4h4My/5WCXfTso/2tOaEcohX9A8hW4ExhGMoC6EDfOY59Ui7KK+xSUD1jP8IJ9bNjd4pkp+W8EbmXpuAEiccUQb87d9F+2mDf7lRwndY3KzCjrCn3dKP88nYKkIkkWQgAyo/vnTkoFaTXvjmgOJtUfNuE+Sj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsJmfsLR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsJmfsLR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577595; x=1774113595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7faSAKEk7MWmlfC9h55k22kmDo22ek5bhse90DVL3nU=;
  b=HsJmfsLRVrb7f6zKOLqTz565ylONZ8spAgywJO6IT8zO+zL4JwJIDiVj
   RXYwpbYbwUDkFsLDQ5BlThKYgFXDfbcFv9dFg6Yv78MkyQXjfQMbT9UaT
   IizebizyPeksa/6f18+5KsTMOE6eTbIdisaDKnfaOAWj+V2jbx+dDD9NV
   VYcLWweygYhneIEATo6dZzri1FDSAZqIVdhSi1b+DrjktSaxl1w/MEHi8
   Bi+8VJy7j6adriQD0OAucaaX6wRMueHfpttmIOQDvOY7UKYDpsp1DBNou
   qX5CzPLcIDiFUHHD4C7aB9KuxePtJZlANFIBUcMgM5zmX1IKQ6K+PM237
   w==;
X-CSE-ConnectionGUID: plVe0Eq7SpaJ1QP8WX9c/g==
X-CSE-MsgGUID: dXdjL58cRk20d5DRGdkGyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976843"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976843"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:48 -0700
X-CSE-ConnectionGUID: RIuSKvrfR/O5QlQZP4vTyw==
X-CSE-MsgGUID: f0+Bl4ssSjSaKLJ1Ud6M+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914533"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 10:19:48 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v11 17/18] iommufd/selftest: Add test ops to test pasid attach/detach
Date: Fri, 21 Mar 2025 10:19:39 -0700
Message-Id: <20250321171940.7213-18-yi.l.liu@intel.com>
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

This adds 4 test ops for pasid attach/replace/detach testing. There are
ops to attach/detach pasid, and also op to check the attached hwpt of a
pasid.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v10 -> v11: Various tweaks. Detail refer to discussion in v10 of this patch
---
 drivers/iommu/iommufd/iommufd_test.h |  26 +++++
 drivers/iommu/iommufd/selftest.c     | 162 +++++++++++++++++++++++++++
 2 files changed, 188 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 1a066feb8697..1cd7e8394129 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -25,6 +25,10 @@ enum {
 	IOMMU_TEST_OP_TRIGGER_IOPF,
 	IOMMU_TEST_OP_DEV_CHECK_CACHE,
 	IOMMU_TEST_OP_TRIGGER_VEVENT,
+	IOMMU_TEST_OP_PASID_ATTACH,
+	IOMMU_TEST_OP_PASID_REPLACE,
+	IOMMU_TEST_OP_PASID_DETACH,
+	IOMMU_TEST_OP_PASID_CHECK_HWPT,
 };
 
 enum {
@@ -62,6 +66,9 @@ enum {
 	MOCK_DEV_CACHE_NUM = 4,
 };
 
+/* Reserved for special pasid replace test */
+#define IOMMU_TEST_PASID_RESERVED 1024
+
 struct iommu_test_cmd {
 	__u32 size;
 	__u32 op;
@@ -150,6 +157,25 @@ struct iommu_test_cmd {
 		struct {
 			__u32 dev_id;
 		} trigger_vevent;
+		struct {
+			__u32 pasid;
+			__u32 pt_id;
+			/* @id is stdev_id */
+		} pasid_attach;
+		struct {
+			__u32 pasid;
+			__u32 pt_id;
+			/* @id is stdev_id */
+		} pasid_replace;
+		struct {
+			__u32 pasid;
+			/* @id is stdev_id */
+		} pasid_detach;
+		struct {
+			__u32 pasid;
+			__u32 hwpt_id;
+			/* @id is stdev_id */
+		} pasid_check;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 04a4b84f5fa1..18d9a216eb30 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -167,6 +167,7 @@ struct mock_dev {
 	unsigned long vdev_id;
 	int id;
 	u32 cache[MOCK_DEV_CACHE_NUM];
+	atomic_t pasid_1024_fake_error;
 };
 
 static inline struct mock_dev *to_mock_dev(struct device *dev)
@@ -227,6 +228,34 @@ static int mock_domain_set_dev_pasid_nop(struct iommu_domain *domain,
 					 struct device *dev, ioasid_t pasid,
 					 struct iommu_domain *old)
 {
+	struct mock_dev *mdev = to_mock_dev(dev);
+
+	/*
+	 * Per the first attach with pasid 1024, set the
+	 * mdev->pasid_1024_fake_error. Hence the second call of this op
+	 * can fake an error to validate the error path of the core. This
+	 * is helpful to test the case in which the iommu core needs to
+	 * rollback to the old domain due to driver failure. e.g. replace.
+	 * User should be careful about the third call of this op, it shall
+	 * succeed since the mdev->pasid_1024_fake_error is cleared in the
+	 * second call.
+	 */
+	if (pasid == 1024) {
+		if (domain->type == IOMMU_DOMAIN_BLOCKED) {
+			atomic_set(&mdev->pasid_1024_fake_error, 0);
+		} else if (atomic_read(&mdev->pasid_1024_fake_error)) {
+			/*
+			 * Clear the flag, and fake an error to fail the
+			 * replacement.
+			 */
+			atomic_set(&mdev->pasid_1024_fake_error, 0);
+			return -ENOMEM;
+		} else {
+			/* Set the flag to fake an error in next call */
+			atomic_set(&mdev->pasid_1024_fake_error, 1);
+		}
+	}
+
 	return 0;
 }
 
@@ -1685,6 +1714,131 @@ static int iommufd_test_trigger_vevent(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
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
+static int iommufd_test_pasid_check_hwpt(struct iommufd_ucmd *ucmd,
+					 struct iommu_test_cmd *cmd)
+{
+	u32 hwpt_id = cmd->pasid_check.hwpt_id;
+	struct iommu_domain *attached_domain;
+	struct iommu_attach_handle *handle;
+	struct iommufd_hw_pagetable *hwpt;
+	struct selftest_obj *sobj;
+	struct mock_dev *mdev;
+	int rc = 0;
+
+	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
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
+	/* hwpt_id == 0 means to check if pasid is detached */
+	if (!hwpt_id) {
+		if (attached_domain)
+			rc = -EINVAL;
+		goto out_sobj;
+	}
+
+	hwpt = iommufd_get_hwpt(ucmd, hwpt_id);
+	if (IS_ERR(hwpt)) {
+		rc = PTR_ERR(hwpt);
+		goto out_sobj;
+	}
+
+	if (attached_domain != hwpt->domain)
+		rc = -EINVAL;
+
+	iommufd_put_object(ucmd->ictx, &hwpt->obj);
+out_sobj:
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return rc;
+}
+
+static int iommufd_test_pasid_attach(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+	int rc;
+
+	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	rc = iommufd_device_attach(sobj->idev.idev, cmd->pasid_attach.pasid,
+				   &cmd->pasid_attach.pt_id);
+	if (rc)
+		goto out_sobj;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		iommufd_device_detach(sobj->idev.idev,
+				      cmd->pasid_attach.pasid);
+
+out_sobj:
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
+	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	rc = iommufd_device_replace(sobj->idev.idev, cmd->pasid_attach.pasid,
+				    &cmd->pasid_attach.pt_id);
+	if (rc)
+		goto out_sobj;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_sobj:
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return rc;
+}
+
+static int iommufd_test_pasid_detach(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+
+	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	iommufd_device_detach(sobj->idev.idev, cmd->pasid_detach.pasid);
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return 0;
+}
+
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
 	struct selftest_obj *sobj = to_selftest_obj(obj);
@@ -1768,6 +1922,14 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_trigger_iopf(ucmd, cmd);
 	case IOMMU_TEST_OP_TRIGGER_VEVENT:
 		return iommufd_test_trigger_vevent(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_ATTACH:
+		return iommufd_test_pasid_attach(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_REPLACE:
+		return iommufd_test_pasid_replace(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_DETACH:
+		return iommufd_test_pasid_detach(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_CHECK_HWPT:
+		return iommufd_test_pasid_check_hwpt(ucmd, cmd);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.34.1

