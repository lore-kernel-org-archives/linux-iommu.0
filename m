Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4B268C63
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 04:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752034283; cv=none; b=axp0leYkJRalnhMpLMpN2eYqtwnK/i49I+8z0w7aoGcU9aJPSYORNTCUi2iyK4v1IfYtSCI1LPhR2b3R4L9jowgnB0+J7qevOEH2LE2lVBqpCE0AAijQR3dndC/JSf4X7vLRLO6IgRM1RkGU1ocCdrqqM9EEU38vXicj/dQDirM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752034283; c=relaxed/simple;
	bh=fK16mo7DG7cquXHm19Z+gYhG43gjt271XQww/gwmjL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+3aRRWoPzzqh/vRCSXmG4/iXCIVdcDuS75ykEMuOFeUd5WYLzABQ0eimKekdA7S+8guDTv3YWFBwE+3CzbUT2AICrikMwjgSAV2DEoctmr2filsp4EkwBGZPkim3sym6JM5t/99cL3l0zLKOinbOhoaQtweN0GvDhFBkBrZnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCCwScK/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCCwScK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752034282; x=1783570282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fK16mo7DG7cquXHm19Z+gYhG43gjt271XQww/gwmjL8=;
  b=dCCwScK/BNb+2wX+F8JS6k1SlOrMAY7OdSD6Q6JBvhWnlmYm5DVJvcde
   2QybmDMnoHY129XKodzCSS/soPeSjA1kGNvpRA3XdYFyjiAUqzi7uCLtY
   IVIJI3mX3UT6+eOhNUw4zQJWMBaaSOEjAoA8i9oJRDMedHaSCr19zIpPU
   WIjnOHg7MxfR5bVMbuwozcDnnkDzSBT8PaGLwTTQLSal/1tr5r1a23mSW
   GPxePXiDyTDFP4jJigKWmsf1hMcBGImns9U50QStj8QTjDUCttBSQYKDq
   KPcaBG0/loMOoYzbiBJoKzIzwzkGTwYBBz9rTmicKiUFMsD36FpfTDtCa
   Q==;
X-CSE-ConnectionGUID: vBCTWQBBRBWAam7R/ccNWw==
X-CSE-MsgGUID: +4QQZByASmqwG248PA5PLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76831845"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="76831845"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 21:11:21 -0700
X-CSE-ConnectionGUID: uto1ld5TQxiILy36P4aEKA==
X-CSE-MsgGUID: pCh99x0jT7yeUkARkLbewA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192851680"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 08 Jul 2025 21:11:18 -0700
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
Subject: [PATCH v4 7/7] iommufd/selftest: Add coverage for vdevice tombstone
Date: Wed,  9 Jul 2025 12:02:34 +0800
Message-Id: <20250709040234.1773573-8-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
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

