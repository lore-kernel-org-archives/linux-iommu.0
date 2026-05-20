Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9328633260B
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259044; cv=none; b=ujUsnIFepyYiP+o/W1VAGV6GxKpqJlllxlDMYVcLSUwoU8mb4Q+Iv9z0fwgSvPrtmTT87vmbHndwSLSVeMYAFyf08pGgMWZdtVOCQ20C2ikpdFrzyc3bI2kCp5hNDSh/7BG+HdorxR27jn26V+bGzDUcIKbX9lwMxN7zsfY0O90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259044; c=relaxed/simple;
	bh=DzIvXEPRpUnLdxbztLyI8mfkLLg2gKXJlYBeY7YN3+Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=moJaSzXeK0tj53TDK0ZqTWaQUQqOFD9JjWL0qA+GLXa5eg1n5wyaYpOLGackIosptxIqkj45oA4R8Ex1+KOidsVHfTwAGQF83+UVWrGJMGrwYWIUVY9vmmeArfDGLA/swtYdpx2qzHbyijaJhZGyhu6Bwwpqn8+futtnImVYEew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QT1059j1; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QT1059j1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Zm93bQ5t5C8w3D4+hr9H/ydh/Ma2k3/VoNQRmowXLsA=;
	b=QT1059j1BWnvmMdNIVY6DikiGb3SFgT693wP6J7Rc0fFQUKsEwpd4IkCOcew3jEjEvIYFPNPV
	nCBUs2EnyUYBspugMmQr5/p8U4A0g0xgU9dDy3JKkgBhDqSnxkMsx7A5EjTHfMvBJeUGiz6c/cm
	gG9b1vPjZ++9HQH2mi3qh+k=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gL1q03gV5zmVD0;
	Wed, 20 May 2026 14:29:32 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 08E0F40572;
	Wed, 20 May 2026 14:37:15 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 14:37:14 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <robin.murphy@arm.com>, <nicolinc@nvidia.com>, <will@kernel.org>,
	<jpb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <wuyifan50@huawei.com>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] Add debugfs support for ARM SMMUv3
Date: Wed, 20 May 2026 14:37:06 +0800
Message-ID: <20260328101706.3448655-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj200003.china.huawei.com (7.202.194.15)
Message-ID: <20260520063706.OZy2VlaLCfxiKwmjF7ONYoyIxuPlgKI2zqELkvCgREA@z>

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
- a symlink named with the device's BDF/name pointing to its sysfs directory for easy navigation.

/sys/kernel/debug/iommu/arm_smmu_v3/smmu0/stream_table/
    ├── <sid>/
    │   ├── ste
    │   ├── cd
    │   └── <dev_name>

Changes since RFCv2:
  Address review comments from Nicolin Chen, kernel test robot, and Sashiko
  automated review:

  Build & kerneldoc fixes (patches 1-3):
   - Add missing @unused parameter description to kerneldoc comments to fix
     clang W=1 warnings reported by kernel test robot.
   - Fix commit message: "driver.This" -> "driver. This" (patch 1).

  Correctness fixes:
   - Fix integer overflow: 1 << sid_bits -> 1ULL << sid_bits with %llu format,
     preventing undefined behavior when SIDSIZE = 32 (patch 1).
   - Fix EVTQ register access: use smmu->page1 instead of smmu->base for
     EVTQ_PROD/EVTQ_CONS, which reside in register page 1 (patch 2).
   - Fix STE config bit test: use proper cfg comparison instead of bitwise AND
     on non-mask enumeration values, and extract S1ContextPtr from data[0]
     instead of data[1] (patch 3).

  Resource leak fixes (patches 1-5):
   - Fix device reference leak: call put_device() when single_open() fails in
     all open() callbacks (capabilities, registers, ste, cd).
   - Fix dentry reference leak: add missing dput() after debugfs_lookup() in
     stream table remove path (patch 3).
   - Move kobject_get_path() outside the per-stream loop to avoid repeated
     allocation (patch 4).

  Locking & concurrency fixes:
   - arm_smmu_debugfs_remove(): use scoped_guard() and move
     debugfs_remove_recursive() outside the lock to avoid blocking other SMMU
     instances on active VFS operations (patch 1).
   - smmu_debugfs_ste_show(): change scoped_guard to guard(mutex) since the
     entire function body is within the lock scope (patch 3).
   - smmu_debugfs_cd_show(): change manual mutex_lock/unlock to
     guard(mutex)(&arm_smmu_asid_lock) (patch 5).

  Error handling fixes:
   - Replace if (!debugfs_create_dir(...)) with IS_ERR() checks throughout,
     since debugfs_create_dir() returns ERR_PTR on failure, not NULL
     (patches 1, 3).
   - Add NULL check for smmu->debugfs before dereference in stream table
     create path (patch 3).
   - Add NULL check for kzalloc_obj() result (patch 3).

  Code style & cleanup:
   - Directory tree comment: use ├── for last entry to avoid churn on
     subsequent patches (patches 1-5).
   - Fix tab/space alignment in directory tree comments (patches 1, 2).
   - Reorder function parameters: @smmu first, @dev second (patch 3).
   - Fix return statement indentation (patch 3).
   - Move function declarations from #ifndef-static pattern to header file
     (patch 3).
   - Move char name[32] and snprintf() to function top for reuse by
     iommu_device_sysfs_add() regardless of CONFIG_ARM_SMMU_V3_DEBUGFS
     (patch 1).
   - Adopt non-tab-aligned style for new struct members (patches 1, 3).
   - Remove useless comments: "DebugFS Info" and "Reserved for future
     extensions" (patches 1, 3).
   - Remove spurious blank line (patch 3).

- Link: https://lore.kernel.org/all/20260328101706.3448655-1-xiaqinxin@huawei.com/

Qinxin Xia (5):
  iommu/arm-smmu-v3: Add basic debugfs framework
  iommu/arm-smmu-v3: Add register display to debugfs
  iommu/arm-smmu-v3: Add Stream Table Entry display to debugfs
  iommu/arm-smmu-v3: Add device symlink in stream table debugfs
  iommu/arm-smmu-v3: Add Context Descriptor display to debugfs

 drivers/iommu/Kconfig                              |  11 +
 drivers/iommu/arm/arm-smmu-v3/Makefile             |   1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c    | 609 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  27 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  30 +
 5 files changed, 675 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c

--
2.51.0
