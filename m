Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190024;
	b=pFLwViUjvFMb8FzcCg6gwa3cmrl06QswXRM/lG/8JZTbJualSedkhv6qbCICNF/F+NJn
	 eGDsRri16FbfS2FRwTmXBwbw0q5AN72onrYPiSJaPA1zNV+F3mxq2vF4Ljo1F6vsw3VfR
	 lryl5rREIuETVbiZQlxEMdJLbJn/Xs7FLmWLpv0LYuZ0oA7QaNeRFMg+dzJuihg4fdtwv
	 X7Lk3I+whFtdw2SFs/ZL0e3iVaWaBSgoSiWRbGMCF6DLqWKHi5i8g7b1sTfw7LZa0I6xv
	 HABEOwba/7M46Dshpzy9gREz/XYJFNLbXwqZZExuh3RRSD0TBrMd8rpVEa9PbDcPfpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190024;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=kUImOcVedUjegxwkK//FyLW+jQN1/HbnoWhnMDB3jpY=;
	b=RBplD2MPwEm6Jl2CfmVI+AQudSc86sYd3iPUNoLzYMsiu3daxI1iJthGH5hI/13rnvw3
	 Q1BWgFhi4OZHojWqbA6hO2QhDSOwcPVS1uYRC9O6sbZP1iQvnXBHr2yYggvGAo6G0RTBi
	 7KCT8GIlc+lt8NU54gAb5IoBbf+RRAcYJ8zy3nhTviAWRrAVjs/f/N14CLOrNDfrHNs7P
	 29H86PRILTWXHA1cYyLQt8htdy3/2eh1e7zOEDwBZCuyKacolU9pByWpEpgqY6qXc8rMo
	 6W0qgVGcSoi3F4roToCq8RdPN/5r00jtvsrwa+mAWRECTefBPg/yK3a58lnEha2d1sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C1d/CmJA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AB2606A334
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1d/CmJA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1481F0093E;
	Fri, 20 Nov 2026 15:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795190023;
	bh=kUImOcVedUjegxwkK//FyLW+jQN1/HbnoWhnMDB3jpY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C1d/CmJAhbgn2yYJRxcS1Ze1OHHuhac0fgbrBOSGxrOfIl6bCLAjcW2iMal0sd80y
	 OpjNuCpzKPzqfW3TJO7rRhwITQHXxRd07Cj9SECpyFf6XDH2vMmqqQrKhLcBWGhiyv
	 huGkrsvNvr3LjR9PPL3hzJZEUupzerxwwTW43omfw7UUl+FtKljdOOMcDo2SUZHXOi
	 5uVv9+rq55Eq0N0KmVxJsThoMmr/EQWIOOCer9Wila7S6hTA0ac5iZ11TZINMRfIGF
	 Ejz+CiK3lN6uuaUp/bWXaFm8OKnXwRiAdU7zYnJxrDdGnUkbzdaF2sd7czHGy8GheC
	 lr+fX4PLBV/Iw==
Message-ID: <25b96bda-edb5-4baf-816c-cfb862b9243b@kernel.org>
Date: Fri, 20 Nov 2026 09:53:40 -0600
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Mark v2 page tables incoherent on Cezanne
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 Alex Deucher <alexander.deucher@amd.com>,
 Akshata V Unkal <Akshata.VUnkal@amd.com>,
 Nathan Blomquist <nblomquist@gmail.com>
References: <20261120152308.76894-1-vasant.hegde@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261120152308.76894-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/26 09:23, Vasant Hegde wrote:
> DMA fails on Cezanne (family 19h, model 50h) when a device is placed in
> an IOMMU v2 paging domain due to missing coherency setting in IOMMU HW.
> The IOMMU walks v2 page tables without observing CPU writes still held
> in the cache. v1 PTEs have a Force Coherent bit, which the driver sets
> on every entry, but the v2 format has no equivalent bit, so v2 walks
> are not kept coherent.
> 
> Set PT_FEAT_DMA_INCOHERENT for v2 domains on this CPU so the generic
> page-table code clflushes table memory before the IOMMU reads it.
> 

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6081
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> Link: https://lore.kernel.org/linux-iommu/CACOV87VBwH+R3eSBEOuz8hk7OaT63+A9m6ipPSW5wt1VhHMFPg@mail.gmail.com/
> Cc: Mario Limonciello (AMD) <superm1@kernel.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Tested-by: Akshata V Unkal <Akshata.VUnkal@amd.com>
> Co-developed-by: Nathan Blomquist <nblomquist@gmail.com>
> Signed-off-by: Nathan Blomquist <nblomquist@gmail.com>

Much appreciated for all your help here Nathan, you did a great job 
narrowing this down.

> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>   drivers/iommu/amd/iommu.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 41ee4ad1dcf8..0f04013f590d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2792,6 +2792,15 @@ static const struct iommu_domain_ops amdv2_ops = {
>   	.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
>   };
>   
> +/*
> + * Force a clflush on Cezanne (family 19h, model 50h) when the v2
> + * page-table is enabled.
> + */
> +static bool amd_iommu_force_incoherent(void)
> +{
> +	return boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model == 0x50;
> +}
> +
>   static struct iommu_domain *amd_iommu_domain_alloc_paging_v2(struct device *dev,
>   							     u32 flags)
>   {
> @@ -2810,6 +2819,13 @@ static struct iommu_domain *amd_iommu_domain_alloc_paging_v2(struct device *dev,
>   	domain->iommu.nid = dev_to_node(dev);
>   
>   	cfg.common.features = BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES);
> +
> +	if (amd_iommu_force_incoherent()) {
> +		cfg.common.features |= BIT(PT_FEAT_DMA_INCOHERENT);
> +		/* pt_iommu_init() rejects DMA_INCOHERENT without a device */
> +		domain->iommu.iommu_device = dev;
> +	}
> +
>   	if (amd_iommu_np_cache)
>   		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
>   	else

