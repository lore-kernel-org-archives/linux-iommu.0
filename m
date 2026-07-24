Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6DC32143D
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906132; cv=none; b=r5BLpmw32pz32h0F4/zKajlDfuaR9Ww9lABjTiCrqsbdC3AKJCliz5Z3pY66dwAMuLnTrPA3swONKUil6VVJ2LMzRKnDQ0Cln6exBH/wZE9gBSnsV6qIHFkFnxalCslBBaswHkno20WW0e4KSkJjzYql+34njP12DG3GjJHgA/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906132; c=relaxed/simple;
	bh=QbMIzfT3pI/FCbKHeyTodh9O19gRKy/LqmADzHFm4aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW5KZmqcmYHHd1OYenp2xVxOZSOu3CWOtSEO6kYvCRSba7MxMexiqQyo4V59w7klRMgy2C5gnxkXDMSmFMmh8QoCv6q55u89yALdF6Sg2hx5W5xBekstZgue9FXwqyqlrhTNFG0XkjyUrWY724RWd9wCKrFRlFE3y0P0MDimpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fS/kTmM4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fS/kTmM4"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceaf8a1265so6933495ad.2
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784906130; x=1785510930; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kHaoMw8Oj5RyClx0k/jfMkqxxF2MZw9lUe54lPVbmc0=;
        b=fS/kTmM4ZkwnbKNBwH2eCeUVkd9PqCUXsLkUwal0BtLXb9yfQvMNTyLsmF6K5ThKbk
         achB9ml8PDsqbUcZPNVmv7bpbXR+RcegPAfeIsBHrJu80gz9dJwjFJNYG6+Ewl6ZHc4x
         NPsIHSw1Hegqks3PwToXHgrPMdJIu95wELajylRcyMGAVzJyWHIF1pL5kLpQQeQwPQ0H
         KYEH9byFAGBjOSle7oXRViObG78u4GCRJ3nHEXxMoymsZjVUYgdWD99t+ILxKIpIpj9l
         F2vYmKcUAzgt7H8akvBDtjRclU7VgoEYKsWPDvDUSBRBN0IuNhUkO3W0rbdvtN8vJvOJ
         y/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906130; x=1785510930;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHaoMw8Oj5RyClx0k/jfMkqxxF2MZw9lUe54lPVbmc0=;
        b=iEU5c+eAZnWJiCyGFrwIOI4Ski+/Ig6XeXOQXsT/UqVQw0l9zt3YGkb6Tdhk3QMgBH
         LiWDZOil7FTcjPWbCp8rYIKUQKGEnNeQswDaQ8VOOIaTpG/4JffMCYrRSIqz3+SstDxQ
         K02J+o042TC5YHyXzhiPkeYQXntluCWL03pLgFhuLYuH2YEzyFJanLUBspCuak2IZVeX
         s2VOuZg6r2/Y+INMPFu6yRKTqw7rOq03zr1Nuldtp3hInNFbrZkLfbBoQxXPPGnW8FrJ
         J88pCUHPCTF9WRj19zH/ijLmzxK8VIXRGDG9Gvc3g1gBAAy5ehycw/AQoAVGyA7zxfjv
         oIYw==
X-Gm-Message-State: AOJu0Yy9nsNCFmSsWiuzkm59I+GSCP5+DdICJg2eW0uY3G/CDL9XBb4v
	iCizTI8WPy8rISckCiajJVm2MG5ON97JFwdAqd4b9rRqj1fl0Z7Z65wqp23rD+VgdIo=
X-Gm-Gg: AR+sD12xuqD4wy6XxqWTavD5KYhzPfjhwLJYpBc/FG8jw5oPgjoKiCinN2TvUof8/bF
	pi7lbkprCzhqNNBhNlxFulW6720QPEd4gW37J7D2XvKB/cVqEkYrbodWHwMijNYHCGqTxlcVQkk
	rYkJbHzQDr/Gw63W9eUPIavKVspVsj0Un9iyrn6vzYHKdgvBcxMHccNuAXgBE+tcOoRhSos+QQu
	G9XEE612lohQc3eoQjwqPRb+modT865kiIOz+RF6UltYxGvRve8k7RRVWXiMdPnFUJ0iqhibjVV
	khr6JQJC3uIB9ZuATG6aRla5TBH1+VBwWPOKlLGfQyAWR9grCI5NQWu+ydzFmHavQvFJdEQ/eiV
	XaT0vJLd44xg9hSmh6t0Uq8z9V8ZCdMpL2q5UMWQmwR1xsh4u0ACm
X-Received: by 2002:a17:90b:54d0:b0:38e:5717:9cc8 with SMTP id 98e67ed59e1d1-38ec6617deemr7146863a91.31.1784906130395;
        Fri, 24 Jul 2026 08:15:30 -0700 (PDT)
Received: from ziepe.ca ([216.228.115.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130ce035sm27005956c88.13.2026.07.24.08.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:15:29 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wnHcW-000000002mg-3wXH;
	Fri, 24 Jul 2026 12:15:28 -0300
Date: Fri, 24 Jul 2026 12:15:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
	will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, bhelgaas@google.com,
	alexander.deucher@amd.com, mario.limonciello@amd.com,
	Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <amOBkJ4BaZ4qnkpc@ziepe.ca>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723061548.10187-3-vasant.hegde@amd.com>

On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
> @@ -3120,20 +3146,28 @@ static int amd_iommu_def_domain_type(struct device *dev)
>  	if (!dev_data)
>  		return 0;
>  
> +	if (!dev_is_pci(dev))
> +		return 0;
> +
>  	/* Always use DMA domain for untrusted device */
> -	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> +	if (to_pci_dev(dev)->untrusted)
>  		return IOMMU_DOMAIN_DMA;

The core code does this, it shouldn't be in a driver?

> -	/*
> -	 * Do not identity map IOMMUv2 capable devices when:
> -	 *  - memory encryption is active, because some of those devices
> -	 *    (AMD GPUs) don't have the encryption bit in their DMA-mask
> -	 *    and require remapping.
> -	 *  - SNP is enabled, because it prohibits DTE[Mode]=0.
> -	 */
> -	if (pdev_pasid_supported(dev_data) &&
> -	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
> -	    !amd_iommu_snp_en) {
> +	/* Apply device specific quirks */
> +	if (quirks_force_identity_mapping(to_pci_dev(dev))) {
> +
> +		/*
> +		 * When memory encryption is active, some of these devices
> +		 * don't have the encryption bit in their DMA-mask and
> +		 * require remapping.
> +		 */
> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +			return 0;

I think this can probably be dropped now? There is no intersection of
this old broken embedded GPU and a CPU that supports CC right?

> +
> +		/* DTE[Mode]=0 is prohibited when SNP is enabled */
> +		if (amd_iommu_snp_en)
> +			return 0;

Ditto?

Jason
