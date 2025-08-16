Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF02472A4;
	Sat, 16 Aug 2025 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755352211; cv=none; b=myAacm5g+z9EQls/KlMuUFzrkRn0FqJ+P2efZehCYMP2TtSsn4vz6eyccrPRN42fm3xP+RA+sms9WirGmF/eVFn5/bHdSl5BuVr57sk84KuUkXBP0V8vHa4As+Qy32e+0cUZbw8SpXQJ0jIdlF3DpwMFERWeobfIKwu324l7TCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755352211; c=relaxed/simple;
	bh=2v4gbRSAawP+if7/L/dsUf2MvnfiteitMG8BYb/Bz4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8Sd89TtS8XoutJmFY4BkIJdPH9Kgli6GFYmWh8rsDNoiy/Tapj/lU7t/bju1MbSRSXfF2OYO7iiggl2/quLqbdee6nZWgl3Far026DXRI1pBLTO5dNdn5W/V5pdxeCwf/XwVzReIfUc0C25ex1rLTZUxa2NEd+kdQUvlpr19Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEaU8+JX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEaU8+JX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E59C4CEEF;
	Sat, 16 Aug 2025 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755352210;
	bh=2v4gbRSAawP+if7/L/dsUf2MvnfiteitMG8BYb/Bz4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oEaU8+JXlRqI08A6N51HY37GbMGa0up12bjAi0MjLKIDO0ZMg1milYS+Gu9aiLsw9
	 TP7gK8WtewmroP0V7lHYlp6EEtuOyU4NGvDNvb/3VUhvaA5RSDrxflhBjEaiNvy/CR
	 aFYO4LhU6zy0P90LqeUztBilGfVVvOzP6jRxEqfHxsX3MEgGl/NCUe/NYrKEesc2aB
	 Kh+LXGqpsRIIwiG5TLjwp2JBmOaR8RoUj5PRnPfuAnDbu31mCrA+JCuaB06mgcCsLY
	 BE82JhWOfP/41Bny35ykULGBKy/rm8cRGKD/VGEsLlUWJgEKPNPwvZp4TOEMCUaawP
	 JBvG992Dl0jCg==
Message-ID: <c9440d31-add4-4c0f-ac2a-184e771ab455@kernel.org>
Date: Sat, 16 Aug 2025 15:50:06 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu: apple-dart: Add 4-level page table support
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Hector Martin <marcan@marcan.st>
References: <20250814-apple-dart-4levels-v1-0-db2214a78c08@jannau.net>
 <20250814-apple-dart-4levels-v1-3-db2214a78c08@jannau.net>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250814-apple-dart-4levels-v1-3-db2214a78c08@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.08.25 10:40, Janne Grunau wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> The T8110 variant DART implementation on T602x SoCs indicates an IAS of
> 42, which requires an extra page table level. The extra level is
> optional, but let's implement it.
> 
> Since the driver failed at IO page table creation with 42-bit IAS add
> "apple,t6020-dart" as separate compatible using the T8110 HW data.

Is the commit description outdated? I don't see this change anywhere.

