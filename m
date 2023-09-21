Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96545676
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 07:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695282752; x=1726818752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h3pYIci+iZkkMqhwJQHGy+I5as9zK7da73IbWNzAKLo=;
  b=REG++/wmePLT1ui/7xUQEG+ms/ybFqBEiwKSlMPVmnmJrBq/0BYlgCmB
   odnRfyyya6sU4tQ6mw95kCFkPoDyT99Y8vSZ5HEUiNfgUN8xdku/9Q7+w
   aiF8I4nnQ332e2sBji8ULvybrfpEX0gEBJVR6yWxkVguWihULMg3Jfyat
   SwqdsnzNRFLnzY9vf+O7YDXnqaM+hesHDoFP5NMGf7JOjEsTi22xgeiNm
   HTLke1s4WdqNH2OO/tDiBzruK2ktqPSVLrWaUz4ZyWPEW+KX2DbP+jM3U
   XdT9JMEmKBrD0134mi0pv6H7ZhldLAj38Cgmbp7gKjpGzoGRaZAcIBowj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832937"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832937"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649573"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649573"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:16 -0700
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
Subject: [PATCH v4 12/17] iommufd/selftest: Rework TEST_LENGTH to test min_size explicitly
Date: Thu, 21 Sep 2023 00:51:33 -0700
Message-Id: <20230921075138.124099-13-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075138.124099-1-yi.l.liu@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

TEST_LENGTH passing ".size = sizeof(struct _struct) - 1" expects -EINVAL
from "if (ucmd.user_size < op->min_size)" check in iommufd_fops_ioctl().
This has been working when min_size is exactly the size of the structure.

However, if the size of the structure becomes larger than min_size, i.e.
the passing size above is larger than min_size, that min_size sanity no
longer works.

Since the first test in TEST_LENGTH() was to test that min_size sanity
routine, rework it to support a min_size calculation, rather than using
the full size of the structure.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 tools/testing/selftests/iommu/iommufd.c | 29 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 9c129e63d7c7..7a29d68bd1d2 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -86,12 +86,13 @@ TEST_F(iommufd, cmd_fail)
 
 TEST_F(iommufd, cmd_length)
 {
-#define TEST_LENGTH(_struct, _ioctl)                                     \
+#define TEST_LENGTH(_struct, _ioctl, _last)                              \
 	{                                                                \
+		size_t min_size = offsetofend(struct _struct, _last);    \
 		struct {                                                 \
 			struct _struct cmd;                              \
 			uint8_t extra;                                   \
-		} cmd = { .cmd = { .size = sizeof(struct _struct) - 1 }, \
+		} cmd = { .cmd = { .size = min_size - 1 },               \
 			  .extra = UINT8_MAX };                          \
 		int old_errno;                                           \
 		int rc;                                                  \
@@ -112,17 +113,19 @@ TEST_F(iommufd, cmd_length)
 		}                                                        \
 	}
 
-	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY);
-	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO);
-	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC);
-	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC);
-	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES);
-	TEST_LENGTH(iommu_ioas_allow_iovas, IOMMU_IOAS_ALLOW_IOVAS);
-	TEST_LENGTH(iommu_ioas_map, IOMMU_IOAS_MAP);
-	TEST_LENGTH(iommu_ioas_copy, IOMMU_IOAS_COPY);
-	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP);
-	TEST_LENGTH(iommu_option, IOMMU_OPTION);
-	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS);
+	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY, id);
+	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO, __reserved);
+	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC, __reserved);
+	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC, out_ioas_id);
+	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES,
+		    out_iova_alignment);
+	TEST_LENGTH(iommu_ioas_allow_iovas, IOMMU_IOAS_ALLOW_IOVAS,
+		    allowed_iovas);
+	TEST_LENGTH(iommu_ioas_map, IOMMU_IOAS_MAP, iova);
+	TEST_LENGTH(iommu_ioas_copy, IOMMU_IOAS_COPY, src_iova);
+	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP, length);
+	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
+	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
 #undef TEST_LENGTH
 }
 
-- 
2.34.1

