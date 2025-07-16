Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A6D28C01C
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649973; cv=none; b=Uwo7zFxioeVWMRvXW19+g7eKa2hHN6/NsShATiZKmkM+a6JELxBqcdutu5/I85JJr8qc3AkZIPlQbu5FoiTT6sQOUmcILr+8q02VxvXETGs7zko7BHlDKT97vHlN10mLjlSpmneHHcszQwG+yAgcS+0lwfbyTl+iwdTU2b2H8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649973; c=relaxed/simple;
	bh=tm3o1OKvzbmwZmyZhLkn0o0jzJ+ODPPxlZSk76PSRB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d2xaY0n2VcJJ9QedLMBE73RqqZ0/yo4j5KppSvlLoIIqwaMENKTnmBE300V2OLdFleX0c5gylYJZDJM24QCygoDIoNJrblwRRz/pgkKEJKL+OFtf7cNJO4ldOc6KdsMyqisdzzr6/jkq6JeoJTnUvxigKXHH0pvDcpP3x+ZvwTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FjOAA60c; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FjOAA60c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752649971; x=1784185971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tm3o1OKvzbmwZmyZhLkn0o0jzJ+ODPPxlZSk76PSRB0=;
  b=FjOAA60cL8pq+cOwLematfHwwlNw0gXP1EqdJaEv2UC/lvxlmvB3BaaJ
   +ofvkHMAsL5b7ukdRqH9E1KXMmQAewrEXIViQ/Rv+fDHrF4M8eKmWbRjs
   mr4sqaey3xV6oZe+g+8Sh55sn/TDSYSuYgy+G/F/PuFG5KP7IxMWvW04g
   7hwb2JIbsm/AU9TbFpZXhMBO6ffeG4PkPVsc7bsbzgiwlzSn+DzjVQlav
   /diGE2BdoQasjtfTTRBvNlqA+JfVIuteHXW9IU5fIGFv+bJUIvrRu2FK6
   XnTmcaf6+tBgdpuujv6+RJOHuM6yFYFsK7t0JQ/nvUIN7/GUyoI6aZVF/
   w==;
X-CSE-ConnectionGUID: 2N0/aNTzQbyQ06nYbWdTPw==
X-CSE-MsgGUID: CXqo0sI8RdmsmpBYeHI0cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58540865"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58540865"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:12:51 -0700
X-CSE-ConnectionGUID: BQgT1JBATPWHY6+/zRt/jQ==
X-CSE-MsgGUID: 8gh4cKRdQLWEkqBbCwX8vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161453660"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 16 Jul 2025 00:12:47 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	shuah@kernel.org,
	nicolinc@nvidia.com,
	aik@amd.com,
	dan.j.williams@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v6 6/8] iommufd/selftest: Explicitly skip tests for inapplicable variant
Date: Wed, 16 Jul 2025 15:03:47 +0800
Message-Id: <20250716070349.1807226-7-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
References: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

no_viommu is not applicable for some viommu/vdevice tests. Explicitly
report the skipping, don't do it silently.

Opportunistically adjust the line wrappings after the indentation
changes using git clang-format.

Only add the prints. No functional change intended.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 tools/testing/selftests/iommu/iommufd.c | 363 ++++++++++++------------
 1 file changed, 176 insertions(+), 187 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index d59d48022a24..1b629bedeb1c 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2779,35 +2779,32 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
 	uint32_t fault_fd;
 	uint32_t vdev_id;
 
