Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED957C
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 09:32:46 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id j23so14982505wra.0
        for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 01:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=feQgqf0TlS1+YtPXugmH99WSVIfKoWnBpS+qs1gtI/s=;
        b=gPgxou4tJOJTYCemcLXdASH3TKfmjwXcQS1SKUsHTJY1Bytj6hQo6kg2lpcbjLe0G8
         IxHKSWsJrjF65FDyRz9dmtVBOTmJGIPHpUWZzpJdzvwmP4heiSLRiCdsqPK/lW3sHEnE
         qyk9q8Uwvl0MlTPHdj0QFaswubfQJy3Y01tTdvuPW9up92JDE+cCwQztZ6Glw6YhzRND
         OsfJLmtiXwZSgBDpHJStK0y7qcN6vj3sbLvIv6AuHt9BgV5HGxRO0mjkLNbpMX9z0qet
         KHTaGghKH9zsoh8gGvmNnjKFd27ueFu6hPIXHd3octKYHWImhrFcuZKQnjfkHYnMNO/m
         5JEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feQgqf0TlS1+YtPXugmH99WSVIfKoWnBpS+qs1gtI/s=;
        b=zk+axOWEupc1P4HjKAWJ+NTBW8ePFVFF9k/orfmnIiRx+O4QEQhod01nTirfNYR0pN
         2UpkEBORSmvsJkFM8vqahsIWGp98ngQDwM+laebMKeGGgATOH9d1qOldcgHLngHQ22Ho
         vydLzlczJITsVCjoewK5e/stnAe1x8Wgl97A8RqF4zyqnGHbt5x99PO5sAYziS28Iqq8
         PV60hFSp0R4tQekGzJ2LMslRzP2tpDKBjyPD3HB4DBIohw7HV+siRHNDhISOhNn5tS+W
         idQli2zCEZRCgSw5kzSsxjXH+JIRSBe5Rozq5tYxH40pqzi8SyJWpb8EsIqXZ6FjTvjs
         jpeQ==
X-Gm-Message-State: AO0yUKXujNb4QKB3lLGdLIO6hLHvJDPvkUEgN45aaYKL1lxV6GgO6uYt
	omHXUJsxNLYdkwVmblQxYtaHKQ==
X-Google-Smtp-Source: AK7set/WC01x4imaV87XB8VanV8Br1rNMOtMY5b40aLGEMbxfKvI9jownVsV6Mha6mc8AexhODk/4A==
X-Received: by 2002:a5d:63cc:0:b0:2c5:594a:a4f0 with SMTP id c12-20020a5d63cc000000b002c5594aa4f0mr1586282wrw.58.1676367164673;
        Tue, 14 Feb 2023 01:32:44 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id i20-20020a1c5414000000b003dc53217e07sm16874606wmb.16.2023.02.14.01.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:32:44 -0800 (PST)
Date: Tue, 14 Feb 2023 09:32:33 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 3/3] iommu: Remove ioasid infrastructure
Message-ID: <Y+tVMRzRQbcc7Guz@myrica>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
 <20230214064414.1038058-4-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214064414.1038058-4-jacob.jun.pan@linux.intel.com>

On Mon, Feb 13, 2023 at 10:44:14PM -0800, Jacob Pan wrote:
> This has no use anymore, delete it all.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Yes, a number of intended users haven't materialized yet. They can
re-introduce the allocator when they need it.

> ---
> v2:
> 	- fix compile issue w/o CONFIG_IOMMU_SVA
> 	- consolidate INVALID_IOASID w/ IOMMU_PASID_INVALID

Why not rename ioasid_t as well?  Probably better to move all the renaming
to a separate patch

