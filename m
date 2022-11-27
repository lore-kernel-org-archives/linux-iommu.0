Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A8933C4
	for <iommu@lists.linux.dev>; Sun, 27 Nov 2022 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669561942;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0wiRNFjSfwxayhwReKk2HhCdJf+ke5EttJUm2mT+i4=;
	b=VW/WJw6+Nipc771fV16QNU01W0foYCL8HsnLJ7ieyTO28W5FO1EAQU7M5jKUi+vvz+ugQ0
	DFa1UsCjNaziiBRrh7RJTjK/iFvc8abFu8nBTDZq89ebzhnWNejvX8LR3SfmO6tDUx1tIR
	+sJCOPCOyk1bd+rO/1MBpXI3HnrzksI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-573-i4w6_f1tM9eljfFprUdyGg-1; Sun, 27 Nov 2022 10:12:20 -0500
X-MC-Unique: i4w6_f1tM9eljfFprUdyGg-1
Received: by mail-qv1-f70.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso9674305qvr.0
        for <iommu@lists.linux.dev>; Sun, 27 Nov 2022 07:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0wiRNFjSfwxayhwReKk2HhCdJf+ke5EttJUm2mT+i4=;
        b=BbAmD999yyxF4BK50l6heMCuqHZx+lT6T0+wqUtuLqhTPpuT9ULDeLQ7pVZO/z6EhP
         e9M+BKs3VyJHj8aCE/KwezGBbwKF1ViScj9UMlDLVA7imaTn7OnMGMxp2cXIbBXxXEBi
         G0KxhJ5RwN2SBStmh3OV7MEE6QyhJOCyT3uok4f7UL0LxJjLGv9abzZuRe9Ho405aO0s
         JT39QXLES8d4/id8HuvpZ01YAAEh5TF8wdKf03HYwTuv7vk6JrQXGg2LLgLJq4YPDaCY
         G1mpwr1QHSWNOqTKoXXV3trdK0urtT+gpQVKx7kNytxcZgOpROEmPU6NeE3TKh4LYTUd
         EuXw==
X-Gm-Message-State: ANoB5pltJ1IN520KYWcQ4O0in6kgLh+A9+nO3puZLMsZduRX9hYFDYed
	M09dHlRckabEFIbRM5Y9m+XLQCUgyB+2pd/BxrPMHFYq14DpV0QlJ7Aii2px0N2c+iwCvfV1/v9
	RhmbNYM+pKLwDU0Q=
X-Received: by 2002:ac8:41ca:0:b0:3a5:6d50:7f39 with SMTP id o10-20020ac841ca000000b003a56d507f39mr43685448qtm.520.1669561940381;
        Sun, 27 Nov 2022 07:12:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5FIGBQMs4mdaEfvQ4YaXsydmwTyqPu/CYEBG9rDFeez+Q924zAUFLRipm1jW/U1yXVCME7aQ==
X-Received: by 2002:ac8:41ca:0:b0:3a5:6d50:7f39 with SMTP id o10-20020ac841ca000000b003a56d507f39mr43685406qtm.520.1669561940087;
        Sun, 27 Nov 2022 07:12:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id w30-20020a05620a0e9e00b006faaf6dc55asm6458946qkm.22.2022.11.27.07.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 07:12:18 -0800 (PST)
Message-ID: <84c2c942-055b-b500-f209-5f8839113ef0@redhat.com>
Date: Sun, 27 Nov 2022 16:12:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v5 12/19] iommufd: Add a HW pagetable object
To: Jason Gunthorpe <jgg@nvidia.com>, bpf@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck
 <cohuck@redhat.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eric Farman <farman@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>, Joao Martins
 <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
 Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <12-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <12-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 11/16/22 22:00, Jason Gunthorpe wrote:
