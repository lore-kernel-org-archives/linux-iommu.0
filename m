Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3C12B62
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 17:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684518631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdI27anb7eL6qAyMiv6nQ13HyxwYxmrDZjQAillNruI=;
	b=bLaofH7bw/VvSZpzH7RbpoFDpgeVSAoR6sTSNwSSUKprw3zDnVsh1/QQdAbiQL05kzwY7U
	rGiAN5CyJI24UJmV1m9KaXMJm9i7K1zDBsfWcJuKBxD3XU4QluDZ61nCjyrtfSnHkfb53A
	qiscVEn4zE7ISQO/ipOWohpxuhaor/Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-1ts7IbHMPpuPMqLLvGredg-1; Fri, 19 May 2023 13:50:30 -0400
X-MC-Unique: 1ts7IbHMPpuPMqLLvGredg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7577727a00eso66646785a.1
        for <iommu@lists.linux.dev>; Fri, 19 May 2023 10:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684518630; x=1687110630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdI27anb7eL6qAyMiv6nQ13HyxwYxmrDZjQAillNruI=;
        b=Bvjl3XaRK4fP8+HISCWNumkh0BOdYOFjz+PvFWhaCrhRoSloSxAxDJBdAKevoAW7J6
         0+afN3YUaWxbbiVvDbyHR7tkVT4nQ6AhFq8YO4Ab2UgACTPGfwoz3pCATZijXN6WTStI
         WjudzM5nY9igKTdQj37xpXEYJkuxHBy1ZPUNFmizMVA57zXiVoTAMC6t2G3Ta6nhcE43
         Xfmgrw27xmF32WKF1Ut1+6h36AksFjIqwBSfJnrky0huS+jn2nr9S9ZK7pIyDt+9WiDI
         TnossI1Bb8u88a1x1F07txS88Y68cK5Im6SIrnbt1azVZdvI5SMU4Kvze/hkz1GcXFRx
         WmnQ==
X-Gm-Message-State: AC+VfDyodlQ11kuwdLbJPEKqnNyMVr2ovlt5iNdYdOr90K1Wb1wAcuhB
	ksB5XMJT1MFaj7JCWR74cPjbxqldV424RSKLgpBHbEBZb4W0Y1k9jvIz1P68eya+EdyREcCbp6J
	9v4x9J4TZYXDdc7g=
X-Received: by 2002:a05:622a:11c1:b0:3f4:f522:dd8c with SMTP id n1-20020a05622a11c100b003f4f522dd8cmr7576385qtk.18.1684518629736;
        Fri, 19 May 2023 10:50:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Wufbot9sDPScxQAkOS3FcC3/sNYf+m1UaSKx2C/VToTdizBKNtGmbdmPqRaOymi2+LcIHQw==
X-Received: by 2002:a05:622a:11c1:b0:3f4:f522:dd8c with SMTP id n1-20020a05622a11c100b003f4f522dd8cmr7576367qtk.18.1684518629505;
        Fri, 19 May 2023 10:50:29 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id g11-20020ae9e10b000000b0074ca7c33b79sm1269098qkm.23.2023.05.19.10.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:50:29 -0700 (PDT)
Date: Fri, 19 May 2023 10:50:27 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	Stable@vger.kernel.org
Subject: Re: [PATCH] iommu/amd/pgtbl_v2: Fix domain max address
Message-ID: <wusnt6x3ynryimgwh2dj5bp3haeb3ux2wjq7y7sym7l4q6tzcx@loyd63j2q63j>
References: <20230518054351.9626-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230518054351.9626-1-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 18, 2023 at 05:43:51AM +0000, Vasant Hegde wrote:
> IOMMU v2 page table supports 4 level (47 bit) or 5 level (56 bit) virtual
> address space. Current code assumes it can support 64bit IOVA address
> space. If IOVA allocator allocates virtual address > 47/56 bit (depending
> on page table level) then it will do wrong mapping and cause invalid
> translation.
> 
> Hence adjust aperture size to use max address supported by the page table.
> 
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Fixes: aaac38f61487 ("iommu/amd: Initial support for AMD IOMMU v2 page table")
> Cc: <Stable@vger.kernel.org>  # v6.0+
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5aaa4cf84506..e14c7c666745 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2128,6 +2128,15 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  	return NULL;
>  }
>  
> +static inline u64 dma_max_address(void)
> +{
> +	if (amd_iommu_pgtable == AMD_IOMMU_V1)
> +		return ~0ULL;
> +
> +	/* V2 with 4/5 level page table */
> +	return ((1ULL << PM_LEVEL_SHIFT(amd_iommu_gpt_level)) - 1);

Hi Vasant,

For the stable releases, this will need to be PAGE_MODE_4_LEVEL
instead of amd_iommu_gpt_level? The 6.4 merge window is when
amd_iommu_gpt_level arrived with the 5 level page table changes.

Regards,
Jerry

> +}
> +
>  static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
>  {
>  	struct protection_domain *domain;
> @@ -2144,7 +2153,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
>  		return NULL;
>  
>  	domain->domain.geometry.aperture_start = 0;
> -	domain->domain.geometry.aperture_end   = ~0ULL;
> +	domain->domain.geometry.aperture_end   = dma_max_address();
>  	domain->domain.geometry.force_aperture = true;
>  
>  	return &domain->domain;
> -- 
> 2.31.1
> 

