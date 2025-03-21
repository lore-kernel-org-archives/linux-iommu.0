Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82D22DFA4
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577597; cv=none; b=Z31EI7dzZYo0OeUyKGSPlelgLxc/yp4tm6BRldyPTKaPm5MCs48zOHPdQaVzSGvoVHy8+dBg2zF9itSWA+OFI6ZYI9qcNJuLMctoFtCQEmFTtI0GihxoddxnQ3vlwod99VjGpIvAAkMjiM9Eis0RNSrX8jCUPuRf1JSvhT8U7fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577597; c=relaxed/simple;
	bh=eDVixeDMBDDi35w9R1lDeIJ3IDlWFmzzv9YGlMQCmLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OLDU3xxdGdRgK8boAs7ezAQ7EV6VC2ONRdxxxmybd7E0EovpAPwH/04bsZg+rxHyy+RxmUrJak7uJJocniIwuqZEEj9JzBfGtbzITiqcJxolmcacLUKnfGdu8CcqBcMSa6Iz6xWi7B32aqONIy4KhTKXfAWJa6h6GsyJMADduWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7TjfYVd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7TjfYVd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577596; x=1774113596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eDVixeDMBDDi35w9R1lDeIJ3IDlWFmzzv9YGlMQCmLA=;
  b=O7TjfYVdDup3RyI6smuv8tzcaAhAUrNJ0kornz531HjfMKhcIciktvb7
   8UuiAVJAiyn7nzcOwfkaikQ5hOa2esvV1uJVX/qhIXksHLHiIF42Itcho
   YHpIBNOBGlvEw6wZbi+b19i2T07iI2YeLoyD82MZUGUbOfWGoJqJGEHb9
   U1xxajmXEDaXs8MNjpJFZrgjTSsOjmhp+Gf2N73Qm8fLtKUeAIGbnHkSu
   DVMHdM4sG7Vd1vUrVMxxrzvvsXSYvC+xmB5jHcGlxajQTU5pRVKlQ+DfD
   rxM8Aee2uxE+F8mWSIxLFJFAq0PnynlQvS8Gd0Tw46QVO0hmgYBZaWfA2
   A==;
X-CSE-ConnectionGUID: lwauWtMgTWicXGkkWubgyg==
X-CSE-MsgGUID: Xu4AftTFRuCNUmvslNBV5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976846"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976846"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:49 -0700
X-CSE-ConnectionGUID: +6zoqaQgQjy5w5ETD6JcKg==
X-CSE-MsgGUID: wXGgRbRdRsW4CEncXBvL/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914544"
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
Subject: [PATCH v11 18/18] iommufd/selftest: Add coverage for iommufd pasid attach/detach
Date: Fri, 21 Mar 2025 10:19:40 -0700
Message-Id: <20250321171940.7213-19-yi.l.liu@intel.com>
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

This tests iommufd pasid attach/replace/detach.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v10 -> v11: Various tweaks. Detail refer to discussion in v10 of this patch,
            besides added the iopf trigger test in pasid path
---
 tools/testing/selftests/iommu/iommufd.c       | 301 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  48 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  97 +++++-
 3 files changed, 437 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 156c74da53cd..c39222b9869b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2996,4 +2996,305 @@ TEST_F(iommufd_viommu, vdevice_cache)
 	}
 }
 
