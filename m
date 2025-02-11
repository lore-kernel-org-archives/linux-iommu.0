Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC9B2528FD;
	Tue, 11 Feb 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299266; cv=none; b=CHQnxykV3QD3jwfo3QOHHWWPGuB/t0ojEijtNj4lU66KPibFOb1Nf6N7hVKTrza/N4TjSoYxht8sT8DXi7eC+e6zO+3++sXXPCTSiEc7VWbwOZBg6TIqH/QFCSJGcSK+20qGTCxgRWWHvDoHbQrA7egR3xqhNPvcE38B/LZhQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299266; c=relaxed/simple;
	bh=Fxqq6zp+OKlNrfdLL0K3HimmEAyjOKDGF/4KIG+bQNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Br+IKFMpy6lrDGrEm6IGQxYBJJP3a8vPL3wzTmK4H62MOIKTcAz6GwRzP2PipPusAAzvrdgnY2i3B1e0t8uqZ9KDkrXbBJqcHaUxchGqkdfV5qoRDPHeL/QHVHBrSGF0aEf0/0NNOoxOhTnD/RIlksIuMjSnKRgPTdDFlpsHUXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CCD713D5;
	Tue, 11 Feb 2025 10:41:25 -0800 (PST)
Received: from [10.57.35.63] (unknown [10.57.35.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17DC03F58B;
	Tue, 11 Feb 2025 10:41:01 -0800 (PST)
Message-ID: <756ba6d7-b18e-4139-851b-496b1820117a@arm.com>
Date: Tue, 11 Feb 2025 18:41:00 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iommu/dart: Assert !locked when configuring
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Sven Peter
 <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
 <20250210-locked-dart-v1-5-5d97fe247f35@rosenzweig.io>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250210-locked-dart-v1-5-5d97fe247f35@rosenzweig.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-10 7:39 pm, Alyssa Rosenzweig wrote:
> Configuration is only possible and needed for non-locked DARTs and will
> fail for locked DARTs. We cannot try -- assert that we do not.

Except now we absolutely will - if a locked DART and its client device 
are advertised to Linux, instead of gracefully refusing to touch it, 
we'll now attach the client to a DMA domain, firing a barrage of 
multiple WARNs in the process, and give it DMA ops which still cannot 
work. I'm not really convinced this series on its own leaves us in a 
better position than we're already in now... :/

How hideous is the rest of what's required to actually make this usable?

Thanks,
Robin.

> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
>   drivers/iommu/apple-dart.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 29b627b38e8c37afd2b6a72865f43d24b633834a..87eb87bb2f5158d000a2c2fc801b722a2262c941 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -309,6 +309,7 @@ apple_dart_hw_enable_translation(struct apple_dart_stream_map *stream_map)
>   	struct apple_dart *dart = stream_map->dart;
>   	int sid;
>   
> +	WARN_ON(stream_map->dart->locked);
>   	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
>   		writel(dart->hw->tcr_enabled, dart->regs + DART_TCR(dart, sid));
>   }
> @@ -318,6 +319,7 @@ static void apple_dart_hw_disable_dma(struct apple_dart_stream_map *stream_map)
>   	struct apple_dart *dart = stream_map->dart;
>   	int sid;
>   
> +	WARN_ON(stream_map->dart->locked);
>   	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
>   		writel(dart->hw->tcr_disabled, dart->regs + DART_TCR(dart, sid));
>   }
> @@ -328,7 +330,7 @@ apple_dart_hw_enable_bypass(struct apple_dart_stream_map *stream_map)
>   	struct apple_dart *dart = stream_map->dart;
>   	int sid;
>   
> -	WARN_ON(!stream_map->dart->supports_bypass);
> +	WARN_ON(stream_map->dart->locked || !stream_map->dart->supports_bypass);
>   	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
>   		writel(dart->hw->tcr_bypass,
>   		       dart->regs + DART_TCR(dart, sid));
> @@ -340,6 +342,7 @@ static void apple_dart_hw_set_ttbr(struct apple_dart_stream_map *stream_map,
>   	struct apple_dart *dart = stream_map->dart;
>   	int sid;
>   
> +	WARN_ON(stream_map->dart->locked);
>   	WARN_ON(paddr & ((1 << dart->hw->ttbr_shift) - 1));
>   	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
>   		writel(dart->hw->ttbr_valid |
> @@ -353,6 +356,7 @@ static void apple_dart_hw_clear_ttbr(struct apple_dart_stream_map *stream_map,
>   	struct apple_dart *dart = stream_map->dart;
>   	int sid;
>   
> +	WARN_ON(stream_map->dart->locked);
>   	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
>   		writel(0, dart->regs + DART_TTBR(dart, sid, idx));
>   }
> 

