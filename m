Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D419BB1
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 18:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686593532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WfC+fA7QHuUg+7zV3oJP34eZ8O1o0OXP59IbCjsY+f8=;
	b=HSmRQeo1volkW8gqb+QkBYZI+hKdOl1+buoVhGogfNN0uzLtfORwbYRgaSzt3J//Z4slo2
	M5Hhg0VMgQoIvDkzNsKEO6zaQ/AySGcICVEJSH53o+WLa23Uo9TUCdwYleqfsBDYJO4Kj2
	1zK/4HuOffxTqIAJdzEIZKd/D5S96+4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-nksY_gv3O2mQL2mMBeiBew-1; Mon, 12 Jun 2023 14:12:09 -0400
X-MC-Unique: nksY_gv3O2mQL2mMBeiBew-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-39cd7689d15so1162877b6e.1
        for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 11:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686593529; x=1689185529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfC+fA7QHuUg+7zV3oJP34eZ8O1o0OXP59IbCjsY+f8=;
        b=UqJtO9batopggGN1LlpDIxJlf+bXNGqppD+nM8vvEiQpnRKbt1jY7a3venaok4ypIU
         q8ZpjXXevyeamOfGczUk6V030R7gKWDqnePYawyUyLCwCGMcP/bP4+v6Pec9FQfA5hbp
         2hVfie36HYWPZaq2ad1kXQlmOKo/jEMyxvHi6En2ZqB7GP2GJc7ut/8myETYDzQ7Fop8
         RYL7bEsN0SnCVtWoeFYJmEqXJRFOlkKSab8qujSScOZDstFAHPlJFoRpiCh2DgpHozU+
         Nk00HegGX9yarPx+fBcDFJwJ30s2pK5vzLLY30+v2Oi3hsBC8mS+U6HjdKfZUC7kSNbx
         czMg==
X-Gm-Message-State: AC+VfDyMO6/Tv1w+wHway7NVjM/Jwnb1/CSV0II2kHb2AqlmM50mEbx5
	loNUlZpMqe/g+BDNygW0jjNyXvAXIuYbnlObA0peRHvEuklcNAfLGdD8dJEWWCKxS+5XtCoq4C9
	O3A9llgUw7btJkU0=
X-Received: by 2002:a05:6808:bce:b0:39c:5ef9:a287 with SMTP id o14-20020a0568080bce00b0039c5ef9a287mr5838745oik.28.1686593528941;
        Mon, 12 Jun 2023 11:12:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5siJQtPBzzmM7yK6WLPkp0yQIVivZKClJMlvcgOVp6oXj9tBIggGZOzsc2/5O0+BibBQWFng==
X-Received: by 2002:a05:6808:bce:b0:39c:5ef9:a287 with SMTP id o14-20020a0568080bce00b0039c5ef9a287mr5838723oik.28.1686593528694;
        Mon, 12 Jun 2023 11:12:08 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id ay9-20020a05622a228900b003f7a54fa72fsm3617904qtb.0.2023.06.12.11.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:12:08 -0700 (PDT)
Date: Mon, 12 Jun 2023 11:12:06 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Su Hui <suhui@nfschina.com>
Cc: Joerg Roedel <joro@8bytes.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com, vasant.hegde@amd.com, jgg@ziepe.ca, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/amd: Fix possible memory leak of 'domain'
Message-ID: <g6iqzwutmdtmi2enfogchhs3toduy4e2hs45hjipuuybcawbhh@uuzohezj3ryj>
References: <20230608021933.856045-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230608021933.856045-1-suhui@nfschina.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2023 at 10:19:34AM +0800, Su Hui wrote:
> Move allocation code down to avoid memory leak.
> 
> Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
> Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
> Changes in v2:
> 	change code order is better and more consistent with other
> drivers. 
>  drivers/iommu/amd/iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index dc1ec6849775..e8a2e5984acb 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2078,10 +2078,6 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  	int mode = DEFAULT_PGTABLE_LEVEL;
>  	int ret;
>  
> -	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> -	if (!domain)
> -		return NULL;
> -
>  	/*
>  	 * Force IOMMU v1 page table when iommu=pt and
>  	 * when allocating domain for pass-through devices.
> @@ -2097,6 +2093,10 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  		return NULL;
>  	}
>  
> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> +	if (!domain)
> +		return NULL;
> +
>  	switch (pgtable) {
>  	case AMD_IOMMU_V1:
>  		ret = protection_domain_init_v1(domain, mode);
> -- 
> 2.30.2
> 

