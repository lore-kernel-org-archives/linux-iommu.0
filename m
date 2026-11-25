Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596855;
	b=YbCPDIV/VvdYbSyA6qCmAE/+xP4GUinPJTobP9VZJsY7TSGM1QlUFQguOsNSdZPtHjqZ
	 mLTmlFq0VCkW4U7b0SKJvx4vEHMakoN5QcF+xHrD1eRcR8XpEA5iV0Hk+An/mCJn3KTgt
	 QlW45iJX65rCREMjX/vB6KqqXfl6RQEFzNd1q9dcMQl4qJy+hsGxQDWcj9gC49KVSALB8
	 Hu0kz82KJ5xlgZTDNQmYHzgVtboPkcO9poR6uxch61xPzN3oeyrk/YcuxlakdkMre0gfq
	 Yq10VCYupy0NR1U17ytNzy5weI5BnlItz5/30EM3VU9/I0uxuRF/C7Vunqp6OPl076A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596855;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=/0+lAOOij2K52U4R0VRs3qIZIOgm3jcSCXFoO01Bohg=;
	b=QGBY3DuxX4dKdZC+CuWZJmpoHOD4PmVcdwH9bJMTDKKotk4s+Ky/0uvsG14Ln9OwKj08
	 VZe3GqD2Ipq/0vFtHm91Sryds7PF6ybnVC4yaJjqQN++BBvTxwLNvaL/c1FfwW23JZpyC
	 IZ44DVrFbg9hSvw90ECFwdHWpaLA1+mptwUKCUEbS3hxJ1GM6BA/qeWJBsv4kCEGdtueM
	 YkOSsw8SxSBnXW0As68jGg+p+X1kjFNtgISOxDVvdWTr44b9+k8B/mr+3pz0qziu7tdl9
	 L5NdKYehZkvmRldPZyShAneQKWOshMeEWVTGalhpzo9w1xDSlkFGibzIdZjxpY8/Tww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=J1yzosnh;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF69606A326
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 08:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AF69606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=J1yzosnh
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261125085411euoutp0176d677afe4172e23c2d09970d0b6c918~rPdKiVe1R2254422544euoutp01X
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 08:54:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261125085411euoutp0176d677afe4172e23c2d09970d0b6c918~rPdKiVe1R2254422544euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795596851;
	bh=/0+lAOOij2K52U4R0VRs3qIZIOgm3jcSCXFoO01Bohg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=J1yzosnh8O0FQ+zOv4xV6wlWYSkwmCBvsTdVPW401AfwWJxN4L78IQe8rbJW1vatb
	 hZcg5/xPfPxRGSsWRLSmDMcAobQidGl/bXypi1JVQNc8fQkRJfeEGt7H6XD6F91xzJ
	 eatuJhhXprNVbYaTSK0AY0O4RpLts+lTdBydLYKo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261125085411eucas1p26fb11707f67c2628fd55e71335d08bab~rPdKQhucL0555705557eucas1p2m;
	Wed, 25 Nov 2026 08:54:11 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261125085408eusmtip12dc81ec341b1bfaabed6853baaabffe2~rPdIRjxTi1139111391eusmtip1Q;
	Wed, 25 Nov 2026 08:54:08 +0000 (GMT)
Message-ID: <3467269e-9929-4c9f-bc19-847976f49527@samsung.com>
Date: Wed, 25 Nov 2026 09:54:08 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 2/2] alpha: enable contiguous memory allocation for
 coherent DMA
To: Magnus Lindholm <linmag7@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>
Cc: richard.henderson@linaro.org, mattst88@gmail.com,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-next@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	will@kernel.org, Mark Brown <broonie@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CA+=Fv5QJxoxEoKxRpm5Hisdf=y+VpmM-s_VBC1tDQ2FTCfb08w@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261125085411eucas1p26fb11707f67c2628fd55e71335d08bab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261124232303eucas1p10f2da7a94c8aa19fa4e406d089c1367e
X-EPHeader: CA
X-CMS-RootMailID: 20261124232303eucas1p10f2da7a94c8aa19fa4e406d089c1367e
References: <20261115103809.1288167-1-linmag7@gmail.com>
	<20261115103809.1288167-3-linmag7@gmail.com> <awVzJMLVw4wUSqky@monoceros>
	<CGME20261124232303eucas1p10f2da7a94c8aa19fa4e406d089c1367e@eucas1p1.samsung.com>
	<CA+=Fv5QJxoxEoKxRpm5Hisdf=y+VpmM-s_VBC1tDQ2FTCfb08w@mail.gmail.com>

