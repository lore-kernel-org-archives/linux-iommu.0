Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9EEDE
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 02:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683255301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cjYsetGrBM63KihX4CFzxpJKx/AEwalSZhpNQfLiHHI=;
	b=UBarOmyGeFiiwGYp3KWzflb/hjYPynGNWl7+MRpdSbek36z7sN8kw9ReYrmdRfQDwIr4eN
	YEfDJRnYBimPEHCbU5MOGGK5PsdVZfetL7I0iI4EXW4kDhY6sEDbizVA7dMfS+ur7MAIqK
	1BvsZAVIYKy/15fhSLIuyussgJR3rF8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-4l36wkf1P1ehbgxrPWtpWA-1; Thu, 04 May 2023 22:55:00 -0400
X-MC-Unique: 4l36wkf1P1ehbgxrPWtpWA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75131c05344so1007160085a.1
        for <iommu@lists.linux.dev>; Thu, 04 May 2023 19:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683255300; x=1685847300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjYsetGrBM63KihX4CFzxpJKx/AEwalSZhpNQfLiHHI=;
        b=iGAz9TYRjSDO2HDyzRKDWa+/MoBAbm10fV1ESgYwdPjQ6yXdqQsqcYq1Er0hJGhrLR
         HQwHYsy3Amhy7YDXv37j3V76LTj4zSyapmzF4DuuUTJEqPsn8mK4fxMzjHWTAs+2uzVT
         6J84zeAC/lnLMUay9oPSiOpZQd6AGJDRJXA3eve+O7a5QfZJEJb3+l0GIbBo+bMxyRc2
         CevxsMIh7amo+nF3eM0Nsi/V0p0JJ48B+3OOcRC63DhRwyvzYIKxd1de3/NGlyKxAQF4
         xHLrnKWwsyQpAQxuFeWk5PmqZkWRper1Rt+ONbMMUQQOQOQ3o9WFpouYjsmWhHwZWK4E
         FJTg==
X-Gm-Message-State: AC+VfDzIhDnwY454Mzmkvton+WxAcR0F+/9VvRGbWbFvkrbgEz1HofHa
	ybfyzu83Agxb2aEHHEYiWfQaFqegCMoJ06OJwiPmmQFMr7C8e8BlkOGrtgxgSUVq6b8ii2z+wGY
	ZEdplsD/7+Rm/Z/E=
X-Received: by 2002:a05:622a:409:b0:3e8:e986:b20a with SMTP id n9-20020a05622a040900b003e8e986b20amr9397767qtx.16.1683255299969;
        Thu, 04 May 2023 19:54:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7L0Ig8yDCWu38q+AtSaJhk9cd5e+dZXKeZcxELnYEzOlnIFTyqh+dBVg8LWeBBdmN88tPaWg==
X-Received: by 2002:a05:622a:409:b0:3e8:e986:b20a with SMTP id n9-20020a05622a040900b003e8e986b20amr9397756qtx.16.1683255299748;
        Thu, 04 May 2023 19:54:59 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a15d000b0074a1d2a17c8sm282513qkm.29.2023.05.04.19.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 19:54:59 -0700 (PDT)
Date: Thu, 4 May 2023 19:54:44 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, jgg@nvidia.com, will@kernel.org, 
	schnelle@linux.ibm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu: Make flush queues a proper capability
Message-ID: <ol6xsnchb5od2br6qor6mdm3b6jedtwlbivfvx46dwx5bwm56w@ub47yn62g4ch>
References: <cover.1683233867.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1683233867.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 04, 2023 at 10:10:54PM +0100, Robin Murphy wrote:
> Hi all,
> 
> Since it came up in discussion on the default domain series, it seemed
> pertinent to dig this idea up, whcih I started a while ago, and finish
> it off.
> 
> Cheers,
> Robin.
> 
> 
> Robin Murphy (2):
>   iommu: Add a capability for flush queue support
>   iommu: Use flush queue capability
> 
>  drivers/iommu/amd/iommu.c                   | 2 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 4 ++--
>  drivers/iommu/dma-iommu.c                   | 3 ++-
>  drivers/iommu/intel/iommu.c                 | 2 +-
>  drivers/iommu/iommu.c                       | 3 ++-
>  include/linux/iommu.h                       | 6 ++++++
>  7 files changed, 16 insertions(+), 6 deletions(-)
> 
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

