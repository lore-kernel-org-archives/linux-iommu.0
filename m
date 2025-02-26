Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C8197A67
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 05:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740546098; cv=none; b=BC5YhB/hsk3DXb7BjBrr6MGb8J4eqFNQdgRYbBpQbNxYufr3Aqhn7pigZR0BSyH6M7JTa/1AyxielYc0QcbTOjhM5v+C8crb7ndBAphb3r5L/zOjDcz/uW+OI3td9QCOAX4qXlpvp3Squ40dtr8FyCErVyBZSTCmfINdh2t2CYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740546098; c=relaxed/simple;
	bh=250+VY82BdBKum0kjDCOCoiLhSUX2ni8me9LIz3VsZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DKa7T5owjtvUVT6CElRkF2VYRQMP44PvjsXtJVgPnnxDcbMErO5Upeiw4f6HHNmCPVHM18IEvk63Fp1YgNp4hO+HGCKZPhDNjnm/+dEgu85ntSlqLaZxvE4ATOew9m4rZrVFVgUdMEBa0dd9mWwEwp54I103kwfLvRHGKoOfAsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9IXZRbd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9IXZRbd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740546095; x=1772082095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=250+VY82BdBKum0kjDCOCoiLhSUX2ni8me9LIz3VsZE=;
  b=T9IXZRbdw+hD6+5C63GP0s0incRQbUAWrKSew8v/FAeAvJeeQUqYxV+A
   cra6yPL+WW8T81ZXI3Yj+ynI/DpmxBcKGkHCmRkFyOQLsllm+BYmlkqRY
   b9L5yJagnkur7MY4GdH3GoIaYQxpoieX2DFBYH+vRiwt4TJXtqZxTZmGW
   fqiFJ8xu2mEQOISK0s041kfrfL6CBVajfluS2lDBZX+UFcYW+JeV11Aht
   eBRDV82v2S1RLeWEY1esUkX9vIq7PVzkrT5v4jV001IwXDweujjMpltbZ
   IsG9Sw90BHSU7tP+mhuw5Kn9ViiV4cRXDaR+ZGQoUGE1zkub/5fS6o9xu
   Q==;
X-CSE-ConnectionGUID: 8Moale1jT/OekQYZw2vLWA==
X-CSE-MsgGUID: kZ1uvvZkQKWXamyqoTHNVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41396687"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41396687"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:01:34 -0800
X-CSE-ConnectionGUID: Fup/+nRBRxO2zSG6Z6AhXA==
X-CSE-MsgGUID: cRU0oCUDTLOTIFOI2Y8aug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116385403"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 25 Feb 2025 21:01:34 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH 2/2] iommufd/selftest: Add coverage for RID replace between handle and non-handle
Date: Tue, 25 Feb 2025 21:01:30 -0800
Message-Id: <20250226050130.5814-3-yi.l.liu@intel.com>
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

