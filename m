Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164B19BA1
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSd58LsA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698864732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jSpvO9yWdHOIonXODoVequLlHvln6ENernUIJLX0kzw=;
	b=WSd58LsAGHjxOUOCSahTvc0zLHWSX8d3CVvY81Rle73h7RVWoURGRrYSOZ6ssFDrtqt0Pb
	0bhZbs593q0QL+vFbCywqYvZGiFB2BMQ+VNEHn9Zx5LCtXLyW0v/D8IYHnHOYTZ0hFHyAx
	o0GQSeJn9oDU47Gjwry0KQiTCK/5IEA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-WDsES6FAP2aMISislfDuMg-1; Wed, 01 Nov 2023 14:52:11 -0400
X-MC-Unique: WDsES6FAP2aMISislfDuMg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41cca2532b8so416971cf.1
        for <iommu@lists.linux.dev>; Wed, 01 Nov 2023 11:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698864731; x=1699469531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSpvO9yWdHOIonXODoVequLlHvln6ENernUIJLX0kzw=;
        b=o5Bc1ArGcITa23k+GPxrv2prwjfcyLaKsVX783zmv7GJSRGUeMG3XJVwIBqOWAmrEm
         tcFBhYQv5HK0jveegz6/uEitp6j2UI0CvOrtFTL8z30K30rodNY1pRhoMdpO5XMZxt0q
         +GHQYpnyW8wOU+yE1DL135xiycqpxYEIjO16rYBumITX8S5huG66b0iUaTcj7Y6aKsLc
         VqeO4lMzmUJHP6nWlPuprS6C/b+OzXqu/uc0fVK7IXT5z9Vsp2mRlDwrRdW1cD2GjGSw
         2KXXf28lgA7LGj37u4Nr0svOo1UgFg9U+muI6CLGH6LWJRAGwl3f5Eac+xGIyCg5DClm
         fZpQ==
X-Gm-Message-State: AOJu0YyuLA13G6ls4UFa3DCZGnArLK7M1jIcPMbk398RRfZe6YCeMwHA
	X2DfVflDSZibAP7URUNyBUbGJFGbt+hhQ1D0HvMgV8Cy3fGMGxBa4SRhLrDbnLqQhdTl+7nIuCC
	b+Aqyn7e+8vO/hpU=
X-Received: by 2002:ac8:5ccb:0:b0:418:194a:f9fe with SMTP id s11-20020ac85ccb000000b00418194af9femr21788625qta.62.1698864730803;
        Wed, 01 Nov 2023 11:52:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEeGwCIrmIcG/GNqBe12DndSHgeTelg5qGMuSdxSqVqsy3N5sBcT1vB3J+FLJJkrrhN7zjcQ==
X-Received: by 2002:ac8:5ccb:0:b0:418:194a:f9fe with SMTP id s11-20020ac85ccb000000b00418194af9femr21788612qta.62.1698864730553;
        Wed, 01 Nov 2023 11:52:10 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id q7-20020ac84507000000b00418be3e365fsm1638595qtn.1.2023.11.01.11.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 11:52:10 -0700 (PDT)
Date: Wed, 1 Nov 2023 11:52:08 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Janne Grunau <j@jannau.net>, Joerg Roedel <jroedel@suse.de>, Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] iommu: Flow ERR_PTR out from __iommu_domain_alloc()
Message-ID: <65qhudcviofmcl2g64wca4yy2a772uqvoky6xp62ij2svj67vg@cr2pu6anogqh>
References: <0-v1-ee4b137bfe3f+57-domain_alloc_err_ptr_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0-v1-ee4b137bfe3f+57-domain_alloc_err_ptr_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 01, 2023 at 02:51:02PM -0300, Jason Gunthorpe wrote:
> Most of the calling code now has error handling that can carry an error
> code further up the call chain. Keep the exported interface
> iommu_domain_alloc() returning NULL and reflow the internal code to use
> ERR_PTR not NULL for domain allocation failure.
> 
> Optionally allow drivers to return ERR_PTR from any of the alloc ops. Many
> of the new ops (user, sva, etc) already return ERR_PTR, so having two
> rules is confusing and hard on drivers. This fixes a bug in DART that was
> returning ERR_PTR.
> 
> This also fixes a bug in iommu_group_alloc_default_domain() where it
> returned both NULL and ERR_PTR, now it always returns ERR_PTR.
> 
> Fixes: 482feb5c6492 ("iommu/dart: Call apple_dart_finalize_domain() as part of alloc_paging()")
> Fixes: 1c68cbc64fe6 ("iommu: Add IOMMU_DOMAIN_PLATFORM")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/linux-iommu/b85e0715-3224-4f45-ad6b-ebb9f08c015d@moroto.mountain/
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 53 +++++++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f17a1113f3d6a3..6bc044d2310487 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1802,10 +1802,10 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>  
>  	/* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
>  	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
> -		return NULL;
> +		return ERR_PTR(-ENODEV);
>  	dom = __iommu_group_alloc_default_domain(group, IOMMU_DOMAIN_DMA);
>  	if (!dom)

Should this be if(IS_ERR(dom)) ?

> -		return NULL;
> +		return dom;
>  
>  	pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
>  		iommu_def_domain_type, group->name);

