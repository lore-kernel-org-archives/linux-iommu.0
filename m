Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934E034A3BC
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831735; cv=none; b=UhLOl7foAeO6QKuEVVYHVnKJ/rpG68le4XJTXhfgw9uKyAg6MkxidrwNaJXMiAM0lMT/39ZXAqwJNRRsmcP+TNG9+6j74KL3Kcmj7/VMKZbGF2IpvC0sspJ4UsGpUqkvrJj/QmlYDHmHdpCIGUdLG+DIlfmyGXazc5lS3ZbD/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831735; c=relaxed/simple;
	bh=RSwHrkqjMZnpf4KcuJO3wViQ6uD3lgv4NjJukwJgCBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=e7r2WglZEzq3vyUvdoGdJ8CPB1zr+qVgx24z5Mx6r+JNigID91ceyX7LHtaHSOk8AF1VuprNbq/Ze3IGY7/RBIU/hxLthpy2UNZPwJUpiZnR6EgVxv0KasLZOIjCxkYfgSEbO/6TO3UPjsM9Eob6lZmV7UQWFwMuAP6qYBwvrhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dxCgZj3E; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dxCgZj3E"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260223072845euoutp010cdbcc6913b509394fa60ab092b73a5e~Wz5EqyhfC1711917119euoutp01g
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 07:28:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260223072845euoutp010cdbcc6913b509394fa60ab092b73a5e~Wz5EqyhfC1711917119euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771831725;
	bh=fHwzvy/lJyzDBJ9QYguzkw4r84XxwakyncGKU7DpSRo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dxCgZj3EJWyjxlcARoDCZRa2yYKXIbd5WcWfBShCk11DnhMzW21d4gKyt3hItQMBO
	 1K0FkaIxNrgCgtUlx4/0vY6CG1ndBcvSZCJ6EKkPmqNANPg+pxRuuWSzaizRsM0dYe
	 iR11kOjlYz3ssGLrjw4z2bgC7Uo7QfBxXzA2gPoI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260223072845eucas1p238d8a317d8340fe8e9c8b658727e8ee8~Wz5ESAyjY2513825138eucas1p2J;
	Mon, 23 Feb 2026 07:28:45 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260223072842eusmtip2e953ab7b19655f3b5707f07bf625dab3~Wz5Bw0DU62888828888eusmtip2N;
	Mon, 23 Feb 2026 07:28:42 +0000 (GMT)
Message-ID: <666eefa7-3e00-4586-a443-1a71dc24e6dd@samsung.com>
Date: Mon, 23 Feb 2026 08:28:41 +0100
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
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260223072845eucas1p238d8a317d8340fe8e9c8b658727e8ee8
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

Applied to dma-mapping-fixes, thanks!

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

