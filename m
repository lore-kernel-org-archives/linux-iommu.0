Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF035203C
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230137; cv=none; b=qjnCZgIWVejlekNfWv2SZMfZ+G/KMBulLkCddX/BRAoEihVmRvZGlr5be03VYJkZ5RvSu6l4qrt6YvBt+XM5lEvsnToW9TYGE1OCMWPwaKmq46e22Cj2sBF5kd/haRDplrw4U/Zpiv9lb/eOhDjnlDau341Oiiu/hJ1bF3K6sxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230137; c=relaxed/simple;
	bh=MsFkLjSbybxChn74YOrTy3TDo56O9airFGxY4Pfuou4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYedjhq/X6n7FVQJu76QP1E8X/DAqyqPIfjjjwYwR8N3uHX80o8IMnLe2HanwixsRDUtexH54b3myTQ3ikjg/9guMCfmSwpkPnVGBCkhZxekxe/cWHX0hTIQ5oUr9yAMyGHDMwjWabaBvreNe0fBJaq+jOonIWfNjHpnfda+NcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkn/4wdE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkn/4wdE"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso05ad.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779230136; x=1779834936; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFhMw9iBLw8MsdYqMIVTBJ2/9NopunCbmxedo6hoNMk=;
        b=gkn/4wdElKlorMBvOd9o9SWOqRr+FqM7DXAt/LAjsW4utaKJI8t7zRe0zyDQIe5BZi
         Y0bqzTmUyiHmJPmqW2utgGpDcfD1951Dp/mKaHVmANWDde1qVfPIBg6O1Op+R3emfp9E
         bx9lI1cDgANMMGkctxI6pAJdtstTp2jObbePI4Ki6hvNOEKAlHlYSCDLHf9/cjnRD/AQ
         pyxhrG+P+LVyCLLsREy5LRt6lHD3SNKyaseN1630IoOYJSTLx9etdb0ePWs0Yuq4u61L
         Sw2TK372cLjY4wsotCYo9rof9kvQyzh9CGqiT80tHgH87gjRieCFPOj+GTHU2s4b567S
         zDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779230136; x=1779834936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFhMw9iBLw8MsdYqMIVTBJ2/9NopunCbmxedo6hoNMk=;
        b=iwJHMpdod2Fw2NhTVvKZcl6t0nphXGWeVhJigMe7dGGv9p06/cynT3AJAacBTu6qQ8
         p9kXs2vvOMfenoJ6KndWlTxcmFZUF+fEVWazvatpIgCteeXZVrDk5jywk1/Ufz2qpVyF
         9LNUQ9nJgLAKYrn6WQz+p/hqfIa+Vmo7NEVJVd37ARiKF4eN7+vBhATuzKYJ2QvTaOqQ
         2v4vi3ob1uxKM39P49Bqj1QQ3bqU0fX6c/5FfmdCVKS+baPKucfp+Xz2E9s3aTrU7kxZ
         UifzCZfdZ8wnwDvIBeE16h/g3LzauOOKLRTJFLrW7u4grGCwsa+1ZvDH19jk2YP1p6PX
         Xl1g==
X-Forwarded-Encrypted: i=1; AFNElJ8paHpCVc6Ka0HRYffUTcmj3hSnrgj5ehKGq1LMSEZL8Q7+xT+qsy1S7IaCFjTP4Ep8lpAHUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfDC9oiR1R3GH44oUR+DelNLDrPYBllOE71HMsHDMbQrjxA5Oj
	fB5XH2yPJSfxZpPbvxA4Hr59kOCpIfgKYdGIOUegxT1gYFiQtRzHHvjyDtI0kOLvDA==