> 
> Later it might be useful to restrict this based on the actual attached
> devices, since most won't need that much address space anyway.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   drivers/iommu/apple-dart.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index e72a93e78e26ca61b233c83d439dbdfadf040fc6..bb48e8603d6c84bcf107294d851c2f2fc1273298 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -133,6 +133,7 @@
>   #define DART_T8110_TCR                  0x1000
>   #define DART_T8110_TCR_REMAP            GENMASK(11, 8)
>   #define DART_T8110_TCR_REMAP_EN         BIT(7)
> +#define DART_T8110_TCR_FOUR_LEVEL       BIT(3)
>   #define DART_T8110_TCR_BYPASS_DAPF      BIT(2)
>   #define DART_T8110_TCR_BYPASS_DART      BIT(1)
>   #define DART_T8110_TCR_TRANSLATE_ENABLE BIT(0)
> @@ -177,6 +178,7 @@ struct apple_dart_hw {
>   	u32 tcr_enabled;
>   	u32 tcr_disabled;
>   	u32 tcr_bypass;
> +	u32 tcr_4level;
>   
>   	u32 ttbr;
>   	u32 ttbr_valid;
> @@ -217,6 +219,7 @@ struct apple_dart {
>   	u32 pgsize;
>   	u32 num_streams;
>   	u32 supports_bypass : 1;
> +	u32 four_level : 1;
>   
>   	struct iommu_group *sid2group[DART_MAX_STREAMS];
>   	struct iommu_device iommu;
> @@ -305,13 +308,16 @@ static struct apple_dart_domain *to_dart_domain(struct iommu_domain *dom)
>   }
>   
>   static void
> -apple_dart_hw_enable_translation(struct apple_dart_stream_map *stream_map)
> +apple_dart_hw_enable_translation(struct apple_dart_stream_map *stream_map, int levels)
>   {
>   	struct apple_dart *dart = stream_map->dart;
>   	int sid;
>   
> +	WARN_ON(levels != 3 && levels != 4);
> +	WARN_ON(levels == 4 && !dart->four_level);
>   	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
> -		writel(dart->hw->tcr_enabled, dart->regs + DART_TCR(dart, sid));
> +		writel(dart->hw->tcr_enabled | (levels == 4 ? dart->hw->tcr_4level : 0),
> +		       dart->regs + DART_TCR(dart, sid));

This is a bit hard to read, I'd prefer an explicit
if (dart->hw->tcr_4level) here.

>   }
>   
>   static void apple_dart_hw_disable_dma(struct apple_dart_stream_map *stream_map)
> @@ -569,7 +575,8 @@ apple_dart_setup_translation(struct apple_dart_domain *domain,
>   	for (; i < stream_map->dart->hw->ttbr_count; ++i)
>   		apple_dart_hw_clear_ttbr(stream_map, i);
>   
> -	apple_dart_hw_enable_translation(stream_map);
> +	apple_dart_hw_enable_translation(stream_map,
> +					 pgtbl_cfg->apple_dart_cfg.n_levels);
>   	stream_map->dart->hw->invalidate_tlb(stream_map);
>   }
>   
> @@ -614,7 +621,7 @@ static int apple_dart_finalize_domain(struct apple_dart_domain *dart_domain,
>   	dart_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
>   	dart_domain->domain.geometry.aperture_start = 0;
>   	dart_domain->domain.geometry.aperture_end =
> -		(dma_addr_t)DMA_BIT_MASK(dart->ias);
> +		(dma_addr_t)DMA_BIT_MASK(pgtbl_cfg.ias);
>   	dart_domain->domain.geometry.force_aperture = true;
>   
>   	dart_domain->finalized = true;
> @@ -807,6 +814,8 @@ static int apple_dart_of_xlate(struct device *dev,
>   	if (cfg_dart) {
>   		if (cfg_dart->pgsize != dart->pgsize)
>   			return -EINVAL;
> +		if (cfg_dart->ias != dart->ias)
> +			return -EINVAL;
>   	}
>   
>   	cfg->supports_bypass &= dart->supports_bypass;
> @@ -1137,6 +1146,7 @@ static int apple_dart_probe(struct platform_device *pdev)
>   		dart->ias = FIELD_GET(DART_T8110_PARAMS3_VA_WIDTH, dart_params[2]);
>   		dart->oas = FIELD_GET(DART_T8110_PARAMS3_PA_WIDTH, dart_params[2]);
>   		dart->num_streams = FIELD_GET(DART_T8110_PARAMS4_NUM_SIDS, dart_params[3]);
> +		dart->four_level = dart->ias > 36;
>   		break;
>   	}
>   
> @@ -1169,9 +1179,9 @@ static int apple_dart_probe(struct platform_device *pdev)
>   
>   	dev_info(
>   		&pdev->dev,
> -		"DART [pagesize %x, %d streams, bypass support: %d, bypass forced: %d] initialized\n",
> +		"DART [pagesize %x, %d streams, bypass support: %d, bypass forced: %d, AS %d -> %d] initialized\n",
>   		dart->pgsize, dart->num_streams, dart->supports_bypass,
> -		dart->pgsize > PAGE_SIZE);
> +		dart->pgsize > PAGE_SIZE, dart->ias, dart->oas);
>   	return 0;
>   
>   err_sysfs_remove:
> @@ -1292,6 +1302,7 @@ static const struct apple_dart_hw apple_dart_hw_t8110 = {
>   	.tcr_enabled = DART_T8110_TCR_TRANSLATE_ENABLE,
>   	.tcr_disabled = 0,
>   	.tcr_bypass = DART_T8110_TCR_BYPASS_DAPF | DART_T8110_TCR_BYPASS_DART,
> +	.tcr_4level = DART_T8110_TCR_FOUR_LEVEL,
>   
>   	.ttbr = DART_T8110_TTBR,
>   	.ttbr_valid = DART_T8110_TTBR_VALID,
> 

