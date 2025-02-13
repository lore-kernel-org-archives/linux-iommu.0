Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADD4205E35
	for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446837; cv=none; b=DVfKk/S77gM85l+NSx+dtRVJd6i3vpnF81JPmGUT1W2icU5Yb//RUh1PIiw4bxgFr76NwHkeAdapggEc/dYxFFRs6ztqP8tVPfQWnU3cj0osEpvj5b2htoQ798CXqcBYvqm1Yd1/2xNuIapkiUJDUcCLXkYtCmK/r5oijKFxR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446837; c=relaxed/simple;
	bh=f5Hw4kGSX8PTFpswXPrMdeZsbOISqrnlWZqD05X3RIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRjj/oebhwH5ZVMyBWbojnE8V4rTcPFdqZaYixnyg456plpaGB92XjtT71/wDI0W/ZcFc8ByogKSdiGErWatYz+Gj6u9BV4eM4OCenLvig5Ud6RKfVAQSHQH7s0vwEZBz2nPdO9uRCQRP3m4WCILUbi4jXDWZFM3nSM/IHAMy5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5980716F3;
	Thu, 13 Feb 2025 03:40:56 -0800 (PST)
Received: from [10.57.38.122] (unknown [10.57.38.122])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B55EA3F6A8;
	Thu, 13 Feb 2025 03:40:34 -0800 (PST)
Message-ID: <e8d2b014-499c-4cbc-95b6-6ed227c4c920@arm.com>
Date: Thu, 13 Feb 2025 11:40:32 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 3/3] iommu: omap: Use
 syscon_regmap_lookup_by_phandle_args
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
 <20250212-syscon-phandle-args-iommu-v1-3-c3fab486b426@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250212-syscon-phandle-args-iommu-v1-3-c3fab486b426@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-12 8:19 pm, Krzysztof Kozlowski wrote:
> Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
> syscon_regmap_lookup_by_phandle() combined with getting the syscon
> argument.  Except simpler code this annotates within one line that given
> phandle has arguments, so grepping for code would be easier.
> 
> There is also no real benefit in printing errors on missing syscon
> argument, because this is done just too late: runtime check on
> static/build-time data.  Dtschema and Devicetree bindings offer the
> static/build-time check for this already.

With my suggestion for capturing a more useful general error in the 
other change, I agree with this one.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/iommu/omap-iommu.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index bce27805805010ae473aa8dbd9e0cb903dd79bba..f12812d3f828ad382c7a84f6ecd604c8f35a6d10 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1127,19 +1127,13 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
>   	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
>   		return 0;
>   
> -	obj->syscfg =
> -		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
> +	obj->syscfg = syscon_regmap_lookup_by_phandle_args(np, "ti,syscon-mmuconfig",
> +							   1, &obj->id);
>   	if (IS_ERR(obj->syscfg)) {
>   		/* can fail with -EPROBE_DEFER */
>   		return PTR_ERR(obj->syscfg);
>   	}
>   
> -	if (of_property_read_u32_index(np, "ti,syscon-mmuconfig", 1,
> -				       &obj->id)) {
> -		dev_err(&pdev->dev, "couldn't get the IOMMU instance id within subsystem\n");
> -		return -EINVAL;
> -	}
> -
>   	if (obj->id != 0 && obj->id != 1) {
>   		dev_err(&pdev->dev, "invalid IOMMU instance id\n");
>   		return -EINVAL;
> 

