Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B643425D542
	for <iommu@lists.linux.dev>; Tue, 11 Feb 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299224; cv=none; b=KgFbX5IDttPF3U1mZiZYvStY8dIxy2fPrLLnEHZ+lUV6JSNAiW3kHF8ohb9QgoARun5oJhrwKi8+Ls98IZtXVNjU55lTYVsWTugDHOfY5P1CYby1mJtluSkiZc6NjpEMZmTIeyx+fVUI7huCzf7ojurdKqmoT77zjXQgtmXmEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299224; c=relaxed/simple;
	bh=douAAtq1juT4etZFymJAHKVVxPzVgwUUhJUWCYFwR9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2BJwnw8aoQlQiGBCqfi2C4IDdhSCZYokvOOoZQNup/apVw8PnnZyShPanClqJCSfBPw+g8mCh4bgvL7pOMAPNdQdNgOM3DZhD0smhFScW2TIQxLjnl7RAGIjGdSijMns5YSLaovwdaFJiIX+6SyVak4lBANBtK9Y5NFSbqmAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=DEP9DTdO; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="DEP9DTdO"
Date: Tue, 11 Feb 2025 13:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739299210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TAqhdEJIac1nBI7ghVhE2bBif5ol3c9AIgGMBRie10Y=;
	b=DEP9DTdOL7rgm9GNUJd6f3Y15SCXoMpg/zGbtOV3YCnDxmMHyOfbamgMAEtFnkbQ9XNUm+
	MNw1pcp/LWTC1B+uJMKjcG5+3N9OeKlZWSoTbJmYBVdgrHLjOgskY7ZE3decNuTCUvHyRp
	3CeV3xiGX1VHrxkMU/bGgEmKJUVhQmG1xMP65Tp37UsFCMdNMSIQmOjPsLLuyhFseo7qsj
	PgOPDlaCfAqLkkGGguWC+wdPYj41eZWPEOnASbTHsZ4/5C7ZwpoFKKL67dASGx1ETp00q4
	wdXWp+4qmJqoLYHAKoplMwVk+bsNqAe35ttAdXPXTwiVpv4hlnJQmT/ndXtstg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/dart: Set DMA domain for locked DARTs
Message-ID: <Z6uZhQtPAE8Ck_b0@blossom>
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
 <20250210-locked-dart-v1-3-5d97fe247f35@rosenzweig.io>
 <1d6b3fe7-9376-422b-a2e6-ebaed7b6cd75@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d6b3fe7-9376-422b-a2e6-ebaed7b6cd75@arm.com>
X-Migadu-Flow: FLOW_OUT

Hi Robin,

> > This is required.
> 
> Now that we can, I'd really rather do this properly and not offer an
> identity domain in the first place when it's not available.

I'm reading through iommu.c but I don't see a way to avoid offering an
identity domain without the DMA override here, just reading through the
logic of iommu_get_default_domain_type. Could you point me to what you
have in mind?

Thanks,
Alyssa

> > --- a/drivers/iommu/apple-dart.c
> > +++ b/drivers/iommu/apple-dart.c
> > @@ -941,6 +941,8 @@ static int apple_dart_def_domain_type(struct device *dev)
> >   		return IOMMU_DOMAIN_IDENTITY;
> >   	if (!cfg->stream_maps[0].dart->supports_bypass)
> >   		return IOMMU_DOMAIN_DMA;
> > +	if (cfg->stream_maps[0].dart->locked)
> > +		return IOMMU_DOMAIN_DMA;
> >   	return 0;
> >   }
> > 
> 
