Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A5308F2A
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937983; cv=none; b=tf0GA0lyDrnU9lqiE+W2vFQV2Q7E6GsM/LiPyHvsjd5WdDSb8tgICfDjuXjTJ8bGzraTFF16gvndv3T02z5m66vu4XjnsUr1fPwtY0uGhF+VG35442ukv6vskZB/2r3TlUHzVh7ObkzoC3QDxyvX7Ywpyowj8Y4craQKRLefsjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937983; c=relaxed/simple;
	bh=14aLCO5GWoojNsXtLkEGVdnhp/kzZ28H3YHxv0pj090=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=btsodqu75hGHnlUWz3RC/YGfZhuR/a8wfi5pa6MM1hDVHs2D0n1v65cP1fFvfCq1T/m6L5gFOgXo43Zg+9czkZndxbHejmi2ib7cBHWTi4gb6di81pWMaxqRoDrPfGUmU/v5D7OH2yUzwwc9HVMI2N113p2ZWt+M4Tn6ZxHawN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ol3fKMFK; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ol3fKMFK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776937966; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=A6YdoIxeuZkdXGNum/CTyuM6cy/pazqB/L6iHJ0FGmU=;
	b=ol3fKMFKIevQImudUVFu5duQMqhONZigwMz6vc4Xv2vQPaqaEFHTI+VFHYsz0Zhiu18kznECcpgrvWVQ2ycBqnrNE3Ocb6KpR7+CI0tKqP3H7Prx5IMityo/u5EgSkDnJXCUfRvFLK12NJtI0bn3gevFb0err0IVQOG0D/t3uzg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X1ZJOkg_1776937964;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X1ZJOkg_1776937964 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Apr 2026 17:52:44 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v2] dma-contiguous: setup default pernuma cma area if not configured explicitly
Date: Thu, 23 Apr 2026 17:52:43 +0800
Message-Id: <20260423095243.14239-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a report on a multi-numa-nodes ARM server that when IOMMU is
disabled, the dma_alloc_coherent() function always returns memory from
node 0 even for devices attaching to other nodes, while they can get
local dma memory when IOMMU is on with the same API.

The reason is, when IOMMU is disabled, the dma_alloc_coherent() will
go the direct way and call dma_alloc_contiguous(). The system doesn't
have any explicit cma setting (like per-numa cma), and only has a
default 64MB cma reserved area (on node 0), where kernel will try
first to allocate memory from.

Robin Murphy suggested to setup pernuma cma or disable cma, which did
solve the issue. While there is still concern that for customers
which don't have much kernel knowledge, they could still suffer from
this silently as some architectures enable cma area by default (not
an issue for X86 though, which set CONFIG_CMA_SIZE_MBYTES to 0 by
default) for most Linux distributions. 

One thought is to follow the current cma reserving policy for platform
with 'CONFIG_DMA_NUMA_CMA=y', that if the numa cma is not explicitly
configured, set it up according to CONFIG_CMA_SIZE_MBYTES (The
percentage kernel option is not considered yet as the number of NUMA
nodes could be big).

Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
Changelog:

	since v1
		* don't use the original way of adding alloc_pages_node()
		before trying default cma node (Robin Murphy)

 kernel/dma/contiguous.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index c56004d314dc..b2fd6789db85 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -107,6 +107,7 @@ static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
 static phys_addr_t numa_cma_size[MAX_NUMNODES] __initdata;
 static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
 static phys_addr_t pernuma_size_bytes __initdata;
+static bool numa_cma_configured;
 
 static int __init early_numa_cma(char *p)
 {
@@ -135,6 +136,7 @@ static int __init early_numa_cma(char *p)
 			break;
 	}
 
+	numa_cma_configured = true;
 	return 0;
 }
 early_param("numa_cma", early_numa_cma);
@@ -142,6 +144,7 @@ early_param("numa_cma", early_numa_cma);
 static int __init early_cma_pernuma(char *p)
 {
 	pernuma_size_bytes = memparse(p, &p);
+	numa_cma_configured = true;
 	return 0;
 }
 early_param("cma_pernuma", early_cma_pernuma);
@@ -181,6 +184,9 @@ static void __init dma_numa_cma_reserve(void)
 			continue;
 		}
 
+		if (!numa_cma_configured)
+			pernuma_size_bytes = size_bytes;
+
 		if (pernuma_size_bytes) {
 
 			cma = &dma_contiguous_pernuma_area[nid];
-- 
2.43.5

