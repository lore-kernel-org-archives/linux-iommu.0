Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24273C8721
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942981; cv=none; b=ZqHILiwHDEm59Sc2YgLBOCeeR1OvngFYzBqdxiJx515BUb/GXfyRcFElZwn0C4MtOUXIGFEcq0SneaLxdeptFBjeU0VC1LUtj80q+x6T2thQDlZS5YiDlzG726M47xvc1Yxj0I6+yfEE+UaytMHvX2/DuXNZH7py7fj2371lIVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942981; c=relaxed/simple;
	bh=1jQHpMSbdXM46kVxaRjFHF6qgC6X8BgdJvv64LHqiPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=DArDc9gF/dvmZLcZQlXC8bviBxfp3nn/43OWxJnUOp4lOmBjAmyR7nvDWh1Czq6avcgV/YaQ2enRwtVha/jZrINcgflAedf2Pft4+wIUNSUXq7oWTfYEaDmnOWu17AwMeNaL8RVwgaH8SsNI8V2qEr6EEeMBmySVcsZNJAIPmBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uva1diva; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uva1diva"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260331074255euoutp01273a76fdf3b2cac4c44e422dc237e7a8~h3Tt5hole1572915729euoutp01O
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 07:42:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260331074255euoutp01273a76fdf3b2cac4c44e422dc237e7a8~h3Tt5hole1572915729euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774942975;
	bh=n6XU63OSDlDGmqLMrEtDGpPy3DmkqxntfJ1+FJlHctA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=uva1divasw/L0LnvvNXqSh4Wm6b9AqbtLPVQWtUbIp/1bh2/Gr5c0VE6nNsxufcmV
	 unmyOBjWthGNcHBvNP1/rpfrTUVnInX/mrXX/q7AteDLCWnP52f6RB914SiNvu+wOi
	 XxHIS8p4vCRuUC90yZcpEn+Xbfvv1H1qe4krHElw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260331074255eucas1p1bd4e8f4b94051f94cb080e283de744f8~h3Ttipnyj2795927959eucas1p1b;
	Tue, 31 Mar 2026 07:42:55 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260331074253eusmtip2ee24dfba73ffe7e4389932ec930dced9~h3TsKWxn_0253302533eusmtip2V;
	Tue, 31 Mar 2026 07:42:53 +0000 (GMT)
Message-ID: <69b0e509-c469-4587-87b5-52d8e29e4c1a@samsung.com>
Date: Tue, 31 Mar 2026 09:42:52 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] dma/contiguous: Fix broken build
To: Maxime Ripard <mripard@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Robin Murphy
	<robin.murphy@arm.com>, Albert Esteve <aesteve@redhat.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev, Mark Brown <broonie@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260331-kind-therapeutic-buzzard-8fc55e@houat>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260331074255eucas1p1bd4e8f4b94051f94cb080e283de744f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260330154021eucas1p1ddf347acd21646c96fda4b266ddfc03b
X-EPHeader: CA
X-CMS-RootMailID: 20260330154021eucas1p1ddf347acd21646c96fda4b266ddfc03b
References: <CGME20260330154021eucas1p1ddf347acd21646c96fda4b266ddfc03b@eucas1p1.samsung.com>
	<20260330-dma-build-fix-v2-1-26d844575815@kernel.org>
	<a097600b-0860-495f-b918-adef327bdaec@samsung.com>
	<20260331-kind-therapeutic-buzzard-8fc55e@houat>

