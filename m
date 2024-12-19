Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F08226164
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614880; cv=none; b=soh6r546j0fb6okpRf3YMehHKQzH8CNtoosS4NIz4RecRorSxtcYvRFar9dn9fAmMs31OL9lmT4LHumUt00e9xa4feDE9JdEALZUkU1cw7z0UsPycsXLI8YkDVxorNNKIe3s1ydtiVH/ZrfEAWJpoAl/tw7mJf7nnBNzl/Ik3mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614880; c=relaxed/simple;
	bh=wH2AQOfVbUtrD7102008EjakkRBzizJVKWauozIMbm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QO6aTacFEz0lHEcp5Jr+5sqONtk0VfCX0IdHveDCVnBulGR3VXSHVyv0/Bvn2z2Oc20y0NgMSG9ar14mFtWhCHktVjv2YbD2FvYg6teeHKzOrQ1R1PqELdBDgURM+OHOO8UrJQBIrUPyCcF4zxtG2GNfWoVGC9DcUYh4MqnS748=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=inEn6Fn+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="inEn6Fn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614878; x=1766150878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wH2AQOfVbUtrD7102008EjakkRBzizJVKWauozIMbm0=;
  b=inEn6Fn+Mj0SsR6sRcgqYP/KlnhacMrJpaXTjNdsxXK0h94KB5bvsjQ+
   z7r+mIT1vovY+XLnxjVTShVT8+2yOL1/FkdMViWiI/As28Vr2kyNkujn3
   KN39YVMH4WvhH/JquBrsjAhNasHFhuOw8L6Rili+dsMEo1THQA+pjOs7G
   lDgQcEOYxIRf7MiiJiVvyy7aW9DLtiBkgBSp5VCiGfSGo3yCugi482N5K
   xwrX3zNkBSO2g3YgieUq3KR2RxBK1xiMIPd/LnazQrUWIoY68nZRDUW9O
   8eLCToF2xo1iRkDig1v3cM3DGD0YksELwv8A0gWbq9FY3r2w5GrZvUm+Q
   w==;
