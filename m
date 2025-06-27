Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77991C8FBA
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 03:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995969; cv=none; b=r+M3r3zMMyP6KIdcDRl719b43xZlzFcz4chlcIm0d5R8x+UJFTLJI1EL9Hu7aUtDeuLkfqS74YKBhtAblTqy11gudZv+WEv0p6SrfM3VQc0vjkGAEaUbvWeyGjbcu6SQ/3uKDIvHDl2U9DOoxBLfCzTNnDKoEm1M3FHGpYqCKPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995969; c=relaxed/simple;
	bh=SCzREkn+LTw/APqsUFRvSQCOubI1qSzNruatKQg5rOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WGCv6XonkjTN4pgXg0QV1QWNw7Ze/uLmiOUAgsAtlmD+MQ03l0DXiVyDC/EdqB1yva79Yu3vfShyLrTkwGrhTJ1ZdRZpte9WATyVUEhOev64xIaNb1Ga/ENkSFahMqj8/sbQLEQKEdCUszutV5fjDU5Z0ekzSAJcAnSvKzTqKjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CztoNh5T; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CztoNh5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750995968; x=1782531968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SCzREkn+LTw/APqsUFRvSQCOubI1qSzNruatKQg5rOo=;
  b=CztoNh5TpRhmrepVvORLs+NJcZQZbJ5QE4q/f6Tb38lVek/wPGtwoEZt
   ZOs/No91wrYAX/gudtTelDVxrD+XxyVmK7glaLRZBhbJ40pP47NQZ61vM
   dSvBcxOfGJRpadOhCvcY8ao4/xsIzevMjBAXBAv4ATh26ZdHTdvcdGrNn
   mqNUUB31Lsi992pK6qPdJybFjSprhy/idMAjakpxkpFsVE1JG/KCpc+0e
   Ut8h/KXPQCWd8OosneFmNfo+q44iokdw+iHybIDPbOAqNoZE2fygqVLu3
   0CkB1TpC3bnU7DHLvvjW/pkAS48AOLO9m8IItMMvqYU4T/UsY2GzDzQq5
   Q==;
X-CSE-ConnectionGUID: OFWRmvs3TKaeSa9xGdzJqg==
X-CSE-MsgGUID: /2zB71ApQzu6XtTHlkWu+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53454228"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="53454228"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 20:46:07 -0700
X-CSE-ConnectionGUID: aZlsw916SQK2+OTFu9P81g==
X-CSE-MsgGUID: DkxvRhqKQdaF0iYh/nA/Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="176374872"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jun 2025 20:46:03 -0700
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
Subject: [PATCH v3 4/5] iommufd/selftest: Explicitly skip tests for inapplicable variant
Date: Fri, 27 Jun 2025 11:38:08 +0800
Message-Id: <20250627033809.1730752-5-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

no_viommu is not applicable for some viommu/vdevice tests. Explicitly
report the skipping, don't do it silently.

Only add the prints. No functional change intended.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 tools/testing/selftests/iommu/iommufd.c | 378 ++++++++++++------------
 1 file changed, 190 insertions(+), 188 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 1a8e85afe9aa..4a9b6e3b37fa 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2760,35 +2760,36 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
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
+	test_err_hwpt_alloc_iopf(
+		ENOENT, dev_id, viommu_id, UINT32_MAX,
+		IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
+		IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
+	test_err_hwpt_alloc_iopf(
+		EOPNOTSUPP, dev_id, viommu_id, fault_id,
+		IOMMU_HWPT_FAULT_ID_VALID | (1 << 31), &iopf_hwpt_id,
+		IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
+	test_cmd_hwpt_alloc_iopf(
+		dev_id, viommu_id, fault_id, IOMMU_HWPT_FAULT_ID_VALID,
+		&iopf_hwpt_id, IOMMU_HWPT_DATA_SELFTEST, &data,
+		sizeof(data));
+
+	/* Must allocate vdevice before attaching to a nested hwpt */
+	test_err_mock_domain_replace(ENOENT, self->stdev_id,
+				     iopf_hwpt_id);
+	test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+	test_cmd_mock_domain_replace(self->stdev_id, iopf_hwpt_id);
+	EXPECT_ERRNO(EBUSY,
+		     _test_ioctl_destroy(self->fd, iopf_hwpt_id));
+	test_cmd_trigger_iopf(dev_id, fault_fd);
 
-		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
-		test_ioctl_destroy(iopf_hwpt_id);
-		close(fault_fd);
-		test_ioctl_destroy(fault_id);
-	}
+	test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
+	test_ioctl_destroy(iopf_hwpt_id);
+	close(fault_fd);
+	test_ioctl_destroy(fault_id);
 }
 
 TEST_F(iommufd_viommu, vdevice_alloc)
@@ -2849,169 +2850,170 @@ TEST_F(iommufd_viommu, vdevice_cache)
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
-
-		/* Negative test: invalid vdev_id */
-		num_inv = 1;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x9;
-		inv_reqs[0].cache_id = 0;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
-
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
+	if (!dev_id)
+		SKIP(return, "Skipping test for variant no_viommu");
+
+	test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+
+	test_cmd_dev_check_cache_all(dev_id,
+				     IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+	/* Check data_type by passing zero-length array */
+	num_inv = 0;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+				   sizeof(*inv_reqs), &num_inv);
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
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   1, &num_inv);
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
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   0, &num_inv);
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
+	test_cmd_dev_check_cache(dev_id, 1,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 2,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 3,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
 
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
+	test_cmd_dev_check_cache(dev_id, 1,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 2,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 3,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+	/* Invalidate the 2nd cache entry and verify */
+	num_inv = 1;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].cache_id = 1;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(num_inv == 1);
+	test_cmd_dev_check_cache(dev_id, 0, 0);
+	test_cmd_dev_check_cache(dev_id, 1, 0);
+	test_cmd_dev_check_cache(dev_id, 2,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 3,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+	/* Invalidate the 3rd and 4th cache entries and verify */
+	num_inv = 2;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].cache_id = 2;
+	inv_reqs[1].flags = 0;
+	inv_reqs[1].vdev_id = 0x99;
+	inv_reqs[1].cache_id = 3;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(num_inv == 2);
+	test_cmd_dev_check_cache_all(dev_id, 0);
+
+	/* Invalidate all cache entries for nested_dev_id[1] and verify */
+	num_inv = 1;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].flags = IOMMU_TEST_INVALIDATE_FLAG_ALL;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(num_inv == 1);
+	test_cmd_dev_check_cache_all(dev_id, 0);
+	test_ioctl_destroy(vdev_id);
 }
 
 FIXTURE(iommufd_device_pasid)
-- 
2.25.1