Hi Magnus,

On 25.11.2026 00:22, Magnus Lindholm wrote:
> On Tue, Nov 24, 2026 at 12:32 PM Uwe Kleine-König
> <u.kleine-koenig@baylibre.com> wrote:
>> On Sun, Nov 15, 2026 at 11:37:43AM +0100, Magnus Lindholm wrote:
>>> Select HAVE_DMA_CONTIGUOUS and reserve a default CMA area after the
>>> machine has initialized its DMA windows. Prefer top-down placement
>>> below the direct-map and usable RAM limits. Skip the default reservation
>>> when no direct-map window exists. Explicit cma= ranges retain their
>>> generic override semantics; top-down placement is a preference, not a
>>> hard lower bound excluding the first 16 MiB.
>>>
>>> Use dma_alloc_contiguous(), which rejects non-blocking callers, before
>>> falling back to alloc_pages_exact(). Pair both paths with
>>> dma_free_contiguous(), whose buddy fallback uses free_pages_exact().
>>> Skip CMA on the GFP_DMA retry after a mapping failure so it cannot
>>> return the same unsuitable CMA pages. Retain zeroing for CMA memory.
>>>
>>> Round the size up to a page boundary in both allocation and free. CMA
>>> allocates size >> PAGE_SHIFT pages, so an unaligned size could otherwise
>>> allocate too few pages and overrun the allocation during zeroing. Keep
>>> the mapping and unmapping lengths consistent with the aligned size.
>>>
>>> With CONFIG_DMA_CMA=y, the default CMA_SIZE_MBYTES setting reserves
>>> 16 MiB without a cma= argument. cma=0 disables the default area.
>>>
>>> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
>>> ---
>>>  .../io/dma-contiguous/arch-support.txt        |  2 +-
>>>  arch/alpha/Kconfig                            |  1 +
>>>  arch/alpha/kernel/pci_iommu.c                 | 19 +++++++++++++------
>>>  arch/alpha/kernel/setup.c                     | 15 +++++++++++++++
>>>  4 files changed, 30 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
>>> index 3c6ce35d704f..6cd205a991f6 100644
>>> --- a/Documentation/features/io/dma-contiguous/arch-support.txt
>>> +++ b/Documentation/features/io/dma-contiguous/arch-support.txt
>>> @@ -6,7 +6,7 @@
>>>      -----------------------
>>>      |         arch |status|
>>>      -----------------------
>>> -    |       alpha: | TODO |
>>> +    |       alpha: |  ok  |
>>>      |         arc: | TODO |
>>>      |         arm: |  ok  |
>>>      |       arm64: |  ok  |
>>> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
>>> index 6ccb2d230326..cddc1f3af209 100644
>>> --- a/arch/alpha/Kconfig
>>> +++ b/arch/alpha/Kconfig
>>> @@ -30,6 +30,7 @@ config ALPHA
>>>       select HAVE_ARCH_COMPILER_H
>>>       select HAVE_ASM_MODVERSIONS
>>>       select HAVE_DEBUG_KMEMLEAK
>>> +     select HAVE_DMA_CONTIGUOUS
>>>       select HAVE_GUP_FAST
>>>       select HAVE_KERNEL_BZIP2
>>>       select HAVE_KERNEL_GZIP
>>> diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
>>> index 955b6ca61627..19aa5c05de2b 100644
>>> --- a/arch/alpha/kernel/pci_iommu.c
>>> +++ b/arch/alpha/kernel/pci_iommu.c
>>> @@ -408,15 +408,20 @@ static void *alpha_pci_alloc_coherent(struct device *dev, size_t size,
>>>  {
>>>       struct pci_dev *pdev = alpha_gendev_to_pci(dev);
>>>       void *cpu_addr;
>>> -     long order = get_order(size);
>>> +     struct page *page;
>>>
>>> +     size = PAGE_ALIGN(size);
>>>       gfp &= ~GFP_DMA;
>>>
>>>  try_again:
>>> -     cpu_addr = (void *)__get_free_pages(gfp | __GFP_ZERO, order);
>>> +     /* A low-memory retry must not return the same unsuitable CMA pages. */
>>> +     page = (gfp & GFP_DMA) ? NULL : dma_alloc_contiguous(dev, size, gfp);
>>> +     if (page)
>>> +             cpu_addr = page_address(page);
>>> +     else
>>> +             cpu_addr = alloc_pages_exact(size, gfp | __GFP_ZERO);
>>>       if (! cpu_addr) {
>>> -             printk(KERN_INFO "pci_alloc_consistent: "
>>> -                    "get_free_pages failed from %ps\n",
>>> +             pr_info("pci_alloc_consistent: allocation failed from %ps\n",
>>>                       __builtin_return_address(0));
>>>               /* ??? Really atomic allocation?  Otherwise we could play
>>>                  with vmalloc and sg if we can't find contiguous memory.  */
>>> @@ -426,7 +431,7 @@ static void *alpha_pci_alloc_coherent(struct device *dev, size_t size,
>>>
>>>       *dma_addrp = pci_map_single_1(pdev, virt_to_phys(cpu_addr), size, 0);
>>>       if (*dma_addrp == DMA_MAPPING_ERROR) {
>>> -             free_pages((unsigned long)cpu_addr, order);
>>> +             dma_free_contiguous(dev, virt_to_page(cpu_addr), size);
>> On next-20261123 I get a build error on an ARCH=alpha allmodconfig build
>>
>> arch/alpha/kernel/pci_iommu.c: In function ‘alpha_pci_alloc_coherent’:
>> arch/alpha/kernel/pci_iommu.c:418:41: error: too few arguments to function ‘dma_alloc_contiguous’; expected 4, have 3
>>   418 |         page = (gfp & GFP_DMA) ? NULL : dma_alloc_contiguous(dev, size, gfp);
>>       |                                         ^~~~~~~~~~~~~~~~~~~~
>> In file included from arch/alpha/kernel/pci_iommu.c:14:
>> include/linux/dma-map-ops.h:105:14: note: declared here
>>   105 | struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp,
>>       |              ^~~~~~~~~~~~~~~~~~~~
>>
>> which seems to be a conflict between
>>
>>         next-20261123~159^2 = f03df6019b56 ("alpha: enable contiguous memory allocation for coherent DMA")
>>
>> from
>> https://git.kernel.org/pub/scm/linux/kernel/git/lindholm/alpha.git for-next
>>
>> and
>>
>>         next-20261123~104^2~23^2~7 = 31f7e12d621b ("dma-contiguous: pass the NUMA node to dma_alloc_contiguous()")
>>
>> from
>> https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git dma_alloc_coherent_node
>>
>> I guess the right thing to do is to pull
>>
>>         https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git dma_alloc_coherent_node
>>
>> into the alpha tree and fix the offending function call in the merge
>> commit.
> Thanks for catching this and identifying the interacting commits.
>
> I reproduced the error on next-20261123. In
> arch/alpha/kernel/pci_iommu.c, I changed:
>
> page = (gfp & GFP_DMA) ? NULL : dma_alloc_contiguous(dev, size, gfp);
>
> to:
>
> page = (gfp & GFP_DMA) ? NULL :
> dma_alloc_contiguous(dev, size, gfp, dev_to_node(dev));
>
> This fixes the allmodconfig pci_iommu.o build. A full DP264 UP build
> with CMA enabled also passed, as did an object build with CMA disabled.
> The full allmodconfig build hit an unrelated cgroup sample error
> involving PATH_MAX and LINE_MAX.
>
> I'd prefer to keep the Alpha tree independent of the DMA series.
> Could we coordinate with Jakub and Marek to carry the adjustment in
> linux-next and ensure it reaches Linus when both changes are present?
> I'm happy to help with further testing.
>
> If that proves awkward, I can remove the CMA patch from for-next and
> defer it to a separate Alpha pull request once the DMA changes have
> landed, updating the caller then.


I think that rebasing the alpha changes on top of Jakub's stable tag:

git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux dma_alloc_coherent_node

would be the easiest way of handling this conflict as this way we will
avoid any build breaks and keep the changes bisectable.

However if You still want to keep Your CMA changes based on v7.4-rc1 in
alpha tree, then please provide a stable tag or branch with them.
I will merge it to dma-mapping-for-next and apply the needed fixup.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