On 31.03.2026 09:40, Maxime Ripard wrote:
> On Mon, Mar 30, 2026 at 07:49:26PM +0200, Marek Szyprowski wrote:
>> On 30.03.2026 17:40, Maxime Ripard wrote:
>>> Commit 3a236f6a5cf2 ("dma: contiguous: Turn heap registration logic
>>> around") didn't remove one last call to dma_heap_cma_register_heap()
>>> that it removed, thus breaking the build.
>>>
>>> That last call is in dma_contiguous_reserve(), to handle the
>>> registration of the default CMA region heap instance.
>>>
>>> The default CMA region instance is already somewhat handled by
>>> retrieving it through the dev_get_cma_area() call in the CMA heap
>>> driver. However, since commit 854acbe75ff4 ("dma-buf: heaps: Give
>>> default CMA heap a fixed name"), we will create two heap instances for
>>> the CMA default region.
>>>
>>> The first one is always called "default_cma_region", and is the one
>>> handled by the call to dev_get_cma_area() mentioned earlier. The second
>>> one is the name it used to have prior to that last commit for backward
>>> compatibility.
>>>
>>> In the case where the default CMA region is defined in the DT, then that
>>> region is registered through rmem_cma_setup() and that region is added
>>> to the list of CMA regions to create a CMA heap instance for.
>>>
>>> In the case where the default CMA region is not defined in the DT
>>> though used to be the case covered by the now removed
>>> dma_heap_cma_register_heap() in dma_contiguous_reserve(). If we only
>>> remove the call to dma_heap_cma_register_heap(), then the legacy name of
>>> the CMA heap will not be registered anymore. We thus need to replace
>>> that call with a call to rmem_cma_insert_area() to make sure we queue
>>> this instance, if created, to create a heap instance.
>>>
>>> Once that call to dma_heap_cma_register_heap() replaced, we can also
>>> remove the now unused function definition, its now empty header, and all
>>> includes of this header.
>>>
>>> Fixes: 3a236f6a5cf2 ("dma: contiguous: Turn heap registration logic around")
>>> Reported-by: Mark Brown <broonie@kernel.org>
>>> Closes: https://lore.kernel.org/linux-next/acbjaDJ1a-YQC64d@sirena.co.uk/
>>> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>>> ---
>>> Changes in v2:
>>> - Fix creation of the CMA heap instance with the legacy name when not
>>>   declared in the DT. 
>>> - Link to v1: https://lore.kernel.org/r/20260330-dma-build-fix-v1-1-748b64f0d8af@kernel.org
>>> ---
>>>  drivers/dma-buf/heaps/cma_heap.c  |  1 -
>>>  include/linux/dma-buf/heaps/cma.h | 16 ----------------
>>>  kernel/dma/contiguous.c           | 14 +++++++++++---
>>>  3 files changed, 11 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
>>> index 7216a14262b04bb6130ddf26b7d009f7d15b03fd..9a8b36bc929f6daa483a0139a2919d95127e0d23 100644
>>> --- a/drivers/dma-buf/heaps/cma_heap.c
>>> +++ b/drivers/dma-buf/heaps/cma_heap.c
>>> @@ -12,11 +12,10 @@
>>>  
>>>  #define pr_fmt(fmt) "cma_heap: " fmt
>>>  
>>>  #include <linux/cma.h>
>>>  #include <linux/dma-buf.h>
>>> -#include <linux/dma-buf/heaps/cma.h>
>>>  #include <linux/dma-heap.h>
>>>  #include <linux/dma-map-ops.h>
>>>  #include <linux/err.h>
>>>  #include <linux/highmem.h>
>>>  #include <linux/io.h>
>>> diff --git a/include/linux/dma-buf/heaps/cma.h b/include/linux/dma-buf/heaps/cma.h
>>> deleted file mode 100644
>>> index e751479e21e703e24a5f799b4a7fc8bd0df3c1c4..0000000000000000000000000000000000000000
>>> --- a/include/linux/dma-buf/heaps/cma.h
>>> +++ /dev/null
>>> @@ -1,16 +0,0 @@
>>> -/* SPDX-License-Identifier: GPL-2.0 */
>>> -#ifndef DMA_BUF_HEAP_CMA_H_
>>> -#define DMA_BUF_HEAP_CMA_H_
>>> -
>>> -struct cma;
>>> -
>>> -#ifdef CONFIG_DMABUF_HEAPS_CMA
>>> -int dma_heap_cma_register_heap(struct cma *cma);
>>> -#else
>>> -static inline int dma_heap_cma_register_heap(struct cma *cma)
>>> -{
>>> -	return 0;
>>> -}
>>> -#endif // CONFIG_DMABUF_HEAPS_CMA
>>> -
>>> -#endif // DMA_BUF_HEAP_CMA_H_
>>> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
>>> index ad50512d71d3088a73e4b1ac02d6e6122374888e..d5d15983060c5c54744d6a63f2b591e1a3455b86 100644
>>> --- a/kernel/dma/contiguous.c
>>> +++ b/kernel/dma/contiguous.c
>>> @@ -40,11 +40,10 @@
>>>  #include <asm/page.h>
>>>  
>>>  #include <linux/memblock.h>
>>>  #include <linux/err.h>
>>>  #include <linux/sizes.h>
>>> -#include <linux/dma-buf/heaps/cma.h>
>>>  #include <linux/dma-map-ops.h>
>>>  #include <linux/cma.h>
>>>  #include <linux/nospec.h>
>>>  
>>>  #ifdef CONFIG_CMA_SIZE_MBYTES
>>> @@ -217,10 +216,19 @@ static void __init dma_numa_cma_reserve(void)
>>>  static inline void __init dma_numa_cma_reserve(void)
>>>  {
>>>  }
>>>  #endif
>>>  
>>> +#ifdef CONFIG_OF_RESERVED_MEM
>>> +static int rmem_cma_insert_area(struct cma *cma);
>>> +#else
>>> +static inline int rmem_cma_insert_area(struct cma *cma)
>>> +{
>>> +	return 0;
>>> +}
>>> +#endif
>>> +
>>>  /**
>>>   * dma_contiguous_reserve() - reserve area(s) for contiguous memory handling
>>>   * @limit: End address of the reserved memory (optional, 0 for any).
>>>   *
>>>   * This function reserves memory from early allocator. It should be
>>> @@ -271,13 +279,13 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>>>  						  &dma_contiguous_default_area,
>>>  						  fixed);
>>>  		if (ret)
>>>  			return;
>>>  
>>> -		ret = dma_heap_cma_register_heap(dma_contiguous_default_area);
>>> +		ret = rmem_cma_insert_area(dma_contiguous_default_area);
>>>  		if (ret)
>>> -			pr_warn("Couldn't register default CMA heap.");
>>> +			pr_warn("Couldn't queue default CMA region for heap creation.");
>>>  	}
>>>  }
>>>  
>>>  void __weak
>>>  dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
>>>
>>> ---
>> Huh, this is still not the correct fix to restore the old behavior.
>> When !CONFIG_OF_RESERVED_MEM the default cma area should be still
>> registered as the default cma dma-buf heap.
> You're right, but it feels that it's a fundamental flaw in the original
> patch rather than a quick fix for the build now. Can you drop the
> patches you applied entirely? If so, I'll send a new version of that
> series.

I've dropped the whole branch already.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

