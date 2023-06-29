Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ED9125CE
	for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 16:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688057521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gcCgxHi29+WLr6Q3w6iXvJUdaDmOPa+NPKcaeu48Iv8=;
	b=V2E+RhGLt6Bap+a6VavNJL42q6ct54XdFDP+NQh4/xDjzFiSErOZ+KrYoKsHYzZIRZwZrU
	zovQ72m0qUBa2HUbkQoOVPpdzaQejay9bSEz6mffKiwrYLZWcmKITuUUf/ApdE1+2QvQzz
	fJw0/Fc1eqfux4trqNc+Jm9W0/R8nMI=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-ASbxVOekMn60-IWbmla7UA-1; Thu, 29 Jun 2023 12:51:59 -0400
X-MC-Unique: ASbxVOekMn60-IWbmla7UA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5621a8bf9a0so1004672eaf.1
        for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 09:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688057519; x=1690649519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcCgxHi29+WLr6Q3w6iXvJUdaDmOPa+NPKcaeu48Iv8=;
        b=WGyRRGj9Rjk8ghb5r2O17IniE9hO6K5qG7EBQTeW6/qstXc70xnFlqtFPpU8294bus
         yVytPZJgC8XOArPwS5X23L2DncoMsjStU9SHG6/UxcRhqMhVZbHJ168Sk9F7htBXpYDn
         0PHz4nDdM/IL4LwyIMgQafbd85XL1Pk5EhRn6X5SON2WKuODxBJ72bLK6+Yhx+K8LTtw
         1v854KTnovrDitpsCcpTZLqVXSxgcQDh73sYG9ciUvcwMCVrEYIvafQoXz7ovkLRCSx3
         0nsX5Csisn3IbtayU50nK3Fd/gy6aZI5YyYE2/ojFlOwXpiKsDuFhuH/u7mwpBj+hzrP
         Fm6A==
X-Gm-Message-State: ABy/qLa6zIuztJnIQFZGJKaHa6/+MhvuC24gCzVm4EgUIpdKro8Kr95a
	HncuSTvLD8gSidZHlfS55JfRvdTsDRb1U812FYi5ZQz0uXcl6xK1KQOJ/M6XaPHJqjDFAFvgazx
	6yFudB7HDlCaIAYk=
X-Received: by 2002:a05:6358:c6a8:b0:133:428:35dc with SMTP id fe40-20020a056358c6a800b00133042835dcmr350104rwb.11.1688057519020;
        Thu, 29 Jun 2023 09:51:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEXu1ssy/Az0ac3bstBNGYR1w08q9o8rL7KkFAzK51rPNY6pw3qV8954HXcULCkKEg+RE5amQ==
X-Received: by 2002:a05:6358:c6a8:b0:133:428:35dc with SMTP id fe40-20020a056358c6a800b00133042835dcmr350097rwb.11.1688057518770;
        Thu, 29 Jun 2023 09:51:58 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id mg7-20020a056214560700b006322ce05eddsm7115304qvb.61.2023.06.29.09.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:51:58 -0700 (PDT)
Date: Thu, 29 Jun 2023 09:51:57 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 1/3] iommu/amd: Disable PPR log/interrupt in
 iommu_disable()
Message-ID: <3sog7su3wh7st6iwj7t37wqccyjxebb7dc2spvq6wobcbgqgke@gwksefrmgtzs>
References: <20230628054554.6131-1-vasant.hegde@amd.com>
 <20230628054554.6131-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230628054554.6131-2-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2023 at 05:45:52AM +0000, Vasant Hegde wrote:
> Similar to other logs, disable PPR log/interrupt in
> iommu_disable() path.
> 
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/init.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 30f09e786f7b..94c91b6ee603 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -483,6 +483,10 @@ static void iommu_disable(struct amd_iommu *iommu)
>  	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
>  	iommu_feature_disable(iommu, CONTROL_GAINT_EN);
>  
> +	/* Disable IOMMU PPR logging */
> +	iommu_feature_disable(iommu, CONTROL_PPRLOG_EN);
> +	iommu_feature_disable(iommu, CONTROL_PPRINT_EN);
> +
>  	/* Disable IOMMU hardware itself */
>  	iommu_feature_disable(iommu, CONTROL_IOMMU_EN);
>  
> -- 
> 2.31.1
> 

