Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE8D3D75D3
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907175; cv=none; b=hVMNm/ovBzxNCkBmocmYjDA7HHuNqa+BDfsb2y1jUXGsaSnMllVJ7Cs6ELwwvHZdcDuQdw9otIGRFB0iX+8lF1l1IQu46+r0A6vfUfhDrPuAY3qGK9+DLQQ9wgI74FyGEXinbkg0wvhfNNaIr/vj4bugt97awUJJb7MqpT0jrQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907175; c=relaxed/simple;
	bh=tHsd6ybOVzAA4iRKUUUSr1a7MLJwo183qF7gRG6rm4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtESEbaiZGhPkdHYVzajC0KtbC3+j9r+Qxxd2VfM2IYdp2rW5O/hGs3DiVU4t7V7mvtQ9S3QkQdY623Yz+UrvNjCBhCu6zjwDHbduQF0aIFc5Hh8mAOvQLUA+GlOnzBE1PIIf9IU0d0DGZKwCDtxWs4fWGaSANeMMzuwhYN2uiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Omdspmqr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Omdspmqr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD4C42BCC;
	Wed,  1 Jul 2026 04:59:28 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CF123F66F;
	Wed,  1 Jul 2026 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782907173; bh=tHsd6ybOVzAA4iRKUUUSr1a7MLJwo183qF7gRG6rm4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OmdspmqrjZ6SdTUbWo9Znf1IiELwK95KpINCbox+m1AZGHFndr5W2CL2RJlCajAR0
	 zGqOorBe+dfC+DUnfjq6+FOOjvyj2uYm08YjnRPuxAf2c+ND2xGeekVbUD8Mp13bcr
	 A6Y/m7Z0AZCp5fK1pG3wd3SHPZD5DiRNG6Lwk7r4=
Message-ID: <b65c0f9f-184e-42fb-85dd-aa6c06dc91d8@arm.com>
Date: Wed, 1 Jul 2026 12:59:29 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drivers/iommu: Catch scatterlist length overflows
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
 =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-4-krzysztof.karas@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260701104437.236979-4-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2026 11:44 am, Krzysztof Karas wrote:
> It is possible, when a very large mapping uses a single
> scatterlist, that padding overflows scatterlist's length field.
> This results in:
>   1) silently wrapping the value
>   2) smaller than desired mappings produced by iommu_map_sg
>   3) leaving mapped bytes in memory (no iommu_unmap)
> 
> Address this issue by adding overflow detection for previous
> scatterlist length field.

Awesome, thanks for figuring it out! Looks like this must date all the 
way back:

Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")

> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v2:
>   * Address overflows instead of unmapping erroneously mapped
>   memory (Robin).
>   * Put this patch last for easier reproduction of the issue.
> 
>   drivers/iommu/dma-iommu.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703ef..c403057577df 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1493,8 +1493,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>   		 *   time through here (i.e. before it has a meaningful value).
>   		 */
>   		if (pad_len && pad_len < s_length - 1) {
> -			prev->length += pad_len;
> -			iova_len += pad_len;
> +			if (overflows_type(prev->length + pad_len, prev->length)) {
> +				/*
> +				 * For large mappings spanning multiple GBs we
> +				 * may not be able to fit all needed padding into
> +				 * sg->length.
> +				 */
> +				ret = -EOVERFLOW;
> +				goto out_restore_sg;
> +			} else {

Nit: we don't really need an "else" after a goto, but it's hardly a big 
deal (however if you did want to respin, note also that the preferred 
title tag here is "iommu/dma: ..."). Either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I'd imagine Joerg can take this as an IOMMU fix, but FWIW if you did 
want an ack to take it through drm-fixes to keep it with the i915 
patches, I wouldn't foresee any significant risk of conflicts.

Thanks,
Robin.

> +				prev->length += pad_len;
> +				iova_len += pad_len;
> +			}
>   		}
>   
>   		iova_len += s_length;

