Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787454;
	b=vx/SYmjCrMuJ5lRagwg9z9c9PyBIcBr85/JpAWQPYI6g6xDVS5mFTzPuhRBtR/xzq59X
	 pSDRo2WNAC6/o3hs51n9hKmeWS9kKnxZALtNGFbIbwH+h7eWnfrgt0iMprzGqUrcc+M1L
	 XsR3NRjSiT4z0GZ2liIysJ16h4V6963lwT3Dfc63nYtRnUXKyGRc93mCOf1HMJap+NJ3Q
	 VD1JS+/hEGZKus6NPNBt3lG/Q9LjAU0mfSDznKXvHcridOdSVVI0RPLTn4L1I+Bds2RMt
	 6LWkRxG+QdzrLI3cRWYPQyS5yITb0TfqunbvAu7xn4uGIc7M7pTxrhR+R6AJlqekPtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787454;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=W2BLdFCLXqqGzqgzzWL5ZjqtGuQVWcPcrvfmmj2AsEQ=;
	b=CyKJjtqq/uApSIUspD/hPfO1Ujy19/XI2iL9WF6liqk9SWgWhqX13V0b3ysxU1bZR0Yu
	 TIkAYcTtPmr6+v0iug/JqmjhakknpOU44uvSBw5UUWtrwTM6k48W2dywMh18NbvyTdSY+
	 ExR3YQyXjEheBLPWijmF3tRH1R4HoJ+MGQzIfesZhW1tJ8UtXSoo7wgEw3XDD/iIZQQ+Y
	 z+94iziZsV7+Anox4A3YxyXgkDSYftnzBr/PqswFLbMUwuBvwc605kIgr4p0RdtAgIZ4v
	 dLU74499a0Yr0+AdHIL4hDa5oueSPfQjtgzblboYHijbro8164TsZyCYXl0v5QHcJpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=G2i4MnW1;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938CF606A31E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 13:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 938CF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=G2i4MnW1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA5871570;
	Fri, 27 Nov 2026 05:50:49 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 490133F632;
	Fri, 27 Nov 2026 05:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795787452; bh=InPRxVzDI2vjxwZEavNbuf666pud9/KmCUGG5pDASzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G2i4MnW1cdxQ9bbPd/ojeNKVpcA7dVi9RkhkGSConJ8BzgFbXeYBGNRCBGuwf61lU
	 ml0Lv82yEpVRg8e98RuLOswk6aoe1ZcEsrq2/a6sLK2R1Lphdv7Se62lzsAVVbdfBR
	 NuR2cdtvGeeGB+KPF3cGWTNfPUOmOQZ8f7D+YShI=
Message-ID: <f789bb4c-ad5c-455a-a51d-fc9fe67b1d13@arm.com>
Date: Fri, 27 Nov 2026 13:50:38 +0000
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
Subject: Re: [PATCH] iommu/exynos: Disable runtime PM on registration failure
To: Zhiqi Zhang <zhiqizhangg@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 stable@vger.kernel.org
References: <20261126045203.62181-1-zhiqizhangg@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261126045203.62181-1-zhiqizhangg@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2026 4:52 am, Zhiqi Zhang wrote:
> exynos_sysmmu_probe() enables runtime PM and then registers the SysMMU
> with the IOMMU core. If iommu_device_register() fails, the error path
> currently only removes the sysfs entry before returning.
> 
> That leaves runtime PM enabled for a device whose probe failed.

If that matters, then wouldn't the same theoretical reasoning also still 
apply to module removal after a successful probe?

> The same
> path can also leave dma_dev pointing at this SysMMU when it was the first
> one to initialize the global DMA helper device, so later domain allocation
> may use a device that never finished probing.
> 
> Add an unwind label for iommu_device_register() failures. Disable runtime
> PM there, clear dma_dev if this probe set it, and then remove the sysfs
> entry as before.
> 
> Found during static probe error-path review with help from OpenAI Codex.
> The fix was build-tested with ARCH=arm exynos_defconfig and W=1 using an
> arm-linux-gnueabihf GCC cross-compiler.
> 
> Fixes: bbc4d205d93f ("iommu/exynos: Fix driver initialization sequence")
> Cc: stable@vger.kernel.org # 6.2+
> Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
> ---
>   drivers/iommu/exynos-iommu.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 7c337ba96..18a536008 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -844,10 +844,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>   
>   	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
>   	if (ret)
> -		goto err_dma_set_mask;
> +		goto err_iommu_register;
>   
>   	return 0;
>   
> +err_iommu_register:
> +	pm_runtime_disable(dev);
> +	if (dma_dev == &pdev->dev)
> +		dma_dev = NULL;

But what about other IOMMU instances that could have probed in parallel 
and already observed dma_dev to be set? Sure the existing code is not 
perfectly race-free to begin with, but this only makes the issue much 
more obviously worse.

Thanks,
Robin.

>   err_dma_set_mask:
>   	iommu_device_sysfs_remove(&data->iommu);
>   	return ret;
> 
> base-commit: ebb7a8dc1e74c705daffe11c2faf38ec2628f838

