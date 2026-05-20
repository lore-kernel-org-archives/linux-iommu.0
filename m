Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DAE33E35B
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259049; cv=none; b=JuhrLAPe9c5gGqhns4xsSu/g8yQjWb3oEKQ0/4S6qx9vnsprVympueBJvy1skjSpctTw2lo9ia8uIEpa6Capszyb0AmsomBokE9rZH3M1h3Rq8cNFIKVHJyvupVprBRD9a2YBbQ7U7r8TqxHqGcptLxcIR/v28O+ZJsAe/7ysnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259049; c=relaxed/simple;
	bh=id5nu2+5revVGV2X7GFUSfspCR6Al6e4oMBFp59uBPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0Zzljr07ktrTpU9BMYlRA6ph+legsxECSz81boGCmS+fIiiOYUzq8XK0SHEf07LnjDM+PZuIFjRrTI3bCcBxvacReypf6l0J592SeGB6tEeMTJg4MDRqwJKQGXumWWxxPAsN0vb2IAaj6lagt9T+rM/6zCOJyLNqZBlS7l3vqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DTUgcXX0; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DTUgcXX0"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Vu3EZBeWinYUHPBmY/X090V8/6NEcv7XCtOXv6H294Q=;
	b=DTUgcXX0QCOxzf8m0FRgEYq6mHvJ8fm5/LaunYVYwK8xC/eRMYpl+bJhsuFUryDpThYXxX4SD
	zD5E2giVkd242GleR1g//3guxL955J3f6aBVzlkV2nSgD1kadg92DnjwG042X0ideouW+DMHrsE
	PjSrMIPTDI/RKohWj9cLQ1I=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gL1qt6q77z12LDX;
	Wed, 20 May 2026 14:30:18 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 307AB40537;
	Wed, 20 May 2026 14:37:20 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 14:37:19 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <robin.murphy@arm.com>, <nicolinc@nvidia.com>, <will@kernel.org>,
	<jpb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <wuyifan50@huawei.com>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] iommu/arm-smmu-v3: Add device symlink in stream table debugfs
Date: Wed, 20 May 2026 14:37:10 +0800
Message-ID: <20260520063714.2440584-4-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260328101706.3448655-1-xiaqinxin@huawei.com>
References: <20260328101706.3448655-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
index a5866f34264f..9babc7d640fd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
@@ -10,6 +10,7 @@
  *     ├── stream_table
  *         ├── <sid>/                                # Stream ID
  *             ├── ste                               # Stream Table Entry
+ *             ├── <dev_name>                         # Symlink to device sysfs directory
  *
  * The capabilities file provides detailed information about:
  * - translation stage support (Stage1/Stage2)
@@ -31,6 +32,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/debugfs.h>
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include "arm-smmu-v3.h"
 
@@ -314,6 +316,7 @@ int arm_smmu_debugfs_create_stream_table(struct arm_smmu_device *smmu,
 	struct dentry *stream_dir, *dev_dir;
 	struct arm_smmu_master *master;
 	struct ste_context *ctx;
+	char *path = NULL, *full_path;
 	char name[64];
 	u32 sid;
 	int i;
@@ -338,6 +341,9 @@ int arm_smmu_debugfs_create_stream_table(struct arm_smmu_device *smmu,
 	if (!master || !master->num_streams)
 		return -ENODEV;
 
+	/* Get device sysfs path once, reuse for all streams */
+	path = kobject_get_path(&dev->kobj, GFP_KERNEL);
+
 	for (i = 0; i < master->num_streams; i++) {
 		sid = master->streams[i].id;
 		snprintf(name, sizeof(name), "%u", sid);
@@ -357,8 +363,19 @@ int arm_smmu_debugfs_create_stream_table(struct arm_smmu_device *smmu,
 		spin_unlock(&smmu->debugfs->stream_lock);
 		debugfs_create_file("ste", 0444, dev_dir, ctx,
 				    &smmu_debugfs_ste_fops);
+
+		/* Create a symlink to the device's sysfs directory */
+		if (path) {
+			full_path = kasprintf(GFP_KERNEL, "/sys%s", path);
+			if (full_path) {
+				debugfs_create_symlink(dev_name(dev), dev_dir,
+						       full_path);
+				kfree(full_path);
+			}
+		}
 	}
 
+	kfree(path);
 	return 0;
 }
 
-- 
2.33.0

