Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783C41EA77
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jn7H6HJA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697820277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPFyuOWJqUveUc8l2XCgspugPvgpFubu2e7MafdWhC0=;
	b=Jn7H6HJAMi57kjgvGOqVUfG9Us/ISZ5mSSCqL1YIXjt/uTqU66VuC/lZ1h20t38dFKZly5
	0TMI0NtY04J8Q2asEjgOEWNH4XwgkxVUh6imoX2J0X+JTC8mhcrU2QBMDKK/YrsuLRawdE
	ImsE9s9+XxWCSCVFyfY3kmupNDD89NQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-ZzfzOl4KP2mBTMcMyAbGIw-1; Fri, 20 Oct 2023 12:44:17 -0400
X-MC-Unique: ZzfzOl4KP2mBTMcMyAbGIw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7a2ca09ebedso102055539f.0
        for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 09:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697820256; x=1698425056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPFyuOWJqUveUc8l2XCgspugPvgpFubu2e7MafdWhC0=;
        b=np0/oP+CXkZKoKL9Vo3/3pWZnrHP6m4rRumj4hKTDNs+maKVTQpoAakw+/Mxl11OBn
         +Nu8a2TefskToJU8A9Bvl5Omx2x0ajHTVbRI4yP9bxOk/8/KR3c+mKrfyxuwV2/PB4Gj
         i0oprlQde3Ap9+NiBH9lZXL0sMZD3cJCG8YoFlKnrBM86Ggo8zD/ufy7G120IoV7pJrj
         KWnDWSU2JQ3/QEhBT0Lrz+LaSxi+/Sj/e8SL0wTKm6928lm94Ih7mRiT8Xuyzfuvh9P0
         duU5SO696FNnBFUpSBXPbj/gp6/UfnDS5kf+UvZE0I+IydgGR4mF7wwUE3RZ2YoE2tKP
         INUQ==
X-Gm-Message-State: AOJu0YxzyR4XVireOKluQCSdw3BfnJ2Rd3MEu4SAj6MU+N/gIS9NimSG
	Z6DwgrK7G2dS6ryD1diuAPMRbK7v1KTV00GztsQeqOerhOVJLrxev5/A4qgYpXNTf8dk+FeNieA
	EHIXtGgOhh9A6BSE=
X-Received: by 2002:a05:6602:2acf:b0:79f:97b6:76de with SMTP id m15-20020a0566022acf00b0079f97b676demr3020890iov.3.1697820255925;
        Fri, 20 Oct 2023 09:44:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlOgE8X7iAGQGbOsY4Fjo3eMZSbzyX6P/GI5FxULHU/1UhmMgWPGNGxD8ZZcMSdhX0MhoiQg==
X-Received: by 2002:a05:6602:2acf:b0:79f:97b6:76de with SMTP id m15-20020a0566022acf00b0079f97b676demr3020862iov.3.1697820255661;
        Fri, 20 Oct 2023 09:44:15 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id ay7-20020a056638410700b0042b03d40279sm628248jab.80.2023.10.20.09.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 09:44:15 -0700 (PDT)
Date: Fri, 20 Oct 2023 10:44:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
 <kevin.tian@intel.com>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>, Yi Y Sun
 <yi.y.sun@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, kvm@vger.kernel.org, Brett
 Creeley <brett.creeley@amd.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v4 02/18] vfio: Move iova_bitmap into iommufd
Message-ID: <20231020104414.5c76e5c1.alex.williamson@redhat.com>
In-Reply-To: <20231018202715.69734-3-joao.m.martins@oracle.com>
References: <20231018202715.69734-1-joao.m.martins@oracle.com>
	<20231018202715.69734-3-joao.m.martins@oracle.com>
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

On Wed, 18 Oct 2023 21:26:59 +0100
Joao Martins <joao.m.martins@oracle.com> wrote:

> Both VFIO and IOMMUFD will need iova bitmap for storing dirties and walking
> the user bitmaps, so move to the common dependency into IOMMUFD.  In doing
> so, create the symbol IOMMUFD_DRIVER which designates the builtin code that
> will be used by drivers when selected. Today this means MLX5_VFIO_PCI and
> PDS_VFIO_PCI. IOMMU drivers will do the same (in future patches) when
> supporting dirty tracking and select IOMMUFD_DRIVER accordingly.
> 
> Given that the symbol maybe be disabled, add header definitions in
> iova_bitmap.h for when IOMMUFD_DRIVER=n
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/iommu/iommufd/Kconfig                 |  4 +++
>  drivers/iommu/iommufd/Makefile                |  1 +
>  drivers/{vfio => iommu/iommufd}/iova_bitmap.c |  0
>  drivers/vfio/Makefile                         |  3 +--
>  drivers/vfio/pci/mlx5/Kconfig                 |  1 +
>  drivers/vfio/pci/pds/Kconfig                  |  1 +
>  include/linux/iova_bitmap.h                   | 26 +++++++++++++++++++
>  7 files changed, 34 insertions(+), 2 deletions(-)
>  rename drivers/{vfio => iommu/iommufd}/iova_bitmap.c (100%)


Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


