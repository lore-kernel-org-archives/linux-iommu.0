Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31652806;
	Mon, 27 Nov 2023 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="cmEfvlc8"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id ADADA42499;
	Mon, 27 Nov 2023 05:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1701064745; bh=QB9rqf5vjtZTxj6YrVQMoEPk5hNZoTD60Drtq1SmnS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cmEfvlc8StbrONgt6ZkpgMd8fHTKxdbaux+xpi5Q2UuFi8l1eO9m8MbS4dYRYBPp2
	 YlIbzLqrM2ZBNvqM4WbPx9vuaMlrJjUY6huSfIjUcCa8yIFbBOMw4oTdgkRb80NbUd
	 De/+I7hx8twtw4klptYNOUX57Qfyi8VM4D4blIJutdk1GHTnMsWQsUcThWdTvo3Mon
	 PUjYlcZJhZSzv4HO/3neOHEfD1yZndALyjTrPiMMgStsq5mbMEdcS45/1t2AGicxlq
	 aTQKq46eWu3bDX9FXFniFT7g7zGFHUp7glIgjmKMeeVN8ZwceveLqgHxNlALupPtOF
	 yCL1r1zzsqZ3Q==
Message-ID: <94634407-9bbd-4f2d-9d0f-4f02cdfadfa5@marcan.st>
Date: Mon, 27 Nov 2023 14:59:00 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: dart: Use readl instead of readl_relaxed for
 consistency
Content-Language: en-US
To: Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231126162009.17934-1-sven@svenpeter.dev>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <20231126162009.17934-1-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/11/27 1:20, Sven Peter wrote:
> While the readl_relaxed in apple_dart_suspend is correct the rest of the
> driver uses the non-relaxed variants everywhere and the single
> readl_relaxed is inconsistent and possibly confusing.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/apple-dart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 59cf256bf40f..c7f047ce0a7a 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -1272,7 +1272,7 @@ static __maybe_unused int apple_dart_suspend(struct device *dev)
>  	unsigned int sid, idx;
>  
>  	for (sid = 0; sid < dart->num_streams; sid++) {
> -		dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(dart, sid));
> +		dart->save_tcr[sid] = readl(dart->regs + DART_TCR(dart, sid));
>  		for (idx = 0; idx < dart->hw->ttbr_count; idx++)
>  			dart->save_ttbr[sid][idx] =
>  				readl(dart->regs + DART_TTBR(dart, sid, idx));

Acked-by: Hector Martin <marcan@marcan.st>

- Hector
