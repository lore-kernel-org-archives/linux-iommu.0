Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F81FAF
	for <iommu@lists.linux.dev>; Mon,  9 Oct 2023 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBxEwhAj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696841497; x=1728377497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r/ghgXXFlCC5X+m363LcA6Jn28Rpf678n/rxTiOLSIg=;
  b=JBxEwhAjUiX+tMOmy74CNRyegSiUXQ0csHjiBH43cuog4w+s+KzCMV6v
   fMpiYsHeRKg16fC4yG5620pWa6Ga8F+uejM2GxL1PeYAbpnoR4mKzwIaI
   Gd6bpokJ9vhdD8C/7mLw5wizkjv2LUEjklrDP9czfTLXf2mvVl6BQsa2+
   ZLaZ0sQ9QvzRt5rP+WD7deAjn6xvslcyg/J4t8oSILWtQ0I/eT5YrtJg7
   ub0+oaD2Dep+lAZ7+fgFg4e7QJZnytwH2XxMkYxA7adOKnvw+RFhD8hfy
   dir9M95awdYRr+ms440UqdDCrm1MEb20TL0r+YL7YV6H8hK0HZ00wtmBD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="364390839"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="364390839"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 01:51:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="818781714"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="818781714"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2023 01:51:36 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
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
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [RFC 6/7] iommufd/selftest: Add test coverage for SIOV virtual device
Date: Mon,  9 Oct 2023 01:51:22 -0700
Message-Id: <20231009085123.463179-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009085123.463179-1-yi.l.liu@intel.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds test coverage for SIOV virtual device by passsing a non-zero pasid
to IOMMU_TEST_OP_MOCK_DOMAIN op, and check if the SIOV virtual device (a.k.a
pasid of this device) is attached to the mock domain, then tries to replace
with a new hwpt and other types of hwpts, and check if the attached domain of
this virtual device is correct.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 53 ++++++++++++++++++-
 .../selftests/iommu/iommufd_fail_nth.c        | 26 +++++++++
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 9a1fbba89e96..945ab07a8b84 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2031,14 +2031,20 @@ FIXTURE(iommufd_device_pasid)
 	uint32_t device_id;
 };
 
+FIXTURE_VARIANT(iommufd_device_pasid)
+{
+	uint32_t pasid;
+};
+
 FIXTURE_SETUP(iommufd_device_pasid)
 {
 	self->fd = open("/dev/iommu", O_RDWR);
 	ASSERT_NE(-1, self->fd);
 	test_ioctl_ioas_alloc(&self->ioas_id);
 
-	test_cmd_mock_domain(self->ioas_id, 0, &self->stdev_id,
-			     &self->hwpt_id, &self->device_id);
+	test_cmd_mock_domain(self->ioas_id, variant->pasid,
+			     &self->stdev_id, &self->hwpt_id,
+			     &self->device_id);
 }
 
 FIXTURE_TEARDOWN(iommufd_device_pasid)
@@ -2046,6 +2052,12 @@ FIXTURE_TEARDOWN(iommufd_device_pasid)
 	teardown_iommufd(self->fd, _metadata);
 }
 
+/* For SIOV test */
+FIXTURE_VARIANT_ADD(iommufd_device_pasid, siov_pasid_600)
+{
+	.pasid = 600, //this is the default pasid for the SIOV virtual device
+};
+
 TEST_F(iommufd_device_pasid, pasid_attach)
 {
 	if (self->device_id) {
@@ -2071,6 +2083,43 @@ TEST_F(iommufd_device_pasid, pasid_attach)
 					   IOMMU_HWPT_ALLOC_DATA_SELFTEST,
 					   &data, sizeof(data));
 
+		if (variant->pasid) {
+			uint32_t new_hwpt_id = 0;
+
+			ASSERT_EQ(0,
+				  test_cmd_pasid_check_domain(self->fd,
+							      self->stdev_id,
+							      variant->pasid,
+							      self->hwpt_id,
+							      &result));
+			EXPECT_EQ(1, result);
+			test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
+					    0, &new_hwpt_id);
+			test_cmd_mock_domain_replace(self->stdev_id,
+						     new_hwpt_id);
+			ASSERT_EQ(0,
+				  test_cmd_pasid_check_domain(self->fd,
+							      self->stdev_id,
+							      variant->pasid,
+							      new_hwpt_id,
+							      &result));
+			EXPECT_EQ(1, result);
+
+			/*
+			 * Detach hwpt from variant->pasid, and check if the
+			 * variant->pasid has null domain
+			 */
+			test_cmd_pasid_detach(variant->pasid);
+			ASSERT_EQ(0,
+				  test_cmd_pasid_check_domain(self->fd,
+							      self->stdev_id,
+							      variant->pasid,
+							      0, &result));
+			EXPECT_EQ(1, result);
+
+			test_ioctl_destroy(new_hwpt_id);
+		}
+
 		/*
 		 * Attach ioas to pasid 100, should succeed, domain should
 		 * be valid.
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 691903c63de0..a5fb45d99869 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -644,6 +644,32 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	self->pasid = 0;
 
+	if (_test_ioctl_destroy(self->fd, self->stdev_id))
+		return -1;
+
+	self->pasid = 300;
+	self->stdev_id = 0;
+
+	/* Test for SIOV virtual devices attach */
+	if (_test_cmd_mock_domain(self->fd, ioas_id, self->pasid,
+				  &self->stdev_id, NULL, &idev_id))
+		return -1;
+
+	/* Test for SIOV virtual device replace */
+	if (_test_cmd_mock_domain_replace(self->fd, self->stdev_id,
+					  hwpt_id, NULL))
+		return -1;
+
+	if (_test_cmd_pasid_detach(self->fd, self->stdev_id, self->pasid))
+		return -1;
+
+	self->pasid = 0;
+
+	if (_test_ioctl_destroy(self->fd, self->stdev_id))
+		return -1;
+
+	self->stdev_id = 0;
+
 	return 0;
 }
 
-- 
2.34.1

