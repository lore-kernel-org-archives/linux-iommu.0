Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452E04C87
	for <iommu@lists.linux.dev>; Thu,  2 Nov 2023 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkMxjooB"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so812516a12.0
        for <iommu@lists.linux.dev>; Wed, 01 Nov 2023 22:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698902536; x=1699507336; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpOGW1xWxrIuTex+k1510XzTwZamE+AhrXKPW4TgjXg=;
        b=jkMxjooBuWFbPyN17zIhRh5y+LEncoXx8ePQ09RrL+3TKcrikSFp0x4BT/6wg8yfNP
         9EMYeE5HXi2hqn7DNCuyY3VoLjg5Sl2arg3BprRMqcBT7g7eu2wpCnKVoH5M6RA5L3gU
         IahaeWBALvpm4+JltTOmMHqlGYYhR/pyr5tf9EbMIDAMJKlS1EAf074KWKk3piyPnTNQ
         fI2XzgZ6y4Eqxf3vRiFhmNK18wAmv7wjVEbLWqHtE/7RdKscRrttMeQUAwmt7qHa+6ET
         PoVUD7ciHEbFo7IiRFpyY3NeTTYKdb4Brn/Cc29cE4DDwW2PqXyQldBIJmdwseCg9r6K
         YSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698902536; x=1699507336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpOGW1xWxrIuTex+k1510XzTwZamE+AhrXKPW4TgjXg=;
        b=aw6wyoaExEmoptMAVBwiaxmn7eBNO5Qv7hrnNad/QElm2934f3VKwqXYhrXH6Fpw2f
         apqBTjpNxNsHIwGVVAIWIL8cMYaq9kM3tJgzuAlhRqz7rUEu6mwojAG3L+4FIvKqDJlv
         RZp80C/4MueodnZWSR/8APDAURIPM1vsuM1qSgjT9EySUa+jd+GBuCWsOLjybJiYnSda
         feEcxueh++J+Rw1sfr56WWvsmvtpgqf/nudYxhfWXB/pc9XgoQDjnamNrU3L3/tBK41U
         Sg9sjqyo3ifBr7jUSydHKpCc3Im/u9s94LIe/kegpoZ5uwnOwVEu0rs2su+7fQg5eiiq
         FN+w==
X-Gm-Message-State: AOJu0YwaqpLxAjxCRa1zWsLlwx9I6ITbDTt/Due1uh2FCD4pcxTnJ+aq
	UNhur4VU4ZYWpbdXzDOx5TmDlg==
X-Google-Smtp-Source: AGHT+IG8yTeuJDyxqf/EI1D+gsQKCVHmo+4hbqNlF1gJDQtN+vGHxYX5pS671/9FkUgCuX1s7Zihdw==
X-Received: by 2002:a50:9b1d:0:b0:543:b9ae:a0d5 with SMTP id o29-20020a509b1d000000b00543b9aea0d5mr2490838edi.4.1698902536493;
        Wed, 01 Nov 2023 22:22:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n17-20020a05640204d100b00540e934bf8dsm1836893edw.43.2023.11.01.22.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 22:22:16 -0700 (PDT)
Date: Thu, 2 Nov 2023 08:22:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Janne Grunau <j@jannau.net>, Joerg Roedel <jroedel@suse.de>,
	Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] iommu: Flow ERR_PTR out from __iommu_domain_alloc()
Message-ID: <9895fa9b-29f6-493f-b4c3-7e227144bd0b@kadam.mountain>
References: <0-v1-ee4b137bfe3f+57-domain_alloc_err_ptr_jgg@nvidia.com>
 <65qhudcviofmcl2g64wca4yy2a772uqvoky6xp62ij2svj67vg@cr2pu6anogqh>
 <20231101231727.GA5675@nvidia.com>
 <98af21ae-f0f0-458a-8a21-7d2002b18ea4@kadam.mountain>
 <3gvk4gzznjsrqouilcqzq7f3lyhmumrm5l25xqk24uuf7426fr@qivhtqql7d2k>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3gvk4gzznjsrqouilcqzq7f3lyhmumrm5l25xqk24uuf7426fr@qivhtqql7d2k>

On Wed, Nov 01, 2023 at 10:09:18PM -0700, Jerry Snitselaar wrote:
> On Thu, Nov 02, 2023 at 07:10:57AM +0300, Dan Carpenter wrote:
> > On Wed, Nov 01, 2023 at 08:17:27PM -0300, Jason Gunthorpe wrote:
> > >         /* The driver gave no guidance on what type to use, try the default */
> > >         dom = __iommu_group_alloc_default_domain(group, iommu_def_domain_type);
> > > -       if (dom)
> > > +       if (!IS_ERR(dom))
> > >                 return dom;
> > >  
> > >         /* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
> > >         if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
> > > -               return ERR_PTR(-ENODEV);
> > > +               return ERR_PTR(-EINVAL);
> > >         dom = __iommu_group_alloc_default_domain(group, IOMMU_DOMAIN_DMA);
> > > -       if (!dom)
> > > +       if (IS_ERR(dom))
> > >                 return dom;
> > >  
> > >         pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
> > 
> > Not related to your patch, but we should delete/move this warning as
> > well.  It's on a success path.
> > 
> > regards,
> > dan carpenter
> > 
> 
> It seems worthwhile to note due to the performance implications, if
> nothing else, of having to fall back to the dma domain type from the
> two types mentioned in the comment. I'm not sure where would be a
> better place since this is first spot where it knows that is going to
> be the case.

Maybe it should be a pr_info() instead of a pr_warn()?  Maybe I'm just
wrong.

regards,
dan carpenter
