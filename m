Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B73815D8
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349666; cv=none; b=SDT338FABLn48Ml3otxsblZbG7e1JVW4ra9EyFZTgwiRhG7rUX1wOTbcDKiyxGX1dW/KAY6XnYvaS04iTntyvM7KUTbhtcVcBaEPRgaO2+zq5fBCQGkusPH7vC7NX5AYAXWK7ua+GNIGfeK4EJXFidNSKGj9IxFHZBEyyMMC7eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349666; c=relaxed/simple;
	bh=0SnJkzwA/pHULhb5TwuLkpxcvwrBwkvslcB87um5YV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=lvxSB0rmhouYTJz44eQIAu2HORl8OxOI+XRKoujp0MOjYMEWIiNse4ZYu0MUUOYHZzUqbwSwMpFdsnSFbbIw7P/OR2WVvWX61isq1LnbxZPV/83BmxgT6pez5CYifJa6UhMHVszBhtgCsB6otOF+yIj8omJ+ly3ek9UiN8Z4nkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=F656mgJ9; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F656mgJ9"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260925152100euoutp01a07ef61edbcf521b86bea2510f021763~YmYfSCZZH2084520845euoutp01f
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:21:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260925152100euoutp01a07ef61edbcf521b86bea2510f021763~YmYfSCZZH2084520845euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790349660;
	bh=SHgaribOFjNf5YMHUlR3fMpt5ySYd+TAsj/f7UavMDk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=F656mgJ9jfgNjrKs8uA1ZyoifUtpO6Jd2QaA5EhGg1UsGVHdaiunvQVyoBsr8yvQm
	 4JvEzIJQ1xTCBczVOiZBqIm+3EdyCpwECRq8i8GN27wlqHNo+fCU/+mKx+GZJgiYUH
	 q6eRUP+VcFpqTg/tZTDMerGTpXC394G1YEw2aP4w=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260925152059eucas1p2019d7b4eb9d392a10993cc13136edee1~YmYeygoFS3026930269eucas1p2w;
	Fri, 25 Sep 2026 15:20:59 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260925152057eusmtip25e163fc5b8da5ebbde70f8a09827ff17~YmYcynyS-2281922819eusmtip28;
	Fri, 25 Sep 2026 15:20:57 +0000 (GMT)
Message-ID: <a5b453db-a4f9-4dba-b150-6e4045f61027@samsung.com>
Date: Fri, 25 Sep 2026 17:20:57 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 00/11] Make the 32-bit ARM DMA API work with normal
 IOMMU DMA default domains (+ Tegra PoC)
To: Mikko Perttunen <mperttunen@nvidia.com>, Robin Murphy
	<robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Russell King <linux@armlinux.org.uk>, Heiko Stuebner
	<heiko@sntech.de>, Thierry Reding <thierry.reding@kernel.org>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jonathan Hunter
	<jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>, Krzysztof
	Kozlowski <krzk@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Yong Wu
	<yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob
	Clark <robin.clark@oss.qualcomm.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260925152059eucas1p2019d7b4eb9d392a10993cc13136edee1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260915021542eucas1p254addab18c10cb117f42ccf3d3522883
X-EPHeader: CA
X-CMS-RootMailID: 20260915021542eucas1p254addab18c10cb117f42ccf3d3522883
References: <CGME20260915021542eucas1p254addab18c10cb117f42ccf3d3522883@eucas1p2.samsung.com>
	<20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>

On 15.09.2026 04:14, Mikko Perttunen wrote:
> Depending on the probe ordering, TegraDRM does not currently probe on 
> kernels with CONFIG_ARM_DMA_USE_IOMMU enabled, such as with 
> multi_v7_defconfig. The Tegra SMMU puts several display and 2D/3D 
> clients into one IOMMU group, and the legacy 32-bit ARM DMA API path 
> creates one UNMANAGED domain per device and attaches it with 
> iommu_attach_device(). That only works for one device per group, so 
> every client after the first fails to attach, 
> iommu_device_use_default_domain() rejects the group with -EBUSY, and the 
> driver goes down with it. tegra_defconfig is currently working by virtue 
> of not enabling CONFIG_ARM_DMA_USE_IOMMU.
>
> Robin suggested [1] that instead of teaching the legacy path about 
> groups, we should explore modernizing the 32-bit ARM DMA code a bit by 
> making it use domain cookies and have the core code own the domains, as 
> is the case on other architectures. Still, ARM's own DMA code is kept to 
> support existing drivers and APIs that expect it, and because dma-iommu 
> is considered too big and unnecessary for 32-bit ARM.


I agree that such little modernization is the right step to unify a bit
ARM 32bit with modern archs and get rid of some workaround in the drivers.

