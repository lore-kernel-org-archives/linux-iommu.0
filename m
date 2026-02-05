Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1B726E6F8
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258864; cv=none; b=PNi90iXuY6u+d2hDtnIGkF7tci0leHr7QqapNrVqW6cLJE3PNbtTbL9FG1xSDRtACkkAGP1ADZMYuB7SdpcgZHsZodtyeXz+Zd5VSBuWyBUgEbGfD6+m93lAOnFYycvn44Bqs2S+x75evyXYNj8C2WOqd2LtpYHaTjrrG6p8IM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258864; c=relaxed/simple;
	bh=B9S9jXBEC8CG/byBROfOYsXHweZLxU0jwg1eJQh5kGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmlrqyFXOxDOzkt3AXg2SvDBsaQnHxKkVne4SfYtkjr7BK+wxE/EeNctZ8YOCIaP7AuwdytWkuMJ78OAWlZm//Ykdn3o1dRkA2G5b/AhnzDb3OBt6Xs2uiQuOOTexj/iGHgf0glNMNDQrvfyrpM+JzO1UiprS8iGT3gKyQgWd24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWwNQdli; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWwNQdli"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770258864; x=1801794864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B9S9jXBEC8CG/byBROfOYsXHweZLxU0jwg1eJQh5kGs=;
  b=FWwNQdligCCgVbZhLfh+pYopkjW8kpfSaTTRkq1mJfK+VtnhOvjm9Q0u
   1zdGKc2GJINPrYsTIjkAW4e/u97cOsFTztwdMdGDLVkecx/N+WDSjmreJ
   ndFTEjtoycHUJWou9lrmwjPCFbzQ/atsUF3IVvnrwgRx5Ul5EzU6Y3AeA
   A+prMzQUDg/A7gyzV8yCfiTxH7fCVPIjzWe9EgeH7Fx528MQgV6YUw2ch
   SAZEwquUPpSuef1KBw1kifTOndJHURscGErS/c+IuFp0yH5hnPyIqSyW9
   /9I+TdDNmVgCfoYJlO4NvA+85T3xkfsHh4exWLU0uX92x2qeDeTAvEy1W
   A==;
X-CSE-ConnectionGUID: tSixQ7HUTVu/easz9VXHtA==
X-CSE-MsgGUID: 4ame+pzaQC6b41IJ6sds1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="74057970"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="74057970"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 18:34:24 -0800
X-CSE-ConnectionGUID: RFMeHWWGRneJcBn4KhO4fQ==
X-CSE-MsgGUID: UTS9hJKCRqChOhgGEFRUvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="214872085"
Received: from spr-duan.bj.intel.com ([172.16.114.123])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 18:34:22 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] iommufd/selftest: Test dirty tracking on PASID
Date: Wed,  4 Feb 2026 21:34:04 -0500
Message-ID: <20260205023405.41583-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205023405.41583-1-zhenzhong.duan@intel.com>
References: <20260205023405.41583-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test case for dirty tracking on a domain attached to PASID, also
confirm attachment to PASID fail if device doesn't support dirty tracking.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 tools/testing/selftests/iommu/iommufd.c | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index dadad277f4eb..d1fe5dbc2813 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2275,6 +2275,33 @@ TEST_F(iommufd_dirty_tracking, set_dirty_tracking)
 	test_ioctl_destroy(hwpt_id);
 }
 
+TEST_F(iommufd_dirty_tracking, pasid_set_dirty_tracking)
+{
+	uint32_t stddev_id, ioas_id, hwpt_id, pasid = 100;
+	uint32_t dev_flags = MOCK_FLAGS_DEVICE_PASID;
+
+	/* Regular case */
+	test_cmd_hwpt_alloc(self->idev_id, self->ioas_id,
+			    IOMMU_HWPT_ALLOC_PASID | IOMMU_HWPT_ALLOC_DIRTY_TRACKING,
+			    &hwpt_id);
+	test_cmd_mock_domain_flags(hwpt_id, dev_flags, &stddev_id, NULL, NULL);
+	ASSERT_EQ(0, _test_cmd_pasid_attach(self->fd, stddev_id, pasid, hwpt_id));
+	test_cmd_set_dirty_tracking(hwpt_id, true);
+	test_cmd_set_dirty_tracking(hwpt_id, false);
+	ASSERT_EQ(0, _test_cmd_pasid_detach(self->fd, stddev_id, pasid));
+
+	test_ioctl_destroy(stddev_id);
+
+	/* IOMMU device does not support dirty tracking */
+	dev_flags |= MOCK_FLAGS_DEVICE_NO_DIRTY;
+	test_ioctl_ioas_alloc(&ioas_id);
+	test_cmd_mock_domain_flags(ioas_id, dev_flags, &stddev_id, NULL, NULL);
+	EXPECT_ERRNO(EINVAL, _test_cmd_pasid_attach(self->fd, stddev_id, pasid, hwpt_id));
+
+	test_ioctl_destroy(stddev_id);
+	test_ioctl_destroy(hwpt_id);
+}
+
 TEST_F(iommufd_dirty_tracking, device_dirty_capability)
 {
 	uint32_t caps = 0;
-- 
2.47.3

