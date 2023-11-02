Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A641851
	for <iommu@lists.linux.dev>; Thu,  2 Nov 2023 04:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9Sj/4dM"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso767379a12.3
        for <iommu@lists.linux.dev>; Wed, 01 Nov 2023 21:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698898260; x=1699503060; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WL7WiLG2qV51ulrzzGIEdA+jAoElZfddPkoCfL1Nnho=;
        b=f9Sj/4dMp7qJz1sGnx9czO4PdGvikLEX9Mab2bhn7F/rBbr+9rjhDQ7qVfOtHuW+1r
         tywPmAB6PE5P36zCPVsjzz/JlQJ1HBVIhKJDNWI9zAKmNWcYg5oxwAQaV4oLThM1xCLY
         r9fl4tG5N/hNGjJA5I3V1QGebPUVrifXFzMudgbojISBVmuvqpKuliuroZm7cvnUDLCb
         3Xa3yU3V9Yi+A9sBP8fhCDLJRhwUllSbCt1AzMPSfukyA2z+5MKNDwSGq5Ik3dCAL5Ru
         HOoAXfQREZ6xG/mu6w7m2sQM2+loFM6vnhlDf3HmqxFX54K5YWtANDdybDrGAr0NL0E0
         VNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698898260; x=1699503060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WL7WiLG2qV51ulrzzGIEdA+jAoElZfddPkoCfL1Nnho=;
        b=SNu6xkMpgVeC8qSCManCqu64UG7lSJQP2EzQ9NJjSrCEWlBcC1IDPjzG4au0aGX82V
         4aBRaqHimcwY9dZVPamGI1pIGZ7NrTzmckoOBEMBeXSIgJ5AGyol+SpEnH4fl/+532Q6
         IUghM4FVPqMMSE4Zu4RQM+hQGyEcUU6uNdcq7LxxpOSmyM+3Vf7Lc7RNjMXz1Gp6+gXK
         oRUYbCE2J67HOn80ZnIoQ1UGx7R27N3BSAp2y5Iyhc/b7jCjh9uy6226ULqs0pL7h2fU
         kA6ehtjAYd8hUsWiA/yfI48K612XtRzjI39Fs8syApeiu2l+qLJtMDdQopWVCtpZ/XWi
         k0lA==
X-Gm-Message-State: AOJu0YwVSLQB/8MutVJGUvIxx9sxLHy/FVCcaYBBiGqlO3Lht8iq8ABy
	/7kKSt2CPVx661JiqF/w1Kc95A==
X-Google-Smtp-Source: AGHT+IFzi0OB6bEYZIRyqbGkslXyG2viOXNWkyJFg01Bna8y9dLPaUG3xgXnPMCiSQhMrGf5Ok22DA==
X-Received: by 2002:a17:907:807:b0:9c4:54c6:8030 with SMTP id wv7-20020a170907080700b009c454c68030mr3165308ejb.6.1698898260224;
        Wed, 01 Nov 2023 21:11:00 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h4-20020a1709063b4400b009b29668fce7sm630006ejf.113.2023.11.01.21.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 21:10:59 -0700 (PDT)
Date: Thu, 2 Nov 2023 07:10:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Janne Grunau <j@jannau.net>, Joerg Roedel <jroedel@suse.de>,
	Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] iommu: Flow ERR_PTR out from __iommu_domain_alloc()
Message-ID: <98af21ae-f0f0-458a-8a21-7d2002b18ea4@kadam.mountain>
References: <0-v1-ee4b137bfe3f+57-domain_alloc_err_ptr_jgg@nvidia.com>
 <65qhudcviofmcl2g64wca4yy2a772uqvoky6xp62ij2svj67vg@cr2pu6anogqh>
 <20231101231727.GA5675@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101231727.GA5675@nvidia.com>

On Wed, Nov 01, 2023 at 08:17:27PM -0300, Jason Gunthorpe wrote:
>         /* The driver gave no guidance on what type to use, try the default */
>         dom = __iommu_group_alloc_default_domain(group, iommu_def_domain_type);
> -       if (dom)
> +       if (!IS_ERR(dom))
>                 return dom;
>  
>         /* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
>         if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
> -               return ERR_PTR(-ENODEV);
> +               return ERR_PTR(-EINVAL);
>         dom = __iommu_group_alloc_default_domain(group, IOMMU_DOMAIN_DMA);
> -       if (!dom)
> +       if (IS_ERR(dom))
>                 return dom;
>  
>         pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",

Not related to your patch, but we should delete/move this warning as
well.  It's on a success path.

regards,
dan carpenter

