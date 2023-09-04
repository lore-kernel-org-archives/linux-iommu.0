Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C7937E
	for <iommu@lists.linux.dev>; Mon,  4 Sep 2023 02:39:35 +0000 (UTC)
X-QQ-mid: bizesmtp62t1693794758twa69jzb
Received: from localhost ( [221.216.117.35])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Sep 2023 10:32:36 +0800 (CST)
X-QQ-SSF: 0140000000000010B000000A0000000
X-QQ-FEAT: tSQw27OYC23XBEqWAG0b/gTmfSNbAKillH2LUjy1Y2LDOPl/U8lWxIKgXVvVx
	MLTV21ye1KpLb/hbWDfY01FkK0KYbpuZjFieCaTbQP6lLhzTZnbDUVSBBpIrY71Qf065rpX
	1LP8ATObXQAfZJytn/j/UG4NoSLbLYU7Moac48ZU/9upewz4d7fR+z1F86kCMa/1D4Rl92e
	hdbAsvyLc+ynboOkXUYwTHHeuvwVtPSfUjuXnUm8a/qSSECZfvFswb+uaSG3F77usy0Pdg0
	zQNuT753vw6RYU11MMboLqXSbBogycvswg5N6xA5yo15bXaD1rqdKY1ViiUI5AvY5Ql7LzV
	l1rd7qcfnxhkqq5WeD4xHvRv1NYPx1afqBa2iSHPwdx8wxMlV8=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2023375898041890435
Date: Mon, 4 Sep 2023 10:32:36 +0800
From: GuokaiXu <xuguokai@ucas.com.cn>
To: jgg@ziepe.ca, kevin.tian@intel.com, shuah@kernel.org
Cc: iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] tools/testing/selftests/iommu:Fixed spelling errors in
 comments
Message-ID: <31680D47D9533D91+20230904023236.GA12494@xgk8823>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:ucas.com.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

From c4e404036e0a7ffcaedc5760bee234713ccfe4a4 Mon Sep 17 00:00:00 2001
From: GuokaiXu <xuguokai@ucas.com.cn>
Date: Mon, 4 Sep 2023 10:18:04 +0800
Subject: [PATCH 1/1] Fix the spelling errors in comments

Signed-off-by: GuokaiXu <xuguokai@ucas.com.cn>
---
 tools/testing/selftests/iommu/iommufd.c          | 2 +-
 tools/testing/selftests/iommu/iommufd_fail_nth.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 33d08600be13..b7249ffc6750 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1729,7 +1729,7 @@ TEST_F(vfio_compat_mock_domain, map)
 	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
 	ASSERT_EQ(BUFFER_SIZE, unmap_cmd.size);
 
-	/* UNMAP_FLAG_ALL requres 0 iova/size */
+	/* UNMAP_FLAG_ALL requires 0 iova/size */
 	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
 	unmap_cmd.flags = VFIO_DMA_UNMAP_FLAG_ALL;
 	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index a220ca2a689d..36e7aa4f615c 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -105,7 +105,7 @@ static bool fail_nth_next(struct __test_metadata *_metadata,
 
 	/*
 	 * This is just an arbitrary limit based on the current kernel
-	 * situation. Changes in the kernel can dramtically change the number of
+	 * situation. Changes in the kernel can dramatically change the number of
 	 * required fault injection sites, so if this hits it doesn't
 	 * necessarily mean a test failure, just that the limit has to be made
 	 * bigger.
-- 
2.25.1

