Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036F433A9
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727896176; cv=none; b=mXcbnaMBx1XDws7VxTydPAGbln88gWbOtTFVDzZPSKXb0igzzNOqEuiwOQ6QAg0/xSTcB8bIJdNG/mwMP1BCqBAvi73+9gvJWxUhnqnJSmEYzd+/verrZs97TV7cICM15r4ieEPcIHK5o00BN1wwIqIo4SPUnZREUr2gWTTGNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727896176; c=relaxed/simple;
	bh=q04UkY0rc+O8C9VOeCGbY7I8PFj4ituUM1H9CtVL7y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUeqNmiws0E0yV10yaRmzs8SxLWYBr9h9xNHfxKnJBnch6Ggq5lffUf1cOu+TT3G0prXO/okpu1bIJ7aGkAxJL7dRiPovcvPFoj2ztZIwzUz8pa/UimQ2RRtrL1PTrhakwI+wYpVujWhEuWo5kKtdJyFCjVUlw6nGUn/Q5boV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oSMeUfLI; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oSMeUfLI"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a99de9beb2so9058085a.3
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 12:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727896174; x=1728500974; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPjiBG8EfRFhdcyqTpBq8FvrWWLTuUMxRiptFtnYyh4=;
        b=oSMeUfLIPaxxUnZ6cbtk3kVhy43XP5kJ5G5TMkhBxcR5DE8VA6U4rHjHCbSsqM/Grs
         Vy659ZiYNlmwZrI76tsddcZCF9Clo3JxpckEcLHS37U2dfjiJa9RaoHZlrt7nGjsMmpd
         cxdOum9ZRz6saV2e6f9pBItO5i8iAQJoD9txPjUFAifhKNpAg/9P3mjuHx5iO0zdvK5Z
         Cyq6Y9Ar9+DYhCrMqhd8/xrxsMxpkbAH4rjuGwu9AFJTiThNA8MftnjVQPgONFbyR2fg
         UmIHx/uSpKPaH02BIPJQTb93PHdfeyNEjF5WKoBt+7l1zWX0sk77pNYZwfFaYlAbiuPq
         a5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727896174; x=1728500974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPjiBG8EfRFhdcyqTpBq8FvrWWLTuUMxRiptFtnYyh4=;
        b=iiU3Pz5sIb40XtsgSFfova8lWV9//jsDmt8RoCPtQKlL+QafMKyOl76CEONkRsLR+U
         08hsEasKMQMAJnrmvPGGRgjxel3t+GaEUa+jsrVouCLaOKNrvFeQpvjpI9AhEtkKSwtB
         58u4GyRPPXx7puiGu/7Jjfl0mjAFCEjOXQPKxjsKAd0Iq3HV5mz1RZ1u6rPrxDkUPqIV
         SAg8+CYyXaqfFvCIJKO/iXbObu4mkh3VpMYluU9IDrBoX/HZh6T2ChAPU7j8sB/RBO8z
         u5UL3RwY0YM136rUKqN7DyncPdxKdACfAb3FV8HfSYXf+uREMP+f80o9tVCF5fi6JN7/
         u1Rw==
X-Gm-Message-State: AOJu0YyqMXn+sl6cPs7L59S+EX8RMVqlvmk6j2Cf9J+A/BFpnFg8tIFz
	3W2tf06wYnWdY6hfTvMqkDl7qTL9mBWV5pjhFCoC2Ehj0U0kFuJ1Bslseg9EpsE=
X-Google-Smtp-Source: AGHT+IF4SeVsCcQ4NWsEP+HJIEHZMEOQrSFkIEXbqWr7ereOmbQR48oVa6ihgiMrneo1fjNyy5NJBw==
X-Received: by 2002:a05:620a:3711:b0:7a9:dcbc:f82b with SMTP id af79cd13be357-7ae62738fcemr535323585a.54.1727896174270;
        Wed, 02 Oct 2024 12:09:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3783fd3asm643874185a.110.2024.10.02.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 12:09:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw4j7-00ABSf-90;
	Wed, 02 Oct 2024 16:09:33 -0300
Date: Wed, 2 Oct 2024 16:09:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 1/8] iommu: Refactor __iommu_domain_alloc()
Message-ID: <20241002190933.GN1369530@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911101911.6269-2-vasant.hegde@amd.com>

On Wed, Sep 11, 2024 at 10:19:04AM +0000, Vasant Hegde wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca>
> 
> Following patch will introduce iommu_paging_domain_alloc_flags() API.
> Hence move domain init code to separate function so that it can be
> resued.
> 
> Also move iommu_get_dma_cookie() setup iommu_setup_default_domain() as
> its required in DMA API mode only.
> 
> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
> [Split the patch and added description - Vasant]
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/iommu.c | 46 +++++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 21 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
