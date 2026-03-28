Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DBF3859D0
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774693039; cv=none; b=HLf3lEv+loZ/UZA4q70oadlMNh+cKH0xW5GJQeGxlPAWtGuLcuEEBt9qr7fDb/wR+M7563c8HmmYmpY5PQesOkZwtG9j9WPVGxzS3piIcOLFjxpDctaFeGrNrTkkCJcKmPvLUpy4nL/JgUNNVSPPG0RtuFzHqKJ1g4WMeMSxn2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774693039; c=relaxed/simple;
	bh=TkrCjlvKxJ2GHd2Al6MZ34CBWN7ZiSxRJeYN99DYv6U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nqi3B9YgAFSoOjdd0XCJzMFSnvhCOA4XYI4BJV0EsBBs9LgSNsb5WfOj85XL9OtoyqfbVTX5QPVih2t66zjMJ6HxqWZRjPRrgjPRbMn3Bm0eBFXqfey5eNsPeJ1ZwZ6cYvCG0tvHCaa4rMlsRajc4iJnrMdWG/Qbew0t96rqv60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Jf2prgtE; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Jf2prgtE; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Jf2prgtE";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Jf2prgtE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4AaMlouoSdoLO09YMstibKmWb5wdcKm3CtKkeSW3Zrc=;
	b=Jf2prgtEKbtoy5HpZKi3npCtQBHN+jBA+Q09KK0A2nl6mNq/gJEIxHkm0Bwlex7M8Pz4TPj4Q
	OJ8NNoj5MokDNh9LgyqVksKwdbHNIRZ8NJzCrZmf5U7dcvpYrBJ9c1YKEU5zDMdwsfSHPl9G3qk
	hV0Sa4eKyGJu7dhToJt7IYo=
Received: from canpmsgout08.his.huawei.com (unknown [172.19.92.156])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fjYN124rCz1BFq2
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 18:17:05 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4AaMlouoSdoLO09YMstibKmWb5wdcKm3CtKkeSW3Zrc=;
	b=Jf2prgtEKbtoy5HpZKi3npCtQBHN+jBA+Q09KK0A2nl6mNq/gJEIxHkm0Bwlex7M8Pz4TPj4Q
	OJ8NNoj5MokDNh9LgyqVksKwdbHNIRZ8NJzCrZmf5U7dcvpYrBJ9c1YKEU5zDMdwsfSHPl9G3qk
	hV0Sa4eKyGJu7dhToJt7IYo=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fjYDy5d0gzmV6s;
	Sat, 28 Mar 2026 18:10:58 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id A04F240565;
	Sat, 28 Mar 2026 18:17:07 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Mar 2026 18:17:06 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <robin.murphy@arm.com>, <nicolinc@nvidia.com>, <will@kernel.org>,
	<jpb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <wuyifan50@huawei.com>, <linuxarm@huawei.com>
Subject: [RFC PATCH v2 0/5] Add debugfs support for ARM SMMUv3
Date: Sat, 28 Mar 2026 18:17:01 +0800
Message-ID: <20260328101706.3448655-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
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

Add a comprehensive debugfs framework to the ARM SMMUv3 driver,                                                                                                                                                                                                                                                       
providing visibility into internal hardware state for debugging
and performance analysis. The debugfs entries are organized under
/sys/kernel/debug/iommu/arm_smmu_v3/, with per-SMMU instance directories
and per-device stream table entries.
                 
Each SMMU instance provides:
- capabilities – static SMMU features and queue sizes.
- registers – SMMU key registers.
- stream_table/ – a directory per device with subdirectories per Stream ID. 
                 
Each Stream ID subdirectory contains:
- ste – the Stream Table Entry in decoded and raw format.
- cd – all valid Context Descriptors (Stage 1 translation tables) associated with the device.
- a symlink named with the device’s BDF/name pointing to its sysfs directory for easy navigation.
                 
/sys/kernel/debug/iommu/arm_smmu_v3/smmu0/stream_table/
└── <sid>/       
    ├─── ste  
    ├─── cd   
    └─── <dev_name>

Changes since V1:
  Address the comments from Nicolin:
  1.Fixed the incorrect comments and replaced 'kzalloc' with 'kzalloc_obj'
  2.'stream_table_create/stream_table_remove' is called in probe_device/release_device
  3.Reused some functions in the driver

  Address the comments from Robin:
  1.Remove unnecessary CR0*EN extra strings
  2.Remove the limit on ssid

  Address the comments from Robin and Nicolin:
  1.The directory structure has been changed
  2.Added lock protection for the ste_show and cd_show

  Others:
  1.'arm_smmu_debugfs_remove' is added to remove the corresponding debugfs when SMMU device is removed
  2.'arm_smmu_debugfs_remove_stream_table' is added to remove the corresponding stream_dir when device is removed
  3.Use scoped_guard for locks that include return
  4.Added 'open' and 'release' operations to prevent the device from being released during dump
  5.Merged 'stream_table_create' and 'ste_show' into one patch
  6.Some other clean code

- Link: https://lore.kernel.org/all/20260313104351.3502293-1-xiaqinxin@huawei.com/

Qinxin Xia (5):
  iommu/arm-smmu-v3: Add basic debugfs framework
  iommu/arm-smmu-v3: Add register display to debugfs
  iommu/arm-smmu-v3: Add Stream Table Entry display to debugfs
  iommu/arm-smmu-v3: Add device symlink in stream table debugfs
  iommu/arm-smmu-v3: Add Context Descriptor display to debugfs

 drivers/iommu/Kconfig                         |  11 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 .../arm/arm-smmu-v3/arm-smmu-v3-debugfs.c     | 571 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  33 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  32 +
 5 files changed, 646 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c

-- 
2.33.0