+FIXTURE(iommufd_device_pasid)
+{
+	int fd;
+	uint32_t ioas_id;
+	uint32_t hwpt_id;
+	uint32_t stdev_id;
+	uint32_t device_id;
+	uint32_t no_pasid_stdev_id;
+	uint32_t no_pasid_device_id;
+};
+
+FIXTURE_VARIANT(iommufd_device_pasid)
+{
+	bool pasid_capable;
+};
+
+FIXTURE_SETUP(iommufd_device_pasid)
+{
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+	test_ioctl_ioas_alloc(&self->ioas_id);
+
+	test_cmd_mock_domain_flags(self->ioas_id,
+				   MOCK_FLAGS_DEVICE_PASID,
+				   &self->stdev_id, &self->hwpt_id,
+				   &self->device_id);
+	if (!variant->pasid_capable)
+		test_cmd_mock_domain_flags(self->ioas_id, 0,
+					   &self->no_pasid_stdev_id, NULL,
+					   &self->no_pasid_device_id);
+}
+
+FIXTURE_TEARDOWN(iommufd_device_pasid)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+FIXTURE_VARIANT_ADD(iommufd_device_pasid, no_pasid)
+{
+	.pasid_capable = false,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_device_pasid, has_pasid)
+{
+	.pasid_capable = true,
+};
+
+TEST_F(iommufd_device_pasid, pasid_attach)
+{
+	struct iommu_hwpt_selftest data = {
+		.iotlb =  IOMMU_TEST_IOTLB_DEFAULT,
+	};
+	uint32_t nested_hwpt_id[3] = {};
+	uint32_t parent_hwpt_id = 0;
+	uint32_t fault_id, fault_fd;
+	uint32_t s2_hwpt_id = 0;
+	uint32_t iopf_hwpt_id;
+	uint32_t pasid = 100;
+	uint32_t viommu_id;
+
+	/* Allocate two nested hwpts sharing one common parent hwpt */
+	test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
+			    IOMMU_HWPT_ALLOC_NEST_PARENT,
+			    &parent_hwpt_id);
+	test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id,
+				   IOMMU_HWPT_ALLOC_PASID,
+				   &nested_hwpt_id[0],
+				   IOMMU_HWPT_DATA_SELFTEST,
+				   &data, sizeof(data));
+	test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id,
+				   IOMMU_HWPT_ALLOC_PASID,
+				   &nested_hwpt_id[1],
+				   IOMMU_HWPT_DATA_SELFTEST,
+				   &data, sizeof(data));
+
+	/* Fault related preparation */
+	test_ioctl_fault_alloc(&fault_id, &fault_fd);
+	test_cmd_hwpt_alloc_iopf(self->device_id, parent_hwpt_id, fault_id,
+				 IOMMU_HWPT_FAULT_ID_VALID | IOMMU_HWPT_ALLOC_PASID,
+				 &iopf_hwpt_id,
+				 IOMMU_HWPT_DATA_SELFTEST, &data,
+				 sizeof(data));
+
+	/* Allocate a regular nested hwpt based on viommu */
+	test_cmd_viommu_alloc(self->device_id, parent_hwpt_id,
+			      IOMMU_VIOMMU_TYPE_SELFTEST,
+			      &viommu_id);
+	test_cmd_hwpt_alloc_nested(self->device_id, viommu_id,
+				   IOMMU_HWPT_ALLOC_PASID,
+				   &nested_hwpt_id[2],
+				   IOMMU_HWPT_DATA_SELFTEST, &data,
+				   sizeof(data));
+
+	test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
+			    IOMMU_HWPT_ALLOC_PASID,
+			    &s2_hwpt_id);
+
+	/* Attach RID to non-pasid compat domain, */
+	test_cmd_mock_domain_replace(self->stdev_id, parent_hwpt_id);
+	/* then attach to pasid should fail */
+	test_err_pasid_attach(EINVAL, pasid, s2_hwpt_id);
+
+	/* Attach RID to pasid compat domain, */
+	test_cmd_mock_domain_replace(self->stdev_id, s2_hwpt_id);
+	/* then attach to pasid should succeed, */
+	test_cmd_pasid_attach(pasid, nested_hwpt_id[0]);
+	/* but attach RID to non-pasid compat domain should fail now. */
+	test_err_mock_domain_replace(EINVAL, self->stdev_id, parent_hwpt_id);
+	/*
+	 * Detach hwpt from pasid 100, and check if the pasid 100
+	 * has null domain.
+	 */
+	test_cmd_pasid_detach(pasid);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_hwpt(self->fd, self->stdev_id,
+					    pasid, 0));
+	/* RID is attached to pasid-comapt domain, pasid path is not used */
+
+	if (!variant->pasid_capable) {
+		/*
+		 * PASID-compatible domain can be used by non-PASID-capable
+		 * device.
+		 */
+		test_cmd_mock_domain_replace(self->no_pasid_stdev_id, nested_hwpt_id[0]);
+		test_cmd_mock_domain_replace(self->no_pasid_stdev_id, self->ioas_id);
+		/*
+		 * Attach hwpt to pasid 100 of non-PASID-capable device,
+		 * should fail, no matter domain is pasid-comapt or not.
+		 */
+		EXPECT_ERRNO(EINVAL,
+			     _test_cmd_pasid_attach(self->fd, self->no_pasid_stdev_id,
+						    pasid, parent_hwpt_id));
+		EXPECT_ERRNO(EINVAL,
+			     _test_cmd_pasid_attach(self->fd, self->no_pasid_stdev_id,
+						    pasid, s2_hwpt_id));
+	}
+
+	/*
+	 * Attach non pasid compat hwpt to pasid-capable device, should
+	 * fail, and have null domain.
+	 */
+	test_err_pasid_attach(EINVAL, pasid, parent_hwpt_id);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_hwpt(self->fd, self->stdev_id,
+					    pasid, 0));
+
+	/*
+	 * Attach ioas to pasid 100, should fail, domain should
+	 * be null.
+	 */
+	test_err_pasid_attach(EINVAL, pasid, self->ioas_id);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_hwpt(self->fd, self->stdev_id,
+					    pasid, 0));
+
+	/*
+	 * Attach the s2_hwpt to pasid 100, should succeed, domain should
+	 * be valid.
+	 */
+	test_cmd_pasid_attach(pasid, s2_hwpt_id);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_hwpt(self->fd, self->stdev_id,
+					    pasid, s2_hwpt_id));
+
+	/*
+	 * Try attach pasid 100 with another hwpt, should FAIL
+	 * as attach does not allow overwrite, use REPLACE instead.
+	 */
+	test_err_pasid_attach(EBUSY, pasid, nested_hwpt_id[0]);
+
+	/*
+	 * Detach hwpt from pasid 100 for next test, should succeed,
+	 * and have null domain.
+	 */
+	test_cmd_pasid_detach(pasid);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_hwpt(self->fd, self->stdev_id,
+					    pasid, 0));
+
+	/*
+	 * Attach nested hwpt to pasid 100, should succeed, domain
+	 * should be valid.
+	 */
+	test_cmd_pasid_attach(pasid, nested_hwpt_id[0]);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_hwpt(self->fd, self->stdev_id,
+					    pasid, nested_hwpt_id[0]));
+
+	/* Attach to pasid 100 which has been attached, should fail. */
+	test_err_pasid_attach(EBUSY, pasid, nested_hwpt_id[0]);
+
+	/* cleanup pasid 100 */
+	test_cmd_pasid_detach(pasid);
+
+	/* Replace tests */
+
+	pasid = 200;
+	/*
+	 * Replace pasid 200 without attaching it, should fail
+	 * with -EINVAL.
+	 */
+	test_err_pasid_replace(EINVAL, pasid, s2_hwpt_id);
+
+	/*
+	 * Attach the s2 hwpt to pasid 200, should succeed, domain should
+	 * be valid.
+	 */
+	test_cmd_pasid_attach(pasid, s2_hwpt_id);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_hwpt(self->fd, self->stdev_id,
+					    pasid, s2_hwpt_id));
+
+	/*
+	 * Replace pasid 200 with self->ioas_id, should fail
+	 * and domain should be the prior s2 hwpt.
+	 */
+	test_err_pasid_replace(EINVAL, pasid, self->ioas_id);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_hwpt(self->fd, self->stdev_id,
+					    pasid, s2_hwpt_id));
+
+	/*
+	 * Replace a nested hwpt for pasid 200, should succeed,
+	 * and have valid domain.
+	 */
+	test_cmd_pasid_replace(pasid, nested_hwpt_id[0]);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_hwpt(self->fd, self->stdev_id,
+					    pasid, nested_hwpt_id[0]));
+
+	/*
+	 * Replace with another nested hwpt for pasid 200, should
+	 * succeed, and have valid domain.
+	 */
+	test_cmd_pasid_replace(pasid, nested_hwpt_id[1]);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_hwpt(self->fd, self->stdev_id,
+					    pasid, nested_hwpt_id[1]));
+
+	/* cleanup pasid 200 */
+	test_cmd_pasid_detach(pasid);
+
+	/* Negative Tests for pasid replace, use pasid 1024 */
+
+	/*
+	 * Attach the s2 hwpt to pasid 1024, should succeed, domain should
+	 * be valid.
+	 */
+	pasid = 1024;
+	test_cmd_pasid_attach(pasid, s2_hwpt_id);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_hwpt(self->fd, self->stdev_id,
+					    pasid, s2_hwpt_id));
+
+	/*
+	 * Replace pasid 1024 with nested_hwpt_id[0], should fail,
+	 * but have the old valid domain. This is a designed
+	 * negative case. Normally, this shall succeed.
+	 */
+	test_err_pasid_replace(ENOMEM, pasid, nested_hwpt_id[0]);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_hwpt(self->fd, self->stdev_id,
+					    pasid, s2_hwpt_id));
+
+	/* cleanup pasid 1024 */
+	test_cmd_pasid_detach(pasid);
+
+	/* Attach to iopf-capable hwpt */
+
+	/*
+	 * Attach an iopf hwpt to pasid 2048, should succeed, domain should
+	 * be valid.
+	 */
+	pasid = 2048;
+	test_cmd_pasid_attach(pasid, iopf_hwpt_id);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_hwpt(self->fd, self->stdev_id,
+					    pasid, iopf_hwpt_id));
+
+	test_cmd_trigger_iopf_pasid(self->device_id, pasid, fault_fd);
+
+	/*
+	 * Replace with s2_hwpt_id for pasid 2048, should
+	 * succeed, and have valid domain.
+	 */
+	test_cmd_pasid_replace(pasid, s2_hwpt_id);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_hwpt(self->fd, self->stdev_id,
+					    pasid, s2_hwpt_id));
+
+	/* cleanup pasid 2048 */
+	test_cmd_pasid_detach(pasid);
+
+	test_ioctl_destroy(iopf_hwpt_id);
+	close(fault_fd);
+	test_ioctl_destroy(fault_id);
+
+	/* Detach the s2_hwpt_id from RID */
+	test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 99a7f7897bb2..f182e96eccc1 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -209,12 +209,16 @@ FIXTURE(basic_fail_nth)
 {
 	int fd;
 	uint32_t access_id;
+	uint32_t stdev_id;
+	uint32_t pasid;
 };
 
 FIXTURE_SETUP(basic_fail_nth)
 {
 	self->fd = -1;
 	self->access_id = 0;
+	self->stdev_id = 0;
+	self->pasid = 0; //test should use a non-zero value
 }
 
 FIXTURE_TEARDOWN(basic_fail_nth)
