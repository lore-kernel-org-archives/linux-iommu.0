Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1237D139
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774692601; cv=none; b=oSFjeih+AphexU5XBvO0GCJeVCAw0L5ggi3WddfjVJ6VAN1xejJuGPCczR/Mehp2TRE4xZsLGe1ZmHKExfsaPGBGTyvebRhQonIeULUPBQIEkD1LG6sxnyS3Qlpj/AJdW32heIbWOM9u8Av7bXiivm0DaMVLlYZanStVfhlXqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774692601; c=relaxed/simple;
	bh=o/YkXcR5vyMXwkxya6PyClgBlH9t5YAY4h3tB58KYgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMI+UYlWsz6IGlxUob6a2n4wv6mTEwefF7t4AFU2kVKKvW0AFZfZC6/PovA3C6Yzb6JVlj2yKt5yDpBjsmUhtbbn0AGf3wxbBfV1N7rkYUmILetFEGmvbVLqtQ3SlsdLGivWYup4S6LbIYUmJKHFRvpAT3kVDwqulFh6bH7mg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cWsDiIDo; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cWsDiIDo"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zEfQ2xHD20u2SNJPKNUNUUMLTWyeWszA9wRDOE62vLc=;
	b=cWsDiIDox67v1VfnLwL3COzpfWl/zHQy+xzjtvGgkgF5nnzZ69dsU/MT5LgpVfsBbXbqEogm1
	yi+rkN5uJADT2kmyr5E3gdeQitAdEpzq/yul6Z0nefWUnNcLGzKaS+WKXKMof2ZS9LH0tZY1Bef
	liOWaPfDh1Tqhwehso/utHE=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fjY4j3Kx0zRhQc;
	Sat, 28 Mar 2026 18:03:49 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F04C4056A;
	Sat, 28 Mar 2026 18:09:56 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Mar 2026 18:09:55 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <robin.murphy@arm.com>, <nicolinc@nvidia.com>, <will@kernel.org>,
	<jpb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <wuyifan50@huawei.com>, <linuxarm@huawei.com>
Subject: [RFC PATCH v2 4/5] iommu/arm-smmu-v3: Add device symlink in stream table debugfs
Date: Sat, 28 Mar 2026 18:09:52 +0800
Message-ID: <20260328100953.3441915-5-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260328100953.3441915-1-xiaqinxin@huawei.com>
References: <20260328100953.3441915-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Add a symlink named  under each stream table entry directory pointing to
the sysfs directory of the actual device. This aids debugging
by providing direct access to device attributes.

/sys/kernel/debug/iommu/arm_smmu_v3/smmu0/stream_table/
└── <sid>/
    ├─── ste
    └─── <dev_name>

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-debugfs.c     | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
index 70623b480d64..dbcc8fce6d8e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
@@ -8,8 +8,9 @@
  *     ├── capabilities    # SMMU feature capabilities and configuration
  *     ├── registers	   # SMMU Key registers
  *     └── stream_table
- *	   └─── <sid>/                                # Stream ID 0
- *	       └── ste                                # Stream Table Entry
+ *	   └─── <sid>/                                # Stream ID
+ *	       ├─── ste                               # Stream Table Entry
+ *	       └── <dev_name>                         # Symlink to device sysfs directory
  *
  * The capabilities file provides detailed information about:
  * - translation stage support (Stage1/Stage2)
@@ -31,6 +32,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/debugfs.h>
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include "arm-smmu-v3.h"
 
@@ -295,6 +297,7 @@ int arm_smmu_debugfs_create_stream_table(struct device *dev,
 	struct dentry *stream_dir, *dev_dir;
 	struct arm_smmu_master *master;
 	struct ste_context *ctx;
+	char *path, *full_path;
 	char name[64];
 	u32 sid;
 	int i;
@@ -333,6 +336,18 @@ int arm_smmu_debugfs_create_stream_table(struct device *dev,
 		debugfs_create_file("ste", 0444, dev_dir, ctx,
 				    &smmu_debugfs_ste_fops);
 
+		/* Create a symlink to the device's sysfs directory */
+		path = kobject_get_path(&dev->kobj, GFP_KERNEL);
+		if (!path)
+			continue;
+
+		full_path = kasprintf(GFP_KERNEL, "/sys%s", path);
+		if (full_path) {
+			debugfs_create_symlink(dev_name(dev), dev_dir, full_path);
+			kfree(full_path);
+		}
+
+		kfree(path);
 	}
 
 	return 0;
-- 
2.33.0

