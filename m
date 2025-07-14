Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A725D1E47A8;
	Mon, 14 Jul 2025 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492204; cv=none; b=ehQUWMV/TS61YZgHoHgI7kf7q1OudbEoOcBWhlODcpBCh9VCJne2qEDZsnrWheaxy0EQj7v/XxmKhX2aRXIW98eFUPdVgzkDCg9Q3OU7lfpIxUsTNXVDyJa4zcDCsnwcj43gT98XBWuwqddblEK7E/WN+ghmPUV+BvnFRWnfr/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492204; c=relaxed/simple;
	bh=DY/dmG6LZNxcbok7TxYUWpoHqR8O26mknUUoN8ACEog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pund2UdI0t4fzdQS4jOS6Kh04eNIsdJef2t9pGUwLQmQaIVfHoAr0hK9yinmTUYNLmy2ZsHI5PuOlGJEcVu/3Th+iU7R0lvfPtqiHpq5O2YuzeyItyQW5Cac8//lgJ2HgJBKTti1PrjGYMcV3dybccu1fttyWwjJivraT1U9R8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYIReyAs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYIReyAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429A9C4CEF4;
	Mon, 14 Jul 2025 11:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752492204;
	bh=DY/dmG6LZNxcbok7TxYUWpoHqR8O26mknUUoN8ACEog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYIReyAs3klRSmt6LYTsKyntQGMMST6uGgl1PMjXnRAetY7AQsoBiwJvrRzLUDJjQ
	 9+/oIXIjiJhUZxDMMT0hOetBJm/rFzgXsyWvVGoFfG9IorBcVt6IDqTXbarJ0ymFy5
	 cimWTCGF/JHusIBPqWcXsNf1Dtg0D91D84wCbPQrrmKBW81Tly1rxv0rbBcBMBR/xW
	 Gdo8CS5XaNtkcQnVELn4XZe/Mvm7dITTDR3V/84LWU04Oo8y83I4h6EQpKiAnLWm5R
	 FFZnXmqk6VgYiH19Y5vzqCYtAwD+NKa4L4ZFs7ffUDEQ8RgL2mQkrNuokVSZPW0sT+
	 /Sf3orGKxjPFw==
Date: Mon, 14 Jul 2025 12:23:19 +0100
From: Will Deacon <will@kernel.org>
To: Zhang Shurong <zhang_shurong@foxmail.com>
Cc: sven@kernel.org, j@jannau.net, alyssa@rosenzweig.io, neal@gompa.dev,
	joro@8bytes.org, robin.murphy@arm.com, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dart: add missing put_device() call in
 apple_dart_of_xlate
Message-ID: <aHTop3m5gdS4vwvk@willie-the-truck>
References: <tencent_22664B08ACDCE35DE10E5546C2FB26B59605@qq.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_22664B08ACDCE35DE10E5546C2FB26B59605@qq.com>

On Sun, Jul 13, 2025 at 12:16:24AM +0800, Zhang Shurong wrote:
> The apple_dart_of_xlate() function obtains a platform device reference
> via of_find_device_by_node() but doesn't release it with put_device().
> This patch adds proper device reference handling to prevent memory
> leaks.
> 
> Fixes: 46d1fb072e76 ("iommu/dart: Add DART iommu driver")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>  drivers/iommu/apple-dart.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 190f28d76615..811bf5176568 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -796,8 +796,10 @@ static int apple_dart_of_xlate(struct device *dev,
>  
>  	if (!cfg) {
>  		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> -		if (!cfg)
> +		if (!cfg)  {
> +			put_device(&iommu_pdev->dev);
>  			return -ENOMEM;
> +		}
>  		/* Will be ANDed with DART capabilities */
>  		cfg->supports_bypass = true;
>  	}
> @@ -805,8 +807,10 @@ static int apple_dart_of_xlate(struct device *dev,
>  
>  	cfg_dart = cfg->stream_maps[0].dart;
>  	if (cfg_dart) {
> -		if (cfg_dart->pgsize != dart->pgsize)
> +		if (cfg_dart->pgsize != dart->pgsize) {
> +			put_device(&iommu_pdev->dev);
>  			return -EINVAL;
> +		}
>  	}
>  
>  	cfg->supports_bypass &= dart->supports_bypass;
> @@ -825,6 +829,8 @@ static int apple_dart_of_xlate(struct device *dev,
>  		}
>  	}
>  
> +
> +	put_device(&iommu_pdev->dev);
>  	return -EINVAL;

Why is it correct to retain the reference on the device in the cases
where this function returns 0?

Will
