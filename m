Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753782D6607
	for <iommu@lists.linux.dev>; Tue,  7 Oct 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830569; cv=none; b=W9vWSWc108376qXLjLa0Nciss5WlpC/W4LpOMoHlKFwStYCbgi2Le7TW/omGnXH2c4sTgo/IQxxWAR1sR2FsTxhxffsDgYZq51sEsqoK72EYYzPYMRf3FQNPadSD3FbooY55Ge1k0MUSr0hSJiCt57Rj4NCdA1/EsCZCSTgT9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830569; c=relaxed/simple;
	bh=u8u0NmnSLZuaOxL/A+X/WOzOBBwdkhSqtKoSjgf4Owg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hiAJspxLUArEqPUzwu8J93AthEU/mnHGGrZ+DHwTrSRPppAC4a3FjSzk/tAaGnbUSUPXsF5RSxNJRVLiV35lHNWLSPi7lBa9DZ/BrQtbgAUkYa4y2UH68SwmpS1ydlKgv+CZzdegUO5Em3vkyF2LvSyT+wzvpClrV4u0wrVe1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qzlUXul4; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qzlUXul4"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251007094918euoutp025b6b9c443922f839a245f61911f5e48c~sLJG9SMew1904619046euoutp02W
	for <iommu@lists.linux.dev>; Tue,  7 Oct 2025 09:49:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251007094918euoutp025b6b9c443922f839a245f61911f5e48c~sLJG9SMew1904619046euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759830558;
	bh=1Wbns4tsawHIT2n+WE+qQ2RONhK37Q87C8TzJuMp5Ss=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=qzlUXul4UDizHJNVk5fsCcjCNVG5XLGHm1bZIynJN7XivSovXyAPy3QiLzq5OYn+X
	 tOXfAj5QNlQFiZyY7H9+aWQVgJZ9LSOxEHjQyi7Es6VlhryALHTvz8odJ/vZ+sh/ap
	 otunaujvwggM5ojvIu7D48V2Mz9e8bIBaOq9DdUE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251007094918eucas1p156e46178b9f1073d96a93b0342cca05c~sLJGnoJ061180611806eucas1p1J;
	Tue,  7 Oct 2025 09:49:18 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251007094917eusmtip270ccf3e223167cded56393464922a0a6~sLJFxeArE2792027920eusmtip2B;
	Tue,  7 Oct 2025 09:49:17 +0000 (GMT)
Message-ID: <51795930-680c-49cc-a4e0-c7ae7e017bad@samsung.com>
Date: Tue, 7 Oct 2025 11:49:16 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 03/14] iommu/exynos: fix device leak on of_xlate()
To: Johan Hovold <johan@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will
	Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>, Janne
	Grunau <j@jannau.net>, Rob Clark <robin.clark@oss.qualcomm.com>, Yong Wu
	<yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Yu Kuai
	<yukuai3@huawei.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251007094327.11734-4-johan@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251007094918eucas1p156e46178b9f1073d96a93b0342cca05c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251007094459eucas1p2474c07d6c4fe475c02d4210d8f184643
X-EPHeader: CA
X-CMS-RootMailID: 20251007094459eucas1p2474c07d6c4fe475c02d4210d8f184643
References: <20251007094327.11734-1-johan@kernel.org>
	<CGME20251007094459eucas1p2474c07d6c4fe475c02d4210d8f184643@eucas1p2.samsung.com>
	<20251007094327.11734-4-johan@kernel.org>

On 07.10.2025 11:43, Johan Hovold wrote:
> Make sure to drop the reference taken to the iommu platform device when
> looking up its driver data during of_xlate().
>
> Note that commit 1a26044954a6 ("iommu/exynos: add missing put_device()
> call in exynos_iommu_of_xlate()") fixed the leak in a couple of error
> paths, but the reference is still leaking on success.
>
> Fixes: aa759fd376fb ("iommu/exynos: Add callback for initializing devices from device tree")
> Cc: stable@vger.kernel.org	# 4.2: 1a26044954a6
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/iommu/exynos-iommu.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index b6edd178fe25..ce9e935cb84c 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1446,17 +1446,14 @@ static int exynos_iommu_of_xlate(struct device *dev,
>   		return -ENODEV;
>   
>   	data = platform_get_drvdata(sysmmu);
> -	if (!data) {
> -		put_device(&sysmmu->dev);
> +	put_device(&sysmmu->dev);
> +	if (!data)
>   		return -ENODEV;
> -	}
>   
>   	if (!owner) {
>   		owner = kzalloc(sizeof(*owner), GFP_KERNEL);
> -		if (!owner) {
> -			put_device(&sysmmu->dev);
> +		if (!owner)
>   			return -ENOMEM;
> -		}
>   
>   		INIT_LIST_HEAD(&owner->controllers);
>   		mutex_init(&owner->rpm_lock);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

