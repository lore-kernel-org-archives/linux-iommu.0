Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158652A1C9
	for <iommu@lists.linux.dev>; Thu, 12 Jun 2025 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694466; cv=none; b=d+Exma45x9k1bUxp3ftzyhaZPgYhlBwwFfkX9bPmjGn4jnpaS9JH65GDfj7L3+rXbEiZQUHwyuaiyNLXSs/EE+7BwMFlJEEsw7kj1AXIeCe3O3fOqcVG4f9s9P08fB9hGrTZZaK+83QGAVDuZBsbjGy5a3VmSNTafgFdhOB4Qq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694466; c=relaxed/simple;
	bh=EbXWInki+PyyE8fUuUZTQmF76D1Lk5S8/93PksOZ3ck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OdQ9YHpyt4DMX5xk4UNBI2UZMFaP8MoYEvh+uXmRoqVzQCTRtRXpnTAuf9Aj2V5nb9y/waaouPKHxbQ/Jo6MWBCLdRyKq+peZBE2Ugq26AF6l3S1ZjmhU61Q2mwwdNe4Oe/+SvOwm7O1dZ5J6mc/XX0Xm3R9g01weVFM1gFDvAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NAoaTQZ7; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NAoaTQZ7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749694460; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UNdnWvi0Uoy+eaWdEfSl14TNqMDEHW+OqfIgxD24jTE=;
	b=NAoaTQZ7a/Fo5pdZGElhaFgj97Xxe2XHMbDuUhRyOvn6AtoKbj76gJgfutUN2c7wbkTCb+28WZC78aiDtoXgJ9YpgvKlTo7Fg6YDuhsJSFfQSPD3JwGdnWwdrzKLnDSazn+CEdIaYzaKJJ+2EBAvior1TkD1amrzzeN5vD4VzP0=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wdf0BoH_1749694457 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Jun 2025 10:14:18 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH] dma-contiguous: hornor the cma address limit setup by user
Date: Thu, 12 Jun 2025 10:14:17 +0800
Message-Id: <20250612021417.44929-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When porting a cma related usage from x86_64 server to arm64 server,
the "cma=4G@4G" setup failed on arm64. The reason is arm64 and some
other architectures have specific physical address limit for reserved
cma area, like 4GB due to the device's need for 32 bit dma. Actually
lots of platforms of those architectures don't have this device dma
limit, but still have to obey it, and are not able to reserve a huge
cma pool.

This situation could be improved by honoring the user input cma
physical address than the arch limit. As when users specify it, they
already knows what the default is which probably can't suit them.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 kernel/dma/contiguous.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 8df0dfaaca18..67af8a55185d 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -222,7 +222,10 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 	if (size_cmdline != -1) {
 		selected_size = size_cmdline;
 		selected_base = base_cmdline;
-		selected_limit = min_not_zero(limit_cmdline, limit);
+
+		/* Hornor the user setup dma address limit */
+		selected_limit = limit_cmdline ?: limit;
+
 		if (base_cmdline + size_cmdline == limit_cmdline)
 			fixed = true;
 	} else {
-- 
2.43.5

