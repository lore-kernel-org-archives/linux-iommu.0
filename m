Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F2E21D3D8
	for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446241; cv=none; b=acpCK9Fo5TPHjG9q1f5upj02PlKj60n3HUrCnlUGqk6YY1zwR1KXVsMhc5ZIXs9eTHOkm43ADcDn49qpvz7GpIbkiMxSOtVA2irXz+1WI01CdKctfvnBAunUBpjCfrm9C5ZwZIGE4tvRi69tAG3QhIgKg7lJWqh7onC2vrWLzm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446241; c=relaxed/simple;
	bh=j7SUEIEGDmwV0UMTw4L/0KijLpcUGnxzR0w5SRUXNPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRCtZe8nEkGeQhFkn/vJrEglqZR3HxY3Vey+xW6NLH2HzoEiX2FwoVeFw+wNtn8x0mYXM6dAXQha9WhtLN4hqML+vSiSD9aEXEfVO+l+EZLvL4XGsm2aEV+YsMSCrSdmfLwLcz5YHOkt3TcL7eV4SfqyayZpqM5jajhqquyWtl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6797B113E;
	Thu, 13 Feb 2025 03:30:59 -0800 (PST)
Received: from [10.57.38.122] (unknown [10.57.38.122])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C284A3F6A8;
	Thu, 13 Feb 2025 03:30:37 -0800 (PST)
Message-ID: <dd1b7ca0-ef9f-4b9d-bca1-8a72c22231bb@arm.com>
Date: Thu, 13 Feb 2025 11:30:35 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/3] iommu: omap: Simplify returning syscon PTR_ERR
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
 <20250212-syscon-phandle-args-iommu-v1-2-c3fab486b426@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250212-syscon-phandle-args-iommu-v1-2-c3fab486b426@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-12 8:19 pm, Krzysztof Kozlowski wrote:
> No need to store PTR_ERR into temporary, local 'ret' variable.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/iommu/omap-iommu.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 04a7deaaba25cb270eb6eeaf6a21030440f78a5e..bce27805805010ae473aa8dbd9e0cb903dd79bba 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1123,7 +1123,6 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
>   					      struct omap_iommu *obj)
>   {
>   	struct device_node *np = pdev->dev.of_node;
> -	int ret;
>   
>   	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
>   		return 0;
> @@ -1132,8 +1131,7 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
>   		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
>   	if (IS_ERR(obj->syscfg)) {
>   		/* can fail with -EPROBE_DEFER */

This comment is no longer correct or useful, since it's alluding to the 
check which you removed in the previous patch. I'd just clean up the 
whole lot in patch #1 as it's all closely related, and also turn this 
return into a dev_err_probe() to capture the spirit of the other errors 
being replaced, perhaps something like "No valid ti,syscon-mmuconfig 
available" - that way it adds some value for debugging probe deferral 
issues more than broken DTs.

Thanks,
Robin.

> -		ret = PTR_ERR(obj->syscfg);
> -		return ret;
> +		return PTR_ERR(obj->syscfg);
>   	}
>   
>   	if (of_property_read_u32_index(np, "ti,syscon-mmuconfig", 1,
> 

