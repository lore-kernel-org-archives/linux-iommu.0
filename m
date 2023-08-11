Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8263B3
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 13:15:57 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-686b9964ae2so1507263b3a.3
        for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691759756; x=1692364556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk14Dz7H4FdUg9p0sN6WcFuxlJWiCiZ/t/1/OgC/wbA=;
        b=O6SfcPhPhp2/rcMRMFihIyEHsGN/QmdqZ3S2Dj/pU7SCB4SafgOQo2815d2xgdh0Ye
         ZMKq8eqrQcjgy6pPnWBiGJ+bdG/wMde6679S+tsHxiFEX7ONHNCPROkLQNUXfM1wmfoj
         2cAbF0kWwzetWKSDC6kMQkVC6tqsdVfeDBAjAl6IqZt2SlD74I3CKVgZR0qU0L8Wpqpl
         SBsEp4u1qJYm08Ur+Hi/4Y3HH2U0P6xwoBQyYM3HIO91Vy3l0L+w13qewKdlSK/6mZdW
         lLHPfE3dU+MW+/b07EXeZbWJWWaFS6MqJ4bDOJdwbOsiu+DK4zGUtMHXbm7EVOFvsF0x
         KC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759756; x=1692364556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gk14Dz7H4FdUg9p0sN6WcFuxlJWiCiZ/t/1/OgC/wbA=;
        b=H0AzT6pgwuv2LzI++SGdU0TSBZdNWUF0iuNaSPXTijH+4K4SzYgsQCkoA40DBT4z43
         f46mFJ0rQNUouv3Qw9Xozm5WGLyizyNBetITsGuoH/VcQetzlc82dhdlF+BVLzA2jN23
         vpHCnplqTueMvNUOPsHM/r5p0JOVplOVZ9dySyp4wfZeQa781eIwsY84fqqcOXu0NHHp
         sLFbg8i4qS95TGqM4YLAT7T0oLHdZW1XETux+S4kGtRHgdHNSYW/7i7+ZvbK2TgM51jr
         66gxNMJ67mQIrLgCoyX8+GWmgpgLn3HoXp8ARihZOyfQq5VVsADL3UH6nYLIydOa9J5A
         AeJQ==
X-Gm-Message-State: AOJu0YwcQ4be3cSr7mdHx7Sxa0at7PeYnWZYyOhu+OcZZwhrJZfTRUkb
	1N1mstrEO0Wcw6iH96eE49aq9w==
X-Google-Smtp-Source: AGHT+IHKb9eOoOwBy/t6krkObycIi8MaJ9+ecHmsqeaQEQRZ9/jpcjbLXjqKselIEqkMODR4iZaDFQ==
X-Received: by 2002:a05:6a00:2305:b0:687:2fa9:532d with SMTP id h5-20020a056a00230500b006872fa9532dmr1752900pfh.17.1691759756263;
        Fri, 11 Aug 2023 06:15:56 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78510000000b0063f1a1e3003sm3288777pfn.166.2023.08.11.06.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:15:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qURze-005R0Z-4Y;
	Fri, 11 Aug 2023 10:15:54 -0300
Date: Fri, 11 Aug 2023 10:15:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 10/16] iommu/amd: Modify logic for checking GT and PPR
 features
Message-ID: <ZNY0imlDnwRkPb+7@ziepe.ca>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-11-vasant.hegde@amd.com>
 <ZMz66cV24yQV9Byn@ziepe.ca>
 <14ad5515-e320-198f-8e94-1a83678a51b1@amd.com>
 <ZNJJTzuCyKXQojfe@ziepe.ca>
 <b11dcd0d-f24c-c940-ce10-a5eba650b27c@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b11dcd0d-f24c-c940-ce10-a5eba650b27c@amd.com>

On Thu, Aug 10, 2023 at 01:31:41PM -0700, Suthikulpanit, Suravee wrote:
> 
> Actually, it is not just for the SNP.
> 
> Please let me further clarify the existence of the global amd_iommu_efr and
> amd_iommu_efr2 variables.
> 
> EFR and EFR2 are provided in two places:
>  1. The IVHD block in the ACPI IVRS table.
>  2. The register offset 0030h (EFR) and 01A0h (EFR2).
> where information in the IVHD block supersedes the MMIO registers.
> 
> The EFR/EFR2 information is needed early in the initialization process prior
> to amd_iomu_init_pci() (where we can start accessing the MMIO registers).
> So, current code ignore information in the MMIO registers (only check and
> warn in case of the IVHD and MMIO are mismatch).
> 
> Currently, IOMMU driver assumes capabilities on all IOMMU instances to be
> homogeneous. Therefore, during early_amd_iommu_init(), the driver probes all
> IVHD blocks and do sanity check to make sure that only features common among
> all IOMMU instances are supported. This is tracked in the global
> amd_iommu_efr / amd_iommu_efr2.

Assuming homogeneous is sort of the point - things should be localized
to their instances so you don't need to make this assumption, that
means minimizing the places that touch the global version

> Therefore, the helper function check_feature_on_all_iommus() uses the
> effective amd_iommu_efr/amd_iommu_efr2 instead of iommu->features. In facts,
> we should remove the code which directly uses the iommu->features,
> iommu->features2, and the iommu_feature() helper function to simply and make
> the code less confusing.

But if you do this I would not object - I just don't think it is good
driver design *for the iommu*

However..

Looking at it I only see two places that need the global 'all iommus'
check - one is amd_iommu_snp_enable() which is never called (seriously
stop adding dead code to support your out of tree patch sets!!!)

And the other is enable_iommus_vapic() which looks like it has the
iommus probed already.

So really this is 'we need it global for some SNP thing that isn't
even in the kernel' which is a really, really, bad justification.
 
Jason
