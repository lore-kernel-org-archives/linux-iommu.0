Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65B1A23AF
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995972; cv=none; b=VoSJGkMLBsFn0O3qQ1glJG+wiH55pbecYaPyWOH8CtdGAlonDTQeiR3GXoX8W32K861uxEG4xsIUrx6jn6mKG8bP2Agd4TZzcf0AWfZzYSB+uUI3OXUary08x0HEjYRHc2q6LpqD/zHJ12MnDmGU+E96t9inquvBlg1K7zwGvfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995972; c=relaxed/simple;
	bh=fK16mo7DG7cquXHm19Z+gYhG43gjt271XQww/gwmjL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmyR1Q922QDPdgANsWvx/AGXjh4un0jG7aXWaS82X5Go/hsQT9eumCT8BnAhyv/EbWWzhPKS0ZaJukyLuDJQbkxY407RYzsOp+Wc9FWAteDVh2TCAAk7xguWMD5RmZWKyuijSYyqnhskESzaT6kCZoKXQezJIP8vu7xwmKd7Okg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cISax95j; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cISax95j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750995971; x=1782531971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fK16mo7DG7cquXHm19Z+gYhG43gjt271XQww/gwmjL8=;
  b=cISax95jfTghKUODVnF0OVa26zkhzPnDl1LxekEuETWsc+SZ2f+pbqsz
   1H92j7BB/M57nun2JTqfl6eGcyRdKvQjU8um2ZqPpcwl5TD2UDZB+I1i0
   FQViWb6cu2I+nJi2a2/SKoS344O0ZgliIUq9QvjR6Ty4ef6NNe/iJhM/1
   LsJXekmMCmXme68DIdsrGukmPXBvw4VVSh796++dWDTP2GqTI7OhzT2yG
   Rb8SnxcoNVLGzEWVDKrxwzQ8kknRJbALMG5O9DoZsyZvIWYPJmXODJBIM
   sB5zYzjUz8yz0EffKI2XPF66MeDi1fq8GxlXg5i7zo4lZ0jFeoprz2Scv
   w==;
X-CSE-ConnectionGUID: w8S7v5HnR5+CpMd0Tu2bTg==
X-CSE-MsgGUID: GiXBP+vHTVeUNr19/OoD+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53454239"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="53454239"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 20:46:11 -0700
X-CSE-ConnectionGUID: HGgcEo6HTXSar56noxdDmA==
X-CSE-MsgGUID: 5sXzOePbRUWsHhSHnsuEkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="176374879"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jun 2025 20:46:07 -0700
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
Subject: [PATCH v3 5/5] iommufd/selftest: Add coverage for vdevice tombstone
Date: Fri, 27 Jun 2025 11:38:09 +0800
Message-Id: <20250627033809.1730752-6-yilun.xu@linux.intel.com>
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

This tests the flow to tombstone vdevice when idevice is to be unbound
before vdevice destruction. The expected result is:

 - idevice unbinding tombstones vdevice ID, the ID can't be repurposed
   anymore.
 - Even ioctl(IOMMU_DESTROY) can't free the tombstoned ID.
 - iommufd_fops_release() can still free everything.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 tools/testing/selftests/iommu/iommufd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 4a9b6e3b37fa..e1470a7a42cd 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3016,6 +3016,20 @@ TEST_F(iommufd_viommu, vdevice_cache)
 	test_ioctl_destroy(vdev_id);
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

