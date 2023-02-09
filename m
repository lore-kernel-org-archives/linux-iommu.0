Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98911627
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675916216; x=1707452216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HKkQ3XLh/cgddbfTjAzae85+rSiZHI2gRNi0xQo2hVQ=;
  b=CfJTkvyv/BMwVcfftq3C3aHsME6aGc4916+LuakbNnE7/WfgGtiO+d5J
   +aLRzFA+Mw5UEXvN+98HZzSFX0XCUON4kFsLh8OB0600Po8p/NBp7HGs3
   hSbp/l8HRuPWjE+Cy/3y0doVbALb8kRq3eCPJDIKPwzb49QY6aqvzOdF0
   MNoVs19fTiw9kUIysvr67p4TyWUOQzMspXE9B0MyJF7Q+lu5Sb7KD0xTs
   LR+9SxvMqo2VHtGKVHBbgwOQS4DEy4F+6gCvb0OzJXRvaww6mMDmPjn9K
   VCYtkC+wfSMHZvtNPWIIp/W6S/9hN0AYlT1qar9WCdYmZiK+XCzOAemX4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394600759"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394600759"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:16:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="912982130"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="912982130"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2023 20:16:54 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com
Subject: [PATCH 5/6] iommufd/selftest: Set iommu_device for mock_device
Date: Wed,  8 Feb 2023 20:16:41 -0800
Message-Id: <20230209041642.9346-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209041642.9346-1-yi.l.liu@intel.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

This is required to avoid NULL pointer when iommufd selftest tries to
allocate domain for mock_device.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 2ecde22a60f4..5afed3fc30fe 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -273,6 +273,8 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 				    struct iommu_test_cmd *cmd)
 {
+	static struct iommu_device iommu_dev = { .ops = &mock_ops };
+	static struct dev_iommu iommu = { .iommu_dev = &iommu_dev };
 	static struct bus_type mock_bus = { .iommu_ops = &mock_ops };
 	struct iommufd_hw_pagetable *hwpt;
 	struct selftest_obj *sobj;
@@ -291,6 +293,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	sobj->idev.ictx = ucmd->ictx;
 	sobj->type = TYPE_IDEV;
 	sobj->idev.mock_dev.bus = &mock_bus;
+	sobj->idev.mock_dev.iommu = &iommu;
 
 	hwpt = iommufd_device_selftest_attach(ucmd->ictx, ioas,
 					      &sobj->idev.mock_dev);
-- 
2.34.1