-	if (self->device_id) {
-		test_ioctl_fault_alloc(&fault_id, &fault_fd);
-		test_err_hwpt_alloc_iopf(
-			ENOENT, dev_id, viommu_id, UINT32_MAX,
-			IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
-			IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
-		test_err_hwpt_alloc_iopf(
-			EOPNOTSUPP, dev_id, viommu_id, fault_id,
-			IOMMU_HWPT_FAULT_ID_VALID | (1 << 31), &iopf_hwpt_id,
-			IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
-		test_cmd_hwpt_alloc_iopf(
-			dev_id, viommu_id, fault_id, IOMMU_HWPT_FAULT_ID_VALID,
-			&iopf_hwpt_id, IOMMU_HWPT_DATA_SELFTEST, &data,
-			sizeof(data));
+	if (!dev_id)
+		SKIP(return, "Skipping test for variant no_viommu");
 
-		/* Must allocate vdevice before attaching to a nested hwpt */
-		test_err_mock_domain_replace(ENOENT, self->stdev_id,
-					     iopf_hwpt_id);
-		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
-		test_cmd_mock_domain_replace(self->stdev_id, iopf_hwpt_id);
-		EXPECT_ERRNO(EBUSY,
-			     _test_ioctl_destroy(self->fd, iopf_hwpt_id));
-		test_cmd_trigger_iopf(dev_id, fault_fd);
+	test_ioctl_fault_alloc(&fault_id, &fault_fd);
+	test_err_hwpt_alloc_iopf(ENOENT, dev_id, viommu_id, UINT32_MAX,
+				 IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
+				 IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
+	test_err_hwpt_alloc_iopf(EOPNOTSUPP, dev_id, viommu_id, fault_id,
+				 IOMMU_HWPT_FAULT_ID_VALID | (1 << 31),
+				 &iopf_hwpt_id, IOMMU_HWPT_DATA_SELFTEST, &data,
+				 sizeof(data));
+	test_cmd_hwpt_alloc_iopf(dev_id, viommu_id, fault_id,
+				 IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
+				 IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
 
-		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
-		test_ioctl_destroy(iopf_hwpt_id);
-		close(fault_fd);
-		test_ioctl_destroy(fault_id);
-	}
+	/* Must allocate vdevice before attaching to a nested hwpt */
+	test_err_mock_domain_replace(ENOENT, self->stdev_id, iopf_hwpt_id);
+	test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+	test_cmd_mock_domain_replace(self->stdev_id, iopf_hwpt_id);
+	EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, iopf_hwpt_id));
+	test_cmd_trigger_iopf(dev_id, fault_fd);
+
+	test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
+	test_ioctl_destroy(iopf_hwpt_id);
+	close(fault_fd);
+	test_ioctl_destroy(fault_id);
 }
 
 TEST_F(iommufd_viommu, viommu_alloc_with_data)
@@ -2902,169 +2899,161 @@ TEST_F(iommufd_viommu, vdevice_cache)
 	uint32_t vdev_id = 0;
 	uint32_t num_inv;
 
-	if (dev_id) {
-		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
-
-		test_cmd_dev_check_cache_all(dev_id,
-					     IOMMU_TEST_DEV_CACHE_DEFAULT);
-
-		/* Check data_type by passing zero-length array */
-		num_inv = 0;
-		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
-
-		/* Negative test: Invalid data_type */
-		num_inv = 1;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
-
-		/* Negative test: structure size sanity */
-		num_inv = 1;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs) + 1, &num_inv);
-		assert(!num_inv);
-
-		num_inv = 1;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   1, &num_inv);
-		assert(!num_inv);
-
-		/* Negative test: invalid flag is passed */
-		num_inv = 1;
-		inv_reqs[0].flags = 0xffffffff;
-		inv_reqs[0].vdev_id = 0x99;
-		test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
-
-		/* Negative test: invalid data_uptr when array is not empty */
-		num_inv = 1;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x99;
-		test_err_viommu_invalidate(EINVAL, viommu_id, NULL,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
-
-		/* Negative test: invalid entry_len when array is not empty */
-		num_inv = 1;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x99;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   0, &num_inv);
-		assert(!num_inv);
-
-		/* Negative test: invalid cache_id */
-		num_inv = 1;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x99;
-		inv_reqs[0].cache_id = MOCK_DEV_CACHE_ID_MAX + 1;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
+	if (!dev_id)
+		SKIP(return, "Skipping test for variant no_viommu");
 
-		/* Negative test: invalid vdev_id */
-		num_inv = 1;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x9;
-		inv_reqs[0].cache_id = 0;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
+	test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+
+	test_cmd_dev_check_cache_all(dev_id, IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+	/* Check data_type by passing zero-length array */
+	num_inv = 0;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs, sizeof(*inv_reqs),
+				   &num_inv);
+	assert(!num_inv);
+
+	/* Negative test: Invalid data_type */
+	num_inv = 1;
+	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(!num_inv);
+
+	/* Negative test: structure size sanity */
+	num_inv = 1;
+	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   sizeof(*inv_reqs) + 1, &num_inv);
+	assert(!num_inv);
+
+	num_inv = 1;
+	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST, 1,
+				   &num_inv);
+	assert(!num_inv);
+
+	/* Negative test: invalid flag is passed */
+	num_inv = 1;
+	inv_reqs[0].flags = 0xffffffff;
+	inv_reqs[0].vdev_id = 0x99;
+	test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(!num_inv);
+
+	/* Negative test: invalid data_uptr when array is not empty */
+	num_inv = 1;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	test_err_viommu_invalidate(EINVAL, viommu_id, NULL,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(!num_inv);
+
+	/* Negative test: invalid entry_len when array is not empty */
+	num_inv = 1;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST, 0,
+				   &num_inv);
+	assert(!num_inv);
+
+	/* Negative test: invalid cache_id */
+	num_inv = 1;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].cache_id = MOCK_DEV_CACHE_ID_MAX + 1;
+	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(!num_inv);
+
+	/* Negative test: invalid vdev_id */
+	num_inv = 1;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x9;
+	inv_reqs[0].cache_id = 0;
+	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(!num_inv);
 
