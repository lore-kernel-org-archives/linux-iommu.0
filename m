Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B1537B03C
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774692600; cv=none; b=fyBpyDuLNFt3YYRWiRkfw2mduJkifv1RKHjRYdRFkqye2WAIPT5kpA+i6vKQgFm7mlZEkNUXtOdCfopeEUbCg9SPTyO36jghWHDrbzcucnddROTh582BnbcxUPel6+ku+RbY1zG+vc9tPBFTkq+JAAdwsjbBetwTjj/7HqhK4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774692600; c=relaxed/simple;
	bh=TkrCjlvKxJ2GHd2Al6MZ34CBWN7ZiSxRJeYN99DYv6U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M7DJYHOIacgB7VIVbpBaBBs/Baugf6Vpm0Z+qDlrSeu6B3BDh7u1CNiQbC7uoq0TsKkq16m2KrAMDVmgJVXz8DS29zAS4TOFSIaARauP63qKA1HKj/zHfMzU6YerjoIWWqXmonuBBqw7K/z34zns5tJX3bkElLVwuSPJbLL8f6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Jf2prgtE; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Jf2prgtE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4AaMlouoSdoLO09YMstibKmWb5wdcKm3CtKkeSW3Zrc=;
	b=Jf2prgtEKbtoy5HpZKi3npCtQBHN+jBA+Q09KK0A2nl6mNq/gJEIxHkm0Bwlex7M8Pz4TPj4Q
	OJ8NNoj5MokDNh9LgyqVksKwdbHNIRZ8NJzCrZmf5U7dcvpYrBJ9c1YKEU5zDMdwsfSHPl9G3qk
	hV0Sa4eKyGJu7dhToJt7IYo=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fjY4g5XMNzLlSS;
	Sat, 28 Mar 2026 18:03:47 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 6255A40562;
	Sat, 28 Mar 2026 18:09:54 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Mar 2026 18:09:53 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <robin.murphy@arm.com>, <nicolinc@nvidia.com>, <will@kernel.org>,
	<jpb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <wuyifan50@huawei.com>, <linuxarm@huawei.com>
Subject: [RFC PATCH v2 0/5] Add debugfs support for ARM SMMUv3
Date: Sat, 28 Mar 2026 18:09:48 +0800
Message-ID: <20260328100953.3441915-1-xiaqinxin@huawei.com>
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

