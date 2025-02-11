Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48CC1E5B6D;
	Tue, 11 Feb 2025 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739298341; cv=none; b=GMpFsNrINl5h2StVOAxi/MkchS581F2Go5vxYJcGQHBKyleLRS3ahJHSLWgTElAPZwQNullpGaRSg7XQMpU2R5Jyz/K1gJZC/pbgwIQsZ51JSd/JyqOxtIglsYJaA3Hzoy5SQOYOdEAddOGpmAl1z7vxHGkzjmEa+jqHvEHXjR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739298341; c=relaxed/simple;
	bh=dk7DcZ8VOV2tzGxsZyrLpE8fBtxN06xuyjPRFr719pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWUoxU9hNa2Yqt+hWq4XpC2WI0Ieegp3bLEYfnSijSjBZ/8VLyFYSJO+jb5DKbRoRnk3FxUMV8mIVedfcMoqpP97cW42j4vR+0hNJdJo23x6+KLlkjP9qVdduB6PQb0yTPuo1EtdrnOE8PVSYGZNwFnPaAloM50gFoNv6it6ImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 684A513D5;
	Tue, 11 Feb 2025 10:26:00 -0800 (PST)
Received: from [10.57.35.63] (unknown [10.57.35.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23A793F58B;
	Tue, 11 Feb 2025 10:25:36 -0800 (PST)
Message-ID: <1d6b3fe7-9376-422b-a2e6-ebaed7b6cd75@arm.com>
Date: Tue, 11 Feb 2025 18:25:35 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] iommu/dart: Set DMA domain for locked DARTs
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Sven Peter
 <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
 <20250210-locked-dart-v1-3-5d97fe247f35@rosenzweig.io>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250210-locked-dart-v1-3-5d97fe247f35@rosenzweig.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-10 7:39 pm, Alyssa Rosenzweig wrote:
> This is required.

Now that we can, I'd really rather do this properly and not offer an 
identity domain in the first place when it's not available.

Thanks,
Robin.

> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
>   drivers/iommu/apple-dart.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 9c74a95eb7e819e94ab2fb47ed0d411a1eba8bf7..9c6f780dc7220096ed6bba692fa1a4bd859b0d61 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -941,6 +941,8 @@ static int apple_dart_def_domain_type(struct device *dev)
>   		return IOMMU_DOMAIN_IDENTITY;
>   	if (!cfg->stream_maps[0].dart->supports_bypass)
>   		return IOMMU_DOMAIN_DMA;
> +	if (cfg->stream_maps[0].dart->locked)
> +		return IOMMU_DOMAIN_DMA;
>   
>   	return 0;
>   }
> 

