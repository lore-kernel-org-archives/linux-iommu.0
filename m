Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290193BB54;
	Tue, 11 Feb 2025 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739298875; cv=none; b=ABSBjhBGWILc3avuKuniBif+mZ4crR4POdB0l1HV5Kg4kph8hY2eZ3znNijFk3nexlkIu5lTHt/dq82CYiMlZZfBsrd1S1aPQiY9kCNBZzwd99wpFafW5mnHUOdaCNiX9E9z5s0HCJFgd40zCKIm1P8ng9gFhSUnzvTdvZpaozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739298875; c=relaxed/simple;
	bh=TvhfNc3I07qiTd32YHIKmw3g9aChxrMBZe65U1A7VhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IsNOc84CSn5Yxx7snGMZfK+H8NMVJqIdFiw30HaNKspPAw3dC8RfMSiqu4hOaH9LsxcuZZNQRlfly4nhWs9cmV3GcSNqUUeBczotXjT6gOv4HTiI5QEgjqfWJTvZlLUVFsnKi5ywoJE1roQQRykga/z1skPsPbF+UW1IGjr8H0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDA0E13D5;
	Tue, 11 Feb 2025 10:34:53 -0800 (PST)
Received: from [10.57.35.63] (unknown [10.57.35.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C11D3F58B;
	Tue, 11 Feb 2025 10:34:30 -0800 (PST)
Message-ID: <98af5c02-5006-4272-aaf0-a0e30c312059@arm.com>
Date: Tue, 11 Feb 2025 18:34:27 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] iommu/dart: Skip reset for locked DARTs
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Sven Peter
 <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Hector Martin <marcan@marcan.st>
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
 <20250210-locked-dart-v1-2-5d97fe247f35@rosenzweig.io>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250210-locked-dart-v1-2-5d97fe247f35@rosenzweig.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-10 7:39 pm, Alyssa Rosenzweig wrote:
> Locked DARTs cannot be reconfigured, therefore the reset/restore
> procedure can't work and should not be needed. Skip it, allowing locked
> DARTs to probe.
> 
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
>   drivers/iommu/apple-dart.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 460cf96bc8001e051916f356d5d175b35e36c608..9c74a95eb7e819e94ab2fb47ed0d411a1eba8bf7 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -452,17 +452,9 @@ apple_dart_t8110_hw_invalidate_tlb(struct apple_dart_stream_map *stream_map)
>   
>   static int apple_dart_hw_reset(struct apple_dart *dart)
>   {
> -	u32 config;
>   	struct apple_dart_stream_map stream_map;
>   	int i;
>   
> -	config = readl(dart->regs + dart->hw->lock);
> -	if (config & dart->hw->lock_bit) {
> -		dev_err(dart->dev, "DART is locked down until reboot: %08x\n",
> -			config);
> -		return -EINVAL;
> -	}
> -
>   	stream_map.dart = dart;
>   	bitmap_zero(stream_map.sidmap, DART_MAX_STREAMS);
>   	bitmap_set(stream_map.sidmap, 0, dart->num_streams);
> @@ -1151,9 +1143,11 @@ static int apple_dart_probe(struct platform_device *pdev)
>   	}
>   
>   	dart->locked = apple_dart_is_locked(dart);
> -	ret = apple_dart_hw_reset(dart);
> -	if (ret)
> -		goto err_clk_disable;
> +	if (!dart->locked) {
> +		ret = apple_dart_hw_reset(dart);
> +		if (ret)
> +			goto err_clk_disable;
> +	}
>   
>   	ret = request_irq(dart->irq, dart->hw->irq_handler, IRQF_SHARED,
>   			  "apple-dart fault handler", dart);
> @@ -1192,7 +1186,9 @@ static void apple_dart_remove(struct platform_device *pdev)
>   {
>   	struct apple_dart *dart = platform_get_drvdata(pdev);
>   
> -	apple_dart_hw_reset(dart);
> +	if (!dart->locked)
> +		apple_dart_hw_reset(dart);

Not much point saving anything on suspend either, in that case.

Thanks,
Robin.

> +
>   	free_irq(dart->irq, dart);
>   
>   	iommu_device_unregister(&dart->iommu);
> @@ -1325,6 +1321,10 @@ static __maybe_unused int apple_dart_resume(struct device *dev)
>   	unsigned int sid, idx;
>   	int ret;
>   
> +	/* Locked DARTs can't be restored, and they should not need it */
> +	if (dart->locked)
> +		return 0;
> +
>   	ret = apple_dart_hw_reset(dart);
>   	if (ret) {
>   		dev_err(dev, "Failed to reset DART on resume\n");
> 

