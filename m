Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F5719AA46
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754159; cv=none; b=c6+4vPd+ZZ6i5ToVh35qOKrF+igAOo5T88rMEqbwzztE/fFYjj0qVVTHpM5h9p08KCqUmvfRHHPZYjyOUv6EFtX6NzTMGrMMEgCdy2pP5SxmGuVfREjWGVlZ5/RNlk38QwjblYhO++f6hH0qR5Rj3nYWSQ0WL/pnL76sOGolU78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754159; c=relaxed/simple;
	bh=+B9K2Hpp3cjUuH99nctnL4FGgHBYxVIU5gJSUwR246A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iq0ASWxKNgqqXtFeMQZNO5N1ed73SnPAOY5932jROzO23hHXDBjEZhMTc0tl6OVwtORJpONmEK8Ctp03wQ0FqeJWJhqcMcn4kL9vTS54vu3RQIYqexfoVIa+1aMUh7Z1XaItvkkTQQshX7oF3qwZ/HNICOM63/bKUDfcGMvJLg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4007FDA7;
	Tue, 27 Aug 2024 03:23:02 -0700 (PDT)
Received: from [10.57.72.132] (unknown [10.57.72.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59E263F66E;
	Tue, 27 Aug 2024 03:22:34 -0700 (PDT)
Message-ID: <53679dda-178c-435b-81c5-42d139911cef@arm.com>
Date: Tue, 27 Aug 2024 11:22:28 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: fix DMA zone when dma-ranges is missing
To: Baruch Siach <baruch@tkos.co.il>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
 Ramon Fried <ramon@neureality.ai>, Elad Nachman <enachman@marvell.com>
References: <731d204f5f556ad61bbaf004b1d984f83c90b4f5.1724748249.git.baruch@tkos.co.il>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <731d204f5f556ad61bbaf004b1d984f83c90b4f5.1724748249.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-27 9:44 am, Baruch Siach wrote:
> Some platforms, like Rockchip RK3568 based Odroid M1, do not provide DMA
> limits information in device-tree dma-ranges property. Still some device
> drivers set DMA limit that relies on DMA zone at low 4GB memory area.
> Until commit ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by
> zone_dma_limit"), zone_sizes_init() restricted DMA zone to low 32-bit
> when there is RAM there.
> 
> Restore DMA zone 32-bit limit for platforms that have RAM in this area.
> 
> Fixes: ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by zone_dma_limit")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> This should go via the dma-mapping tree that contains the fixed commit.
> ---
>   arch/arm64/mm/init.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index bfb10969cbf0..7fcd0aaa9bb6 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -116,6 +116,9 @@ static void __init arch_reserve_crashkernel(void)
>   
>   static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>   {
> +	if (memblock_start_of_DRAM() < U32_MAX)
> +		zone_limit = min(zone_limit, U32_MAX);

This seems like a bit of a bodge, since it now means we either get the 
old or the new behaviour depending on where DRAM is, so if, say, RAM 
starts at 3GB but all devices have a 3GB DMA offset, we still can't have 
a properly-sized DMA zone.

Really it comes down to this change:

-       zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
+       zone_dma_limit = min(dt_zone_dma_limit, acpi_zone_dma_limit);

where although the "32" represented the assumption of RAM starting at 0, 
it also implicitly removed the handling of the case where no DMA ranges 
are specified. Per the commit message, it's that which we want to 
account for, not the placement of RAM.

I think the more correct version should be:

	if (zone_limit == PHYS_ADDR_MAX)
		zone_limit = U32_MAX;

Thanks,
Robin.

> +
>   	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
>   }
>   
