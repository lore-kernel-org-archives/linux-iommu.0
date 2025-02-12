Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4E17ADF7
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327035; cv=none; b=OkaaC7RhIPF8DdmG38DUsNCakI4QZxw07tfY2e/wRoe27czI0d+QtG/2lEszjRZYMFzhs7JKABClXQxLChNvFf+cBFxgMX6vDdjOFGUeoCu1c+/zMx3YhTqFpTG5+nsnP4SePg/KXinDxo+HsHiXqCXlJJeyhmFn3nptryE+zz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327035; c=relaxed/simple;
	bh=JuPHjZ0Y7aWs+k2bM/BIpl26UhvRA7ZGyZ2edVyFPcs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tPY89z/n0MtH4eiU3Kf69zVvUmt+XMXBqu8PPV0OKKuvqZQ7kSw72eEyv//kmnAu+fEaGGlSkzuIua+d4VGr3HLWHHUqSJO+CsH/CVHgkOdFwVw4eBhwIUUTB7Pp1nVszBghzgHUxnMxlZ7I/8Gitc/msMX0hobFVYQzLTfDxf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Yt28D4QN2z1V63c;
	Wed, 12 Feb 2025 10:19:56 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 98A8E140119;
	Wed, 12 Feb 2025 10:23:42 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 10:23:42 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <baohua@kernel.org>, <chenxiang66@hisilicon.com>
CC: <yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH 0/3] dma mapping benchmark: add support for dma_map_sg
Date: Wed, 12 Feb 2025 10:23:37 +0800
Message-ID: <20250212022340.1994486-1-xiaqinxin@huawei.com>
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
Qinxin Xia (3):
  dma-mapping: benchmark: modify the framework to adapt to more map
    modes
  dma-mapping: benchmark: add support for dma_map_sg
  dma-mapping benchmark:add support for dma_map_sg

 include/linux/map_benchmark.h                 |   7 +
 kernel/dma/map_benchmark.c                    | 224 ++++++++++++++++--
 .../testing/selftests/dma/dma_map_benchmark.c |  16 +-
 3 files changed, 222 insertions(+), 25 deletions(-)

--
2.33.0

