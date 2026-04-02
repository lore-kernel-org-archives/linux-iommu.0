Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C6737E2F2
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113224; cv=none; b=tzb9unbqWFXLMWsXORvtOvKwZE409xzgAHZSpqMdrZl8D/GiwGigi2tyAPDlJFFbC/oQc70nTV4wBwZPePv9QQP9t8e/ahW5/D70scpAJUJSKIXEFsBl64ZD4iQVKewc7zX1eaMIE9rwDRUjxk5138vMT/2vBCZ7xNhEFjCT0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113224; c=relaxed/simple;
	bh=AJgbjTMo4uteJP2yu4rYIFseJzFeYRWEjPiRIt6mV6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdjmfPrlVHcD+0c1gipKkMNiHlk4YvqA2lxt+Vbi/MoCaATQmpgtyQFY6BoKc+pVd6iie6V0sMRkISVsFLFjfoMV8BxD8pt0p7nQE7Rt7AIPIW1sPtzh0LjSk84SJOPMb32wS63OXKcX6+dbtlH4sSq8KeqHXTMJVpu8Ad44SEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+bqB9gd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+bqB9gd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775113223; x=1806649223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AJgbjTMo4uteJP2yu4rYIFseJzFeYRWEjPiRIt6mV6U=;
  b=X+bqB9gd/eHWIetS+K+NAGffAGMgKr7SLk63a/oqc6VFxQ3129BWdbgh
   diT+qDoLUX0Opqy9txgnAYIXV1nKAu/MsPeJNZP5GD7n8tkRNQ5juV8Jt
   SCvVLaC1yd8eixeSw8wT66X1gWLyxqqJWVHWCGedSibiP3FuAQQt1NlVT
   /y4amENFsfcELS2g+HEVWpxVBnIT7hGL8EhnQ0lkbckASeDzNCAM/shUy
   N3zvbeZYSBwn5A4TDAnO8uQaggiWjocXIHoZrq/7hLTVAZdqoIG+ZS6bq
   GyWU5cydXv9ic8nRkmdRk4/H15Q1mjxflgjSHIsUtF6zvCCwrX/QLl8AM
   Q==;
X-CSE-ConnectionGUID: LtK4K1afSZCUaKZOsqQWWg==
X-CSE-MsgGUID: Cax0cGqFSmWLE7FfxJrfOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76053638"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76053638"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 00:00:20 -0700
X-CSE-ConnectionGUID: /NsrcIFmTnOkee3ADfUz7A==
X-CSE-MsgGUID: DnwYh4I5Qh6MLBB7G8v+IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="231847841"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 02 Apr 2026 00:00:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] iommufd/selftest: Test dirty tracking on PASID
Date: Thu,  2 Apr 2026 14:57:27 +0800
Message-ID: <20260402065734.1687476-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
References: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Add test case for dirty tracking on a domain attached to PASID, also
confirm attachment to PASID fail if device doesn't support dirty tracking.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260330101108.12594-5-zhenzhong.duan@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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
2.43.0