X-CSE-ConnectionGUID: XUEcgyd6QaCk9AGeKX6EEw==
X-CSE-MsgGUID: z3iVioT3R8yWucC2z9HrmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46542328"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46542328"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:27:52 -0800
X-CSE-ConnectionGUID: fDLlZyz+TRmnrXpEgFpBkA==
X-CSE-MsgGUID: LZCDhteiRi2hVa9CdFY7Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103177348"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2024 05:27:51 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v6 14/14] iommufd/selftest: Add coverage for iommufd pasid attach/detach
Date: Thu, 19 Dec 2024 05:27:46 -0800
Message-Id: <20241219132746.16193-15-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219132746.16193-1-yi.l.liu@intel.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
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
 tools/testing/selftests/iommu/iommufd.c       | 348 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  39 +-
 tools/testing/selftests/iommu/iommufd_utils.h | 102 +++++
 3 files changed, 482 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index a1b2b657999d..575a9289dfdb 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2956,4 +2956,352 @@ TEST_F(iommufd_viommu, vdevice_cache)
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
+	uint32_t auto_hwpt;
+	uint32_t viommu_id;
+	bool result;
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
+	/* Faulte related preparation */
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
+	test_err_pasid_attach(EINVAL, pasid, s2_hwpt_id, NULL);
+
+	/* Attach RID to pasid compat domain, */
+	test_cmd_mock_domain_replace(self->stdev_id, s2_hwpt_id);
+	/* then attach to pasid should succeed, */
+	test_cmd_pasid_attach(pasid, nested_hwpt_id[0], NULL);
+	/* but attach RID to non-pasid compat domain should fail now. */
+	test_err_mock_domain_replace(EINVAL, self->stdev_id, parent_hwpt_id);
+	test_cmd_pasid_detach(pasid);
+
+	if (!variant->pasid_capable) {
+		/*
+		 * PASID-compatible domain can be used by non-PASID-capable
+		 * device.
+		 */
+		test_cmd_mock_domain_replace(self->no_pasid_stdev_id, nested_hwpt_id[0]);
+		test_cmd_mock_domain_replace(self->no_pasid_stdev_id, self->ioas_id);
+		/*
+		 * Attach hwpt to pasid#100 of non-PASID-capable device,
+		 * should fail, no matter domain is pasid-comapt or not.
+		 */
+		EXPECT_ERRNO(EINVAL,
+			     _test_cmd_pasid_attach(self->fd, self->no_pasid_stdev_id,
+						    pasid, parent_hwpt_id, NULL));
+		EXPECT_ERRNO(EINVAL,
+			     _test_cmd_pasid_attach(self->fd, self->no_pasid_stdev_id,
+						    pasid, s2_hwpt_id, NULL));
+	}
+
+	/*
+	 * Attach non pasid compat hwpt to pasid-capable device, should
+	 * fail, and have null domain.
+	 */
+	test_err_pasid_attach(EINVAL, pasid, parent_hwpt_id, NULL);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, 0, &result));
+	EXPECT_EQ(1, result);
+
+	/*
+	 * Attach ioas to pasid 100, should succeed, domain should
+	 * be valid.
+	 */
+	test_cmd_pasid_attach(pasid, self->ioas_id, &auto_hwpt);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, auto_hwpt, &result));
+	EXPECT_EQ(1, result);
+
+	/*
+	 * Attach same ioas to pasid 100, should succeed.
+	 */
+	test_cmd_pasid_attach(pasid, self->ioas_id, &auto_hwpt);
+
+	/*
+	 * Try attach pasid 100 with another hwpt, should FAIL
+	 * as attach does not allow overwrite, use REPLACE instead.
+	 */
+	test_err_pasid_attach(EINVAL, pasid, nested_hwpt_id[0], NULL);
+
+	/*
+	 * Detach hwpt from pasid 100, and check if the pasid 100
+	 * has null domain. Should be done before the next attach.
+	 */
+	test_cmd_pasid_detach(pasid);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, 0, &result));
+	EXPECT_EQ(1, result);
+
+	/*
+	 * Attach nested hwpt to pasid 100, should succeed, domain
+	 * should be valid.
+	 */
+	test_cmd_pasid_attach(pasid, nested_hwpt_id[0], NULL);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, nested_hwpt_id[0],
+					      &result));
+	EXPECT_EQ(1, result);
+
+	/*
+	 * Try attach pasid 100 to same nested_hwpt_id[0], should succeed.
+	 */
+	test_cmd_pasid_attach(pasid, nested_hwpt_id[0], NULL);
+
+	/*
+	 * Detach hwpt from pasid 100, and check if the pasid 100
+	 * has null domain
+	 */
+	test_cmd_pasid_detach(pasid);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, 0, &result));
+	EXPECT_EQ(1, result);
+
+	/* Replace tests */
+
+	pasid = 200;
+	/*
+	 * Replace pasid 200 without attaching it first, should
+	 * fail with -EINVAL.
+	 */
+	test_err_cmd_pasid_replace(EINVAL, pasid, s2_hwpt_id, NULL);
+
+	/*
+	 * Attach a s2 hwpt to pasid 200, should succeed, domain should
+	 * be valid.
+	 */
+	test_cmd_pasid_attach(pasid, s2_hwpt_id, NULL);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, s2_hwpt_id,
+					      &result));
+	EXPECT_EQ(1, result);
+
+	/*
+	 * Replace pasid 200 with self->ioas_id, should succeed,
+	 * and have valid domain.
+	 */
+	test_cmd_pasid_replace(pasid, self->ioas_id, &auto_hwpt);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, auto_hwpt,
+					      &result));
+	EXPECT_EQ(1, result);
+
+	/*
+	 * Replace a nested hwpt for pasid 200, should succeed,
+	 * and have valid domain.
+	 */
+	test_cmd_pasid_replace(pasid, nested_hwpt_id[0], NULL);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, nested_hwpt_id[0],
+					      &result));
+	EXPECT_EQ(1, result);
+
+	/*
+	 * Replace with another nested hwpt for pasid 200, should
+	 * succeed, and have valid domain.
+	 */
+	test_cmd_pasid_replace(pasid, nested_hwpt_id[1], NULL);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, nested_hwpt_id[1],
+					      &result));
+	EXPECT_EQ(1, result);
+
+	/*
+	 * Detach hwpt from pasid 200, and check if the pasid 200
+	 * has null domain.
+	 */
+	test_cmd_pasid_detach(pasid);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, 0, &result));
+	EXPECT_EQ(1, result);
+
+	/* Negative Tests for pasid replace, use pasid 1024 */
+
+	/*
+	 * Attach a s2 hwpt to pasid 1024, should succeed, domain should
+	 * be valid.
+	 */
+	pasid = 1024;
+	test_cmd_pasid_attach(pasid, s2_hwpt_id, NULL);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, s2_hwpt_id,
+					      &result));
+	EXPECT_EQ(1, result);
+
+	/*
+	 * Replace pasid 1024 with self->ioas_id, should fail,
+	 * but have the old valid domain. This is a designed
+	 * negative case, normally replace with self->ioas_id
+	 * could succeed.
+	 */
+	test_err_cmd_pasid_replace(ENOMEM, pasid, self->ioas_id, NULL);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, s2_hwpt_id,
+					      &result));
+	EXPECT_EQ(1, result);
+
+	/*
+	 * Detach hwpt from pasid 1024, and check if the pasid 1024
+	 * has null domain.
+	 */
+	test_cmd_pasid_detach(pasid);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, 0, &result));
+	EXPECT_EQ(1, result);
+
+	/* Attach to iopf-capable hwpt */
+
+	/*
+	 * Attach an iopf hwpt to pasid 2048, should succeed, domain should
+	 * be valid.
+	 */
+	pasid = 2048;
+	test_cmd_pasid_attach(pasid, iopf_hwpt_id, NULL);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, iopf_hwpt_id,
+					      &result));
+	EXPECT_EQ(1, result);
+
+	/*
+	 * Replace with s2_hwpt_id for pasid 2048, should
+	 * succeed, and have valid domain.
+	 */
+	test_cmd_pasid_replace(pasid, s2_hwpt_id, NULL);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, s2_hwpt_id,
+					      &result));
+	EXPECT_EQ(1, result);
+
+	/*
+	 * Detach hwpt from pasid 2048, and check if the pasid 2048
+	 * has null domain.
+	 */
+	test_cmd_pasid_detach(pasid);
+	ASSERT_EQ(0,
+		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+					      pasid, 0, &result));
+	EXPECT_EQ(1, result);
+
+	test_ioctl_destroy(iopf_hwpt_id);
+	close(fault_fd);
+	test_ioctl_destroy(fault_id);
+
+	/* Detach the s2_hwpt_id from RID */
+	test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
+
+	test_ioctl_destroy(nested_hwpt_id[0]);
+	test_ioctl_destroy(nested_hwpt_id[1]);
+	test_ioctl_destroy(nested_hwpt_id[2]);
+	test_ioctl_destroy(viommu_id);
+	test_ioctl_destroy(parent_hwpt_id);
+	test_ioctl_destroy(s2_hwpt_id);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 64b1f8e1b0cf..c9580724ca9c 100644
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
 