It was me who raised the concern about the drivers depending on the first-fit
allocation algorithm used in the32-bit ARM DMA code. This is an issue for some
legacy Samsung Exynos drivers. I not aware of any other driver used on ARM 32bit
SoCs that depends on this behavior.

If one is still interested in switching ARM 32bit to generic IOMMU-DMA code I
can prepare a workaround for those Exynos drivers. I still have it on my todo
list, but in meantime there was no interest in updating ARM 32bit DMA code.


> The series is in four parts:
>
> - Patches 1-2 are preparation in the IOMMU core:
>   1. Add iommu_teardown_dma_ops, counterpart to iommu_setup_dma_ops.
>   2. Add cookie type for ARM's DMA domains.
> - Patches 3-6 implement the DMA API side on 32-bit ARM:
>   3. Split up domain and address space management code in arch/arm/.
>   4. Implement parallel dma_ops / cookie APIs on ARM side.
>   5. Avoid domain allocation when IOMMU core does it.
>   6. Support foreign-allocated sg_tables.
> - Patch 7 enables 32-bit ARM IOMMU drivers to provide a DMA default 
>   domain.
> - Patches 8-11 convert Tegra:
>   8. Allows deferring translation enable until driver handshake for
>      selected devices.
>   9-10. Removes code detaching ARM UNMANAGED DMA domains in
>         Host1x/TegraDRM.
>   11. Enables DMA default domain for selected Tegra devices.
>
> None of this should have any functional effect on any device other than 
> the Tegra devices enabled in patches 8-11. Other IOMMU drivers can opt 
> in later. The new DMA default domains are enabled only when the IOMMU 
> driver explicitly specifies a DMA domain type, just returning 0 for the 
> default is not enough (unlike on arm64), keeping the current behavior.
>
> Patches 8-11 are provided for demonstration but we can deal with them 
> separately if the rest of the series is accepted.
>
> Patches 1,2,3 are applicable independently.
> Patches 4,5 depend on the previous patches.
> Patch 6 can be applied independently but is only required once
>   the whole series lands (by TegraDRM).
> Patch 7 depends on patch 4.
>
> Patches 1-7 only touch drivers/iommu/ and arch/arm/mm/ and associated 
> headers.
>
> Best regards,
> Mikko
>
> [1] https://lore.kernel.org/linux-tegra/910d1492-ad3b-4201-93c6-208be1dcde7d@arm.com/
>
> ---
> Mikko Perttunen (11):
>       iommu: Add iommu_teardown_dma_ops
>       iommu: Add cookie type for ARM_DMA_USE_IOMMU
>       ARM: dma-mapping: Split mapping allocation from domain allocation
>       ARM: dma-mapping: Implement and expose DMA setup functions
>       ARM: dma-mapping: Bypass the legacy path for core-owned DMA API domains
>       ARM: dma-mapping: Handle foreign buffers in arm_iommu_get_sgtable
>       iommu: Let 32-bit ARM drivers opt into a DMA API default domain
>       iommu/tegra-smmu: Defer display client translation to driver handover
>       gpu: host1x: Drop release of legacy 32-bit ARM DMA domain
>       drm/tegra: Drop release of legacy 32-bit ARM DMA domain
>       iommu/tegra-smmu: Use a DMA API default domain per swgroup
>
>  arch/arm/include/asm/dma-iommu.h |  17 ++++
>  arch/arm/mm/dma-mapping.c        | 209 ++++++++++++++++++++++++++++++++-------
>  drivers/gpu/drm/tegra/dc.c       |   8 ++
>  drivers/gpu/drm/tegra/drm.c      |  15 ---
>  drivers/gpu/host1x/dev.c         |  15 ---
>  drivers/iommu/Kconfig            |   1 +
>  drivers/iommu/dma-iommu.c        |   5 +
>  drivers/iommu/dma-iommu.h        |  52 +++++++---
>  drivers/iommu/iommu.c            |  24 ++---
>  drivers/iommu/tegra-smmu.c       | 109 +++++++++++++++++++-
>  drivers/memory/tegra/tegra114.c  |  15 ++-
>  drivers/memory/tegra/tegra124.c  |  12 ++-
>  drivers/memory/tegra/tegra210.c  |   6 +-
>  drivers/memory/tegra/tegra30.c   |  18 ++--
>  include/linux/iommu.h            |   3 +
>  include/soc/tegra/mc.h           |  20 ++++
>  16 files changed, 410 insertions(+), 119 deletions(-)
> ---
> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
> change-id: 20260728-b4-arm32-iommu-dma-cookie-3170e07f9125
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

