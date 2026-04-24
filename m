Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93C21255A
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777012890; cv=none; b=T6dWKF3Yx60pHgroSx6kb9BHmnbSajqsTDCNXkl9V2d3zjEx10erpzYycjUMdYRnMoD1ti60Ihk+IAUEhZhoICrG3Vn44uVZPK28G81ihFFwyFNDJGA0DjyBMAapJ3pru0vRbQ3xePhzH6ViBIcChqk2ePmig5zLHhJM89Ep+IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777012890; c=relaxed/simple;
	bh=py6200VNs9CQwejtv6M/Y9wbJEAf2XQYecs730uCbb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8VlU/jCMZEb0nR50FQ1S3uCw1X6Gbs6p/l4haMKJcDbiYGSCwijFQOWfQGaao7BL+AVrXzZhMw3gYo8gRXvxWt4I3c+FPmW0y7HVaK4HkNtqg0GN8BOK+QQmIrRR3r7kXSX8jjloSpMpb2vusKHcoGrUyh8Naj+aDpxCX4jtGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ta8YEUa7; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ta8YEUa7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777012880; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=LvQ4bEDMUuAkdBnpsr3cU9rclCnY7mDzqEJrn85KyaU=;
	b=Ta8YEUa7Ewu+JECPRd0x18KIfm38sLJ8TgxDvhBgEo85qCeg+rllOpn4XHhO4K0vTEj63jKtYTUBfDJpI9ZL0flJHCac6A30BqflI85yeQLlDgj6AIIZb6/5aauQmRnF5p5UYS/+W68jeTtU2uAAI2YemayWvr7HGvQ6rDKI5vc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X1bhvTE_1777012878;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X1bhvTE_1777012878 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Apr 2026 14:41:19 +0800
Date: Fri, 24 Apr 2026 14:41:17 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Ying Huang <ying.huang@linux.alibaba.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] dma-contiguous: setup default pernuma cma area if not
 configured explicitly
Message-ID: <aesQjax9qYU3osnZ@U-2FWC9VHC-2323.local>
References: <20260423095243.14239-1-feng.tang@linux.alibaba.com>
 <43c5301c-fe6a-41e4-9482-ccfc7b62f2a7@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43c5301c-fe6a-41e4-9482-ccfc7b62f2a7@arm.com>

On Thu, Apr 23, 2026 at 02:51:06PM +0100, Robin Murphy wrote:
> On 23/04/2026 10:52 am, Feng Tang wrote:
> > There was a report on a multi-numa-nodes ARM server that when IOMMU is
> > disabled, the dma_alloc_coherent() function always returns memory from
> > node 0 even for devices attaching to other nodes, while they can get
> > local dma memory when IOMMU is on with the same API.
> > 
> > The reason is, when IOMMU is disabled, the dma_alloc_coherent() will
> > go the direct way and call dma_alloc_contiguous(). The system doesn't
> > have any explicit cma setting (like per-numa cma), and only has a
> > default 64MB cma reserved area (on node 0), where kernel will try
> > first to allocate memory from.
> > 
> > Robin Murphy suggested to setup pernuma cma or disable cma, which did
> > solve the issue. While there is still concern that for customers
> > which don't have much kernel knowledge, they could still suffer from
> > this silently as some architectures enable cma area by default (not
> > an issue for X86 though, which set CONFIG_CMA_SIZE_MBYTES to 0 by
> > default) for most Linux distributions.
> > 
> > One thought is to follow the current cma reserving policy for platform
> > with 'CONFIG_DMA_NUMA_CMA=y', that if the numa cma is not explicitly
> > configured, set it up according to CONFIG_CMA_SIZE_MBYTES (The
> > percentage kernel option is not considered yet as the number of NUMA
> > nodes could be big).
> 
> IIRC, the main reason it's still an opt-in is that it doesn't necessarily
> interact all that well with the default CMA area, and what we definitely
> don't want to do is unexpectedly start allocating additional CMA areas on
> systems which don't need nor want them.

I see the point, thanks

> 
> I guess what might be ideal would be to rearrange things such that when
> DMA_NUMA_CMA is enabled, we try to merge the "global" CMA area with a
> per-node area that can satisfy the necessary size, ZONE_DMA32, etc.
> constraints, such that unless explicitly configured otherwise, we don't end
> up making that extra n+1th allocation. Similarly I'm not sure about the
> usefulness of having two separate types of per-node area, especially given
> the apparent intent that users only want one _or_ the other, so probably
> dma_contiguous_numa_area[] should really have just been a generalisation of
> dma_contiguous_pernuma_area[] in the first place...

Yes, that makes sense. I did wonder what happens when both of them are
configured in the cmdline. The 2 numa dma array should better be merged,
maybe giving 'numa_cma' a higher priority. I know a user case for
'numa_cma' is that some socket in system have GPU/GPGPU card for AI
connected and need huge cma area specifically for it.


> I can imagine that work being quite involved though, as all the interaction
> between default, command line and devicetree/platform controls is sure to be
> fiddly. As a compromise for now, I think rather than trying to imply a
> default "cma_pernuma" behaviour, it would be cleaner to instead imply
> "numa_cma" to only replicate the default area across nodes other than the
> one which has it already. That then would inherently avoid changing anything
> for single-node systems; otherwise at the very least any automatic fiddling
> with pernuma_size_bytes should depend on num_online_nodes() > 1.

Something like the psudo code below?
(One complex point would be to get the node id of default cma area,
as 'struct cma' is a private definition in mm/cma.h, and we can't
access cma->nid inside contiguous.c for now)

---
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index d8fd6f779f79..6694ae62e785 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -97,6 +97,7 @@ static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
 static phys_addr_t numa_cma_size[MAX_NUMNODES] __initdata;
 static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
 static phys_addr_t pernuma_size_bytes __initdata;
+static bool numa_cma_configured;
 
 static int __init early_numa_cma(char *p)
 {
@@ -125,6 +126,7 @@ static int __init early_numa_cma(char *p)
 			break;
 	}
 
+	numa_cma_configured = true;
 	return 0;
 }
 early_param("numa_cma", early_numa_cma);
@@ -132,6 +134,7 @@ early_param("numa_cma", early_numa_cma);
 static int __init early_cma_pernuma(char *p)
 {
 	pernuma_size_bytes = memparse(p, &p);
+	numa_cma_configured = true;
 	return 0;
 }
 early_param("cma_pernuma", early_cma_pernuma);
@@ -182,6 +185,11 @@ static void __init dma_numa_cma_reserve(void)
 					ret, nid);
 		}
 
+		if (!numa_cma_configured && dma_contiguous_default_area) {
+			if (nid != dma_contiguous_default_area->nid)
+				numa_cma_size[nid] =  (dma_contiguous_default_area->count) << PAGE_SHIFT;
+		}
+
 		if (numa_cma_size[nid]) {
 
 			cma = &dma_contiguous_numa_area[nid];
@@ -216,8 +224,6 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 	phys_addr_t selected_limit = limit;
 	bool fixed = false;
 
-	dma_numa_cma_reserve();
-
 	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
 
 	if (size_cmdline != -1) {
@@ -256,6 +262,8 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 		if (ret)
 			pr_warn("Couldn't register default CMA heap.");
 	}
+
+	dma_numa_cma_reserve();
 }
 
 void __weak


Thanks,
Feng

> 
> Thanks,
> Robin.
 