> 
> diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
> index 99d4b075df49..1fa543204e89 100644
> --- a/drivers/iommu/iommufd/Kconfig
> +++ b/drivers/iommu/iommufd/Kconfig
> @@ -11,6 +11,10 @@ config IOMMUFD
>  
>  	  If you don't know what to do here, say N.
>  
> +config IOMMUFD_DRIVER
> +	bool
> +	default n
> +
>  if IOMMUFD
>  config IOMMUFD_VFIO_CONTAINER
>  	bool "IOMMUFD provides the VFIO container /dev/vfio/vfio"
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index 8aeba81800c5..34b446146961 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -11,3 +11,4 @@ iommufd-y := \
>  iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
>  
>  obj-$(CONFIG_IOMMUFD) += iommufd.o
> +obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
> diff --git a/drivers/vfio/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
> similarity index 100%
> rename from drivers/vfio/iova_bitmap.c
> rename to drivers/iommu/iommufd/iova_bitmap.c
> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> index c82ea032d352..68c05705200f 100644
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
> diff --git a/drivers/vfio/pci/mlx5/Kconfig b/drivers/vfio/pci/mlx5/Kconfig
> index 7088edc4fb28..c3ced56b7787 100644
> --- a/drivers/vfio/pci/mlx5/Kconfig
> +++ b/drivers/vfio/pci/mlx5/Kconfig
> @@ -3,6 +3,7 @@ config MLX5_VFIO_PCI
>  	tristate "VFIO support for MLX5 PCI devices"
>  	depends on MLX5_CORE
>  	select VFIO_PCI_CORE
> +	select IOMMUFD_DRIVER
>  	help
>  	  This provides migration support for MLX5 devices using the VFIO
>  	  framework.
> diff --git a/drivers/vfio/pci/pds/Kconfig b/drivers/vfio/pci/pds/Kconfig
> index 407b3fd32733..fff368a8183b 100644
> --- a/drivers/vfio/pci/pds/Kconfig
> +++ b/drivers/vfio/pci/pds/Kconfig
> @@ -5,6 +5,7 @@ config PDS_VFIO_PCI
>  	tristate "VFIO support for PDS PCI devices"
>  	depends on PDS_CORE
>  	select VFIO_PCI_CORE
> +	select IOMMUFD_DRIVER
>  	help
>  	  This provides generic PCI support for PDS devices using the VFIO
>  	  framework.
> diff --git a/include/linux/iova_bitmap.h b/include/linux/iova_bitmap.h
> index c006cf0a25f3..1c338f5e5b7a 100644
> --- a/include/linux/iova_bitmap.h
> +++ b/include/linux/iova_bitmap.h
> @@ -7,6 +7,7 @@
>  #define _IOVA_BITMAP_H_
>  
>  #include <linux/types.h>
> +#include <linux/errno.h>
>  
>  struct iova_bitmap;
>  
> @@ -14,6 +15,7 @@ typedef int (*iova_bitmap_fn_t)(struct iova_bitmap *bitmap,
>  				unsigned long iova, size_t length,
>  				void *opaque);
>  
> +#if IS_ENABLED(CONFIG_IOMMUFD_DRIVER)
>  struct iova_bitmap *iova_bitmap_alloc(unsigned long iova, size_t length,
>  				      unsigned long page_size,
>  				      u64 __user *data);
> @@ -22,5 +24,29 @@ int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
>  			 iova_bitmap_fn_t fn);
>  void iova_bitmap_set(struct iova_bitmap *bitmap,
>  		     unsigned long iova, size_t length);
> +#else
> +static inline struct iova_bitmap *iova_bitmap_alloc(unsigned long iova,
> +						    size_t length,
> +						    unsigned long page_size,
> +						    u64 __user *data)
> +{
> +	return NULL;
> +}
> +
> +static inline void iova_bitmap_free(struct iova_bitmap *bitmap)
> +{
> +}
> +
> +static inline int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
> +				       iova_bitmap_fn_t fn)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void iova_bitmap_set(struct iova_bitmap *bitmap,
> +				   unsigned long iova, size_t length)
> +{
> +}
> +#endif
>  
>  #endif

