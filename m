Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB413394
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 22:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684449334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/p+Qobq6GsS01xfGKbCJnqYpaZn4yfr5KBFNSnBMQk=;
	b=UfO56rucRgZFfUsXaBLiNLKBog75QZW1rJTWie8d4qZrWML85zWNvPxZjWx5Qr99cYhhMS
	yCBMNUYajDY0JrtNiiItmvwCB5xopLNbsQa9CAe6+zvURN9jSlUxEcvosZBz30OnOrcdMr
	w6wjCsJZjkiZEDdj9bJsg3xMIgfYACs=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-OAEZErsZNuO5Azx4LN5Xag-1; Thu, 18 May 2023 18:35:33 -0400
X-MC-Unique: OAEZErsZNuO5Azx4LN5Xag-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-33826fb9d0fso21216415ab.0
        for <iommu@lists.linux.dev>; Thu, 18 May 2023 15:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684449332; x=1687041332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/p+Qobq6GsS01xfGKbCJnqYpaZn4yfr5KBFNSnBMQk=;
        b=fMHxNwjbiKPISI4hhjYE8ik81YO90XoiOHVeJwHaOUC8kTIe1iGdLwlcVGjwwLdti2
         B/dj0kabgjt7oTgHvhbeEadVmWUwMDe69lQjAmRFgIBbouLfgtYshhjwi2CYgyleRRju
         g7WKMzLjN5SU3ciq5f5WbOorf6jTZonLT7nrfL7dzVfw994Irl+5+1Rqh8gkjI7ZgrYq
         v50VWLhesOlhUJ2F4ZUrW8fd0WoNsy3W2qC04i6jmOh0vZErKio4rEltDM67WD1AGDlW
         9H+XCjTvNYuAlvpSjYuY/gDnJ/DAKFdbB45xpcwFYe86H95Zbd4SwNiI2b4BoZMzPnUE
         8mAg==
X-Gm-Message-State: AC+VfDwRv3inQ8iglVPH52a8t+326dYgROYIFj8P1Hm/50zBRvJQpFTm
	zY2w60t2X6GtU/apBYM6YUVm1bN4ziaw/XspoIOCu1vVmrwl53lyRR954A+Nm8wMmJZBiYOhfld
	mBilbuQitLHEnrNE=
X-Received: by 2002:a92:c6cf:0:b0:331:8bd6:a9c7 with SMTP id v15-20020a92c6cf000000b003318bd6a9c7mr4928475ilm.27.1684449332442;
        Thu, 18 May 2023 15:35:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/3EVnqkv5XfIfmt1ZhfuV1qUMfFS2PFhpxrb77fO4ksu3/hoSGBpxfcSHZ/5OvrOT39fGLg==
X-Received: by 2002:a92:c6cf:0:b0:331:8bd6:a9c7 with SMTP id v15-20020a92c6cf000000b003318bd6a9c7mr4928452ilm.27.1684449332187;
        Thu, 18 May 2023 15:35:32 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id t39-20020a05663836e700b004090c67f155sm735522jau.91.2023.05.18.15.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:35:31 -0700 (PDT)
Date: Thu, 18 May 2023 16:35:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
 <kevin.tian@intel.com>, Shameerali Kolothum Thodi        
 <shameerali.kolothum.thodi@huawei.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>, Yi Y Sun
 <yi.y.sun@intel.com>, Eric Auger <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH RFCv2 03/24] vfio: Move iova_bitmap into iommu core
Message-ID: <20230518163530.01d6b02c.alex.williamson@redhat.com>
In-Reply-To: <20230518204650.14541-4-joao.m.martins@oracle.com>
References: <20230518204650.14541-1-joao.m.martins@oracle.com>
	<20230518204650.14541-4-joao.m.martins@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 May 2023 21:46:29 +0100
Joao Martins <joao.m.martins@oracle.com> wrote:

> Both VFIO and IOMMUFD will need iova bitmap for storing dirties and walking
> the user bitmaps, so move to the common dependency into IOMMU core. IOMMUFD
> can't exactly host it given that VFIO dirty tracking can be used without
> IOMMUFD.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/iommu/Makefile                | 1 +
>  drivers/{vfio => iommu}/iova_bitmap.c | 0
>  drivers/vfio/Makefile                 | 3 +--
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename drivers/{vfio => iommu}/iova_bitmap.c (100%)
> 
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 769e43d780ce..9d9dfbd2dfc2 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
>  obj-$(CONFIG_IOMMU_IOVA) += iova.o
> +obj-$(CONFIG_IOMMU_IOVA) += iova_bitmap.o
>  obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>  obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
> diff --git a/drivers/vfio/iova_bitmap.c b/drivers/iommu/iova_bitmap.c
> similarity index 100%
> rename from drivers/vfio/iova_bitmap.c
> rename to drivers/iommu/iova_bitmap.c
> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> index 57c3515af606..f9cc32a9810c 100644
> --- a/drivers/vfio/Makefile
> +++ b/drivers/vfio/Makefile
> @@ -1,8 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_VFIO) += vfio.o
>  
> -vfio-y += vfio_main.o \
> -	  iova_bitmap.o
> +vfio-y += vfio_main.o
>  vfio-$(CONFIG_VFIO_DEVICE_CDEV) += device_cdev.o
>  vfio-$(CONFIG_VFIO_GROUP) += group.o
>  vfio-$(CONFIG_IOMMUFD) += iommufd.o

Doesn't this require more symbols to be exported for vfio?  I only see
iova_bitmap_set() as currently exported for vfio-pci variant drivers,
but vfio needs iova_bitmap_alloc(), iova_bitmap_free(), and
iova_bitmap_for_each().  Otherwise I'm happy to see it move to its new
home ;)  Thanks,

Alex

