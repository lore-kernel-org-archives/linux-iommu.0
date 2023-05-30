Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D0E63DE
	for <iommu@lists.linux.dev>; Tue, 30 May 2023 05:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425169; x=1716961169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h3j7TOfIQuH7z3LxCDFxk2omlYmPQ3Xc+LrRNfedgCw=;
  b=GeAbGN+qjPqIk74wLYMPYs15/m95ws9t84AHXqKnuxhcZuSyd86gPR3V
   uzKtfJ6HfL089q52i2q2ecjh/geNbIBw1R52niUiJVSiTLyN9UBd+of5y
   7PdZ4JxJw6ykjRO7xyuvTS6ZKKX6fgy5S9iy1oAm6qCV51dlLZZk/dFA+
   ZbcljUarzzBWtFqUVkQWkEXDit+zYMTNDbiH0dR4Lb21wl0OHWxhenTrb
   5f5Lc+yw6KkxlyX34XG3sRTP6l0H7jUwIRzUkAkEaEAdciM8Ey65EywjJ
   VY6NARKJ9LTMa16aTvdoTMl3063dYRIUsrM0PM45T3BTDkffFbaW1vbMG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579940"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579940"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:39:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739370008"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739370008"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:39:25 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCHES 17/17] iommufd/selftest: Cover iopf-capable nested hwpt
Date: Tue, 30 May 2023 13:37:24 +0800
Message-Id: <20230530053724.232765-18-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530053724.232765-1-baolu.lu@linux.intel.com>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The coverage includes operations to allocate, destroy, and replace an
iopf-capable nested HWPT.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 20 ++++++++++++++++---
 tools/testing/selftests/iommu/iommufd.c       | 17 +++++++++++++++-
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 487d45c29c6d..613ee7ef8af8 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -137,7 +137,8 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 	})
 
 static int _test_cmd_hwpt_alloc_nested(int fd, __u32 device_id, __u32 parent_id,
-				       __u32 *hwpt_id)
+				       __u32 event_fd, __u32 *hwpt_id,
+				       __u32 *out_fault_fd)
 {
 	struct iommu_hwpt_selftest data = {
 		.flags = IOMMU_TEST_FLAG_NESTED,
@@ -153,21 +154,34 @@ static int _test_cmd_hwpt_alloc_nested(int fd, __u32 device_id, __u32 parent_id,
 	};
 	int ret;
 
+	if (out_fault_fd) {
+		cmd.event_fd = event_fd;
+		cmd.flags |= (IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE |
+			      IOMMU_HWPT_ALLOC_FLAGS_USER_PASID_TABLE);
+	}
+
 	ret = ioctl(fd, IOMMU_HWPT_ALLOC, &cmd);
 	if (ret)
 		return ret;
 	if (hwpt_id)
 		*hwpt_id = cmd.out_hwpt_id;
+	if (out_fault_fd)
+		*out_fault_fd = cmd.out_fault_fd;
 	return 0;
 }
 
 #define test_cmd_hwpt_alloc_nested(device_id, parent_id, hwpt_id)     \
 	ASSERT_EQ(0, _test_cmd_hwpt_alloc_nested(self->fd, device_id, \
-						 parent_id, hwpt_id))
+						 parent_id, 0, hwpt_id, NULL))
+#define test_cmd_hwpt_alloc_iopf(device_id, parent_id, event_fd,	\
+				 hwpt_id, out_fault_fd)			\
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc_nested(self->fd, device_id,	\
+						 parent_id, event_fd,	\
+						 hwpt_id, out_fault_fd))
 #define test_err_cmd_hwpt_alloc_nested(_errno, device_id, parent_id, hwpt_id) \
 	EXPECT_ERRNO(_errno,                                                  \
 		     _test_cmd_hwpt_alloc_nested(self->fd, device_id,         \
-						 parent_id, hwpt_id))
+						 parent_id, 0, hwpt_id, NULL))
 
 static int _test_cmd_hwpt_invalidate(int fd, __u32 hwpt_id)
 {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 2987e8603418..6bf99172a8e9 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -294,7 +294,9 @@ TEST_F(iommufd_ioas, nested_hwpt_alloc)
 {
 	uint32_t nested_hwpt_id[2] = {};
 	uint32_t parent_hwpt_id = 0;
+	uint32_t event_fd, fault_fd;
 	uint32_t test_hwpt_id = 0;
+	uint32_t iopf_hwpt_id = 0;
 
 	if (self->device_id) {
 		/* Negative tests */
@@ -316,6 +318,12 @@ TEST_F(iommufd_ioas, nested_hwpt_alloc)
 		test_cmd_hwpt_check_iotlb(nested_hwpt_id[1],
 					  IOMMU_TEST_IOTLB_DEFAULT);
 
+		/* Allocate and destroy iopf capable nested hwpt */
+		event_fd = eventfd(0, EFD_CLOEXEC);
+		ASSERT_NE(-1, event_fd);
+		test_cmd_hwpt_alloc_iopf(self->device_id, parent_hwpt_id,
+					 event_fd, &iopf_hwpt_id, &fault_fd);
+
 		/* Negative test: a nested hwpt on top of a nested hwpt */
 		test_err_cmd_hwpt_alloc_nested(EINVAL, self->device_id,
 					       nested_hwpt_id[0],
@@ -344,9 +352,16 @@ TEST_F(iommufd_ioas, nested_hwpt_alloc)
 			     _test_ioctl_destroy(self->fd, nested_hwpt_id[1]));
 		test_ioctl_destroy(nested_hwpt_id[0]);
 
+		/* Switch from nested_hwpt_id[1] to iopf hwpt */
+		test_cmd_mock_domain_replace(self->stdev_id, iopf_hwpt_id);
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, iopf_hwpt_id));
+		test_ioctl_destroy(nested_hwpt_id[1]);
+
 		/* Detach from nested_hwpt_id[1] and destroy it */
 		test_cmd_mock_domain_replace(self->stdev_id, parent_hwpt_id);
-		test_ioctl_destroy(nested_hwpt_id[1]);
+		test_ioctl_destroy(iopf_hwpt_id);
+		close(event_fd);
 
 		/* Detach from the parent hw_pagetable and destroy it */
 		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
-- 
2.34.1

