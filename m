Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CCA2FA0FB
	for <iommu@lists.linux.dev>; Thu, 14 Aug 2025 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163814; cv=none; b=CyaPA0lzdNw5HKQ32YuFhwz0xdfvuQdY/mgt5Y9EWL63K9WaxuBCTZPtG9JMH/3myc+cJisSn0XZiex/fXUg68DJccaIlJaWGIxDJsPnHmrdVk4ptfD9y6wuc2pHGB6r3Kad4htJnk31LooCmGASI8JiSyDX4lDmWRFBFRmaTWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163814; c=relaxed/simple;
	bh=nW/9F2yIVAtL2VqZvHCe0aHMLFPQjgyU2uxIC/UaZpE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XiiBHYB/75NF6P8U2k/nEHFZoWbILnHNAOlskxdPpugyllS+Crfvz27cGLRV5mspdzqkZiP9666UR8Z3027PE1HWmaJZEpRx8JllGj8p95g3NNkYWPmmMIbjIGMkaaplyxOLJCZXdrE6hAoP4xXJTzfZnCgI3rMsK8g62QShiII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c2fx85YMwzdcFF;
	Thu, 14 Aug 2025 17:25:48 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 12ED1140136;
	Thu, 14 Aug 2025 17:30:09 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 17:30:08 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <yangyicong@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH 0/2] iommu: Add io_ptdump debug interface for iommu
Date: Thu, 14 Aug 2025 17:30:03 +0800
Message-ID: <20250814093005.2040511-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)

This patch supports the iopgtable_dump function (similar to kernel_page_dump).
The IOMMU page table dump debugging function is added to the framework layer.
Different architectures only need to provide the implemented dump ops.
It also provides the implementation of ARM SMMUv3 and io-pgtable-arm.

Qinxin Xia (2):
  iommu/debug: Add IOMMU page table dump debug facility
  iommu/io-pgtable: Add ARM SMMUv3 page table dump support

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  13 ++
 drivers/iommu/dma-iommu.c                   |  15 ++
 drivers/iommu/dma-iommu.h                   |   4 +
 drivers/iommu/io-pgtable-arm.c              | 169 +++++++++++++++++++
 drivers/iommu/iommu.c                       | 175 ++++++++++++++++++++
 include/linux/io-pgtable.h                  |   4 +
 include/linux/io_ptdump.h                   |  16 ++
 include/linux/iommu.h                       |  10 +-
 mm/Kconfig.debug                            |  19 +++
 mm/Makefile                                 |   2 +
 mm/io_ptdump.c                              |  24 +++
 mm/io_ptdump_debugfs.c                      |  17 ++
 12 files changed, 467 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/io_ptdump.h
 create mode 100644 mm/io_ptdump.c
 create mode 100644 mm/io_ptdump_debugfs.c

-- 
2.33.0

