Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E938F634
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398642; cv=none; b=X0W2BL8vgiz6OhTTNIEkBkH/VUcVIdAt7L7F8jlti9Wn7yTDhPI8AD4d0r0nZsPs6lEW8kkpuzTvIgcBQiqs2WeWxb2gEcacx/Bmr9ew34ZQNQ0fh+uwsAeGIbbRtwKPMrdKSAieMl1XF6szZuVR9mFPiVwyYST+GtwNAWm1NZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398642; c=relaxed/simple;
	bh=gCtrCb/c3HE2reckFdJ8xzGfvtTRnM6R5eCCzWupMgU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iCCOaGy6ywekHDf+dgo3qk5fEt/LMcVkw3THV8alhrRa1U4hohGjnt7CQ/zPxyZJR0sJ4zqn8xmZ7Adtc6HMIGgw4+v4J4zIe+9o7/LLPCwAFml9RaiQ9zKAVbe7cS9ZiuEM0spfrxX6ueQFtGfYnHr7yDh2k5GjAWl00xSMUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VVYaNNzB; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VVYaNNzB"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=za6ghEJCrb+lYRv/i2BVEq0wST7kfXUfGRgAgHvjBPo=;
	b=VVYaNNzBGJeWm6Nq4ii1z7XmAMVbw3/1TNxZsmYnmTUaFrgo/lDtAN+XVJw0+KtOu9f+UsGQj
	xuVoETgBVp1Sfy8IwYas845hbPq0iRt3Ng7hS0yi96jjAHilLZ34V73WM17dAgDAKJAvsJNjYDI
	pz72pWIL+ztYTGrFonR6enw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fXLYS5pPRznTWB;
	Fri, 13 Mar 2026 18:38:20 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 60B804056E;
	Fri, 13 Mar 2026 18:43:55 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Mar 2026 18:43:54 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jpb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
Subject: [RFC PATCH 0/5]  Add debugfs support for ARM SMMUv3
Date: Fri, 13 Mar 2026 18:43:46 +0800
Message-ID: <20260313104351.3502293-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200003.china.huawei.com (7.202.194.15)

This patch series introduces a debugfs interface for the ARM SMMUv3
driver, enabling developers and system administrators to inspect the
internal state of the SMMU for debugging and diagnostic purposes.

The debugfs entries are organized under:

  /sys/kernel/debug/iommu/arm_smmu_v3/

For each SMMU instance, a subdirectory named smmu3.<phys_addr> is
created (e.g. smmu3.0x0000000100100000). Inside, the following files are
available:

  capabilities  - Display SMMU feature capabilities and configuration
                  (stage support, coherency, ATS, PRI, queue depths)
  registers     - Show key control registers (CR0, CR1, CR2) and
                  command/event queue pointers (PROD/CONS)
  stream_table/ - Directory per PCI device or platform device, named
                  as <bus:dev:func>:<stream-id>; contains:
      ste       - Stream Table Entry (STE) details and raw data
      context_descriptors/
          all   - All valid Context Descriptors (CDs) for the device

The interface is designed with scalability in mind; additional
debugging features (e.g., queue dumping, event injection) can be added
later without breaking existing entries. Proper locking and error
handling ensure that the SMMU driver remains stable even when debugfs
accesses fail.
 
Qinxin Xia (5):
  iommu/arm-smmu-v3: Add basic debugfs framework
  iommu/arm-smmu-v3: Add register display to debugfs
  iommu/arm-smmu-v3: Add Stream Table Entry display to debugfs
  iommu/arm-smmu-v3: Add stream table directory structure to debugfs
  iommu/arm-smmu-v3: Add Context Descriptor display to debugfs

 drivers/iommu/Kconfig                         |  11 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 .../arm/arm-smmu-v3/arm-smmu-v3-debugfs.c     | 516 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  13 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  18 +
 5 files changed, 559 insertions(+)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c

-- 
2.33.0

