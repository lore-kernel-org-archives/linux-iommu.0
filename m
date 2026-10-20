Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792495751;
	b=XCYT/VjEJLo7PhoI9xYabmPC7fWBhso02KaMbAlvbW1dmRG7XDY362H3Az3aS1KND4mY
	 qRdGVexaPxvWrmyVf6Gqklrlz1RLB9mNAxPC/sw7a/3cX7nPaEaP5OA8S60OF6FyWLdtu
	 9NBk1H9hiAxb8i46iHgya4qVr5Dt5VVGMAi7pV+CF9/mTydi4BKH4MHbS+SOfOvmL55HM
	 xDWTrWnTWWtl9p3vz3e5Jzyi5ZIKu07n+W4q6GAiifpy/yOG51XXoiDbXyIgL15U0XFc8
	 9PnDsA5qm9RcXnigoZ3VunbB1MN8QzkpsLyWIbGfjNgT0wg5+jo5txBCaY791aoHwEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495751;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lvOImHjk9+PSZt/dZxaP6lDjW+Q8Usn4Xh93yDh43jg=;
	b=OhmF52Lg8cfRjcwZ8bND1gwM0CfOkJFkD05s15kfaLFVmS+p9CDTw3F23Ws1YvwokGBZ
	 oA2bhJKlhUZUSiLwk7wiH8QBxxRVtXfkFOcrJAHprJ7+y5awn8k9ia09sH+dJToWvWIaM
	 lT5SIPZphrZnEMoprh3ZUzkOCLMcXGF1zBDiS2d6HSjgQ1V0Gh/XFU+JQWfik8x1nrKqq
	 SGUqmxzRaU8WtwjpT5EXwV76HLUIs0gOhxB3DiBWUXy4OXeENzOR1J7uUET/kTopxnAYq
	 DqN/Tt8iKsBYBNL05KVnCuZ+Cf9F+pj3Svw6YV5dMN0RDKdhprWOeexmTKS7nrdzlgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ldbNPAVz;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C5C606A319
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 11:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01C5C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ldbNPAVz
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04FE21596;
	Tue, 20 Oct 2026 04:29:06 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55BE03F7B4;
	Tue, 20 Oct 2026 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792495749; bh=lPExewzubDO61zAC5f5szD4RLVzqEIiHTrrWFFbXWiU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ldbNPAVz3IGbNhuOHCkg9AxOAasSipoy6B5lGBDzvn/l+iQ+xrMGjWe9+CJcsFl11
	 6SP4SsUPLz31dVdUWoNT+EX1DN80XrhHO69Qp0pChRZFwxSOXLiZHUB06wU7fItPn9
	 6t/Ojv9c6iy2iP/FPyS1UkbN/qZvM71rUcPMepAk=
Message-ID: <be6cd787-8502-4499-ad62-597c1b9b7702@arm.com>
Date: Tue, 20 Oct 2026 12:28:54 +0100
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
Subject: Re: [PATCH v2 07/11] iommu: Let 32-bit ARM drivers opt into a DMA API
 default domain
To: Mikko Perttunen <mperttunen@nvidia.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
 <20261016-b4-arm32-iommu-dma-cookie-v2-7-b06842a01938@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261016-b4-arm32-iommu-dma-cookie-v2-7-b06842a01938@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/10/2026 7:46 am, Mikko Perttunen wrote:
> iommu_get_default_domain_type() unconditionally forces IDENTITY on
> 32-bit ARM as ARM_DMA_USE_IOMMU installs its own UNMANAGED domain on top
> of whatever the group already had. Now that the ARM DMA API state is an
> ordinary domain cookie, IOMMU drivers can ask for a real
> IOMMU_DOMAIN_DMA default domain instead. Drop the override so that
> ->def_domain_type is honoured, and let a driver-requested DMA domain
> through the !CONFIG_IOMMU_DMA guard when ARM_DMA_USE_IOMMU can back it.
> 
> IOMMU_DOMAIN_DMA stays strictly opt-in on 32-bit ARM and is never the
> fallback to avoid unexpected changes, as drivers today return 0 from
> ->def_domain_type while expecting the legacy behaviour.
> 
> Behaviour is therefore unchanged for every existing 32-bit ARM IOMMU
> driver:
> 
> - exynos-iommu, omap-iommu, rockchip-iommu, msm_iommu, ipmmu-vmsa,
>    mtk_iommu*, sun50i-iommu and qcom_iommu have no ->def_domain_type,
>    so iommu_get_def_domain_type() returns the unchanged cur_type of 0,
>    which is forced to IDENTITY as before.
> - arm-smmu returns IDENTITY for legacy bindings and 0 otherwise, which
>    ends up in the same place.
> - tegra-smmu returns IDENTITY explicitly, and keeps doing so until a
>    later patch.
> 
> Also move the static_assert on the two DMA API implementations being
> mutually exclusive to drivers/iommu/dma-iommu.h, next to the
> declarations that depend on it.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   drivers/iommu/dma-iommu.h |  3 +++
>   drivers/iommu/iommu.c     | 20 +++++---------------
>   2 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
> index 71b23cb698c0..24fa4165450f 100644
> --- a/drivers/iommu/dma-iommu.h
> +++ b/drivers/iommu/dma-iommu.h
> @@ -12,6 +12,9 @@
>    * IOMMU_DOMAIN_DMA default domains. Only one provider can be compiled in at a
>    * time.
>    */
> +static_assert(!(IS_ENABLED(CONFIG_IOMMU_DMA) &&
> +		IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)));
> +

