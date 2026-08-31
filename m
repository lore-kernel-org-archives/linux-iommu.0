Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594A3BBFCD
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158595; cv=none; b=fW+mRz8e7USL9vjgukwLKZJseKTsWOCvO3akURJp+If8lUuJ8et2Ff3SrauQeH4iiY39Elb5lER1NkVC0o/idSyRAhVNl+wtY/hle1KAl0F/0jVY8y4dzPFTtEpiekoyuri0bqaWtGgppjm91gX0Ol0D4KbUHQKiENIz+a/HtvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158595; c=relaxed/simple;
	bh=hD504iWH6SSSqkjmHen1AbOwW4nA7QRPXc/vue4tvrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XyluUjbVNlUb8PaBlDCTfsfgTAiv+PjoYyec4LTMiR/GUZ0yFGpHSYn49T+BZHzplRqnP2HSJk+7jLePiEvOlTJLRr4nRY4nnVyoTQhfYN7oI9T3uaxM1yW8hmByY92p6eOKyUHVOdHBC2RPS7+onnzCQU/RSqhHRlQiAUIdhJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jz154Pd7; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jz154Pd7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788158588; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KnRpGDNSnmGwK0xm9uTwqT9M/s9RecAQEpuoHsJ108I=;
	b=Jz154Pd7448EH9h+OJohu5ZrLqg32P/J14Z18NojExTVFofHVZCejL3EzC50p09bda9XTFv5htwwEyXSdm914ovv+Y+Nsd3tio2l+yUiQzsoGYVNU0vf1l5i0H3zD8VGostH7wOa7i0Zt3jUHROUbq+jRDae5RvkBN5hNEL8LPk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X9uOgwV_1788158578;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X9uOgwV_1788158578 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 14:43:07 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: joro@8bytes.org,
	will@kernel.org,
	jgg@ziepe.ca
Cc: robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	smostafa@google.com,
	praan@google.com,
	skhawaja@google.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH] iommupt/kunit: Unmap in the tests before freeing the domain
Date: Mon, 31 Aug 2026 14:42:56 +0800
Message-ID: <20260831064256.2233356-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_increase_level(), test_pgsize_boundary() and test_mixed() leave
their mappings installed and let pt_kunit_iommu_exit() free the whole
table, while the other cases unmap and then check that the table is
empty.

Besides being inconsistent, the mappings which survive into
pt_iommu_deinit() keep the IOMMU_DEBUG_PAGEALLOC references that
iommu_map() took on the mapped pages.  Nothing drops them, so with
iommu.debug_pagealloc=1 the pages behind the hard-coded test OAs stay
counted as IOMMU-mapped and every later allocation or free of one of
them reports:

    WARNING: drivers/iommu/iommu-debug-pagealloc.c:91 at __iommu_debug_check_unmapped+0x4e/0x70, CPU#0: init/1
    iommu: Detected page leak!

Unmap what these tests map, and check in pt_kunit_iommu_exit() that
nothing was left behind so this does not come back.  KUNIT_EXPECT is
used there rather than KUNIT_ASSERT because a failing assert aborts the
rest of the cleanup, which leaves pt_kunit_dev registered and cascades
into the following test cases.

Verified with the generic_pt kunit suite (tools/testing/kunit/kunit.py
--arch=x86_64, drivers/iommu/generic_pt/.kunitconfig), which covers the
amdv1, vtdss, riscv64 and x86_64 formats: the pt_kunit_iommu_exit() check
on its own, without the unmaps, makes exactly these three cases fail and
nothing else (23 of 227 results); with the unmaps there are no failures,
214 passed and 13 skipped.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20260827161828.GA3769797@ziepe.ca
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 drivers/iommu/generic_pt/kunit_iommu_pt.h | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
index ece1c9b8c55d..a9c414951637 100644
--- a/drivers/iommu/generic_pt/kunit_iommu_pt.h
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -119,19 +119,22 @@ static void test_increase_level(struct kunit *test)
 	/* Add every possible level to the max */
 	while (common->max_vasz_lg2 != pt_top_range(common).max_vasz_lg2) {
 		struct pt_range top_range = pt_top_range(common);
+		pt_vaddr_t va;
 
 		if (top_range.va == 0)
-			do_map(test, top_range.last_va + 1, 0,
-			       priv->smallest_pgsz);
+			va = top_range.last_va + 1;
 		else
-			do_map(test, top_range.va - priv->smallest_pgsz, 0,
-			       priv->smallest_pgsz);
+			va = top_range.va - priv->smallest_pgsz;
+		do_map(test, va, 0, priv->smallest_pgsz);
 
 		KUNIT_ASSERT_EQ(test, pt_top_range(common).top_level,
 				top_range.top_level + 1);
 		KUNIT_ASSERT_GE(test, common->max_vasz_lg2,
 				pt_top_range(common).max_vasz_lg2);
+
+		do_unmap(test, va, priv->smallest_pgsz);
 	}
+	KUNIT_ASSERT_EQ(test, count_valids(test), 0);
 }
 
 static void test_map_simple(struct kunit *test)
@@ -404,6 +407,8 @@ static void test_pgsize_boundary(struct kunit *test)
 		kunit_skip(test, "Format does not have the required range");
 
 	do_map(test, 0xfef80000, 0x208b95d000, 0xfef9ffff - 0xfef80000 + 1);
+	do_unmap(test, 0xfef80000, 0xfef9ffff - 0xfef80000 + 1);
+	KUNIT_ASSERT_EQ(test, count_valids(test), 0);
 }
 
 /* See https://lore.kernel.org/r/20250826143816.38686-1-eugkoira@amazon.com */
@@ -425,6 +430,8 @@ static void test_mixed(struct kunit *test)
 	/* 14 2M, 3 1G, 3 2M */
 	KUNIT_ASSERT_EQ(test, count_valids(test), 20);
 	check_iova(test, start, oa, len);
+	do_unmap(test, start, len);
+	KUNIT_ASSERT_EQ(test, count_valids(test), 0);
 }
 
 static struct kunit_case iommu_test_cases[] = {
@@ -465,6 +472,12 @@ static void pt_kunit_iommu_exit(struct kunit *test)
 	if (!test->priv)
 		return;
 
+	/*
+	 * The tests are expected to unmap what they map. Use EXPECT so a
+	 * failure here does not abort the rest of the cleanup.
+	 */
+	KUNIT_EXPECT_EQ(test, count_valids(test), 0);
+
 	pt_iommu_deinit(priv->iommu);
 	/*
 	 * Look for memory leaks, assumes kunit is running isolated and nothing

base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
-- 
2.43.7