@@ -226,6 +230,8 @@ FIXTURE_TEARDOWN(basic_fail_nth)
 		rc = _test_cmd_destroy_access(self->access_id);
 		assert(rc == 0);
 	}
+	if (self->pasid && self->stdev_id)
+		_test_cmd_pasid_detach(self->fd, self->stdev_id, self->pasid);
 	teardown_iommufd(self->fd, _metadata);
 }
 
@@ -622,9 +628,9 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t fault_id, fault_fd;
 	uint32_t veventq_id, veventq_fd;
 	uint32_t fault_hwpt_id;
+	uint32_t test_hwpt_id;
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
-	uint32_t stdev_id;
 	uint32_t idev_id;
 	uint32_t hwpt_id;
 	uint32_t viommu_id;
@@ -655,25 +661,29 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL,
-				  &idev_id))
+	if (_test_cmd_mock_domain_flags(self->fd, ioas_id,
+					MOCK_FLAGS_DEVICE_PASID,
+					&self->stdev_id, NULL, &idev_id))
 		return -1;
 
 	if (_test_cmd_get_hw_info(self->fd, idev_id, &info, sizeof(info), NULL))
 		return -1;
 
-	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0, 0, &hwpt_id,
+	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0,
+				 IOMMU_HWPT_ALLOC_PASID, &hwpt_id,
 				 IOMMU_HWPT_DATA_NONE, 0, 0))
 		return -1;
 
