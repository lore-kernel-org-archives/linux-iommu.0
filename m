Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171F83D0BE4;
	Wed, 20 May 2026 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270846; cv=none; b=cqQO72Q+r79eoRI70XAaYKfJrpVQo4Iek2sU1hyKdrlnG/4knLuGWGRs3O5P0eFYItd0hXDbxDlsLzdmQbQxQQribh2QRTFgCs08fHZ02kghC6hVyresLmMYBRNbP5P9Zv2pE0wzmjZY7N46ltJavI096pxkSkHVWk+9gWTkLyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270846; c=relaxed/simple;
	bh=SvyTkewuCAYgva/MIbZ/Ixj5tmrW8fAv79jIjNwvUzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=BRdZw9UMgbJYPn3NXjT6cGgdT0QDBUwOS2B8Na281uz0ZPWfJ9ZJIYDGj0xCTAX+vtYAPJC3PcQwGpRj7PrnlJfMXolRDP/9TyDg8x8CKiNDi95DVrjT/ClbDFrnHJwhb1nDMwmY6qQg1z74Y0+ClXl2TpUw0DZa3iv/ukglnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XF5eoO6i; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XF5eoO6i"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260520095359euoutp0198bcd0d30eb407a19ba86b2e2a0aa636~xPWbGPRHZ2283822838euoutp01G;
	Wed, 20 May 2026 09:53:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260520095359euoutp0198bcd0d30eb407a19ba86b2e2a0aa636~xPWbGPRHZ2283822838euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779270839;
	bh=ROuDJc1ckmzsUK3GQqF5RpUdIt3rHpwnZ651Dx4KTEU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=XF5eoO6iIyP+yCtpP3A8TGvh7GdDuyqBUt33HERHmy0S7JjHZU25lGEQBRo1uI7yM
	 xKjGjzOAnuX9sNbzBHZjYTMarbQoPJA/rfU7eI7SVQCO27LQ49kvWSeFQnoBkjwSrS
	 lCkUYQMv8ZgGaOQMZ5JVsI8vM6NOOrcWXVPUsv64=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260520095358eucas1p1d5ec8fc83da4c9969214d9dbd4e59061~xPWajlDwS0908909089eucas1p1b;
	Wed, 20 May 2026 09:53:58 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260520095357eusmtip1a47766f5000651b2ff2398051841ce3f~xPWZFRiKV1382913829eusmtip1U;
	Wed, 20 May 2026 09:53:57 +0000 (GMT)
Message-ID: <e5dbe092-1c28-4799-b7c6-a78f84065dd2@samsung.com>
Date: Wed, 20 May 2026 11:53:56 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 3/8] of: reserved_mem: add dumpable flag to opt-in
 vmcore
To: Wandun Chen <chenwandun1@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
	robin.murphy@arm.com, leitao@debian.org, kees@kernel.org, coxu@redhat.com,
	tangyouling@kylinos.cn, songshuaishuai@tinylab.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260520091844.592753-4-chenwandun@lixiang.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260520095358eucas1p1d5ec8fc83da4c9969214d9dbd4e59061
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260520091935eucas1p1e3bd0cd7a5d2229acf937de3439571c7
X-EPHeader: CA
X-CMS-RootMailID: 20260520091935eucas1p1e3bd0cd7a5d2229acf937de3439571c7
References: <20260520091844.592753-1-chenwandun@lixiang.com>
	<CGME20260520091935eucas1p1e3bd0cd7a5d2229acf937de3439571c7@eucas1p1.samsung.com>
	<20260520091844.592753-4-chenwandun@lixiang.com>

On 20.05.2026 11:18, Wandun Chen wrote:
> From: Wandun Chen <chenwandun1@gmail.com>
>
> From: Wandun Chen <chenwandun@lixiang.com>
>
> Add a 'dumpable' flag to struct reserved_mem so the kernel can decide
> whether a reserved area should be included in the kdump vmcore. Most
> reserved regions are owned by devices and do not contain data useful
> for kernel crash analysis, so excluding them by default is the right
> behaviour.
>
> Reusable CMA regions are different: pages in a CMA region are handed
> back to the buddy allocator and may contain key data for crash
> analysis, so set dumpable to true in rmem_cma_setup().
>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> Link: https://lore.kernel.org/all/20260506144542.GA2072596-robh@kernel.org/
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  include/linux/of_reserved_mem.h | 1 +
>  kernel/dma/contiguous.c         | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
> index e8b20b29fa68..55a67cee41ea 100644
> --- a/include/linux/of_reserved_mem.h
> +++ b/include/linux/of_reserved_mem.h
> @@ -15,6 +15,7 @@ struct reserved_mem {
>  	phys_addr_t			base;
>  	phys_addr_t			size;
>  	void				*priv;
> +	bool				dumpable;
>  };
>  
>  struct reserved_mem_ops {
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 03f52bd17120..eddec89eb414 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -579,6 +579,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
>  		dma_contiguous_default_area = cma;
>  
>  	rmem->priv = cma;
> +	rmem->dumpable = true;
>  
>  	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
>  		&rmem->base, (unsigned long)rmem->size / SZ_1M);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

