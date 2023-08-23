Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD7200C8
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 22:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692829810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJhvmg4OF/PiAvSp7KoGhowOvB51ZR0zAwtP7KTHIaY=;
	b=TZ2d884Q2IiUvPnUuYYvEB5IrWijRLOrzwz8M7AV0eZRfWjicCFpoLXzITXtNMI09KNBW/
	Y6/lRY399tdZ9FxWkcDlKcX9vchBupayviXh8znasyPFfZK7cv/qlZH37mbEi0+ldAiJig
	jagqBVHrnxVjA700FqPLeBHUjafZZJ0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-HrXVUqxgNqGRxB8_kF-nHA-1; Wed, 23 Aug 2023 18:30:07 -0400
X-MC-Unique: HrXVUqxgNqGRxB8_kF-nHA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63ccbef84eeso64955056d6.3
        for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 15:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692829807; x=1693434607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJhvmg4OF/PiAvSp7KoGhowOvB51ZR0zAwtP7KTHIaY=;
        b=Vf9J3w7chpCp4qa2CCYSqh199Me1fARq4c6aBCyAFMpPezXpSQrHfGeFi3oZPa0Mhf
         cHsTXnUy89nKTrJNyjalU6dn/+jiEpzNOuAlLQWqW4zCLzPYF4h3aFhTWfODYOdTYZVz
         iiw2NuA9a86Qs5CwD3U6RkKrc1+qpK53bLbCkvsvp2BLl3c6fXa8WmBF9lAj7XDlKHO2
         xvmhP3UAyCL9ZEpL12yEtmbzTKXKbNTcgLWsVkv2IriIlEcZ3SeCC1hbzktPb10jlCTz
         ZZBR4i3J27YfAH8NBysh20OYak3DZOmSelAh08gAfXJlWCU97B5VxLYhhPrPq2d2kJZD
         XBCA==
X-Gm-Message-State: AOJu0YxUDaM38awdzflRzp0Y6aGIYu1vC3RWaORmYSkzlLg6u/Xh1Nhz
	eLBAJTeA/LDbsHOKIt0hbi77NUAr3yKxpezR0bIYbIj9GgJPaqfIXZTrL2YPqUQsQl5WUebzuey
	Vz3Y7j2gRxTarsgQ=
X-Received: by 2002:ad4:559b:0:b0:64a:3073:e549 with SMTP id f27-20020ad4559b000000b0064a3073e549mr12371257qvx.59.1692829807112;
        Wed, 23 Aug 2023 15:30:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcmGdHDJn8rbScxvnhZIAVWzKrhxq4VUwkf4ah1dYwRQWfvStc94jR0S5Ewxn7KOxdHbiFrA==
X-Received: by 2002:ad4:559b:0:b0:64a:3073:e549 with SMTP id f27-20020ad4559b000000b0064a3073e549mr12371249qvx.59.1692829806892;
        Wed, 23 Aug 2023 15:30:06 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id m18-20020ae9e712000000b0076d4bb714afsm4193424qka.50.2023.08.23.15.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 15:30:06 -0700 (PDT)
Date: Wed, 23 Aug 2023 15:30:04 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca
Subject: Re: [PATCH v5 08/14] iommu/amd: Consolidate feature detection and
 reporting logic
Message-ID: <jik5oniwfauvmvwjmemif3fvrcpfukyxk3cqqe542txrp6ejvw@mv6cvyhgn3jc>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
 <20230821104227.706997-9-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230821104227.706997-9-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 10:42:21AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Currently, IOMMU driver assumes capabilities on all IOMMU instances to be
> homogeneous. During early_amd_iommu_init(), the driver probes all IVHD
> blocks and do sanity check to make sure that only features common among all
> IOMMU instances are supported. This is tracked in the global amd_iommu_efr
> and amd_iommu_efr2, which should be used whenever the driver need to check
> hardware capabilities.
> 
> Therefore, introduce check_feature() and check_feature2(), and modify
> the driver to adopt the new helper functions.
> 
> In addition, clean up the print_iommu_info() to avoid reporting redundant
> EFR/EFR2 for each IOMMU instance.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       | 17 ++++--
>  drivers/iommu/amd/amd_iommu_types.h |  4 ++
>  drivers/iommu/amd/init.c            | 89 ++++++++++++-----------------
>  drivers/iommu/amd/iommu.c           |  4 +-
>  4 files changed, 54 insertions(+), 60 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