> The hw_pagetable object exposes the internal struct iommu_domain's to
> userspace. An iommu_domain is required when any DMA device attaches to an
> IOAS to control the io page table through the iommu driver.
>
> For compatibility with VFIO the hw_pagetable is automatically created when
> a DMA device is attached to the IOAS. If a compatible iommu_domain already
> exists then the hw_pagetable associated with it is used for the
> attachment.
>
> In the initial series there is no iommufd uAPI for the hw_pagetable
> object. The next patch provides driver facing APIs for IO page table
> attachment that allows drivers to accept either an IOAS or a hw_pagetable
> ID and for the driver to return the hw_pagetable ID that was auto-selected
> from an IOAS. The expectation is the driver will provide uAPI through its
> own FD for attaching its device to iommufd. This allows userspace to learn
> the mapping of devices to iommu_domains and to override the automatic
> attachment.
>
> The future HW specific interface will allow userspace to create
> hw_pagetable objects using iommu_domains with IOMMU driver specific
> parameters. This infrastructure will allow linking those domains to IOAS's
> and devices.
>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Lixiao Yang <lixiao.yang@intel.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/Makefile          |  1 +
>  drivers/iommu/iommufd/hw_pagetable.c    | 57 +++++++++++++++++++++++++
>  drivers/iommu/iommufd/ioas.c            |  3 ++
>  drivers/iommu/iommufd/iommufd_private.h | 33 ++++++++++++++
>  drivers/iommu/iommufd/main.c            |  3 ++
>  5 files changed, 97 insertions(+)
>  create mode 100644 drivers/iommu/iommufd/hw_pagetable.c
>
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index 2b4f36f1b72f9d..e13e971aa28c60 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  iommufd-y := \
> +	hw_pagetable.o \
>  	io_pagetable.o \
>  	ioas.o \
>  	main.o \
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> new file mode 100644
> index 00000000000000..43d473989a0667
> --- /dev/null
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> + */
> +#include <linux/iommu.h>
> +
> +#include "iommufd_private.h"
> +
> +void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_hw_pagetable *hwpt =
> +		container_of(obj, struct iommufd_hw_pagetable, obj);
> +
> +	WARN_ON(!list_empty(&hwpt->devices));
> +
> +	iommu_domain_free(hwpt->domain);
> +	refcount_dec(&hwpt->ioas->obj.users);
> +	mutex_destroy(&hwpt->devices_lock);
> +}
> +
> +/**
> + * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
> + * @ictx: iommufd context
> + * @ioas: IOAS to associate the domain with
> + * @dev: Device to get an iommu_domain for
> + *
> + * Allocate a new iommu_domain and return it as a hw_pagetable.
> + */
> +struct iommufd_hw_pagetable *
> +iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
> +			   struct device *dev)
> +{
> +	struct iommufd_hw_pagetable *hwpt;
> +	int rc;
> +
> +	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
> +	if (IS_ERR(hwpt))
> +		return hwpt;
> +
> +	hwpt->domain = iommu_domain_alloc(dev->bus);
> +	if (!hwpt->domain) {
> +		rc = -ENOMEM;
> +		goto out_abort;
> +	}
> +
> +	INIT_LIST_HEAD(&hwpt->devices);
> +	INIT_LIST_HEAD(&hwpt->hwpt_item);
> +	mutex_init(&hwpt->devices_lock);
> +	/* Pairs with iommufd_hw_pagetable_destroy() */
> +	refcount_inc(&ioas->obj.users);
> +	hwpt->ioas = ioas;
> +	return hwpt;
> +
> +out_abort:
> +	iommufd_object_abort(ictx, &hwpt->obj);
> +	return ERR_PTR(rc);
> +}
> diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
> index 7671456e86413a..64e6d0f73e39aa 100644
> --- a/drivers/iommu/iommufd/ioas.c
> +++ b/drivers/iommu/iommufd/ioas.c
> @@ -17,6 +17,7 @@ void iommufd_ioas_destroy(struct iommufd_object *obj)
>  	rc = iopt_unmap_all(&ioas->iopt, NULL);
>  	WARN_ON(rc && rc != -ENOENT);
>  	iopt_destroy_table(&ioas->iopt);
> +	mutex_destroy(&ioas->mutex);
>  }
>  
>  struct iommufd_ioas *iommufd_ioas_alloc(struct iommufd_ctx *ictx)
> @@ -28,6 +29,8 @@ struct iommufd_ioas *iommufd_ioas_alloc(struct iommufd_ctx *ictx)
>  		return ioas;
>  
>  	iopt_init_table(&ioas->iopt);
> +	INIT_LIST_HEAD(&ioas->hwpt_list);
> +	mutex_init(&ioas->mutex);
>  	return ioas;
>  }
>  
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 6721332dbbba03..bb5cbd8f4e5991 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -103,6 +103,7 @@ static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
>  enum iommufd_object_type {
>  	IOMMUFD_OBJ_NONE,
>  	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
> +	IOMMUFD_OBJ_HW_PAGETABLE,
>  	IOMMUFD_OBJ_IOAS,
>  };
>  
> @@ -181,10 +182,20 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
>   * io_pagetable object. It is a user controlled mapping of IOVA -> PFNs. The
>   * mapping is copied into all of the associated domains and made available to
>   * in-kernel users.
> + *
> + * Every iommu_domain that is created is wrapped in a iommufd_hw_pagetable
> + * object. When we go to attach a device to an IOAS we need to get an
> + * iommu_domain and wrapping iommufd_hw_pagetable for it.
> + *
> + * An iommu_domain & iommfd_hw_pagetable will be automatically selected
> + * for a device based on the hwpt_list. If no suitable iommu_domain
> + * is found a new iommu_domain will be created.
>   */
>  struct iommufd_ioas {
>  	struct iommufd_object obj;
>  	struct io_pagetable iopt;
> +	struct mutex mutex;+	struct list_head hwpt_list;
>  };
>  
>  static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_ucmd *ucmd,
> @@ -207,6 +218,28 @@ int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
>  int iommufd_option_rlimit_mode(struct iommu_option *cmd,
>  			       struct iommufd_ctx *ictx);
>  
> +/*
> + * A HW pagetable is called an iommu_domain inside the kernel. This user object
> + * allows directly creating and inspecting the domains. Domains that have kernel
> + * owned page tables will be associated with an iommufd_ioas that provides the
> + * IOVA to PFN map.
> + */
> +struct iommufd_hw_pagetable {
> +	struct iommufd_object obj;
> +	struct iommufd_ioas *ioas;
> +	struct iommu_domain *domain;
> +	bool auto_domain : 1;
> +	/* Head at iommufd_ioas::hwpt_list */
> +	struct list_head hwpt_item;
> +	struct mutex devices_lock;
> +	struct list_head devices;
> +};
> +
> +struct iommufd_hw_pagetable *
> +iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
> +			   struct device *dev);
> +void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
> +
>  struct iommufd_access {
>  	unsigned long iova_alignment;
>  	u32 iopt_access_list_id;
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 266109045537ed..3eab714b8e12a3 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -355,6 +355,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
>  	[IOMMUFD_OBJ_IOAS] = {
>  		.destroy = iommufd_ioas_destroy,
>  	},
> +	[IOMMUFD_OBJ_HW_PAGETABLE] = {
> +		.destroy = iommufd_hw_pagetable_destroy,
> +	},
>  };
>  
>  static struct miscdevice iommu_misc_dev = {


Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

