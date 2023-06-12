Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B61B8E3
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686594305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Sgi47kH0PCbTs77Mh+EdH/0jTbT9hD0C4idLa33WR4=;
	b=hP/K6ixZRz/+o2nJVq3LbaXPePuIi19F8bJYH0LG0llRxYJHWsoNJ/5wcgPteG9rB4RskB
	tIZmo+paQMRHsi3sJSgJ8TBLmmCh9fTNLBxw+2D62ALKw/feyqe9IRm+wORQ1DMhBbeFbo
	tIZjEuJc8Pgh73j4Fgw1+s383nsP6o4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-y8o22rwpMuqk2oJnI865wQ-1; Mon, 12 Jun 2023 14:24:57 -0400
X-MC-Unique: y8o22rwpMuqk2oJnI865wQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75ec9b8775cso28557085a.3
        for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 11:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594297; x=1689186297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Sgi47kH0PCbTs77Mh+EdH/0jTbT9hD0C4idLa33WR4=;
        b=QfkS/US6zMLbI6ip33wVr1mM1wgqWKwNqpO1jQrSzsCO8gZFFXMbSOdr0z5Q0EGLdY
         IycMpRuydhLal5A5reFDo/RaFRMzA0mMmz12llgOXWxEuuj8v8FABrouf2xOQCH4kliz
         MoMMA+bT5WjBnkO+6yHYH7AWOvoP4bC5j02fZtnP+NicxZF1bLouumJgRnxanGdWzIZT
         mStO1wFZmYuV0WrFJyrdlF24ePkQfdh1jesrbJ4eCLzqNjl6YtXMBCt2QwT5/nowexcW
         vxej2U8EA7a9+mZiHUdSSi0CKHswEfEyYlDT9i3yWAigbxTjWtKWXdtsz2ISPRtlz70u
         HK5w==
X-Gm-Message-State: AC+VfDwcKIbUD/4+yxOCy7Usnux2IGy8e2wBwROjNxQK+NHNt3ttw8gr
	MbWIPhcjf/0hXXKPC6ldeETOMkqZXdbf3YkoDw3F6NauTUGuH3dTUrUtNM3UgqwY2Su0GETU2Te
	LqYchWNeJgq6UWEhbcXW+r5Y=
X-Received: by 2002:a05:620a:a05:b0:75b:23a0:d9cc with SMTP id i5-20020a05620a0a0500b0075b23a0d9ccmr9771081qka.34.1686594297249;
        Mon, 12 Jun 2023 11:24:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/zFE4OFgtfDe/celHlFxGIV8WehynO0y3PpQZHhPNTPTJ7UpkKGY+aFQG1pGIVR64EkxiHQ==
X-Received: by 2002:a05:620a:a05:b0:75b:23a0:d9cc with SMTP id i5-20020a05620a0a0500b0075b23a0d9ccmr9771066qka.34.1686594297009;
        Mon, 12 Jun 2023 11:24:57 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p12-20020a05620a132c00b0075edaba7369sm3047335qkj.81.2023.06.12.11.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:24:56 -0700 (PDT)
Date: Mon, 12 Jun 2023 11:24:55 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu/amd: Fix DTE_IRQ_PHYS_ADDR_MASK macro
Message-ID: <rcd3zfrn4wjyvxlpjjch3ytrfwaw6ezlxos2e6mcal2rc247lb@l35menobcyff>
References: <20230609090327.5923-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230609090327.5923-1-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2023 at 09:03:27AM +0000, Vasant Hegde wrote:
> Interrupt Table Root Pointer is 52 bit and table must be aligned to start
> on a 128-byte boundary. Hence first 6 bits are ignored.
> 
> Current code uses address mask as 45 instead of 46bit. Use GENMASK_ULL
> macro instead of manually generating address mask.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/amd_iommu_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 2ddbda3a4374..ae0edeb379d4 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -283,7 +283,7 @@
>  #define AMD_IOMMU_PGSIZES_V2	(PAGE_SIZE | (1ULL << 21) | (1ULL << 30))
>  
>  /* Bit value definition for dte irq remapping fields*/
> -#define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
> +#define DTE_IRQ_PHYS_ADDR_MASK		GENMASK_ULL(51, 6)
>  #define DTE_IRQ_REMAP_INTCTL_MASK	(0x3ULL << 60)
>  #define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
>  #define DTE_IRQ_REMAP_ENABLE    1ULL
> -- 
> 2.31.1
> 

