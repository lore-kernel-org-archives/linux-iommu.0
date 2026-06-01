Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5968E3E00A5
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336375; cv=none; b=Ukl6eijyM0+onvcyeP+ySHiO27l8WioHfNygcd5V/Gnn8GXwaBaxBgm7Imxp2VqpWnidX5GVeENE4ItTZ7FSVR6JFukcfbU+hOjzvHHHiF9VLlnvKwb/XOyAOOFN9gXNcjiHtwCLEdpEcPFDc/uIdZ1OcGfZAkZT+Ht8u6qWsNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336375; c=relaxed/simple;
	bh=xCSmiTgW2gp0UZZcRgch+bSYZxNYHdqPa15p3QyPPNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvfUTi6fZ7OnIUEusMMJ0bHtOfN9BZ7+I6JOeQgGjDdfm0Ohw6tpCG44aByaiof2ApyLO/lT27jeWEL9txHLKNlwNEerN8fhKqgUqeQdD0SN8F5KpY6+tLPbF8U7PEEX6ngzxr5MEk8WVYZCRYq7ekF2YJRy5seWZxzl2rAz8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EJhtBFJM; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EJhtBFJM"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9154ca1aa1dso224887885a.0
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780336373; x=1780941173; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajzqlQYEAeycmyed8yu6upDmFOo140vP8s+rqI6MeM4=;
        b=EJhtBFJMJuA9CyNxzZ74bCcQEac84Bs2IV8Y40X8DEED/WZgPD2f8pBK7M/g6Gh7+t
         9dECo7qw/CXexmKM6VZOwKrJI6865SXNSPzVho/nfw5MhzaEKJ9FTU1D+A5Se0EOw9rE
         m7oot6x3hIdwVpZrn41lHPQp9d6oNeUvqAjfZdUvTYgmyHNdofFEHHizDn+exJVju7x2
         NZkTphlAPIhxXbt/IKK/Ispd7ztGubFp66ZCqsmIzLucQblwwmMoPTXs3ciulYdm5Wv1
         rkIGIcwDVNFgvbabBgwBsM7e/Bz5IWx0ilboxSMNMW4I6nbwHspx/oDZclxRyZ5G7IFk
         Q31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336373; x=1780941173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajzqlQYEAeycmyed8yu6upDmFOo140vP8s+rqI6MeM4=;
        b=RI2AunWuImU3Um9imPh5A1QrReeuvl3yrIeECT+UUSvMb8So7kJblRp85PxNZqR8as
         MU6eYfpQhtPC97pEcOVMFi3AyzphDNsc9gZyE8yWjJmqqhyymZYoW70u2wod8JpyKlre
         ZcfyYnVYsJSYjiTuhVTIx/O2Qi/fQ0dtJVE11i/2lfhiTUijIFZY3DPkACzlsCBeBCaS
         Vh1z9AZQu5HerzwC4m/Hj8M0v9rTMgsZhQod+7vc935uEP4GLmbUMfpVtpSozuPBybwi
         FBtYSTb8TOP2iibfQnq4PzSk6F31OiVHkrwuWfHqZvyZmwh2D/oFbqAnIBgxopfRcneT
         X0Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+hYnDszqq526a3tW1yILvK8kdHFIrihQeRTbd701O/lTXzdpk6EDxLbO6msCXpeZaGITQdww==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyood+p/CvFYxt+wFxnTzeqwLMM+Rev3YNdNr3lqlG04kG5MSY2
	m9+ckZHvR33JcBZXd9gf5jJkaTRUiTNXUtw7Yslp0+dv7T1g37JJyiD+DDam0xQURfQ=
X-Gm-Gg: Acq92OEpIQJAB98ms9Lysd1tvmYhAK9axleqQOSQus5u+BvBB7FeJ4DE9E0dieMkPnX
	jCKPZ0zeD5LU0UkoiKj2eFU3c1DHTwOo0Wn8v18M0QDnLHc2am2WXYj+0i9Yui+sPyLEq0ZpWK9
	AfunK3NwnqD4PO0aXuMonyTGcJQ3926oblTs86hN4u3huSYuFPjGJs0DdzMGpZ+KCHFcfygklf1
	mhWEz+BGzj+r+zlZFYsRzdygt6xVTTt1M68cfAB1Fpwccso13nF9Mav3Nbrq+2unCoSE7jgfiwQ
	SDjZLmb7UxW9sLPoJ1VJCLgyvaqb4yMhGjQKnh6lZ2kVmYMAdmwU0sLaoIKcyOBp097gI4RlXd1
	QPrnHpB+aPZ8wU0o+wcIXNm3YtnkjiMKmIgHWOIJUH9RDOQH9UhxRk71xpk9nm3zmt3csBmBHDt
	eSzWnyzQanrsQyIKoK0WOlkl/G9+0oBEvV2ZgyBNKvb3G+43RNGc6jI49pQX98DISGZUzi53QHu
	R98g6iFRHkLUBY6
X-Received: by 2002:a05:620a:2202:b0:915:4c9b:4120 with SMTP id af79cd13be357-91578006ac3mr63386685a.37.1780336373342;
        Mon, 01 Jun 2026 10:52:53 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153265126asm1064337685a.45.2026.06.01.10.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:52:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wU6om-000000027gs-1lLx;
	Mon, 01 Jun 2026 14:52:52 -0300
Date: Mon, 1 Jun 2026 14:52:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, jmoroni@google.com, praan@google.com,
	stable@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v4] dma-buf: Fix silent overflow for phys vec to sgt
Message-ID: <20260601175252.GD2487554@ziepe.ca>
References: <20260528191658.2506362-1-xuehaohu@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528191658.2506362-1-xuehaohu@google.com>

On Thu, May 28, 2026 at 07:16:58PM +0000, David Hu wrote:
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
> index 794acff2546a..1aabc0ee70bb 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -10,7 +10,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
>  					 dma_addr_t addr)
>  {
>  	unsigned int len, nents;
> -	int i;
> +	unsigned int i;
>  
>  	nents = DIV_ROUND_UP(length, UINT_MAX);
>  	for (i = 0; i < nents; i++) {
> @@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
>  				  struct phys_vec *phys_vec, size_t nr_ranges,
>  				  size_t size)
>  {
> -	unsigned int nents = 0;
> +	size_t nents = 0;
>  	size_t i;
>  
>  	if (!state || !dma_use_iova(state)) {
> @@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
>  		nents = DIV_ROUND_UP(size, UINT_MAX);
>  	}
>  
> +	if (WARN_ON_ONCE(nents > UINT_MAX))
> +		return 0;

The WARN seems a bit much, but if you have it then it should be
arranged so the caller ultimately fails.

But otherwise I think correcting the types is a good idea

Jason
