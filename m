Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC43269AE4
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493765; cv=none; b=XDM8vxs0x4f4Iy84XWU80moHgQHPP4dlGtw37ndZoEaswXoJPl+G5lwvLokqLou0gGeoK8szlJopN6cFISqjvoVpsoPC3nH8Xu5vP/8PIzsb41olZTD9Zz8gmfRamEGd9XVE99Rt/W8DeU3JtmdirYeMtOVzOqltIrEGxtX/xAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493765; c=relaxed/simple;
	bh=G4T38wDwbtJSolol4t9Wvue++SByJEQJy4qBtUgctBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmowPRH4zy7sazqg9wSRNEpjYCgXD5HQrsh1tph+ZpY5NnGcopEXzztq4u65KHVHHSplhh9iWDa5Kgw4l/94LzNe0CI4Z0KxV7i5MKq5eNFMSYgR3RExGn+920X/TfUXBO6jIB4b07wFh3rVt10Lm0mf/xq60PCRxDoRAcG5inU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dW/JG7Fv; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dW/JG7Fv"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be8f28172dso444028385a.3
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 06:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740493762; x=1741098562; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YkcYV4gV/E7qfD26A7G2ezewOL689Fm1UG+GfYbd62g=;
        b=dW/JG7FvAiYBkAhUn8dXAo//nqqlCSvC4/ITgkVby6ivd7xcbNO3uhV8yU1gsN/Ul3
         8NPxtR0dG4kG28cDv2HvWBRHxvaMr7QvK1wCdQQXdFyMW0KyUloErRSgwXtHP/uyzqQn
         kw4ixPRHmOfN1GJSeiQ+x/riW6B5UNSACsz5r4wu5mPwoCeS55IIb8CPpCy1PWiW1kNk
         /XWLnrkoqczD1Wf1t1jB8YVbuEgrcvr/9gpV/31QbXkMxmrzREEz9LQUq/8jY7U876Hm
         KxDvwCJ+BAlbJVCPdqCM+NjzZ/aQYMF7CP26lEQVvftWdqyf8YbDvMhoDIr8SxRN5mIh
         b5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493762; x=1741098562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkcYV4gV/E7qfD26A7G2ezewOL689Fm1UG+GfYbd62g=;
        b=xGG+decRqZTpzyAN9qtYmmWVsYJ1eZt1OaF2zcdeTLcvJtrBR6FtlWU7aMCsUDaAYE
         AAVakflvQvp2vwgZthgjZTciJeFkFXB2wAfh9hhFkvsK0kWigc2X1rwds3WmLFnmurlj
         Q45fRHfDIuM6mSmQhRTcl6nSfro2TIlqm0GtcOr6RnCDgu5oMaqNmOuKtQ4a8mWlhhW2
         +ePw1HJAr4ftakafk0AK5uCThATp6m0Rl3rbwdCgX5rzmp3amRNssESxRcGuJNcI3GN9
         jLwlTzs5Mqhgn7kAEGZNSNeYW/ljXR6mmF0XqdkHogtOpQqXngt8tCu+ekkuSKo/A13l
         axbg==
X-Gm-Message-State: AOJu0YyPSE5Flf8jx4HZIJjPLhtPkvl0vgJZq8zP5Rzphpk8ewVZgRsA
	wVASuTnAmUl8g0ahxS/MG9MNP6l3jrVrswvys9lHYRWjYYgsNnw3o9/w3Ww2B0o=
X-Gm-Gg: ASbGncsaJbdNfVV35OwroWPLkkkKiqkSfQowSR+ZVsq6qa7W2sqaUkse7zBgiWTEJ6z
	rtxGsIXwz1effL6Qdq/TTwPIU4FRZmVzzNeSWVqs945+iYxrWlKrHz/3xL/8YkYetKwE4BwGypR
	7gpME8X1zdr4YwFeGMbA05etHo85txQAyJisax3Ms0smTKGpLOhcLKEQWIEIknbJmgdXHrMRVmr
	AyreDI3ctzrfndkSgBAxaXRBZleXkjiIRTl0N2jR47nn0migACp8SuuxOh3GBvWE1lvwVIPWUDz
X-Google-Smtp-Source: AGHT+IFmF4rJsVSnZG51UHCTlAiCIB2QJ9EUAjv7uhyZvudw5PXcUwAI5PmRXpZgndiOCL1R5xEKbA==
X-Received: by 2002:a05:620a:44c4:b0:7c0:aa35:c3b7 with SMTP id af79cd13be357-7c0ceeeb379mr2093736885a.12.1740493762635;
        Tue, 25 Feb 2025 06:29:22 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c20abffsm115131485a.0.2025.02.25.06.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:29:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tmvw1-00000002T5w-2MS3;
	Tue, 25 Feb 2025 10:29:21 -0400
Date: Tue, 25 Feb 2025 10:29:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 7/7] iommu/amd: Make protection_domain as static
Message-ID: <20250225142921.GI545008@ziepe.ca>
References: <20250225105345.52143-1-vasant.hegde@amd.com>
 <20250225105345.52143-8-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225105345.52143-8-vasant.hegde@amd.com>

On Tue, Feb 25, 2025 at 10:53:45AM +0000, Vasant Hegde wrote:
> And update amd_iommu_domain_alloc_sva() error path to call
> amd_iommu_domain_free() directly.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h | 1 -
>  drivers/iommu/amd/iommu.c     | 2 +-
>  drivers/iommu/amd/pasid.c     | 2 +-
>  3 files changed, 2 insertions(+), 3 deletions(-)

Why do we even have protection_domain_free() just fold it into
amd_iommu_domain_free()?

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
