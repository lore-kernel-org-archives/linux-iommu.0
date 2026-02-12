Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B343217733
	for <iommu@lists.linux.dev>; Thu, 12 Feb 2026 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770894240; cv=none; b=jYznygbEFoeC489k6N2DuwovWVmee75pyZUpvIHcQNa4rcKaoLlALA6eRw9kdFfiiGRGYctmjakOqpRTEFQpUI7USUaGvA6YRkXCLfStxErDjQ2gl+T4qVR9VxxFumhVPLcGlWJ8qX18HX3kFcEVSb5bzAaZ/1PT3eH2gKMnsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770894240; c=relaxed/simple;
	bh=aOSH9xjmXHFxJbfq11i2cyeHJGv4fEZVx/MVkzSN2Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=HspnTSu09eljnbGnMG9+Bh+2QvLaCML8mZkoTfJthhdIlzpB42V8sb0ej6Em/u0pU7Xfo8Jk9BM+7WJX0M9paMAkWTbzxs3ZNF3StbltTH7S6n5kt/OtO6CcrhTMq4qQfKc16SDT5jdn96+0mgB/FrqOTARpEPYpmOUAVZWS18Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Xx/a54SW; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Xx/a54SW"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260212110351euoutp023eae6aafda5ae4e0b0ca7fbf570aeef7~TeuvbAtaC1818718187euoutp02L
	for <iommu@lists.linux.dev>; Thu, 12 Feb 2026 11:03:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260212110351euoutp023eae6aafda5ae4e0b0ca7fbf570aeef7~TeuvbAtaC1818718187euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770894231;
	bh=IxeoTLwSUaIpCJwceeWSECzAXTLUXMKlMHh6nbUcmXo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Xx/a54SWOjsDEMxs6qeaSQ7Odmn8OrMA9eLavT6NidMycfeQMK2C1H1vWSJWNhvix
	 laAM/BdhN1sHFTCTkESNm8rotB6+HNH4MclqcAX2gYB1AnjTP0nPq25L8Vb+uTCLkM
	 AaVKfj2geCnETndy2qmT61FyJvv/qy0ud6RZ3GPI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260212110351eucas1p1ffa80cd3fde9ef5c94e6090c508b8f5c~TeuvGNC9M1161211612eucas1p1H;
	Thu, 12 Feb 2026 11:03:51 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260212110350eusmtip2ef3e41cf3f95e814e053cc0ce9b38a58~Teut9YrGo2457924579eusmtip2j;
	Thu, 12 Feb 2026 11:03:50 +0000 (GMT)
Message-ID: <621783e8-d77d-4f29-bda0-ef487dd27b5b@samsung.com>
Date: Thu, 12 Feb 2026 12:03:49 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 1/5] dma-mapping: avoid random addr value print out on
 error path
To: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
	christian.koenig@amd.com, robin.murphy@arm.com, jgg@ziepe.ca,
	leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com,
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260209153809.250835-2-jiri@resnulli.us>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260212110351eucas1p1ffa80cd3fde9ef5c94e6090c508b8f5c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260209153816eucas1p22befaa2c5ef3c6d5e67956eea08424ed
X-EPHeader: CA
X-CMS-RootMailID: 20260209153816eucas1p22befaa2c5ef3c6d5e67956eea08424ed
References: <20260209153809.250835-1-jiri@resnulli.us>
	<CGME20260209153816eucas1p22befaa2c5ef3c6d5e67956eea08424ed@eucas1p2.samsung.com>
	<20260209153809.250835-2-jiri@resnulli.us>

On 09.02.2026 16:38, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>
> dma_addr is unitialized in dma_direct_map_phys() when swiotlb is forced
> and DMA_ATTR_MMIO is set which leads to random value print out in
> warning. Fix that by just returning DMA_MAPPING_ERROR.
>
> Fixes: e53d29f957b3 ("dma-mapping: convert dma_direct_*map_page to be phys_addr_t based")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

I will take this patch when v7.0-rc1 is out, as this fix definitely has 
to be applied regardless of the discussion about the remaining patches.

> ---
>   kernel/dma/direct.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index da2fadf45bcd..62f0d9d0ba02 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -88,7 +88,7 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>   
>   	if (is_swiotlb_force_bounce(dev)) {
>   		if (attrs & DMA_ATTR_MMIO)
> -			goto err_overflow;
> +			return DMA_MAPPING_ERROR;
>   
>   		return swiotlb_map(dev, phys, size, dir, attrs);
>   	}

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

