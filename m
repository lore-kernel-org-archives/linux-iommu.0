Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354435;
	b=MMYF92GCUNjdRdKNuFAoEMFdHi5TKUe7MJeqwWLZ4aKYgPYVw5W+VA7idjEPhg27MimS
	 9Z0zlq4+VMDd4EwN5ZuR/7LGhv0LY8OA8xsILZhNl0XaMR3TaCLPKe97AXaGgd3iO1ab3
	 iQ9etB7upI3gORjCcFe+ulSVkeSJzHj7aRl1NPFtuL98ex+6ElKGB6Rqn67Vn7KnAwv9X
	 Be4ieVTqZuqvl1uPygE+RM4/LNb+9HsPsD0QCAkkKSNN9wQUznwyELYlNRxwP69RFXZso
	 8swdLOYXn+rzP8B9BFgfIlHllfhNnqsjzbXqmRmHCNNpsc/f1dsVlYPatNWw/ET8fPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354435;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=ler9Vb08uoWkkGJsgusT3UJ2fmGaAr/9sD2dowX7gwE=;
	b=MpvPP5m2L4rDsQRn8Y5mWUojVppPP0EMh5Q6tliWr0wDRTE6RJsHDfWQyQ09lHGOSN/9
	 xCLUzhyE6ytaYJvMLLgU2JwoDfEtb+FymvvNNpuJ4JJGTgwG9qKxH0l2AzlXkpFzrEb2l
	 IoI6UArQGTy79A5ub3eBPYcPwCU0VgyqP6poZFvDK+5ifYUcFiBqqlW+NU5AvhMk3IeeC
	 oTBRrwY7234FQYPNxaeYboW7PzA4XKdE2RqhRfWZDSGum9ZEg9BfAINVEe2vqa/Up7wuf
	 nJ9VU1gmkqUcVCZM5x6un2aEFMPKjVxz4eXAcJQ0Mzredr21hVQISsyuSLiAnAgVmWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=HUhq70I3;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA4606A31F
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 10:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CCA4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=HUhq70I3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1793354435; x=1824890435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ler9Vb08uoWkkGJsgusT3UJ2fmGaAr/9sD2dowX7gwE=;
  b=HUhq70I3xfLfFzBedmY+/ylM/XSLSUtcZPO3kG3yWr5yUlparGHUJZd3
   gJqgVoRofkO02SqJC+U4W+ZvkZc8XwviFWLRbz9ew+MJt/o0hjIT5rOUV
   36Fw2j8KLaKJqVPPu3HHL+yQEOoOETXUAgPhd8t7MZX7VONZ/xnfqKo4I
   QSYXQpCVJxNrGnJyVlGgodkaaUhJEyiwvN93UdhYExZJGQ4PRGhtmsmMI
   u8ZWheEvDTXDL7AB2kMD45Pw2onDEZai0tBrj18CGOUNCplHVN3iLB+xW
   uYKfh0ZnMQuwZaurb1eC9K3Vqv2izK/ChuDmiQ1UFDQw5Qtq8PanHfuWY
   Q==;
X-CSE-ConnectionGUID: f41PGanPSUaMqPFAgY0gLw==
X-CSE-MsgGUID: aXQZUxloQz+Q/vIVKiUTRA==
X-IronPort-AV: E=Sophos;i="6.27,186,1787011200"; 
   d="scan'208";a="32646804"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:00:32 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:26549]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.238:2525] with esmtp (Farcaster)
 id 9c26f0e1-9b75-4adb-bb6b-4f1f1a420bc2; Fri, 30 Oct 2026 10:00:32 +0000 (UTC)
X-Farcaster-Flow-ID: 9c26f0e1-9b75-4adb-bb6b-4f1f1a420bc2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:00:32 +0000
Received: from dev-dsk-mheyne-1b-8cc83676.eu-west-1.amazon.com (10.13.235.223)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:00:30 +0000
From: Maximilian Heyne <mheyne@amazon.de>
To: <stable@vger.kernel.org>
CC: Maximilian Heyne <mheyne@amazon.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, "Nicolas
 Saenz Julienne" <nsaenz@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] dma/pool: eliminate CMA alloc warning in atomic_pool_expand
Date: Fri, 30 Oct 2026 10:00:00 +0000
Message-ID: <20261030-ghent-tubes-5abba7d2@mheyne-amazon>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

atomic_pool_expand() allocates with decreasing page order first from the
CMA and if that fails via alloc_pages(). If the cma allocation fails a
warning, such as the following, is printed:

  cma: __cma_alloc_frozen: reserved: alloc failed, req-size: 4096 pages, ret: -16
  cma: number of available pages:
  cma: range 0: 1024@0
  cma:
  => 1024 free of 1024 total pages
  DMA: preallocated 262144 KiB GFP_KERNEL pool for atomic allocations

In this case the allocation succeeded via alloc_pages and therefore,
printing the warning is not necessary. Therefore, similar to commit
463d439becb8 ("dma/pool: eliminate alloc_pages warning in
atomic_pool_expand") silence the warning also for the CMA attempt.

Fixes: d7e673ec2c8e ("dma-pool: Only allocate from CMA when in same memory zone")
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 00f422a1e8966..aa44fd74db538 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -99,7 +99,7 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 		pool_size = 1 << (PAGE_SHIFT + order);
 		if (cma_in_zone(gfp))
 			page = dma_alloc_from_contiguous(NULL, 1 << order,
-							 order, false);
+							 order, true);
 		if (!page)
 			page = alloc_pages(gfp | __GFP_NOWARN, order);
 	} while (!page && order-- > 0);
-- 
2.50.1