The iommu core supports replace between the attach with/without handle,
add test to cover it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |   5 +
 drivers/iommu/iommufd/selftest.c              | 102 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |   2 +
 .../selftests/iommu/iommufd_fail_nth.c        |   3 +
 tools/testing/selftests/iommu/iommufd_utils.h |  18 ++++
 5 files changed, 130 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index a6b7a163f636..87dd123d1ff0 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -24,6 +24,7 @@ enum {
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 	IOMMU_TEST_OP_TRIGGER_IOPF,
 	IOMMU_TEST_OP_DEV_CHECK_CACHE,
+	IOMMU_TEST_OP_MIX_REPLACE_HANDLE,
 };
 
 enum {
@@ -145,6 +146,10 @@ struct iommu_test_cmd {
 			__u32 id;
 			__u32 cache;
 		} check_dev_cache;
+		struct {
+			__u32 pt_id;
+			/* @id is stdev_id */
+		} mix_replace_handle;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 20a48cb067e6..f237a6ef58b7 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1629,6 +1629,105 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
 	return 0;
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
+static int iommufd_test_mixed_group_replace(struct iommufd_device *idev,
+					    struct iommu_domain *domain)
+{
+	struct iommu_domain *old_domain = iommu_get_domain_for_dev(idev->dev);
+	struct iommu_group *group = idev->igroup->group;
+	struct iommu_attach_handle *handle, *old_handle;
+	int ret;
+
+	/*
+	 * The test device should have been attached by the _handle API,
+	 * hence there should be an entry in the group->pasid_array.
+	 */
+	old_handle = iommu_attach_handle_get(group, IOMMU_NO_PASID, 0);
+	if (IS_ERR(old_handle))
+		return PTR_ERR(old_handle);
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	mutex_lock(&idev->igroup->lock);
+	iommu_detach_group(domain, group);
+
+	/* attach without handle */
+	ret = iommu_attach_group(domain, group);
+	if (ret)
+		goto out_revert;
+
+	/* replace with handle should succeed */
+	ret = iommu_replace_group_handle(group, domain, handle);
+	if (ret)
+		goto out_revert;
+
+	if (iommu_get_domain_for_dev(idev->dev) != domain) {
+		ret = -ENODEV;
+		goto out_revert;
+	}
+
+	/* replace with the same handle/domain should succeed */
+	ret = iommu_replace_group_handle(group, domain, handle);
+
+out_revert:
+	WARN_ON(iommu_replace_group_handle(group, old_domain, old_handle));
+	mutex_unlock(&idev->igroup->lock);
+	kfree(handle);
+	return ret;
+}
+
+static int iommufd_test_mixed_handle_replace(struct iommufd_ucmd *ucmd,
+					     unsigned int device_id,
+					     u32 pt_id)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_device *idev;
+	struct iommu_domain *domain;
+	struct selftest_obj *sobj;
+	int rc;
+
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, device_id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	idev = sobj->idev.idev;
+
+	hwpt = iommufd_get_hwpt(ucmd, pt_id);
+	if (IS_ERR(hwpt)) {
+		rc = PTR_ERR(hwpt);
+		goto out_dev_obj;
+	}
+
+	domain = hwpt->domain;
+
+	rc = iommufd_test_mixed_group_replace(idev, domain);
+
+	iommufd_put_object(ucmd->ictx, &hwpt->obj);
+
+out_dev_obj:
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return rc;
+}
+
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
 	struct selftest_obj *sobj = to_selftest_obj(obj);
@@ -1710,6 +1809,9 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 					  cmd->dirty.flags);
 	case IOMMU_TEST_OP_TRIGGER_IOPF:
 		return iommufd_test_trigger_iopf(ucmd, cmd);
+	case IOMMU_TEST_OP_MIX_REPLACE_HANDLE:
+		return iommufd_test_mixed_handle_replace(ucmd, cmd->id,
+						cmd->mix_replace_handle.pt_id);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index a1b2b657999d..8d8ce97b53ee 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1951,6 +1951,8 @@ TEST_F(iommufd_mock_domain, alloc_hwpt)
 		test_cmd_hwpt_alloc(self->idev_ids[i], self->ioas_id,
 				    IOMMU_HWPT_ALLOC_NEST_PARENT, &hwpt_id[1]);
 
+		test_cmd_mixed_replace(self->stdev_ids[i], hwpt_id[0]);
+
 		/* Do a hw_pagetable rotation test */
 		test_cmd_mock_domain_replace(self->stdev_ids[i], hwpt_id[0]);
 		EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, hwpt_id[0]));
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 64b1f8e1b0cf..fa6d8cbbe6e1 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -665,6 +665,9 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 				 IOMMU_HWPT_DATA_NONE, 0, 0))
 		return -1;
 
+	if (_test_cmd_mixed_replace(self->fd, stdev_id, hwpt_id))
+		return -1;
+
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
 		return -1;
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index d979f5b0efe8..27d51f880369 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -936,3 +936,21 @@ static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
 	EXPECT_ERRNO(_errno,                                                 \
 		     _test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id,   \
 					     virt_id, vdev_id))
+
+static int _test_cmd_mixed_replace(int fd, __u32 stdev_id, __u32 pt_id)
+{
+	struct iommu_test_cmd test_mixed_replace = {
+		.size = sizeof(test_mixed_replace),
+		.op = IOMMU_TEST_OP_MIX_REPLACE_HANDLE,
+		.id = stdev_id,
+		.mix_replace_handle = {
+			.pt_id = pt_id,
+		},
+	};
+
+	return ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_MIX_REPLACE_HANDLE),
+		     &test_mixed_replace);
+}
+
+#define test_cmd_mixed_replace(stdev_id, hwpt_id)                         \
+	ASSERT_EQ(0, _test_cmd_mixed_replace(self->fd, stdev_id, hwpt_id))
-- 
2.34.1