X-Gm-Gg: Acq92OHZRe78mthW8Jl+wZpSSrbzJTdYeCUTLj+RyCyTCSmErg4TjryivS2DhOzGyrS
	0D/r6FV0MJU5sNw3U9xyp3lYoDosB0lzSGZ7SNiEMgmIEaBjMaN3ljqLoDGVsXaPLvBab0XEadr
	9BaOra3vVTKERsBQgWmsj1qEwVs9rCaZ5Gy1URWLIYJmXLqHLR2HtQxAVKe79dKQ8BN7JqwUu2R
	OY9Qzy1QUiCHCsRlkw90ll4bv7KQ/DhNvG83y9WprcaHwicTrT1Bbd6FyarBgcvYflf4OH+ANSK
	rNn0YHwJPJPuKj5VpNB7x2UDrb5b+n6hM8UUdSgKNH1u4yBcI0iC3jr1b4J8cq5gt78KFGgq0NB
	pHAhPHWTqObRbYBoQz/63zjd0XZZ1lq3zkMOw9gIJ7l7Afb6zUq/sHeHI1MKw7Hl5O1TwAonNgq
	FiCDXnwF19nnmncKXxTeVrhQU8Cm1fcX8iQMucEgw9bha6ZkVHiIX2x0sr0ZsINUWVpm3Q
X-Received: by 2002:a17:902:ebc9:b0:2bd:6dad:7cce with SMTP id d9443c01a7336-2bdb04168abmr7873715ad.26.1779230135236;
        Tue, 19 May 2026 15:35:35 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f67eff284sm8465883b3a.8.2026.05.19.15.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:35:34 -0700 (PDT)
Date: Tue, 19 May 2026 22:35:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 11/16] iommu/vt-d: preserve PASID table of preserved
 device
