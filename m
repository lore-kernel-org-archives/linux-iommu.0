Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C509242D67
	for <iommu@lists.linux.dev>; Mon, 23 Jun 2025 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672657; cv=none; b=LcnYhVKDlBBxF91XPxxlaFBV/7+HqQi36sr0rbbrYZjVCcyB9jEPGY7Bw8rx86RQyq8IcJrNa1cwisNpxB+aOdMHBOf2IgNn1CrNyfKgmtQ4uZdthXwC+v1FDWADeNByUdon7byw3MOgZFljdUhwgV/VwGGtJ7fsjAa8j6Qw/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672657; c=relaxed/simple;
	bh=l8eKALXzeaaC5h8btBdADZUaPZ7XJqqocvLm82cf354=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGwl+L6DLO5+FKQed6uW1HkDPXYqgQqPgk9eTQ4I9RHrP2yw9rScJC5aVma71J+YBu1aircegEKW+39VW7DkeFK9oklM3wA+jbpcwHNvAEAe3QzAxzK3U0fSHsOy7hEPc/qtclJn9Y5ptil9iq8aqy5Dj40zKwzMXnOl/JO6FJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcriAQaG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcriAQaG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750672656; x=1782208656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l8eKALXzeaaC5h8btBdADZUaPZ7XJqqocvLm82cf354=;
  b=ZcriAQaGW/ZfiqQ8geJjU2Vzgyt/q+j4zczTrBOSR8TKgyWYYuX/m0LO
   l/PgThKq2REsZ59UbcTEFrPbBW1Ky+/F48PzewMRhl/G9dBNY3d651ejp
   28JUMZ6VBrtwjT9tamcZMu0KF6IAAPLF/MQvNMx1PjUWdlm41h1DfvTPi
   cD2P6joJfTl1zKsCtrAeH8+Ek334T/mIM1fjwgBT2pjPhdVlswD9eNUY6
   x+KN0holSo0OjurXKWUrMVVJd2DKnCwNqVdqLeql4FQyo6DMMt3RnLpzC
   t+qqwcxP42vlVFRrHZAITybeUGaH1ZMrkmTHtkvUajfJm09A62vlu0aUj
   w==;
X-CSE-ConnectionGUID: vCOcw1mlQZ2LxzLuOe+16g==
X-CSE-MsgGUID: bRHdvLxwRSiQEh7pTJO+NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="78285871"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="78285871"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 02:57:34 -0700
X-CSE-ConnectionGUID: GQ6xhPXaQLW+y0PzodT/cA==
X-CSE-MsgGUID: cq5kHF8wTiapbOmvRqb/SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="155859371"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jun 2025 02:57:31 -0700
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
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v2 4/4] iommufd/selftest: Add coverage for vdevice tombstone
Date: Mon, 23 Jun 2025 17:49:46 +0800
Message-Id: <20250623094946.1714996-5-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tests the flow to tombstone vdevice when idevice is to be unbound
before vdevice destroy. The expected result is:

 - idevice unbound tombstones vdevice ID, the ID can't be repurposed
   anymore.
 - Even ioctl(IOMMU_DESTROY) can't free it the tombstoned ID.
 - iommufd_fops_release() can still free everything.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 tools/testing/selftests/iommu/iommufd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 1a8e85afe9aa..092e1344447e 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3014,6 +3014,19 @@ TEST_F(iommufd_viommu, vdevice_cache)
 	}
 }
 
+TEST_F(iommufd_viommu, vdevice_tombstone)
+{
+	uint32_t viommu_id = self->viommu_id;
+	uint32_t dev_id = self->device_id;
+	uint32_t vdev_id = 0;
+
+	if (dev_id) {
+		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+		test_ioctl_destroy(self->stdev_id);
+		EXPECT_ERRNO(ENOENT, _test_ioctl_destroy(self->fd, vdev_id));
+	}
+}
+
 FIXTURE(iommufd_device_pasid)
 {
 	int fd;
-- 
2.25.1

