Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9D019755E
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059255; cv=none; b=NLo1Kitxt3CzGCfQZWuaVbe222iVPo/0JyLvuQzRkTsqaIBcbU/roFJah4vOelVY30rWD/Y4gPm7GMMovs8SDRDDLzwDTU+R/7RuI6Lmk8tNlMlNLzufFufjjKmC7iOB10UjVgPu0K3R1yi1FUbHDip7q0cPz3H0CU3alnnHZg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059255; c=relaxed/simple;
	bh=UBK2++6IRrjge/hxqNBcdR6fr3YmxNov9V0fJ8/xKzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxtM7+Ht5+BcOaA78U+cIFVr+vNCBScnjhVQpsKzXLoKy8bXsFg5/FX8ZrWgQpwQ8QNMnZGkFrJ4hcnr+I6x5WInh2xhu/YvlnuL8Ghg2BLsAd/H7t8lKe2eVO43Y+hQ4oo6R4H0K6BUgHz/rfuhqrW+y5UnxhOIqRaoYx4hj4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC02B1007;
	Wed, 11 Sep 2024 05:54:42 -0700 (PDT)
Received: from [10.57.76.6] (unknown [10.57.76.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 068053F66E;
	Wed, 11 Sep 2024 05:54:11 -0700 (PDT)
Message-ID: <794814bf-76d3-433c-8dd7-de17c54464c0@arm.com>
Date: Wed, 11 Sep 2024 13:54:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: reliably inform about DMA support for IOMMU
To: Leon Romanovsky <leon@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
References: <7bbedc085ce87b121b9d0cb33eca8fba2fbdddbc.1726049194.git.leonro@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <7bbedc085ce87b121b9d0cb33eca8fba2fbdddbc.1726049194.git.leonro@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-11 11:15 am, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> If the DMA IOMMU path is going to be used, the appropriate check should
> return that DMA is supported.

Oof, indeed the significance of what iommu_dma_ops *didn't* implement is 
a subtle one...

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: b5c58b2fdc42 ("dma-mapping: direct calls for dma-iommu")
> Closes: https://lore.kernel.org/all/181e06ff-35a3-434f-b505-672f430bd1cb@notapiano
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   kernel/dma/mapping.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 1a7de37bd643..38d7b3239dbb 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -824,6 +824,9 @@ static int dma_supported(struct device *dev, u64 mask)
>   
>   	if (WARN_ON(ops && use_dma_iommu(dev)))
>   		return false;
> +
> +	if (use_dma_iommu(dev))
> +		return true;
>   	/*
>   	 * ->dma_supported sets the bypass flag, so we must always call
>   	 * into the method here unless the device is truly direct mapped.
