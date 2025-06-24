Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600A026CE2E
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750786596; cv=none; b=AMqGPzhnA29Ep2QhYa0I9tnb1jHx2Li/oxf8eU9PT/Lnfqwl03RJdUuxbcRQfvr3D9oxuvSFG0Ozyy4zjLraL2bUFNepaQrZ3xIZZjqHIuPl2hXCu1ataNAfLVSO9WT9OVQb+vewpSvPtZQE7e+fot6H0PhyY0C674LMPpeMkKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750786596; c=relaxed/simple;
	bh=zJPn55FN4b4Ivnh/o+8rVt+pDkYbSpkmmie7pToD4CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1j6ShdPX/5xT9CjsZ/gbPG3tPHMwEO/POA/lXEQtQ7HQ6D0FmWKEB3aNpU1mGO04vzqMy0JRjsZTxVm1UJiyyuchqIkFdbVCk7iU+bMmMI3+cgqYasGCyyJDBgpTU1iromgo1lC9qNNoc3nQM72tc7cL4SX0e4aMF9aGPaNqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 613AA113E;
	Tue, 24 Jun 2025 10:36:15 -0700 (PDT)
Received: from [10.57.29.113] (unknown [10.57.29.113])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FC4E3F58B;
	Tue, 24 Jun 2025 10:36:31 -0700 (PDT)
Message-ID: <33672077-77b9-476c-9565-b78aae2a38de@arm.com>
Date: Tue, 24 Jun 2025 18:36:29 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iommu: mtk_iommu_v1: Simplify by dropping local
 'mtk_mapping' variable
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20250624-syscon-phandle-args-iommu-v3-0-1a36487d69b8@linaro.org>
 <20250624-syscon-phandle-args-iommu-v3-3-1a36487d69b8@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250624-syscon-phandle-args-iommu-v3-3-1a36487d69b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-24 1:22 pm, Krzysztof Kozlowski wrote:
> Storing 'data->mapping' in local variable in
> mtk_iommu_v1_probe_finalize() does not make the code easier to read.
> Use the 'data->mapping' directly.
> 
> ARM64 W=1 builds also complain with:
> 
>    mtk_iommu_v1.c:512:28: error: variable 'mtk_mapping' set but not used [-Werror,-Wunused-but-set-variable]
> 
> but this is not being fixed here and 'data' still won't be used in such
> compile test.

Sorry, I guess that's on me for doing the COMPILE_TEST stubs the lazy 
way... TBH I'm still not sure this driver hasn't completely bitrotted, 
but if we're touching it at all we should probably actually fix the 
warning, e.g.:

-#define arm_iommu_attach_device(...)   -ENODEV
+#define arm_iommu_attach_device(d, m)  ((void)m, -ENODEV)

or perhaps make it a less lazy static inline.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Old warning is changed now to:
> 
>    error: variable 'data' set but not used [-Werror,-Wunused-but-set-variable]
> ---
>   drivers/iommu/mtk_iommu_v1.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 66824982e05fbfdda224276ad41b90f9d5f9ca4e..bbe3e9d901c69ac6405d9549a4481fc80f1adb80 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -509,14 +509,12 @@ static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
>   
>   static void mtk_iommu_v1_probe_finalize(struct device *dev)
>   {
> -	struct dma_iommu_mapping *mtk_mapping;
>   	struct mtk_iommu_v1_data *data;
>   	int err;
>   
>   	data        = dev_iommu_priv_get(dev);

And for the sake of a readability cleanup you may as well fold this into 
the declaration line as well. And then maybe also whack a __maybe_unused 
on it, for even less effort than the first silly thing I thought of 
above... :)

Thanks,
Robin.

> -	mtk_mapping = data->mapping;
>   
> -	err = arm_iommu_attach_device(dev, mtk_mapping);
> +	err = arm_iommu_attach_device(dev, data->mapping);
>   	if (err)
>   		dev_err(dev, "Can't create IOMMU mapping - DMA-OPS will not work\n");
>   }
> 

