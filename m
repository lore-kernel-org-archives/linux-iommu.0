Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B922917B418
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210483; cv=none; b=rv6IBFZXZ+zbWl0c1h2Yy7s5WXhJgEDBzqHDHUbHKZZD3B00M2KJyh/YtflpC04ro0qXuYCXNlNhofYio6NLalYd2g1Mp+5JdAibm+g30+IZ4vFDFfxR0NQpyvXWFnwuKhl4g+L+S8aJQe7cMSnEx7r7fG8SfwyJe61pAcfZTk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210483; c=relaxed/simple;
	bh=WIBRkIHWkIFL4A5IFR/XeJWLhbgiKv0HdiS09tYdNUg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YzH0yDeiRJsAJXLHQhhXrr3TeI6JULyP5GtxkYRCNZBgOu45lreqKqVnN3VepZcSekSmiN1n1Sc8TuDUDBKbE6BbauoglPe9wRkBwkTycsftE+VfPuovKYOxOpmi1gy316nOt5FJAf6njxClFpOM+bDrl4ZG/feFtkHZYxoAeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hMuF3UZl; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hMuF3UZl"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UCKl16/KcMv5EkrgnYgW3e+HNSMeClk7G+A1fie3DxE=;
	b=hMuF3UZlyjmbQ/M/hezl+ssrV8RXHB6Ae2pyle+e0qV9KMMsFEk8DtrB5LLw9rg4dVcBCZzIW
	sJM+Ex5rFVFvp2zJ5WhcllYoMXzmE2tPg5440tppcln2AyvGAffTkx8oKE8N1LpBL0/yHBrKS+L
	32f+lughGZuzbip4IwGM55s=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dqRvD1SJ2z1T4J2;
	Mon, 12 Jan 2026 17:30:48 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 4053C4056A;
	Mon, 12 Jan 2026 17:34:38 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Jan 2026 17:34:37 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <xiaqinxin@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>
CC: <iommu@lists.linux.dev>, <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v6 0/3] dma-mapping: benchmark: Add support for dma_map_sg
Date: Mon, 12 Jan 2026 17:34:33 +0800
Message-ID: <20260112093436.3456315-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Modify the framework to adapt to more map modes, add benchmark
support for dma_map_sg, and add support sg map mode in ioctl.
 
The result:
[root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
dma mapping benchmark(SG_MODE): threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
average map latency(us):1.4 standard deviation:0.3
average unmap latency(us):1.3 standard deviation:0.3
[root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
dma mapping benchmark(SINGLE_MODE): threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
average map latency(us):1.0 standard deviation:0.3
average unmap latency(us):1.3 standard deviation:0.5 

---
Changes since V5:
- Address the comments from Barry, the incorrect and unnecessary 'prepare_data' judgment
  is deleted and renamed 'prepare_data()' to 'initialize_data()'. The mode and
  other parameters in the output print are placed in the same print. In addition, the incorrect
  map_mode judgment in ioctrl and the wrong path in sg:prepare() does not release 'params' is fixed.
- Link: https://lore.kernel.org/all/20251222153246.2220659-1-xiaqinxin@huawei.com/

Changes since V4:
- Address the comments from Barry and Jonathan, irrelevant patches are deleted and
  the original cache processing logic is restored with add prepare_data().
- Link: https://lore.kernel.org/all/20250614143454.2927363-3-xiaqinxin@huawei.com/

Changes since V3:
- Address the comments from Barry, change mode to a more specific namespace.
- Link: https://lore.kernel.org/all/20250509020238.3378396-1-xiaqinxin@huawei.com/

Changes since V2:
- Address the comments from Barry and ALOK, some commit information and function
  input parameter names are modified to make them more accurate.
- Link: https://lore.kernel.org/all/20250506030100.394376-1-xiaqinxin@huawei.com/

Changes since V1:
- Address the comments from Barry, added some comments and changed the unmap type to void.
- Link: https://lore.kernel.org/lkml/20250212022718.1995504-1-xiaqinxin@huawei.com/


Qinxin Xia (3):
  dma-mapping: benchmark: modify the framework to adapt to more map
    modes
  dma-mapping: benchmark: add support for dma_map_sg
  tools/dma: Add dma_map_sg support

 include/uapi/linux/map_benchmark.h |   9 +-
 kernel/dma/map_benchmark.c         | 245 ++++++++++++++++++++++++++---
 tools/dma/dma_map_benchmark.c      |  23 ++-
 3 files changed, 250 insertions(+), 27 deletions(-)

-- 
2.33.0

