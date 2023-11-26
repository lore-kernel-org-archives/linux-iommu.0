Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F789456
	for <iommu@lists.linux.dev>; Sun, 26 Nov 2023 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="wtKzHquY"
Date: Sun, 26 Nov 2023 12:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1701017661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAmJjrTeu7RdpM+b+JpbyW5DOb3ge7UnfELqR9X21vo=;
	b=wtKzHquY9kuLOewD37q4BwVrha6NkJj6WgOHRMW2fatDWrh95MB18j0uarel5fLWSUlwzm
	qMFnbyvDB/aofTADTJ/nlhFvUuQllx8s/wZampc23S0zO6pAPeakTYc2B72HvYNGO0ViZj
	ZmTQ56CtscqX2ywNCKwpNtBVW1BgBeWIle2yzRtaYZKzXdq24efeXVX9GmJhOG2xoixOzh
	DimbDLLlpYvGnSBjMNL0rSQqoGv07vao0UMgEopo43J6LvDeCyvYPBrp7gTcbarL4bdbDN
	TgHm6XFBme6tpkYZ9h6dMbGtwAGPEDCLLWRg4CxtmbklMpqA5AXPGobkAlsKRw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: dart: Use readl instead of readl_relaxed for
 consistency
Message-ID: <ZWN4OHtr-c4XzOFL@blossom>
References: <20231126162009.17934-1-sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126162009.17934-1-sven@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT

r-b

On Sun, Nov 26, 2023 at 05:20:09PM +0100, Sven Peter wrote:
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
> -- 
> 2.34.1
> 