-	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
+	if (_test_cmd_mock_domain_replace(self->fd, self->stdev_id, ioas_id2, NULL))
 		return -1;
 
-	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, hwpt_id, NULL))
+	if (_test_cmd_mock_domain_replace(self->fd, self->stdev_id, hwpt_id, NULL))
 		return -1;
 
 	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0,
-				 IOMMU_HWPT_ALLOC_NEST_PARENT, &hwpt_id,
+				 IOMMU_HWPT_ALLOC_NEST_PARENT |
+						IOMMU_HWPT_ALLOC_PASID,
+				 &hwpt_id,
 				 IOMMU_HWPT_DATA_NONE, 0, 0))
 		return -1;
 
@@ -699,6 +709,31 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 		return -1;
 	close(veventq_fd);
 
+	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0,
+				 IOMMU_HWPT_ALLOC_PASID,
+				 &test_hwpt_id,
+				 IOMMU_HWPT_DATA_NONE, 0, 0))
+		return -1;
+
+	/* Tests for pasid attach/replace/detach */
+
+	self->pasid = 200;
+
+	if (_test_cmd_pasid_attach(self->fd, self->stdev_id,
+				   self->pasid, hwpt_id)) {
+		self->pasid = 0;
+		return -1;
+	}
+
+	if (_test_cmd_pasid_replace(self->fd, self->stdev_id,
+				    self->pasid, test_hwpt_id))
+		return -1;
+
+	if (_test_cmd_pasid_detach(self->fd, self->stdev_id, self->pasid))
+		return -1;
+
+	self->pasid = 0;
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 6f2ba2fa8f76..27794b6f58fc 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -843,14 +843,15 @@ static int _test_ioctl_fault_alloc(int fd, __u32 *fault_id, __u32 *fault_fd)
 		ASSERT_NE(0, *(fault_fd));                               \
 	})
 