Message-ID: <agzlrsK1p7hf6DJE@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-12-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-12-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:28PM +0000, Samiullah Khawaja wrote:
> In scalable mode the PASID table is used to fetch the io page tables.
> Preserve and restore the PASID table of the preserved devices.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/intel/iommu.c      |   5 +-
>  drivers/iommu/intel/iommu.h      |  12 +++
>  drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++++
>  drivers/iommu/intel/pasid.c      |   7 +-
>  drivers/iommu/intel/pasid.h      |   9 ++
>  include/linux/kho/abi/iommu.h    |  13 +++
>  6 files changed, 184 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b90757164cd8..6d42051dcf7c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2951,8 +2951,10 @@ static int clear_unpreserve_context_entry_fn(struct device *dev,
>  	if (!info)
>  		return 0;
>  
> -	if (dev_is_pci(dev) && dev_iommu_preserved_state(dev))
> +	if (dev_is_pci(dev) && dev_iommu_preserved_state(dev)) {
> +		pasid_cleanup_preserved_table(dev);
>  		return 0;
> +	}
>  
>  	domain_context_clear(info);
>  	return 0;
> @@ -4013,6 +4015,7 @@ const struct iommu_ops intel_iommu_ops = {
>  	.page_response		= intel_iommu_page_response,
>  #ifdef CONFIG_IOMMU_LIVEUPDATE
>  	.preserve_device	= intel_iommu_preserve_device,
> +	.unpreserve_device	= intel_iommu_unpreserve_device,
>  	.preserve		= intel_iommu_preserve,
>  	.unpreserve		= intel_iommu_unpreserve,
>  #endif
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 8e37acf7de12..62076a1a0b4d 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1290,12 +1290,15 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
>  #ifdef CONFIG_IOMMU_LIVEUPDATE
>  int intel_iommu_preserve_device(struct device *dev,
>  				struct iommu_device_ser *device_ser);
> +void intel_iommu_unpreserve_device(struct device *dev,
> +				   struct iommu_device_ser *device_ser);
>  int intel_iommu_preserve(struct iommu_device *iommu,
>  			 struct iommu_hw_ser *iommu_ser);
>  void intel_iommu_unpreserve(struct iommu_device *iommu,
>  			    struct iommu_hw_ser *iommu_ser);
>  void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>  					       struct iommu_hw_ser *iommu_ser);
> +void pasid_cleanup_preserved_table(struct device *dev);
>  #else
>  static inline int intel_iommu_preserve_device(struct device *dev,
>  					      struct iommu_device_ser *device_ser)
> @@ -1303,6 +1306,11 @@ static inline int intel_iommu_preserve_device(struct device *dev,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline void intel_iommu_unpreserve_device(struct device *dev,
> +						 struct iommu_device_ser *device_ser)
> +{
> +}
> +
>  static inline int intel_iommu_preserve(struct iommu_device *iommu,
>  				       struct iommu_hw_ser *iommu_ser)
>  {
> @@ -1318,6 +1326,10 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
>  							     struct iommu_hw_ser *iommu_ser)
>  {
>  }
> +
> +static inline void pasid_cleanup_preserved_table(struct device *dev)
> +{
> +}
>  #endif
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index 50a63812533f..404b485e97b9 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -14,6 +14,7 @@
>  #include <linux/pci.h>
>  
>  #include "iommu.h"
> +#include "pasid.h"
>  #include "../iommu-pages.h"
>  
>  static void unpreserve_iommu_context_table(struct intel_iommu *iommu, int end)
> @@ -140,10 +141,96 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>  	iommu_for_each_preserved_device(_restore_used_domain_ids, iommu);
>  }
>  
> +enum pasid_lu_op {
> +	PASID_LU_OP_PRESERVE = 1,
> +	PASID_LU_OP_UNPRESERVE,
> +	PASID_LU_OP_RESTORE,
> +	PASID_LU_OP_FREE,
> +};
> +
> +static int pasid_lu_do_op(void *table, enum pasid_lu_op op)
> +{
> +	int ret = 0;
> +
> +	switch (op) {
> +	case PASID_LU_OP_PRESERVE:
> +		ret = iommu_preserve_page(table);

Nit: This is making me consider renaming the helper as
`iommu_preserve_folio`. I almost thought why are we preserving a single
page. 

> +		break;
> +	case PASID_LU_OP_UNPRESERVE:
> +		iommu_unpreserve_page(table);
> +		break;
> +	case PASID_LU_OP_RESTORE:
> +		iommu_restore_page(virt_to_phys(table));
> +		break;
> +	case PASID_LU_OP_FREE:
> +		iommu_free_pages(table);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +

[snip]

> +
> +void pasid_cleanup_preserved_table(struct device *dev)
> +{
> +	struct pasid_table *pasid_table;
> +	struct pasid_dir_entry *dir;
> +	struct pasid_entry *table;
> +	size_t dir_size;
> +
> +	pasid_table = intel_pasid_get_table(dev);
> +	if (!pasid_table)
> +		return;
> +
> +	dir = pasid_table->table;
> +	table = get_pasid_table_from_pde(&dir[0]);
> +	if (!table)
> +		return;
> +
> +	/* Clear everything except the first entry in table. */
> +	memset(&table[1], 0, SZ_4K - sizeof(*table));

Nit: Is the first entry always 4K or could it change based on PAGE_SIZE?

> +
> +	/* Use the folio order to calculate the size of Pasid Directory */
> +	dir_size = (1 << (folio_order(virt_to_folio(dir)) + PAGE_SHIFT));
> +
> +	/* Clear everything except the first entry in directory */
> +	memset(&dir[1], 0, dir_size - sizeof(struct pasid_dir_entry));
> +
> +	clflush_cache_range(&table[0], SZ_4K);
> +	clflush_cache_range(&dir[0], dir_size);
> +}
> +

[...]

> +void *intel_pasid_try_restore_table(struct device *dev, u64 max_pasid)
> +{
> +	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
> +
> +	if (!ser)
> +		return NULL;
> +
> +	BUG_ON(pasid_lu_handle_pd(phys_to_virt(ser->intel.pasid_table),
> +				  PASID_LU_OP_RESTORE));
> +	if (WARN_ON_ONCE(ser->intel.max_pasid != max_pasid)) {

I'm wondering if this could be slightly relaxed to:
if (ser->intel.max_pasid < max_pasid) to ensure it's a minimum
requirement rather than an exact match?

> +		pasid_lu_handle_pd(phys_to_virt(ser->intel.pasid_table),
> +				   PASID_LU_OP_FREE);
> +		return NULL;
> +	}
> +
> +	return phys_to_virt(ser->intel.pasid_table);
> +}
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 89541b74ab8c..5cac8e95f73b 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -60,8 +60,11 @@ int intel_pasid_alloc_table(struct device *dev)
>  
>  	size = max_pasid >> (PASID_PDE_SHIFT - 3);
>  	order = size ? get_order(size) : 0;
> -	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
> -					1 << (order + PAGE_SHIFT));
> +
> +	dir = intel_pasid_try_restore_table(dev, 1 << (order + PAGE_SHIFT + 3));
> +	if (!dir)
> +		dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
> +						1 << (order + PAGE_SHIFT));
>  	if (!dir) {
>  		kfree(pasid_table);
>  		return -ENOMEM;

Thanks,
Praan
