Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0BF381AF
	for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766417591; cv=none; b=EloEfTBuzt2abweTWPNN+QA48+BRS/B0l1MhfhB1YBl7h9boyeDlvxwwkbvHi/fga5jqWRFIiNYfruW8T71IitgbkE1gyBImxUC8FP9QHhxYCtdiNjaiVTJXF5BaA8SO/EhQ4X7ZaUYabWpdI4LtKusvZ8ZU5aueVwnZtQMhBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766417591; c=relaxed/simple;
	bh=yjqCExhERu7JyppjnbaSzH5EPMMlyfxP1WjwUQ/oxvc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d21iKDozGFTH9oK7e0vQ9NWZ0yDsVNVjp/t0N5FAc0KzNppEz38WTA5bTjWPrNrUY/ujmDx30x050tY6DMbIiB2xLK/wuSL2RPQIAKZbAhGR+otPzl69mSIGNJvH2W2WRTL7+Fpq3zoAtGYm9j39FHpReanPFWd4or2kzUefoCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4nyMYKuw; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4nyMYKuw"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=I9JPjWtcAB4Py/MgOEC1lT4M5YiN2XFPngCh8HnAGQk=;
	b=4nyMYKuwPd65HCSrSfnzshmbty/oDA4/IJ/TpwDtv5e2JfwvZrSlAkoQRag1KgARUWtkqLqhV
	o6KEdv6CA/wrbsQaM/auItqIr0vhz8VCiTRoO6pLNxkp+RojX/F5fBNARZn3tzH+q6XwOVFIXMR
	cQv7Zlz5Baa5aYamVn0QJ0M=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dZhsb1hjmzpSwC;
	Mon, 22 Dec 2025 23:30:11 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id A26E9201EE;
	Mon, 22 Dec 2025 23:33:04 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Dec 2025 23:33:04 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <xiaqinxin@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>
CC: <iommu@lists.linux.dev>, <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v5 0/3] dma-mapping: benchmark: Add support for dma_map_sg
Date: Mon, 22 Dec 2025 23:32:43 +0800
Message-ID: <20251222153246.2220659-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
  dma-mapping: benchmark: modify the framework to adapt to more map modes
  dma-mapping: benchmark: add support for dma_map_sg
  tools/dma: Add dma_map_sg support

 include/uapi/linux/map_benchmark.h |   9 +-
 kernel/dma/map_benchmark.c         | 245 ++++++++++++++++++++++++++---
 tools/dma/dma_map_benchmark.c      |  17 +-
 3 files changed, 246 insertions(+), 25 deletions(-)

-- 
2.33.0