-static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 fault_fd)
+static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 pasid,
+				  __u32 fault_fd)
 {
 	struct iommu_test_cmd trigger_iopf_cmd = {
 		.size = sizeof(trigger_iopf_cmd),
 		.op = IOMMU_TEST_OP_TRIGGER_IOPF,
 		.trigger_iopf = {
 			.dev_id = device_id,
-			.pasid = 0x1,
+			.pasid = pasid,
 			.grpid = 0x2,
 			.perm = IOMMU_PGFAULT_PERM_READ | IOMMU_PGFAULT_PERM_WRITE,
 			.addr = 0xdeadbeaf,
@@ -881,7 +882,10 @@ static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 fault_fd)
 }
 
 #define test_cmd_trigger_iopf(device_id, fault_fd) \
-	ASSERT_EQ(0, _test_cmd_trigger_iopf(self->fd, device_id, fault_fd))
+	ASSERT_EQ(0, _test_cmd_trigger_iopf(self->fd, device_id, 0x1, fault_fd))
+#define test_cmd_trigger_iopf_pasid(device_id, pasid, fault_fd) \
+	ASSERT_EQ(0, _test_cmd_trigger_iopf(self->fd, device_id, \
+					    pasid, fault_fd))
 
 static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
 				  __u32 type, __u32 flags, __u32 *viommu_id)
