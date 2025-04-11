Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5BB2367A9;
	Fri, 11 Apr 2025 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376069; cv=none; b=N7MAP7q2DMco7XPgbcbOTCN03+7sQf2gkmXyoGZnv88KaF5NHfPAawThZk3Wx/Ywj0MlWPPDkYVgQ8f29L1kfC2P+eoP0GSZMq+DSf0b/o8w0K1EOPTvv6tEM7+Ur/cK/X3WhHIoFPlSKEuhtqndMbIcULLH8UhJ1c0KJw2+aeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376069; c=relaxed/simple;
	bh=lr+VhLf3eXJXBu37NmhSosbRGBfKF2EPlcRShgMJRbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sSB7mLG1nPsKEXPEAE8h7zPjmmWHJzfsTok0RHga/+9kV/cbMHV0MSY2g+S8ChfytYNPrb7LAFfcVqY5dnTHk2dfJwQ6Z4U8IgpJ+JkHVsBHWhilUBSj0497XPXalKbsFa3hk3F0KV+p8yM78MM74hUECYNBVWjsTdIh1i5ZxMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdPxPKev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdPxPKev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873B7C4CEE2;
	Fri, 11 Apr 2025 12:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744376068;
	bh=lr+VhLf3eXJXBu37NmhSosbRGBfKF2EPlcRShgMJRbA=;
	h=From:To:Cc:Subject:Date:From;
	b=TdPxPKev03UUFySrQxT/GFeKWB+7u5ocABW13IchDRYBUzEp6eeDdTAvl/yId1hjN
	 LjOe6EafD6mB2dmf1r0ShO0aXU4lYlOlnEwMxPJQiw+J9yiH1VcywfFEE27RNg94pK
	 raYsx2DIaa+vKq0BjWx8OLfnrZx1cS1crT/Ug8Lzporamz5UOnflqv5RgTIHJwBtBk
	 E0Wy3g37/Izdj8/ZuT7yQCCuAcKgS44nW72bx/rWqVcRnNq4Irwej7+4N9gvQY9x7n
	 Y54gAWBWwDmXyYPFRkWoR/KMNYu24g5xtKHIE4FmC7cxzSmgIzjXMj4eHa6zdlHK7m
	 fOk7PWDK+KxeQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Rob Clark <robdclark@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/io-pgtable-arm: dynamically allocate selftest device struct
Date: Fri, 11 Apr 2025 14:54:11 +0200
Message-Id: <20250411125423.1411061-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

In general a 'struct device' is way too large to be put on the kernel
stack. Apparently something just caused it to grow a slightly larger,
which pushed the arm_lpae_do_selftests() function over the warning
limit in some configurations:

drivers/iommu/io-pgtable-arm.c:1423:19: error: stack frame size (1032) exceeds limit (1024) in 'arm_lpae_do_selftests' [-Werror,-Wframe-larger-than]
 1423 | static int __init arm_lpae_do_selftests(void)
      |                   ^

Change the function to use a dynamically allocated platform_device
instead of the on-stack device structure. The device is not actually
registered with the system, but is initialized enough to be used here.

Fixes: ca25ec247aad ("iommu/io-pgtable-arm: Remove iommu_dev==NULL special case")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/io-pgtable-arm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 7632c80edea6..9f3bf0b5e8da 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -1433,15 +1434,17 @@ static int __init arm_lpae_do_selftests(void)
 	};
 
 	int i, j, k, pass = 0, fail = 0;
-	struct device dev;
+	struct platform_device *pdev;
 	struct io_pgtable_cfg cfg = {
 		.tlb = &dummy_tlb_ops,
 		.coherent_walk = true,
-		.iommu_dev = &dev,
 	};
 
-	/* __arm_lpae_alloc_pages() merely needs dev_to_node() to work */
-	set_dev_node(&dev, NUMA_NO_NODE);
+	pdev = platform_device_alloc("io-pgtable-test", 0);
+	if (!pdev)
+		return -ENOMEM;
+
+	cfg.iommu_dev = &pdev->dev;
 
 	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
 		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
@@ -1461,6 +1464,8 @@ static int __init arm_lpae_do_selftests(void)
 	}
 
 	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
+	platform_device_put(pdev);
+
 	return fail ? -EFAULT : 0;
 }
 subsys_initcall(arm_lpae_do_selftests);
-- 
2.39.5

