Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBF130E0F2
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759407485; cv=none; b=sxosJ6ebyeoDYIPcE8YqjooQYzASddF90EFNLJw4WCpYwPUvF/mH7vHf/xYkmV+dsf2UuQI8Wxbmn5OULVXoIQkwNRS+jZimu1IyuNCxtY0S0IFpBDNbAbHN3/N2vzRFg7NDNuHRHkqjKzZMjm0yUgYred5WbeB8RknwxpXRDEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759407485; c=relaxed/simple;
	bh=v2cxIy568LY1SrjI/6Dd0izYESQMei35okjPMN6TjcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFA5ikKmLk5KzpewwM16+cUVCsaf8l5Miu8i128dBUCYFwa6D9qBOP+q/jr/DbJtZAK54dh+rRSeXxajc2U5nUMHNy6/8wIWJsPL7PQOCRF8kiz5WV0CDu9x9mnlqL5daX6gsRenOia2wL8WdZ8omCMgG/DSH95Absyol6+78vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44880168F;
	Thu,  2 Oct 2025 05:17:55 -0700 (PDT)
Received: from [10.57.2.183] (unknown [10.57.2.183])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 044383F66E;
	Thu,  2 Oct 2025 05:17:59 -0700 (PDT)
Message-ID: <338e1456-533b-4b59-a660-00d0ca51aada@arm.com>
Date: Thu, 2 Oct 2025 13:17:57 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] iommu: fix device leaks
To: Johan Hovold <johan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>,
 Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250925122756.10910-1-johan@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250925122756.10910-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-25 1:27 pm, Johan Hovold wrote:
> This series fixes device leaks in the iommu drivers, which pretty
> consistently failed to drop the reference taken by
> of_find_device_by_node() when looking up iommu platform devices.
> 
> Included are also a couple of related cleanups.
Modulo the nitpick for OMAP,

Acked-by: Robin Murphy <robin.murphy@arm.com>

We could in fact also clean up nearly all the NULL checks in these areas 
that are now entirely redundant since per-instance ops lookup, but that 
might just le;ad to more patches from the static checker brigade trying 
to put them back... :/

Thanks,
Robin.

> Johan
> 
> 
> Johan Hovold (14):
>    iommu/apple-dart: fix device leak on of_xlate()
>    iommu/qcom: fix device leak on of_xlate()
>    iommu/exynos: fix device leak on of_xlate()
>    iommu/ipmmu-vmsa: fix device leak on of_xlate()
>    iommu/mediatek: fix device leak on of_xlate()
>    iommu/mediatek: fix device leaks on probe()
>    iommu/mediatek: simplify dt parsing error handling
>    iommu/mediatek-v1: fix device leak on probe_device()
>    iommu/mediatek-v1: fix device leaks on probe()
>    iommu/mediatek-v1: add missing larb count sanity check
>    iommu/omap: fix device leaks on probe_device()
>    iommu/omap: simplify probe_device() error handling
>    iommu/sun50i: fix device leak on of_xlate()
>    iommu/tegra: fix device leak on probe_device()
> 
>   drivers/iommu/apple-dart.c              |  2 ++
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 10 +++-----
>   drivers/iommu/exynos-iommu.c            |  9 +++----
>   drivers/iommu/ipmmu-vmsa.c              |  2 ++
>   drivers/iommu/mtk_iommu.c               | 33 +++++++++++++++++--------
>   drivers/iommu/mtk_iommu_v1.c            | 28 +++++++++++++++++----
>   drivers/iommu/omap-iommu.c              | 32 +++++++++++++++---------
>   drivers/iommu/sun50i-iommu.c            |  2 ++
>   drivers/iommu/tegra-smmu.c              |  5 ++--
>   9 files changed, 81 insertions(+), 42 deletions(-)
> 