@@ -623,7 +629,6 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t fault_hwpt_id;
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
-	uint32_t stdev_id;
 	uint32_t idev_id;
 	uint32_t hwpt_id;
 	uint32_t viommu_id;
@@ -654,25 +659,29 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
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
 
@@ -692,6 +701,22 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 				 IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data)))
 		return -1;
 
+	self->pasid = 200;
+
+	/* Tests for pasid attach/replace/detach */
+	if (_test_cmd_pasid_attach(self->fd, self->stdev_id,
+				   self->pasid, ioas_id, NULL)) {
+		self->pasid = 0;
+		return -1;
+	}
+
+	_test_cmd_pasid_replace(self->fd, self->stdev_id, self->pasid, ioas_id2, NULL);
+
+	if (_test_cmd_pasid_detach(self->fd, self->stdev_id, self->pasid))
+		return -1;
+
+	self->pasid = 0;
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index d979f5b0efe8..523ff28e4bc9 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -936,3 +936,105 @@ static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
 	EXPECT_ERRNO(_errno,                                                 \
 		     _test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id,   \
 					     virt_id, vdev_id))
+
+static int _test_cmd_pasid_attach(int fd, __u32 stdev_id, __u32 pasid,
+				  __u32 pt_id, __u32 *out_pt_id)
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
+	int ret;
+
+	ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_PASID_ATTACH),
+		    &test_attach);
+	if (ret)
+		return ret;
+
+	if (out_pt_id)
+		*out_pt_id = test_attach.pasid_attach.pt_id;
+	return 0;
+}
+
+#define test_cmd_pasid_attach(pasid, hwpt_id, out_pt_id) \
+	ASSERT_EQ(0, _test_cmd_pasid_attach(self->fd, self->stdev_id, \
+					    pasid, hwpt_id, out_pt_id))
+
+#define test_err_pasid_attach(_errno, pasid, hwpt_id, out_pt_id) \
+	EXPECT_ERRNO(_errno, \
+		     _test_cmd_pasid_attach(self->fd, self->stdev_id, \
+					    pasid, hwpt_id, out_pt_id))
+
+static int _test_cmd_pasid_replace(int fd, __u32 stdev_id, __u32 pasid,
+				   __u32 pt_id, __u32 *out_pt_id)
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
+	int ret;
+
+	ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_PASID_REPLACE),
+		    &test_replace);
+	if (ret)
+		return ret;
+
+	if (out_pt_id)
+		*out_pt_id = test_replace.pasid_replace.pt_id;
+	return 0;
+}
+
+#define test_cmd_pasid_replace(pasid, hwpt_id, out_pt_id) \
+	ASSERT_EQ(0, _test_cmd_pasid_replace(self->fd, self->stdev_id, \
+					     pasid, hwpt_id, out_pt_id))
+
+#define test_err_cmd_pasid_replace(_errno, pasid, hwpt_id, out_pt_id) \
+	EXPECT_ERRNO(_errno, \
+		     _test_cmd_pasid_replace(self->fd, self->stdev_id, \
+					     pasid, hwpt_id, out_pt_id))
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
+static int test_cmd_pasid_check_domain(int fd, __u32 stdev_id, __u32 pasid,
+				       __u32 hwpt_id, bool *result)
+{
+	struct iommu_test_cmd test_pasid_check = {
+		.size = sizeof(test_pasid_check),
+		.op = IOMMU_TEST_OP_PASID_CHECK_DOMAIN,
+		.id = stdev_id,
+		.pasid_check = {
+			.pasid = pasid,
+			.hwpt_id = hwpt_id,
+			.out_result_ptr = (__u64)result,
+		},
+	};
+
+	return ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_PASID_CHECK_DOMAIN),
+		     &test_pasid_check);
+}
-- 
2.34.1