> ---
>  Documentation/x86/sva.rst   |   2 +-
>  arch/x86/kernel/traps.c     |   5 +-
>  drivers/dma/idxd/device.c   |   8 +-
>  drivers/dma/idxd/idxd.h     |   1 -
>  drivers/dma/idxd/init.c     |   2 +-
>  drivers/dma/idxd/irq.c      |   2 +-
>  drivers/iommu/intel/dmar.c  |   4 +-
>  drivers/iommu/intel/iommu.c |   2 +-
>  drivers/iommu/intel/iommu.h |   1 -
>  drivers/iommu/intel/svm.c   |   3 +-
>  drivers/iommu/ioasid.c      | 422 ------------------------------------
>  drivers/iommu/iommu-sva.c   |   2 +-
>  drivers/iommu/iommu-sva.h   |   1 -
>  include/linux/ioasid.h      |  83 -------
>  include/linux/iommu.h       |  11 +-
>  include/linux/sched/mm.h    |   4 +-
>  include/uapi/linux/iommu.h  |   1 +
>  mm/init-mm.c                |   4 +-

drivers/iommu/{Makefile,Kconfig} also need updates

>  18 files changed, 29 insertions(+), 529 deletions(-)
>  delete mode 100644 drivers/iommu/ioasid.c
>  delete mode 100644 include/linux/ioasid.h

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 46e1347bfa22..7cbcf37df8cd 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -13,7 +13,6 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> -#include <linux/ioasid.h>
>  #include <uapi/linux/iommu.h>
>  
>  #define IOMMU_READ	(1 << 0)
> @@ -192,8 +191,14 @@ enum iommu_dev_features {
>  	IOMMU_DEV_FEAT_IOPF,
>  };
>  
> -#define IOMMU_PASID_INVALID	(-1U)
> -
> +//#define IOMMU_PASID_INVALID	(-1U)

Remove this

> +typedef unsigned int ioasid_t;
> +#ifdef CONFIG_IOMMU_SVA
> +static inline bool pasid_valid(ioasid_t ioasid)
> +{
> +	return ioasid != IOMMU_PASID_INVALID;
> +}
> +#endif

This isn't specific to SVA, doesn't need an ifdef

>  #ifdef CONFIG_IOMMU_API
>  
>  /**
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index cdc138086230..4c52835d3359 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -8,7 +8,7 @@
>  #include <linux/mm_types.h>
>  #include <linux/gfp.h>
>  #include <linux/sync_core.h>
> -#include <linux/ioasid.h>
> +#include <uapi/linux/iommu.h>
>  
>  /*
>   * Routines for handling mm_structs
> @@ -454,7 +454,7 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
>  #ifdef CONFIG_IOMMU_SVA
>  static inline void mm_pasid_init(struct mm_struct *mm)
>  {
> -	mm->pasid = INVALID_IOASID;
> +	mm->pasid = IOMMU_PASID_INVALID;
>  }
>  
>  /* Associate a PASID with an mm_struct: */
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 65d8b0234f69..a95f07f0c98c 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -157,5 +157,6 @@ struct iommu_page_response {
>  	__u32	grpid;
>  	__u32	code;
>  };
> +#define IOMMU_PASID_INVALID	(-1U)

Why change UAPI?

Thanks,
Jean

>  
>  #endif /* _UAPI_IOMMU_H */
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index c9327abb771c..a084039f55d8 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -10,7 +10,7 @@
>  
>  #include <linux/atomic.h>
>  #include <linux/user_namespace.h>
> -#include <linux/ioasid.h>
> +#include <linux/iommu.h>
>  #include <asm/mmu.h>
>  
>  #ifndef INIT_MM_CONTEXT
> @@ -40,7 +40,7 @@ struct mm_struct init_mm = {
>  	.user_ns	= &init_user_ns,
>  	.cpu_bitmap	= CPU_BITS_NONE,
>  #ifdef CONFIG_IOMMU_SVA
> -	.pasid		= INVALID_IOASID,
> +	.pasid		= IOMMU_PASID_INVALID,
>  #endif
>  	INIT_MM_CONTEXT(init_mm)
>  };
> -- 
> 2.25.1
> 