Don't the first couple of patches already make this redundant, since 
such a build would now fail anyway due to multiple definitions of 
iommu_setup_dma_ops() etc.?

>   #if defined(CONFIG_ARM_DMA_USE_IOMMU)
>   
>   #include <asm/dma-iommu.h>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5fbb76d44a1e..0d812c4b9f08 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1884,18 +1884,6 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
>   
>   	lockdep_assert_held(&group->mutex);
>   
> -	/*
> -	 * ARM32 drivers supporting CONFIG_ARM_DMA_USE_IOMMU can declare an
> -	 * identity_domain and it will automatically become their default
> -	 * domain. Later on ARM_DMA_USE_IOMMU will install its UNMANAGED domain.
> -	 * Override the selection to IDENTITY.
> -	 */
> -	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
> -		static_assert(!(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU) &&
> -				IS_ENABLED(CONFIG_IOMMU_DMA)));
> -		driver_type = IOMMU_DOMAIN_IDENTITY;
> -	}
> -
>   	for_each_group_device(group, gdev) {
>   		driver_type = iommu_get_def_domain_type(group, gdev->dev,
>   							driver_type);
> @@ -1913,11 +1901,13 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
>   
>   	/*
>   	 * If the common dma ops are not selected in kconfig then we cannot use
> -	 * IOMMU_DOMAIN_DMA at all. Force IDENTITY if nothing else has been
> -	 * selected.
> +	 * IOMMU_DOMAIN_DMA at all, unless this is ARM32 and the driver asked
> +	 * for it explicitly, where CONFIG_ARM_DMA_USE_IOMMU provides the
> +	 * implementation. Force IDENTITY if nothing else has been selected.
>   	 */
>   	if (!IS_ENABLED(CONFIG_IOMMU_DMA)) {
> -		if (WARN_ON(driver_type == IOMMU_DOMAIN_DMA))
> +		if (WARN_ON(driver_type == IOMMU_DOMAIN_DMA &&
> +			    !IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)))

This ends up looking a bit odd, and not clear that it's still more or 
less the same special-case workaround seemingly being removed in the 
hunk above.

At this point I'd rather push any remaining identity special cases into 
the relevant drivers, however I'm somewhat more confident that there may 
not actually need to be any:

- exynos-iommu, omap-iommu, rockchip-iommu, msm_iommu: AFAICS these all 
only ever have a single client device, so the per-group implicit domain 
should be equivalent to the per-device explicit one, so they should not 
be impacted by switching (provided the "throw away the ARM domain" idiom 
in some of their client drivers becomes non-destructive as mentioned)

- mtk_iommu, sun50i-iommu, qcom_iommu, arm_smmu: While Kconfig might 
allow building them, I'm not sure we really support the first 3 on 
32-bit at all, but again since these all have no special CONFIG_ARM 
group handling anyway then either they must work out as above or they're 
already broken, and thus at most the change might un-break them.

- mtk_iommu_v1 and ipmmu-vmsa probably wouldn't care given that they end 
up attaching to their own shared domain anyway - they just can't wait to 
be able to use a proper singleton group to rip all that out :D

The main reason for forcing identity was to meet the expectations of the 
existing ARM DMA ops setup, but if we're now touching the ARM code to 
properly tie that in to the IOMMU flow, then I think we can just do the 
right thing.

Thanks,
Robin.

>   			return -1;
>   		if (!driver_type)
>   			driver_type = IOMMU_DOMAIN_IDENTITY;
> 

