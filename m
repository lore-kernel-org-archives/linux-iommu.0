Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1170E19E966;
	Wed, 23 Apr 2025 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426913; cv=none; b=qhigZy2uFcD7aF8dxisW8WpsO+vYuBjeIeo1MENxzrtT+nbXmh0ASh4MwBhbgQTjYZJ0cnC+MIMGQ7KxHzjHpNPdj9qWKklfypB+Q9ptW/G8k1WJQ4Lp5covBTSKi49bOtQchsKkgyrGOXyF/vgdyWgkWzMmBtJRHtwetBhLd08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426913; c=relaxed/simple;
	bh=DT2vdXkm5UTmWS58pbDzSP2uTIp7fiBR1eJQ+9e9UMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qd5I4Fa4tnyEZspZo/vIe50rWiR/A7B77yv6rQmutqMHP5td2ENqZlr8LcL2NXx8g3ouiXgibbAI8Ht5Ysk0sKfAa7o12ozU6xG3i00MlcPo7L+s+vArWOnoefXCNUdJV5DaVhjqMDG2YtDyr6R3Wl/sikH002RiRTf2R/konHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpQSXkaI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpQSXkaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DA3C4CEE8;
	Wed, 23 Apr 2025 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745426912;
	bh=DT2vdXkm5UTmWS58pbDzSP2uTIp7fiBR1eJQ+9e9UMI=;
	h=From:To:Cc:Subject:Date:From;
	b=kpQSXkaICpkzZ85VDQxj7jy1Bsx9d36+2o7RD6suAZam+Qz8iAU3ZXGGMEoI84UjR
	 S9+zC70OJ0b4r4Prz6c8evH4/Dlu/YJd6rphhF4ecKgW2xw2iFiw/780ZHEKec8DPg
	 g6rD9pD0TKJAtYfc8Yiwr3I314Vf55tVWwPuhG9WNHhP2oJTmYBfZBcR03qoUh5WZp
	 sd2vF53MvXxmqLsE7hEOhoKFBgDxc5cRr4sv5vMyBBQyt+Kco4pL/GBlmaIIb/Xk96
	 37uYkmpUqvJ/FBbbj3rsYnX4of6vmJrPIciBEklfktvC+w/i9aS9faia7MedbplwI3
	 F6amN7bzOvcgQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Rob Clark <robdclark@chromium.org>,
	Kunkun Jiang <jiangkunkun@huawei.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] iommu/io-pgtable-arm: dynamically allocate selftest device struct
Date: Wed, 23 Apr 2025 18:48:16 +0200
Message-Id: <20250423164826.2931382-1-arnd@kernel.org>
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

Change the function to use a dynamically allocated faux_device
instead of the on-stack device structure.

Fixes: ca25ec247aad ("iommu/io-pgtable-arm: Remove iommu_dev==NULL special case")
Link: https://lore.kernel.org/all/ab75a444-22a1-47f5-b3c0-253660395b5a@arm.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use faux device instead of platform_device, as Robin suggested.
    The faux device is more appropriate here since the is no actual physical
    device, though on the other hand the v1 patch had the advantage of not
    actually needing to register the device.
---
 drivers/iommu/io-pgtable-arm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 545229cf62d2..bbd42323c029 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
+#include <linux/device/faux.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -1437,15 +1438,17 @@ static int __init arm_lpae_do_selftests(void)
 	};
 
 	int i, j, k, pass = 0, fail = 0;
-	struct device dev;
+	struct faux_device *dev;
 	struct io_pgtable_cfg cfg = {
 		.tlb = &dummy_tlb_ops,
 		.coherent_walk = true,
-		.iommu_dev = &dev,
 	};
 
-	/* __arm_lpae_alloc_pages() merely needs dev_to_node() to work */
-	set_dev_node(&dev, NUMA_NO_NODE);
+	dev = faux_device_create("io-pgtable-test", NULL, 0);
+	if (!dev)
+		return -ENOMEM;
+
+	cfg.iommu_dev = &dev->dev;
 
 	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
 		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
@@ -1465,6 +1468,8 @@ static int __init arm_lpae_do_selftests(void)
 	}
 
 	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
+	faux_device_destroy(dev);
+
 	return fail ? -EFAULT : 0;
 }
 subsys_initcall(arm_lpae_do_selftests);
-- 
2.39.5