@@ -1051,3 +1055,90 @@ static int _test_cmd_read_vevents(int fd, __u32 event_fd, __u32 nvevents,
 	EXPECT_ERRNO(_errno,                                                 \
 		     _test_cmd_read_vevents(self->fd, event_fd, nvevents,    \
 					    virt_id, prev_seq))
+
+static int _test_cmd_pasid_attach(int fd, __u32 stdev_id, __u32 pasid,
+				  __u32 pt_id)
+{
+	struct iommu_test_cmd test_attach = {
+		.size = sizeof(test_attach),
+		.op = IOMMU_TEST_OP_PASID_ATTACH,
+		.id = stdev_id,
+		.pasid_attach = {
+			.pasid = pasid,
+			.pt_id = pt_id,
+		},
+	};
+
+	return ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_PASID_ATTACH),
+		     &test_attach);
+}
+
+#define test_cmd_pasid_attach(pasid, hwpt_id) \
+	ASSERT_EQ(0, _test_cmd_pasid_attach(self->fd, self->stdev_id, \
+					    pasid, hwpt_id))
+
+#define test_err_pasid_attach(_errno, pasid, hwpt_id) \
+	EXPECT_ERRNO(_errno, \
+		     _test_cmd_pasid_attach(self->fd, self->stdev_id, \
+					    pasid, hwpt_id))
+
+static int _test_cmd_pasid_replace(int fd, __u32 stdev_id, __u32 pasid,
+				   __u32 pt_id)
+{
+	struct iommu_test_cmd test_replace = {
+		.size = sizeof(test_replace),
+		.op = IOMMU_TEST_OP_PASID_REPLACE,
+		.id = stdev_id,
+		.pasid_replace = {
+			.pasid = pasid,
+			.pt_id = pt_id,
+		},
+	};
+
+	return ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_PASID_REPLACE),
+		     &test_replace);
+}
+
+#define test_cmd_pasid_replace(pasid, hwpt_id) \
+	ASSERT_EQ(0, _test_cmd_pasid_replace(self->fd, self->stdev_id, \
+					     pasid, hwpt_id))
+
+#define test_err_pasid_replace(_errno, pasid, hwpt_id) \
+	EXPECT_ERRNO(_errno, \
+		     _test_cmd_pasid_replace(self->fd, self->stdev_id, \
+					     pasid, hwpt_id))
+
+static int _test_cmd_pasid_detach(int fd, __u32 stdev_id, __u32 pasid)
+{
+	struct iommu_test_cmd test_detach = {
+		.size = sizeof(test_detach),
+		.op = IOMMU_TEST_OP_PASID_DETACH,
+		.id = stdev_id,
+		.pasid_detach = {
+			.pasid = pasid,
+		},
+	};
+
+	return ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_PASID_DETACH),
+		     &test_detach);
+}
+
+#define test_cmd_pasid_detach(pasid) \
+	ASSERT_EQ(0, _test_cmd_pasid_detach(self->fd, self->stdev_id, pasid))
+
+static int test_cmd_pasid_check_hwpt(int fd, __u32 stdev_id, __u32 pasid,
+				     __u32 hwpt_id)
+{
+	struct iommu_test_cmd test_pasid_check = {
+		.size = sizeof(test_pasid_check),
+		.op = IOMMU_TEST_OP_PASID_CHECK_HWPT,
+		.id = stdev_id,
+		.pasid_check = {
+			.pasid = pasid,
+			.hwpt_id = hwpt_id,
+		},
+	};
+
+	return ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_PASID_CHECK_HWPT),
+		     &test_pasid_check);
+}
-- 
2.34.1

