Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B293A0B2E
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397760; cv=none; b=taO8RcR0ZpJgWAv0IRSFKer4t4p9IBoNr2txkxKRe1pP2Cv+AVdDAUJy6eMVL0R672i1Z+yWBTuLcc2WfQexjNG1xG0uaZS4oU7myswy0Cpeg6EGIdYERFY9CAmnkjYWK0YOUhM7FFGuf+JEnsGmDDD34kT70u9zRvZu0XhfZ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397760; c=relaxed/simple;
	bh=qjgPdRm4ZE5PWnURF3lUNHIhYW/JfrxqkVr5Kw1oNwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=od66gNBNUpF3wOc3XZm/KHxvP71W9mKEE1gskR/1/zgCQIdBJuJAzPFBL4dUXxyCCYmTExSZ3uhsyaVgLbyEer0noBCXUZLjOWAvHLsAgEcHGgsEkdSBaf7z126AGQY6Jp3OTc0RAZM9gmLGfv+0SwX4E38R5B6DkHnGkH26wFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MnWZqGEn; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MnWZqGEn"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 262973165;
	Thu, 25 Jun 2026 07:29:09 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 669E53F836;
	Thu, 25 Jun 2026 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782397753; bh=qjgPdRm4ZE5PWnURF3lUNHIhYW/JfrxqkVr5Kw1oNwE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MnWZqGEnKH2EhQavXCW7Yl0+Q8r4veQKBRHMWp+oc8Bz6nX8Ny55VHMzy1n3XM1v3
	 Ci0wWwUw/VUTmG1EyJiBOhzksBI6DlkdWWg194tllBG2FoG7rgJurqCmkvMxyf580d
	 jnj2+fdQZRxD5uEIgUBAUEqxO9xom3Jd/BkU1ceY=
Message-ID: <ce5f27fd-82be-4750-8592-2eeb31a54523@arm.com>
Date: Thu, 25 Jun 2026 15:29:10 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drivers/iommu: Unroll unsuccessful mapping
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
References: <20260625134342.1102921-1-krzysztof.karas@intel.com>
 <20260625134342.1102921-2-krzysztof.karas@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260625134342.1102921-2-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/2026 2:43 pm, Krzysztof Karas wrote:
> Currently, if iommu maps fewer bytes than requested (iova_len),
> it proceeds to free the iova, but never tries to unmap already
> touched bytes. This behavior may cause memory hogging down the
> line.

Huh? iommu_map_sg() has always unmapped internally upon any error - can 
you clarify how you've seen it returning a short mapping in a non-error 
case?

Thanks,
Robin.

> Correct that by unmapping before exiting.
> 
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
>   drivers/iommu/dma-iommu.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 381b60d9e7ce..c4c058ba07ef 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1515,8 +1515,14 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>   	 * implementation - it knows better than we do.
>   	 */
>   	ret = iommu_map_sg(domain, iova, sg, nents, prot, GFP_ATOMIC);
> -	if (ret < 0 || ret < iova_len)
> +	if (ret < 0 || ret < iova_len) {
> +		if (ret > 0) {
> +			/* Unmap partially mapped bytes before freeing IOVA */
> +			if (iommu_unmap(domain, iova, ret) != ret)
> +				ret = -EIO;
> +		}
>   		goto out_free_iova;
> +	}
>   
>   	return __finalise_sg(dev, sg, nents, iova);
>   
> @@ -1525,7 +1531,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>   out_restore_sg:
>   	__invalidate_sg(sg, nents);
>   out:
> -	if (ret != -ENOMEM && ret != -EREMOTEIO)
> +	if (ret != -ENOMEM && ret != -EREMOTEIO && ret != -EIO)
>   		return -EINVAL;
>   	return ret;
>   }

