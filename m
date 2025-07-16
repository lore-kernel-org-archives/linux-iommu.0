Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F1328E607
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649976; cv=none; b=IjzYy9JrjpcM5VtNxTF1vb3cKbGywtnHED5LBP+Ics7KG7NdrcnuSi3LuB/AkJbCd7xUAH6I6Gza0MR1Kv0CDQBYpuMuIFlZQAJ97Aqf6uheoH/FwHIoHzx+hcoCnSdZ69vKW27kxjRbWCnt0aRjgF9gIEfNqzHxLfVYGdPVbyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649976; c=relaxed/simple;
	bh=UFzZVPewCANHosCYHCZyErsVJrZf28BY92qL2etK5SU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UY1NOh9nK7Lx1/5iB5FNX6QgDbF2d5U/74xPWo86pJ7O9llZHuVn4kcJS5TE3XCNzeiOvxJxkGP39qmvKFItkqi1YwreU44kYsEwRemQYzyNgsXLmNQho/k3K5k1/u6ldRm8fVMG8OnkjUKIVQmTLIyul40Mz7pI3BkN2i2tHXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMzUPb1f; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMzUPb1f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752649975; x=1784185975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UFzZVPewCANHosCYHCZyErsVJrZf28BY92qL2etK5SU=;
  b=eMzUPb1fI36C5YmzYy57SApkJdb94Hwf3xh6EkvF0AHwLJNHKOD4iKGH
   TtKbUcnIoXiWT5WtKss07Ak3mF1q/VpMM7MXjFqPOlv4Cc2NmtK+PWjxx
   rqGv9QlOoujx2g4Dh4QSVdaYj4g5qVlGUky2AG1pKfiHjErjWv6VrHNvj
   K+DDpjULCTbFREmAtVWwiyjZSIRqIR2Wl9PItTH8uqlRSm9hnKb0AuLpn
   06SzYs3xBFZpoIwUn1gh2Tiwhv8qec8AsJu0yA6sseWHNadCtCpfNW25Y
   u2Lb7WfhVskmsrENX14txbsstSD7kINRte3AAHo6O1R+/F+oh5w8U1tL6
   A==;
X-CSE-ConnectionGUID: 9TWsU8rYS1yysgIwjt/8ww==
X-CSE-MsgGUID: 8vm/CMOKRfeL0mEPkENmIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58540877"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58540877"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:12:54 -0700
X-CSE-ConnectionGUID: gTGNLvXwQRSjzUzWtGaw9w==
X-CSE-MsgGUID: e1+XLYb1Sy60Ejg2tPmNQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161453670"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 16 Jul 2025 00:12:51 -0700
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
Subject: [PATCH v6 7/8] iommufd/selftest: Add coverage for vdevice tombstone
Date: Wed, 16 Jul 2025 15:03:48 +0800
Message-Id: <20250716070349.1807226-8-yilun.xu@linux.intel.com>
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

This tests the flow to tombstone vdevice when idevice is to be unbound
before vdevice destruction. The expected results of the tombstone are:

 - The vdevice ID can't be reused anymore (not tested in this patch).
 - Even ioctl(IOMMU_DESTROY) can't free the vdevice ID.
 - iommufd_fops_release() can still free everything.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 tools/testing/selftests/iommu/iommufd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 1b629bedeb1c..26fe912c62ae 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3115,6 +3115,20 @@ TEST_F(iommufd_viommu, hw_queue)
 	test_ioctl_ioas_unmap(iova, PAGE_SIZE);
 }
 
+TEST_F(iommufd_viommu, vdevice_tombstone)
+{
+	uint32_t viommu_id = self->viommu_id;
+	uint32_t dev_id = self->device_id;
+	uint32_t vdev_id = 0;
+
+	if (!dev_id)
+		SKIP(return, "Skipping test for variant no_viommu");
+
+	test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+	test_ioctl_destroy(self->stdev_id);
+	EXPECT_ERRNO(ENOENT, _test_ioctl_destroy(self->fd, vdev_id));
+}
+
 FIXTURE(iommufd_device_pasid)
 {
 	int fd;
-- 
2.25.1

