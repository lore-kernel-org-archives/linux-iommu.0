Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9F2F87B
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789115578; cv=none; b=JhCr/3S2SfmIi23HQZLQY48Ih5KhLUinXAntKeKoyjT5Rg+/H1kgjPWXVnJJhKxmg3BNWdIYs1sSgwbxUTB0kxjnBH3YjlhfRbKCgH0B7YuOW4H+95puT1zCy6XYLCUCkFiuX1QQP2ktXcKf7brQKuzWJY3nnfz5aEA30MuvQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789115578; c=relaxed/simple;
	bh=GVLKW0vKobSOXvpuvhQauC/VvSKIhC1Mz1xz3trkgdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=V7I4kFRjXeDpc1g8v5F1/K6EBAYy4M56JDufr0N5XPwo2Y/9wjBnGcqbY/dqZm+obokVHvwAtdmJhzFAiCDMo9P+TMBr+n5Zdgv/p6j3t0iOPFa6IwGTqgLd+dp5tYjuxNiN2l70bk/05Kh0INLBPi3VgwLvNbdCKa8hot2uy+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fi/jM3v8; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fi/jM3v8"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260911083253euoutp023de204a389e6c1a20efd002982e58844~UNyKHUv-60704707047euoutp02V
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 08:32:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260911083253euoutp023de204a389e6c1a20efd002982e58844~UNyKHUv-60704707047euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1789115573;
	bh=sNLKrty9gaK1VitGi35rk08EQYY+sWubFpVgHUlu1LQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=fi/jM3v89yqk6GwsG4euBYEk/cIOnahokg3DB+M5Iy5DStJrWRrtk3QTSq2ghKztF
	 oEFKEVrtWrxgakkbZ9sOIl6LVb+TMvS4PXWlhWDgrVky0U1FcU3upmcWdK1IFmNZma
	 Dv6sx6u1fQpozAP8LriR9v6vZaBp9RM37iHIh4so=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260911083253eucas1p22fdb3209f93c33757fca07e398ce7484~UNyJ1LQDq0665006650eucas1p2M;
	Fri, 11 Sep 2026 08:32:53 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260911083251eusmtip13723878e9b36c836de28df75315bdc3a~UNyID60TI0126101261eusmtip1b;
	Fri, 11 Sep 2026 08:32:51 +0000 (GMT)
Message-ID: <a23182fa-74ed-44f0-a613-ad8d3c19fb18@samsung.com>
Date: Fri, 11 Sep 2026 10:32:50 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] x86/mm: Don't force unencrypted DMA for IOMMU-backed
 devices
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Mostafa Saleh
	<smostafa@google.com>, Alexander.Deucher@amd.com, Thomas.Lendacky@amd.com,
	Vasant.Hegde@amd.com, Timo Witte <timo.witte@gmail.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260908113232.247457-1-aneesh.kumar@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260911083253eucas1p22fdb3209f93c33757fca07e398ce7484
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260908113247eucas1p12e67fcdf50573da0c0fac36cee4b06e9
X-EPHeader: CA
X-CMS-RootMailID: 20260908113247eucas1p12e67fcdf50573da0c0fac36cee4b06e9
References: <CGME20260908113247eucas1p12e67fcdf50573da0c0fac36cee4b06e9@eucas1p1.samsung.com>
	<20260908113232.247457-1-aneesh.kumar@kernel.org>

On 08.09.2026 13:32, Aneesh Kumar K.V (Arm) wrote:
> Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select
> them via attrs") exposed an issue with force_dma_unencrypted() on
> systems using host memory encryption.
>
> force_dma_unencrypted() checks whether the device DMA mask can address
> the encryption bit and, if not, requires DMA allocations to use
> unencrypted memory. However, this check is not applicable when the
> device is using the IOMMU. In that case, the device DMA mask constrains
> the IOVA seen by the device, not the backing physical address, so it
> does not need to cover the C-bit.
>
> This currently causes dma_alloc_attrs() to set
> __DMA_ATTR_ALLOC_CC_SHARED for such devices. iommu_dma_alloc() does not
> support that attribute and rejects the allocation, causing DMA
> allocations to fail.
>
> Do not force DMA allocations to be unencrypted when the device is using
> the IOMMU. This allows the IOMMU to map the encrypted physical pages as
> before and avoids incorrectly requesting CC_SHARED allocations.
>
> Fixes: 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select them via attrs")
> Reported-by: Timo Witte <timo.witte@gmail.com>
> Link: https://lore.kernel.org/all/CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>


Applied to dma-mapping-fixes with adjusted url and changed 'link' tag to
the 'closes' one, thanks!

> ---
>  arch/x86/mm/mem_encrypt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 912f22ca838f..a349d8d21569 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -13,6 +13,7 @@
>  #include <linux/cc_platform.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/virtio_anchor.h>
> +#include <linux/iommu-dma.h>
>  
>  #include <asm/sev.h>
>  
> @@ -30,7 +31,7 @@ bool force_dma_unencrypted(struct device *dev)
>  	 * device does not support DMA to addresses that include the
>  	 * encryption mask.
>  	 */
> -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) && !use_dma_iommu(dev)) {
>  		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>  		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>  						dev->bus_dma_limit);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