-		/*
-		 * Invalidate the 1st cache entry but fail the 2nd request
-		 * due to invalid flags configuration in the 2nd request.
-		 */
-		num_inv = 2;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x99;
-		inv_reqs[0].cache_id = 0;
-		inv_reqs[1].flags = 0xffffffff;
-		inv_reqs[1].vdev_id = 0x99;
-		inv_reqs[1].cache_id = 1;
-		test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 1);
-		test_cmd_dev_check_cache(dev_id, 0, 0);
-		test_cmd_dev_check_cache(dev_id, 1,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-		test_cmd_dev_check_cache(dev_id, 2,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-		test_cmd_dev_check_cache(dev_id, 3,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-
-		/*
-		 * Invalidate the 1st cache entry but fail the 2nd request
-		 * due to invalid cache_id configuration in the 2nd request.
-		 */
-		num_inv = 2;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x99;
-		inv_reqs[0].cache_id = 0;
-		inv_reqs[1].flags = 0;
-		inv_reqs[1].vdev_id = 0x99;
-		inv_reqs[1].cache_id = MOCK_DEV_CACHE_ID_MAX + 1;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 1);
-		test_cmd_dev_check_cache(dev_id, 0, 0);
-		test_cmd_dev_check_cache(dev_id, 1,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-		test_cmd_dev_check_cache(dev_id, 2,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-		test_cmd_dev_check_cache(dev_id, 3,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-
-		/* Invalidate the 2nd cache entry and verify */
-		num_inv = 1;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x99;
-		inv_reqs[0].cache_id = 1;
-		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 1);
-		test_cmd_dev_check_cache(dev_id, 0, 0);
-		test_cmd_dev_check_cache(dev_id, 1, 0);
-		test_cmd_dev_check_cache(dev_id, 2,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-		test_cmd_dev_check_cache(dev_id, 3,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-
-		/* Invalidate the 3rd and 4th cache entries and verify */
-		num_inv = 2;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x99;
-		inv_reqs[0].cache_id = 2;
-		inv_reqs[1].flags = 0;
-		inv_reqs[1].vdev_id = 0x99;
-		inv_reqs[1].cache_id = 3;
-		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 2);
-		test_cmd_dev_check_cache_all(dev_id, 0);
+	/*
+	 * Invalidate the 1st cache entry but fail the 2nd request
+	 * due to invalid flags configuration in the 2nd request.
+	 */
+	num_inv = 2;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].cache_id = 0;
+	inv_reqs[1].flags = 0xffffffff;
+	inv_reqs[1].vdev_id = 0x99;
+	inv_reqs[1].cache_id = 1;
+	test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(num_inv == 1);
+	test_cmd_dev_check_cache(dev_id, 0, 0);
+	test_cmd_dev_check_cache(dev_id, 1, IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 2, IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 3, IOMMU_TEST_DEV_CACHE_DEFAULT);
 
-		/* Invalidate all cache entries for nested_dev_id[1] and verify */
-		num_inv = 1;
-		inv_reqs[0].vdev_id = 0x99;
-		inv_reqs[0].flags = IOMMU_TEST_INVALIDATE_FLAG_ALL;
-		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 1);
-		test_cmd_dev_check_cache_all(dev_id, 0);
-		test_ioctl_destroy(vdev_id);
-	}
+	/*
+	 * Invalidate the 1st cache entry but fail the 2nd request
+	 * due to invalid cache_id configuration in the 2nd request.
+	 */
+	num_inv = 2;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].cache_id = 0;
+	inv_reqs[1].flags = 0;
+	inv_reqs[1].vdev_id = 0x99;
+	inv_reqs[1].cache_id = MOCK_DEV_CACHE_ID_MAX + 1;
+	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(num_inv == 1);
+	test_cmd_dev_check_cache(dev_id, 0, 0);
+	test_cmd_dev_check_cache(dev_id, 1, IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 2, IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 3, IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+	/* Invalidate the 2nd cache entry and verify */
+	num_inv = 1;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].cache_id = 1;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs, sizeof(*inv_reqs),
+				   &num_inv);
+	assert(num_inv == 1);
+	test_cmd_dev_check_cache(dev_id, 0, 0);
+	test_cmd_dev_check_cache(dev_id, 1, 0);
+	test_cmd_dev_check_cache(dev_id, 2, IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 3, IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+	/* Invalidate the 3rd and 4th cache entries and verify */
+	num_inv = 2;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].cache_id = 2;
+	inv_reqs[1].flags = 0;
+	inv_reqs[1].vdev_id = 0x99;
+	inv_reqs[1].cache_id = 3;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs, sizeof(*inv_reqs),
+				   &num_inv);
+	assert(num_inv == 2);
+	test_cmd_dev_check_cache_all(dev_id, 0);
+
+	/* Invalidate all cache entries for nested_dev_id[1] and verify */
+	num_inv = 1;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].flags = IOMMU_TEST_INVALIDATE_FLAG_ALL;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs, sizeof(*inv_reqs),
+				   &num_inv);
+	assert(num_inv == 1);
+	test_cmd_dev_check_cache_all(dev_id, 0);
+	test_ioctl_destroy(vdev_id);
 }
 
 TEST_F(iommufd_viommu, hw_queue)
-- 
2.25.1

