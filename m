Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428910;
	b=Mvet0VEbf5h3L8SXCVeFfs5a83uFow8kcoYxdtVma9LoXDqRYICDfKVpEIsLK/RNmxM2
	 Zl2uG6+ifw/ZjHs8v4cCptI1Ni3lzzTIewHp0r/WFAmj9X5dkVUL8mh/d48w0bxSZ63kr
	 dwLRxFK+csg77Qxr9zvf+NvbE/qoBfazU2TEo84rynBhtg5qtdcO9osuvxg4uXpon0JTz
	 i+Pmt6NAd7DcDPKtY0W8aE0mr9MlTyKHr7MOPj4Tblq+15VZzgf5ucyXqWyOsy/FCMfvN
	 bFF9YecyL11mOBCbfR0xyG/qvP7pXYL12ZgnOJcnwBH5OR1KjWpGowlTgsQTxERvSig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428910;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=DDvlbAjqIKYcI5YtOv7UdDRsF0j2wGcohxG2sB0GTBM=;
	b=LHkVKWFBjUIMYJLAubKS6awenBLRU8Ytq1sIodqqQC+n0yigD4N4h/Q0ZMIh/7AA1nbn
	 py+dj7eCevXhmGtqxb6E+C7bqu4nZ5OWrEdXyoBs7YFi//IL2D7lasGFMMk9zx+JXanbU
	 ubTTCXumrn9snJ4g8bsTEhFZiZm0CYx7R9auaErLx+X3z0mKMEvouDh4FmVfET7U4bi8J
	 AIPSi1TGqGyLATG19DcFxnMZ2hkctOyCRKTu/52uZz1f76qcQ/JHfvwGkZu2pxvhPXWS1
	 tGEClfTFtUmt4+nYHZjxyowfhj8zDjnoU2glryEt0zkv0+FVgxmJ8V+2uNfig3ti5/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sng5j+Zz;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9805F606A32A
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 16:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9805F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sng5j+Zz
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C869204C;
	Mon, 19 Oct 2026 09:55:04 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD3273F673;
	Mon, 19 Oct 2026 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792428907; bh=g0MCRM90bHOY9xtPWztIDlp+2g+2cg4X+xov3AAv2Po=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sng5j+ZzFPDKIUj2toxn/TcsqEiuqIvvYLh9Yr5Pwf6ZrnfHiO9wuC1inCAEV3TpQ
	 p7pS065DFJmLupgiAFGyl3YkDf/3uNsTsKqraz3NzjmlCJeBovUBlLUAp/tmllNJd2
	 sXy+3vjJWuLa0jAC8Y7hKQgSL+h1opd/Ug5uqnsI=
Message-ID: <5173dbaa-2a49-420d-bf4e-97c9cc340bd9@arm.com>
Date: Mon, 19 Oct 2026 17:55:02 +0100
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
Subject: Re: [PATCH v2 05/11] ARM: dma-mapping: Bypass the legacy path for
 core-owned DMA API domains
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
 <20261016-b4-arm32-iommu-dma-cookie-v2-5-b06842a01938@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261016-b4-arm32-iommu-dma-cookie-v2-5-b06842a01938@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/10/2026 7:46 am, Mikko Perttunen wrote:
> ARM's arch_setup_dma_ops / arm_setup_iommu_dma_ops creates a custom
> IOMMU domain for DMA API usage, and continues to do so when the IOMMU
> driver doesn't explicitly request a DMA default domain type.
> 
> When, however, that DMA default domain is requested and the core owns
> the domain, we need to skip our own domain management. Add checks to
> arm_setup/teardown_iommu_dma_ops for these cases. In such a case IOVAs
> can be allocated from anywhere in the domain's geometry, so also add a
> check to ensure the device's dma-ranges cover it. Presently, this is the
> case for all platforms except some OMAP platforms with a non-zero
> dma-ranges base.

It's probably worth adding some cleverness to arm_iommu_detach_device() 
as well - it might work out benign to attempt to detach from a real 
core-owned default domain, but we'll now want to set dma_ops and 
to_dma_iommu_mapping according to the default domain itself (since we'll 
now have the possibility of switching between an explicit unmanaged 
dma_iommu_mapping and the implicit default one.)

Thanks,
Robin.

> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   arch/arm/mm/dma-mapping.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f2d3e8ec3487..d6315baeddb9 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1761,13 +1761,33 @@ EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
>   
>   static void arm_setup_iommu_dma_ops(struct device *dev)
>   {
> -	struct dma_iommu_mapping *mapping;
> +	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
>   	u64 dma_base = 0, size = 1ULL << 32;
>   
>   	if (dev->dma_range_map) {
>   		dma_base = dma_range_map_min(dev->dma_range_map);
>   		size = dma_range_map_max(dev->dma_range_map) - dma_base;
>   	}
> +
> +	/*
> +	 * An existing cookie means the core owns the domain. Only set the
> +	 * per-binding DMA ops. IOVAs are allocated from the whole aperture,
> +	 * so the device's dma-ranges must cover it.
> +	 */
> +	if (mapping) {
> +		const struct iommu_domain_geometry *geo =
> +			&mapping->domain->geometry;
> +
> +		if (dma_base > geo->aperture_start ||
> +		    dma_base + size < geo->aperture_end) {
> +			dev_err(dev, "dma-ranges do not cover the IOMMU aperture\n");
> +			return;
> +		}
> +
> +		set_dma_ops(dev, &iommu_ops);
> +		return;
> +	}
> +
>   	mapping = arm_iommu_create_mapping(dev, dma_base, size);
>   	if (IS_ERR(mapping)) {
>   		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
> @@ -1792,6 +1812,9 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
>   	if (!mapping)
>   		return;
>   
> +	if (!mapping->owns_domain)
> +		return;
> +
>   	arm_iommu_detach_device(dev);
>   	arm_iommu_release_mapping(mapping);
>   }
> 

