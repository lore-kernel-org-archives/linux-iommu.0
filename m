Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A23194A53
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862327; cv=none; b=SF5nPCexBzcT/z+n7+FRGFjC3bgSIIk8HEpG47napBHmLZF+rRhu5wsooUlgAeiuxDVwCc01Zwj2lXEMRc7kr8IuO0zUb3NwF5E2iWGRWg/PcZyFodiAg6AXAN0QjE6pbqeCVSDnByqGIg3iuFM6Z1t0bKpJbr3nFU3HnXolz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862327; c=relaxed/simple;
	bh=67KV09L7AMzd3lMzV/so5KS+Nk30r5h8MTbUbMq5TPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUHbUR9wJWEYxDY+IIQ6svKiIyl9Y6b7zikyLr/XhA6Pe2KmQsNrxf/E01t7mG2ZRfeOUCufaiiYnNeIIWhZXsvpyxjNq/648jPQS8seblPFSxCJOnR0evYpUFFcp27uBYRCfGRpcrw5c/D6qDjvaAnqA/sFqINoi0+jxaEEYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ABE1339;
	Wed,  2 Oct 2024 02:45:54 -0700 (PDT)
Received: from [10.57.75.246] (unknown [10.57.75.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC0743F64C;
	Wed,  2 Oct 2024 02:45:23 -0700 (PDT)
Message-ID: <472d2dcc-82ce-44f3-b991-6aba1e4d18f9@arm.com>
Date: Wed, 2 Oct 2024 10:45:22 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/dma: Potential uninitialized variable in
 iommu_dma_unmap_sg
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, joro@8bytes.org,
 will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, anupnewsmail@gmail.com
References: <20241002083131.18135-1-alessandro.zanni87@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241002083131.18135-1-alessandro.zanni87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-02 9:31 am, Alessandro Zanni wrote:
> This patch fix the possibility to have the variable 'start'
> not initialized.

Why should it need initialising though? For "start" to never be set, 
then either sg_dma_is_bus_address() is true for the whole list, or the 
list is bogus and has sg_dma_len()==0 on the very first segment. Either 
way, the second loop will then do nothing, "if (end)" will remain false, 
and thus "start" will not be used. Where's the bug?

Thanks,
Robin.

> Smatch tool raises the error:
> drivers/iommu/dma-iommu.c:1510
> iommu_dma_unmap_sg() error: uninitialized symbol 'start'.
> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>   drivers/iommu/dma-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2a9fa0c8cc00..5b2596f4b24f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1496,7 +1496,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>   void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>   		enum dma_data_direction dir, unsigned long attrs)
>   {
> -	dma_addr_t end = 0, start;
> +	dma_addr_t end = 0, start = 0;
>   	struct scatterlist *tmp;
>   	int i;
>   
