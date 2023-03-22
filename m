Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850168C01
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 15:16:37 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id hf2so18839659qtb.3
        for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679498196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+HBQCTOq+QqVNkJZ+4QIpkhFmpEgZaWVINrTQNwuq8s=;
        b=jtA9AxTTQYLWB7g+hH3bMTXf6/+n7o0yqNShap1Y/5kaqMz+ZsQnoWfMK1YEkR6vDv
         uMbSfqrKL63R8h/d8AAZZxfhib1Yl8fU/pUs0IRRH/JLWeU8RlOS9nlRbvSWA9kYGUip
         4yJwpCY5y7QdCfczUsHb4aoiMShjYNLlqTJhvKfdjKrkbGAf+Ta21paUjWRmky2YCMrn
         N3M3oBmgh14x5VM9Z6JOP1a/w38eI60Cx3MmdhFC2PPDKJBJ6mFobV8yTrRjb4CZg6gU
         HVcsrp6lVMLs1xFPb0KY92STzTZ/CNk7B2shU5ztbNJAK9qBev/T+OqBSPBW+eg5XXr5
         aUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679498196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HBQCTOq+QqVNkJZ+4QIpkhFmpEgZaWVINrTQNwuq8s=;
        b=wtiNAt8yKy3BkbkhoyBQNibboqtSuZSJqSz1zoBWDDT0J+bZ9FtT9UKqRVVv1ATymR
         0cPFPWuVXR4CF70cAXk3NHp3qGLO8pIcurhDDI5DFGcQupH6AT6mQoLSK2C4w6YoBP0+
         TsVHvRme/DZTFdzDhHa3owCiKLY3FCNd/BzTT9yZW5Fuvz0R1HwLX5lChWLh/+Zm7NDI
         gcZqc7v3BJYDovNbffdvR9zRykgntyZuYkg82bo7WkABnkxLbRLNIbB+92L5RTODtFa1
         QovCj8/g6kieQnwmnARGctAAzmQ5sm1d5ethJrwqReizWuKflB2x5MfdxcBZMvFJPu6X
         RIBg==
X-Gm-Message-State: AO0yUKXC7mTfN0SGjVKLyiUUu46J0zBlPEM45NuEoC+PNX7ijQaPd8ao
	/k2liF3qn9ZorrJCXsfqbWcgkHiJxOrDnEUAPAs=
X-Google-Smtp-Source: AK7set+HNhejSvnBIYwhuwgNNsDv6NGN+2OSNq9lmKgrCuFnU40+7H4+Cr6NnogIE+bN3TKzqj+3nA==
X-Received: by 2002:a05:622a:cf:b0:3e3:7dff:663e with SMTP id p15-20020a05622a00cf00b003e37dff663emr4344627qtw.27.1679498196355;
        Wed, 22 Mar 2023 08:16:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id t21-20020a37aa15000000b00746b7372d62sm459437qke.27.2023.03.22.08.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 08:16:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pf0CZ-000oxC-3N;
	Wed, 22 Mar 2023 12:16:35 -0300
Date: Wed, 22 Mar 2023 12:16:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steven Price <steven.price@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/rockchip: Add missing set_platform_dma_ops callback
Message-ID: <ZBsb01emBJJMZIt0@ziepe.ca>
References: <20230315164152.333251-1-steven.price@arm.com>
 <ZBnBU9OU4iV6CV0W@ziepe.ca>
 <85607806-b888-2d5e-67a4-e9d63ebd1976@arm.com>
 <ZBr5e6tn1i7EE/16@ziepe.ca>
 <a5b946f0-5be8-a656-a8d5-1cd75399f0c4@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b946f0-5be8-a656-a8d5-1cd75399f0c4@arm.com>

On Wed, Mar 22, 2023 at 03:08:41PM +0000, Steven Price wrote:
> @@ -1035,8 +1055,9 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>  	if (iommu->domain == domain)
>  		return 0;
>  
> -	if (iommu->domain)
> -		rk_iommu_detach_device(iommu->domain, dev);
> +	ret = rk_iommu_identity_attach(&rk_identity_domain, dev);
> +	if (ret)
> +		return ret;

>  
>  	iommu->domain = domain;
>  
> @@ -1049,8 +1070,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>  		return 0;
>  
>  	ret = rk_iommu_enable(iommu);
> -	if (ret)
> -		rk_iommu_detach_device(iommu->domain, dev);

I think this still needs error handling, it should put it back to the
identity domain and return an error code if it fails to attach to the
requested domain.

It should also initlaize iommu->domain to the identity domain when the
iommu struct is allocated. The iommu->domain should never be
NULL. identity domain means the IOMMU is turned off which was
previously called "detached".

Otherwise it looks like I would expect, thanks

Jason
