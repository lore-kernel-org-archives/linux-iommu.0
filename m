Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF99190676
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741996323; cv=none; b=i2CKr3KOoisV4qngQcV0M4XYyHPvwOvY8ty0j/SDos/5MwHk90jHktjnx0ch1aFT/M4m7F0Z5F93cXt+fjacpwwvNGX9USQS/VVFw1ihsBxpwhjyvyeWdRTJ9R1ANsAshUItVPEdIthQMUv8/KwS5h0IT0fdudyBnS/x05unCbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741996323; c=relaxed/simple;
	bh=p0Pj9tcQG6GfXZFp5IfdT5bVi4hWdGazLlS6zlwcJK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5a+L8zXDHNJHk0/CuOfBfh6995o4h5a+7VH3lgGPfqSGpHRdHmzwXoiAi1IPmbggxlDpZx4rkPLYR+ECabi4FfS5dhedyB3piS90D0AsMEkE8pbfMCIIFNhVhyjX3yRbGfY6Nc59hhJWxXRtP/b9syT604CBoPd8DeFl7r8yyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=NFxeQgAk; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="NFxeQgAk"
Date: Fri, 14 Mar 2025 19:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1741996309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0BbUbAG3eg70hP8/1CroK/Kf34mgOD7Ll45eATb+8I=;
	b=NFxeQgAk/R//VsAghYt8xhZSxiEQfPlmN19UgK3B030JQ8DgU2qLncAavMBApOJvK5h5lg
	FUI5N99t4GbrKAlZJktXynUCkOGRuTdDJO+6pTR+vnBMnEg2gyTzcvSnu8Z6AeMVQhUdCe
	G/CygyehVX9vYdfN1LvodihTLRmi16FtkLWVdvudJpaumAGt4A6HbhqFCQ0WA8bXBghD0a
	FaY2zdPIg22BU+zEcb1/4T24fLmnLXnoNfEToknIWMRMU6gDUUQOti7EI4zXgs4O/Y7paf
	zr+w5Yo/Fw2B8LmI1cejA0u0Erz9SM016vXwFJNqetok9RyACi6XuJE+f6ly1w==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: marcan@marcan.st, fnkl.kernel@gmail.com,
	Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: apple-dart: fix potential null pointer deref
Message-ID: <Z9TBEAJkOrHIWype@blossom>
References: <20250314230102.11008-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314230102.11008-1-qasdev00@gmail.com>
X-Migadu-Flow: FLOW_OUT

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Le Fri , Mar 14, 2025 at 11:01:02PM +0000, Qasim Ijaz a écrit :
> If kzalloc() fails, accessing cfg->supports_bypass causes a null pointer dereference. 
> 
> Fix by checking for NULL immediately after allocation and returning -ENOMEM.
> 
> Fixes: 3bc0102835f6 ("iommu: apple-dart: Allow mismatched bypass support")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
>  drivers/iommu/apple-dart.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 13ccb801f52a..e13501541fdd 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -797,12 +797,11 @@ static int apple_dart_of_xlate(struct device *dev,
>  
>  	if (!cfg) {
>  		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> -
> +		if (!cfg)
> +			return -ENOMEM;
>  		/* Will be ANDed with DART capabilities */
>  		cfg->supports_bypass = true;
>  	}
> -	if (!cfg)
> -		return -ENOMEM;
>  	dev_iommu_priv_set(dev, cfg);
>  
>  	cfg_dart = cfg->stream_maps[0].dart;
> -- 
> 2.39.5
> 
