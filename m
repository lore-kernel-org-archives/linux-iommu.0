Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43788152504
	for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739913; cv=none; b=Dugik8ygUHGPRklxJRAAuZQU//zFeHlnM0EbyrWCH26vjN488PrnGPtLek1iKndOe6iAozAqzIpCCWxxw9LWCJ3/Cz9wDXIYrjN9IDYiGPJB2AHz63bkvbfJB938kCkamFL46uExWSRnV6ygM3hwEaZdq63wLBYZWkTfIAwkbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739913; c=relaxed/simple;
	bh=Vtg8/hmm7Tk5OYgmBj2HuCFNy9zqye8A/8kuy4mk56Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqCxNvtEYQcPCacnMs03+4SGLrcMSBMMRxqOdnZmjXrzwETbRLGd4HSiLHIior3eShuVWkZXzhxJtDkyPFwmvm/Y5ynyLGiYj3ETZAeCmR6tb4R1GYR51Q3gn9iXItxlSAFBkb2VLRZn3vANcffxRWtx/6t0tWQG3onXTqXe5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=f6dnc6QT; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f6dnc6QT"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-447ed27aea2so27918621cf.2
        for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1721739909; x=1722344709; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vtg8/hmm7Tk5OYgmBj2HuCFNy9zqye8A/8kuy4mk56Y=;
        b=f6dnc6QTigtkcnYCozDUMI/Qs1x2iskhG9iAi0H3TPeeQouIpB5P8NYaxpt7tzTtWa
         sxlZXzhxam2KxzEbMnKCuxcW7xIpfRy09uuLxkySRK6X+MTJIJyAb6nQwrVJQynKcgsA
         mQudH/1/xIAN8cDPZuLn10G6nwwigN+m+x3RmKC1GpkEDebLealbbfaaV7bfv3wBHDMu
         3UkgH4FZR/sBeSnzaGvFD3ozlo93Vz6i1ny3ACEg7ZBRkUXHPT3Pd8z7I1i30PL9QMp7
         6Ag+XGO5nzU84RHrFGiU4EeBighbBGwg3hsIPSU4xV9avtrTqHvdeQre7ADvP52S2ubK
         pLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721739909; x=1722344709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vtg8/hmm7Tk5OYgmBj2HuCFNy9zqye8A/8kuy4mk56Y=;
        b=UZvnbxfXZ3mpO9q/GRcGwPnxkfK3cqymNTJzZUO4jTtgCJpOQGrdV/Ib12gWrHRwGK
         VwhOYkuRJduXx7N4vEUZhoXFe4LozFAZPrT/phYZi+pGO1MTORoOkTzmVMobhDHMQ57C
         ZGZ8u8JsmCmB0/Fuxty4g4yovv22uZkJUDMRz4vsisfSXKGrj9KqaYA0hCgpS+XPgCYy
         76OyHdtOEfWbzZhnb9SVqxggNFcrGkfuWPwC+EVufPbgNT+F0flvW6b9MOVKPKXTswvG
         fxbDUSy0eRsWqZnQ0uNBZ7Qs3HQXQJ6m85qYDzP5TO0dS9ezFpETCEE/ksmNDL8JzbRH
         6iTQ==
X-Gm-Message-State: AOJu0YwpcLtVyH2mvc3/gR+XRdOgEXRbelTyqG40IJxP9xrCaMf4JZMg
	0akqSABY54GoaMIvRjwQYBs0C1yd0sTQdLhIi5TKcYhYnJI7wWPQPGjPNuVuW5Y=
X-Google-Smtp-Source: AGHT+IE7T1YOL1HjuT++Xv7J0Nvnh/On8yX/MVQavWLUTGzuWWuL7eiD0uzyahQMJWgO60cMu1d1DQ==
X-Received: by 2002:a05:622a:243:b0:447:bfb2:f9fc with SMTP id d75a77b69052e-44fa525ddbemr130448031cf.12.1721739908927;
        Tue, 23 Jul 2024 06:05:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd34efesm44275351cf.46.2024.07.23.06.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:05:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sWFCV-003gJu-TC;
	Tue, 23 Jul 2024 10:05:07 -0300
Date: Tue, 23 Jul 2024 10:05:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu: Add support to change domain to blocked domain
 via sysfs
Message-ID: <20240723130507.GK14050@ziepe.ca>
References: <20240722115553.6005-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722115553.6005-1-vasant.hegde@amd.com>

On Mon, Jul 22, 2024 at 11:55:53AM +0000, Vasant Hegde wrote:
> Add support to change default domain to 'blocked' domain. This is useful
> for debugging.

But how does it work? If you set the default domain (aka the domain
used by the DMA API) to blocked, then surely no drivers should be
bindable too? Did that happen inadvertanly for some other reason?

Maybe this is just a neat hack for testing purposes?

Jason
