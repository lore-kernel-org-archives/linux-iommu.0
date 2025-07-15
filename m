Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871D9272804
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561714; cv=none; b=Xsq4faEyS5pWFHajMcvqEYtvKGySK7RQFlNv2p1FM6x8MWcJEnjZXUW3DP3ajqCEoSlsP8v5JbtcclEuSSi9KGATGpL2EJA4wzl2MKBBupsHqLlVyzVSDak2eRhqNOVH4ie3RykavXIHanyyjfN9rfLd2kQJoePtKjq7eyhW3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561714; c=relaxed/simple;
	bh=+FnZBthc0QfK6q6BLjuKbUJ1xSApwzKyXwldHpF8ahA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPaoAb2QZ8zuUsoMytNxF2fKUqZd/WUfGL5PwDouFoTm08SuoR7hhBaYj+6X3ZyW7CA7sB8mJARJ/osUolWJdC274HCVTKzOlIbfZG5eIivg6JivA3rg3leywL4+nWdcILFMAhgBKiJT3zyLPOe/9J3PfXFzXJyZzbGRg79DZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jN7IV/Oh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jN7IV/Oh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752561713; x=1784097713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+FnZBthc0QfK6q6BLjuKbUJ1xSApwzKyXwldHpF8ahA=;
  b=jN7IV/OhuV/U7PkSOc5q9j0KDgcP3f0NDECzrW451t9cbWRfenVD8d6q
   IoZJGs0jY41m41o5CXH11fTV3/l6MrvIsD/ZIIt2wnD5jugDebXb7oFMI
   qI2uMQBqpbE3PINT+zZ0O5ymaM0p27kUhyjvKWDbks1cdaAmSFm87jj5A
   dKe1pqtRZdykjkJOY3aXocv6u7dka/nxiTPsT7j9NTSDA53NSC7L3yPA6
   E3xJ9DE8BbP7D8bRQ8S/lCqCZIVvvfJw+SuGJlNCt4Jn7agucWUHlQpwb
   EEJBHVagL7CRPtrbnas992K1eIxLAPEHOdglQESyLMM3NYj38qRj/gds2
   w==;
X-CSE-ConnectionGUID: sSDinq1rQjWAAi4w50VaKw==
X-CSE-MsgGUID: mxh966o+TOqjMBNf9xtW8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53880903"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="53880903"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:41:52 -0700
X-CSE-ConnectionGUID: IqY9hFhuSxu04MSLDUl62A==
X-CSE-MsgGUID: gvCMW5LITt2VXXjo8PAwxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157649045"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 14 Jul 2025 23:41:48 -0700
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
Subject: [PATCH v5 7/8] iommufd/selftest: Add coverage for vdevice tombstone
Date: Tue, 15 Jul 2025 14:32:44 +0800
Message-Id: <20250715063245.1799534-8-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
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

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 tools/testing/selftests/iommu/iommufd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 16ea10ea1dbf..6084396f7111 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3117,6 +3117,20 @@ TEST_F(iommufd_viommu, hw_queue)
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

