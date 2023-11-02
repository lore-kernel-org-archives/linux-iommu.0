Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60341FA1
	for <iommu@lists.linux.dev>; Thu,  2 Nov 2023 05:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8cRa2+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698901762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHYO1jEBA87qxIt1CoOBS6IMxUxOefeEeZQfA7TKrlI=;
	b=F8cRa2+PkSdIzf0qkhNVTqyHrYoWrv1LSkuhUyzLFoZ1m53E6T1d2WyuGErO9hrbem6M/E
	SI5tTstEvMA/v4XBuOUcY54QNZ6hjbZbueklD+w2bi3FEiauYfy/qOaFN2mGxiIZf7R0Ss
	Q8t9BIYASgpzaz10offn0xiemkIwUZg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-OnbzMjUXPOyb9Y-Gu0fxug-1; Thu, 02 Nov 2023 01:09:20 -0400
X-MC-Unique: OnbzMjUXPOyb9Y-Gu0fxug-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66d4aa946ceso9715336d6.1
        for <iommu@lists.linux.dev>; Wed, 01 Nov 2023 22:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698901760; x=1699506560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHYO1jEBA87qxIt1CoOBS6IMxUxOefeEeZQfA7TKrlI=;
        b=i050wF3UxcAi5+V0lPVeuSfSPfwBjWbglj65y8whWJbsxsIUycWemLzYVYN5s/H8Bv
         FptFFrnerH8BrBXjmQq/zMe0yT9yIogdPgwdCS0bFxRF4A86LL6gKTVUnhuDxd17W8ya
         OYrcZA3ZPg2js2uotNxQnBT7IjcrvIqJEe6D1gR3i+hH3YOwxCikMpXVtY/PyKaTteTe
         PyVnEFE0kwUidzO8AE9nshGfCPNK+pmpSikiT4R9Fwu5YnUekygYe5G8t+ch/UKHLgQ1
         ojlNOJv8mQ/wqGkULKKGf5RLksbeftS+NIMH7+IslgdiMB6HpbNbLjuQA57BWG4wJz/i
         jzqg==
X-Gm-Message-State: AOJu0Yx5+QIwqTWAsgCvttb51dTM/MG8WFX5ybCMGd28lH3ckqA6ud/a
	4RGayFL0LtzlUbKhlVW1aAIW+1zbM2M0VDpS/YfkBlvRSDg+gFuSzJ6C7wGSXHK+KnqctGvBdrw
	LgaQg0Pgtscg4ElI=
X-Received: by 2002:a05:6214:321:b0:671:560f:3306 with SMTP id j1-20020a056214032100b00671560f3306mr9223723qvu.4.1698901760429;
        Wed, 01 Nov 2023 22:09:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+rMVp+nYhqE20uYx+99r1KdUmNBWIMGbl7atS9Kae91iSA6aYs17RIAvLXJaktRrVKtP9gA==
X-Received: by 2002:a05:6214:321:b0:671:560f:3306 with SMTP id j1-20020a056214032100b00671560f3306mr9223703qvu.4.1698901760178;
        Wed, 01 Nov 2023 22:09:20 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id kh14-20020a056214514e00b0064c1b27bf2dsm2067269qvb.140.2023.11.01.22.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 22:09:19 -0700 (PDT)
Date: Wed, 1 Nov 2023 22:09:18 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, Janne Grunau <j@jannau.net>, 
	Joerg Roedel <jroedel@suse.de>, Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] iommu: Flow ERR_PTR out from __iommu_domain_alloc()
Message-ID: <3gvk4gzznjsrqouilcqzq7f3lyhmumrm5l25xqk24uuf7426fr@qivhtqql7d2k>
References: <0-v1-ee4b137bfe3f+57-domain_alloc_err_ptr_jgg@nvidia.com>
 <65qhudcviofmcl2g64wca4yy2a772uqvoky6xp62ij2svj67vg@cr2pu6anogqh>
 <20231101231727.GA5675@nvidia.com>
 <98af21ae-f0f0-458a-8a21-7d2002b18ea4@kadam.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <98af21ae-f0f0-458a-8a21-7d2002b18ea4@kadam.mountain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 02, 2023 at 07:10:57AM +0300, Dan Carpenter wrote:
> On Wed, Nov 01, 2023 at 08:17:27PM -0300, Jason Gunthorpe wrote:
> >         /* The driver gave no guidance on what type to use, try the default */
> >         dom = __iommu_group_alloc_default_domain(group, iommu_def_domain_type);
> > -       if (dom)
> > +       if (!IS_ERR(dom))
> >                 return dom;
> >  
> >         /* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
> >         if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
> > -               return ERR_PTR(-ENODEV);
> > +               return ERR_PTR(-EINVAL);
> >         dom = __iommu_group_alloc_default_domain(group, IOMMU_DOMAIN_DMA);
> > -       if (!dom)
> > +       if (IS_ERR(dom))
> >                 return dom;
> >  
> >         pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
> 
> Not related to your patch, but we should delete/move this warning as
> well.  It's on a success path.
> 
> regards,
> dan carpenter
> 

It seems worthwhile to note due to the performance implications, if
nothing else, of having to fall back to the dma domain type from the
two types mentioned in the comment. I'm not sure where would be a
better place since this is first spot where it knows that is going to
be the case.

