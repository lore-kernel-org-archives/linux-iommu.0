Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4079C25E479
	for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418381; cv=none; b=j1xer/AvnXa/YdfKtnD3AzNIiSEDTclDEVrsSgFrB8hNmdJFLcZ2Fx+iXv+6PAIF8h9cJ/FliVdSVqQdl5SbhFYJbP11w8+dn+cmQNYLFFHV0OmREs1BHHhC7mearCdC1j84bE3oFxBq63e/o1SrQADNH9SE/dtRRkaqx247qEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418381; c=relaxed/simple;
	bh=Frx48Dj5vtpyGFe0IeU8eaW0Gaf1W+H03xtEuNJVg5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qhxi7W9PmqPrzZEcdkrZv9x0bfc6cBT6C/QAmvdn6+wNenO4EfY0kbLR8XMgl0ED52GAeUTPl3O8C9xvvYbNmL+Ja4HjgSAKWELAUo1UHTvSysAxSg0Q+7clRYOOWDsqPOOXTcVoEAVWLH+LMKbRP3wwN76ykWxLixgovDLoxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D909C176A;
	Fri, 20 Jun 2025 04:19:18 -0700 (PDT)
Received: from [10.57.31.151] (unknown [10.57.31.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C72773F673;
	Fri, 20 Jun 2025 04:19:35 -0700 (PDT)
Message-ID: <340d76b8-c3a6-4116-ae51-ac4e4ee6a994@arm.com>
Date: Fri, 20 Jun 2025 12:19:28 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/rockchip: prevent iommus dead loop when two masters
 share one IOMMU
To: Simon Xue <xxm@rock-chips.com>, joro@8bytes.org, will@kernel.org,
 heiko@sntech.de
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250620073945.572523-1-xxm@rock-chips.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250620073945.572523-1-xxm@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-20 8:39 am, Simon Xue wrote:
> When two masters share an IOMMU, calling ops->of_xlate during
> the second master's driver init may overwrite iommu->domain set
> by the first. This causes the check if (iommu->domain == domain)
> in rk_iommu_attach_device() to fail, resulting in the same
> iommu->node being added twice to &rk_domain->iommus, which can
> lead to an infinite loop in subsequent &rk_domain->iommus operations.

Indeed this is a property of the IOMMU instance itself so it really 
should be initialised before registration, irrespective of client 
devices. FWIW, if it's possible to take an unexpected 
RK_MMU_IRQ_PAGE_FAULT immediately after requesting the IRQ (e.g. in a 
kdump kernel after a crash with the hardware still running) then I think 
the current code could probably end up dereferencing NULL in 
report_iommu_fault() as well.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

And probably also:

Cc: stable@vger.kernel.org
Fixes: 25c2325575cc ("iommu/rockchip: Add missing set_platform_dma_ops 
callback")

Thanks,
Robin.

> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> ---
>   drivers/iommu/rockchip-iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 22f74ba33a0e..e6bb3c784017 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1157,7 +1157,6 @@ static int rk_iommu_of_xlate(struct device *dev,
>   		return -ENOMEM;
>   
>   	data->iommu = platform_get_drvdata(iommu_dev);
> -	data->iommu->domain = &rk_identity_domain;
>   	dev_iommu_priv_set(dev, data);
>   
>   	platform_device_put(iommu_dev);
> @@ -1195,6 +1194,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	if (!iommu)
>   		return -ENOMEM;
>   
> +	iommu->domain = &rk_identity_domain;
> +
>   	platform_set_drvdata(pdev, iommu);
>   	iommu->dev = dev;
>   	iommu->num_mmu = 0;

