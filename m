Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA7A2ED08B
	for <iommu@lists.linux.dev>; Tue,  6 May 2025 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746500475; cv=none; b=Zj5UePpHxq1EOZbUKjpovyLWc5ankYrtwyBPOYov85RV3DDDObuiqClhRuTGyShEsp+QstiBzJtTMHlEdMjwsr7F1gzGiC3bicX9YFWFkl58KhOXODKenBJT4/ZVuc3XQeXgXjsqW6/YUB+Ee6J0WnE6/Q3hMfk5/nhbCjlQgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746500475; c=relaxed/simple;
	bh=U4LHRXobj6e9iwpT+E2cHmNPYDN/WF/ubBZn0+9xyf8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NUz22ZLtmCph+Q/BPlWmKxsg3GrGb1W5lMXIkVQtx/GR7/6bUGk+TaQt+pL0izgKMjYrfMFrtlpgb8p4qiJXtkAt9RjIp6cN8kaEbgAnIvckbsZT7u8siTR7ntSqjXYT1/quUS2FInSW2VDEoH801UkpDaCEIAx+AfqISK44/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Zs35v17w2z1d1Br;
	Tue,  6 May 2025 10:59:47 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C2161800B1;
	Tue,  6 May 2025 11:01:02 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 May 2025 11:01:01 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <baohua@kernel.org>, <xiaqinxin@huawei.com>
CC: <yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 0/4] dma mapping benchmark: add support for dma_map_sg
Date: Tue, 6 May 2025 11:00:56 +0800
Message-ID: <20250506030100.394376-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Modify the framework to adapt to more map modes, add benchmark
support for dma_map_sg, and add support sg map mode in ioctl.

The result:
[root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
dma mapping mode: DMA_MAP_SG_MODE
dma mapping benchmark: threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
average map latency(us):1.4 standard deviation:0.3
average unmap latency(us):1.3 standard deviation:0.3
[root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
dma mapping mode: DMA_MAP_SINGLE_MODE
dma mapping benchmark: threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
average map latency(us):1.0 standard deviation:0.3
average unmap latency(us):1.3 standard deviation:0.5

---
Changes since V1:
- Address the comments from Masami, added some comments and changed the unmap type to void.
- Link: https://lore.kernel.org/lkml/20250212022718.1995504-1-xiaqinxin@huawei.com/

Qinxin Xia (4):
  dma-mapping: benchmark: Add padding to ensure uABI remained consistent
  dma mapping benchmark: modify the framework to adapt to more map modes
  dma-mapping: benchmark: add support for dma_map_sg
  dma mapping benchmark:add support for dma_map_sg

 include/linux/map_benchmark.h                 |  46 +++-
 kernel/dma/map_benchmark.c                    | 222 ++++++++++++++++--
 .../testing/selftests/dma/dma_map_benchmark.c |  16 +-
 3 files changed, 249 insertions(+), 35 deletions(-)

--
2.33.0

