Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E42F261C
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263231; cv=none; b=ZXK67YdRNcq1wcU1q/vMIC19uQ0aDjM6DxJP7Y1OCYFe1aU7zMxf5xo6ahqXmzHBlnd5l5o87uLGDaGeVBHdLuKpfleEnmIoi2wvhAM4m6QdUJoI/eKugQfpTYr6iSNzDPE2Q64GJXaEo/rFKWmVAu1PSrzgRHjytw4THTeYcmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263231; c=relaxed/simple;
	bh=x7ojQGAtNFB9/BA5yUqyXaR/a/Ze/5m3NRuuvcwiU7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lf+KO9UKoUnmqIpo76AKv/6PQiTe7cjW1Gr4cWPVeRK3nlgVoltsxNhuprT8EwDpLi1S3BpxYZc/mmT5JTLITPr7VndYj5rJW30MhTadlv5n1S20FodVgyMT87Lx5FTuW/XmBoflxy6BJhzdo4JTXtj4wuX8d1gdt7J9mpEI4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oiozLbQB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oiozLbQB"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae49120e97so24985ad.0
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 14:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773263228; x=1773868028; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pHCxo/G/rAcnDxlQUxDj+DoGxJBnofNqlavWRWu6L04=;
        b=oiozLbQBZ9KbaBTNfO7RncUN7ujUQ0CeH43iIry8FuKraoZizeFWwAO+uq7koooKo+
         a3HJkOwNecaTrExMOoB+WiUbT5WOQ5MCXTeiZtzZpgakGelFWUe9FSsf4t/tG0HvXQOw
         umWpla1S2Fyr7CuPFeTB2vHKYQzxAJLUaYuM7xYhrGpyEGagQbGCYYi/U8vTC85gtr6E
         yTWYQKmNVedyITHHcMcFAM1xrPVOGeA1ylzk1Owb6agfTCoUL9aM7+s+aLxGlv3KP3Tw
         5LlyJwidBXGA9fyJuYyLMSJH/eYlCv/lpiUUM5J8Rl2nItfusr925vOAKMfWJ/Lgp5F9
         M+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773263228; x=1773868028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHCxo/G/rAcnDxlQUxDj+DoGxJBnofNqlavWRWu6L04=;
        b=fZ5AKz3EUFZF16ooHM9ky2TDf2JJ80OZLa8gsCHB1Q4BIQMhVhyko7OesRPZ+NNe2S
         nC/akv3LY9ZXrilbXADRMwn3FS+hvFvW8gy1RQzd+32suzFMtm6HPmjoUM78xq8qmZc2
         82DOG2BahMvHw/SWHkzLQ+TvSz8+2j0nm5ZUBvaDa25mImKSNo+v5xIxiKTXz0LITl3z
         rh5Hac48e5W2fEllKBZNtzDWepTuNYFayLBPMNTufLcq+guPnaOwgZjbyL4Vto+PzJqP
         WWHqUkBGUUr/6gIJZESOV80qI+1Q4eOy/QqU1Zy9mjY9JodGwicRuxUO/HPDJnJM8yBm
         7owQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZmQGXCYKvhquIL9PhnVUlocpwQDzSbJXhdgIiK2KrqLqek9QFZljHViCVV3njOU7KqvZEyw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz56Uwo+P4bmCnAjFd6yozYKGjmGJGlterZjoDUHAgVXBYaN6La
	ierRR2WiJPjNW9Die6PU07CMjVBx8pIq9HE6qmk08/colTg7tKCMo3bAodhffThizA==
X-Gm-Gg: ATEYQzxQqg7EUKfXAL5f87jRwFp8YQ9Ga2E3TwJsX6jNmx0GD2Fk/iKUqvIivRmMFtY
	9TeAEHt1qNDuZ2B/fuKkfkd6SGB5p8vYaMtjgNbGnjMZY7PWlsRPxLF+cXSOCP44vfvs00c2OiL
	/j0Y84gElf9JQOQPl9QM8Z4dtOfcIcH2218qwZSOaKXz+CymGEQokVnhd3d1zktFqWCIdiogt9i
	7p5/r9SdRPXtRJDE3YiMRAoY7wckZCmXsrQdos+He+9Q6PSHlt2mRfWA3n3ghAP7AbkSOMc5jdj
	+Ywa+C1jFBWHtdvEILvAFa0AJ8FxmtSHHX9RmxRatkzcq4Vz+IVIAfc321kdYuM38ZpxHYeqZCF
	JakI5FoOs5VQl6qirYwHwAaLujH53zFG7yYWL+SOl4h0c00zVe7H8q1NeGAVx4wAl31hi7DMi5n
	aGYP7SgD4W+2bKJu5Yujy5416JFPUks0Fuwv4qEs8XZlWjfOgBIgYCcMzb/w==
X-Received: by 2002:a17:902:cf0a:b0:2a0:7fac:c031 with SMTP id d9443c01a7336-2aebae3df3fmr895995ad.14.1773263227723;
        Wed, 11 Mar 2026 14:07:07 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0725bfd0sm698451b3a.14.2026.03.11.14.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 14:07:07 -0700 (PDT)
Date: Wed, 11 Mar 2026 21:07:00 +0000
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
Subject: Re: [PATCH 01/14] iommu: Implement IOMMU LU FLB callbacks
Message-ID: <abHZdOKyLmmmHADz@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-2-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-2-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:35PM +0000, Samiullah Khawaja wrote:
> Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
> alloc/free helper functions to allocate memory for the IOMMU LU FLB
> object and the serialization structs for device, domain and iommu.
> 
> During retrieve, walk through the preserved objs nodes and restore each
> folio. Also recreate the FLB obj.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/Kconfig         |  11 +++
>  drivers/iommu/Makefile        |   1 +
>  drivers/iommu/liveupdate.c    | 177 ++++++++++++++++++++++++++++++++++
>  include/linux/iommu-lu.h      |  17 ++++
>  include/linux/kho/abi/iommu.h | 119 +++++++++++++++++++++++
>  5 files changed, 325 insertions(+)
>  create mode 100644 drivers/iommu/liveupdate.c
>  create mode 100644 include/linux/iommu-lu.h
>  create mode 100644 include/linux/kho/abi/iommu.h
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index f86262b11416..fdcfbedee5ed 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -11,6 +11,17 @@ config IOMMUFD_DRIVER
>  	bool
>  	default n
>  
> +config IOMMU_LIVEUPDATE
> +	bool "IOMMU live update state preservation support"
> +	depends on LIVEUPDATE && IOMMUFD
> +	help
> +	  Enable support for preserving IOMMU state across a kexec live update.
> +
> +	  This allows devices managed by iommufd to maintain their DMA mappings
> +	  during kexec base kernel update.
> +
> +	  If unsure, say N.
> +

I'm wondering if this should be under the if IOMMU_SUPPORT below? I
believe this was added here because IOMMUFD isn't under IOMMU_SUPPORT,
but it wouldn't make sense to "preserve" IOMMU across a liveupdate if
IOMMU_SUPPORT is disabled? Should we probably be move it inside the 
if IOMMU_SUPPORT block for better organization, or at least have a depends
on IOMMU_SUPPORT added to it? The IOMMU_LUO still depends on the 
IOMMU_SUPPORT infrastructure to actually function.. as we add calls
within core functions like dev_iommu_get etc.

>  menuconfig IOMMU_SUPPORT
>  	bool "IOMMU Hardware Support"
>  	depends on MMU
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 0275821f4ef9..b3715c5a6b97 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST) += io-pgtable-arm-selftests.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
> +obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
>  obj-$(CONFIG_IOMMU_IOVA) += iova.o
>  obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> new file mode 100644
> index 000000000000..6189ba32ff2c
> --- /dev/null
> +++ b/drivers/iommu/liveupdate.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (C) 2025, Google LLC

Minor nit: 2026 OR 2025-26, here and everywhere else

> + * Author: Samiullah Khawaja <skhawaja@google.com>
> + */
> +
> +#define pr_fmt(fmt)    "iommu: liveupdate: " fmt
> +
> +#include <linux/kexec_handover.h>
> +#include <linux/liveupdate.h>
> +#include <linux/iommu-lu.h>
> +#include <linux/iommu.h>
> +#include <linux/errno.h>
> +
> +static void iommu_liveupdate_restore_objs(u64 next)
> +{
> +	struct iommu_objs_ser *objs;
> +
> +	while (next) {
> +		BUG_ON(!kho_restore_folio(next));

Same thing about BUG_ON [1] as mentioned below in the 
iommu_liveupdate_flb_retrieve() function, can we consider returning an
error which can be checked in the caller and the error can be bubbled up
as -ENODATA?

> +		objs = __va(next);
> +		next = objs->next_objs;
> +	}
> +}
> +
> +static void iommu_liveupdate_free_objs(u64 next, bool incoming)
> +{
> +	struct iommu_objs_ser *objs;
> +
> +	while (next) {
> +		objs = __va(next);
> +		next = objs->next_objs;
> +
> +		if (!incoming)
> +			kho_unpreserve_free(objs);
> +		else
> +			folio_put(virt_to_folio(objs));

Interesting! kho_restore_folio already adjusts the refcount via 
adjust_managed_page_count which is why folio_put() is needed for a valid
refcount. Sweet :)

> +	}
> +}
> +
> +static void iommu_liveupdate_flb_free(struct iommu_lu_flb_obj *obj)
> +{
> +	if (obj->iommu_domains)
> +		iommu_liveupdate_free_objs(obj->ser->iommu_domains_phys, false);
> +
> +	if (obj->devices)
> +		iommu_liveupdate_free_objs(obj->ser->devices_phys, false);
> +
> +	if (obj->iommus)
> +		iommu_liveupdate_free_objs(obj->ser->iommus_phys, false);
> +
> +	kho_unpreserve_free(obj->ser);
> +	kfree(obj);
> +}
> +
> +static int iommu_liveupdate_flb_preserve(struct liveupdate_flb_op_args *argp)
> +{
> +	struct iommu_lu_flb_obj *obj;
> +	struct iommu_lu_flb_ser *ser;
> +	void *mem;
> +
> +	obj = kzalloc(sizeof(*obj), GFP_KERNEL);

I know this is obvious but let's add a comment that obj just exists in 
the "current" kernel whereas mem is supposed to survive the KHO..

> +	if (!obj)
> +		return -ENOMEM;
> +
> +	mutex_init(&obj->lock);
> +	mem = kho_alloc_preserve(sizeof(*ser));
> +	if (IS_ERR(mem))
> +		goto err_free;
> +
> +	ser = mem;
> +	obj->ser = ser;
> +
> +	mem = kho_alloc_preserve(PAGE_SIZE);
> +	if (IS_ERR(mem))
> +		goto err_free;
> +
> +	obj->iommu_domains = mem;
> +	ser->iommu_domains_phys = virt_to_phys(obj->iommu_domains);
> +
> +	mem = kho_alloc_preserve(PAGE_SIZE);
> +	if (IS_ERR(mem))
> +		goto err_free;
> +
> +	obj->devices = mem;
> +	ser->devices_phys = virt_to_phys(obj->devices);
> +
> +	mem = kho_alloc_preserve(PAGE_SIZE);
> +	if (IS_ERR(mem))
> +		goto err_free;
> +
> +	obj->iommus = mem;
> +	ser->iommus_phys = virt_to_phys(obj->iommus);
> +
> +	argp->obj = obj;
> +	argp->data = virt_to_phys(ser);
> +	return 0;
> +
> +err_free:
> +	iommu_liveupdate_flb_free(obj);
> +	return PTR_ERR(mem);
> +}
> +
> +static void iommu_liveupdate_flb_unpreserve(struct liveupdate_flb_op_args *argp)
> +{
> +	iommu_liveupdate_flb_free(argp->obj);
> +}
> +
> +static void iommu_liveupdate_flb_finish(struct liveupdate_flb_op_args *argp)
> +{
> +	struct iommu_lu_flb_obj *obj = argp->obj;
> +
> +	if (obj->iommu_domains)
> +		iommu_liveupdate_free_objs(obj->ser->iommu_domains_phys, true);
> +
> +	if (obj->devices)
> +		iommu_liveupdate_free_objs(obj->ser->devices_phys, true);
> +
> +	if (obj->iommus)
> +		iommu_liveupdate_free_objs(obj->ser->iommus_phys, true);
> +
> +	folio_put(virt_to_folio(obj->ser));
> +	kfree(obj);
> +}
> +
> +static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
> +{
> +	struct iommu_lu_flb_obj *obj;
> +	struct iommu_lu_flb_ser *ser;
> +
> +	obj = kzalloc(sizeof(*obj), GFP_ATOMIC);

Why does this have to be GFP_ATOMIC? IIUC, the retrieve path is 
triggered by a userspace IOCTL in the new kernel. The system should be
able to sleep here? (unless we have a use-case to call this in IRQ-ctx?)
AFAICT, we call this under mutexes already, hence there's no situation
where we could sleep in a spinlock context?

GFP_ATOMIC creates a point of failure if the system is under memory 
pressure. I believe we should be allowed to sleep for this allocation
because the "preserved" mappings still allow DMAs to go on and we're in
no hurry to restore the IOMMU state? I believe this could be GFP_KERNEL.

> +	if (!obj)
> +		return -ENOMEM;
> +
> +	mutex_init(&obj->lock);
> +	BUG_ON(!kho_restore_folio(argp->data));

The use of BUG_ON in new code is heavily discouraged [1].
If KHO can't restore the folio for whatever reason, we can be treat it
as a corruption of the handover data. I believe crashing the kernel for
it would be an overkill? 

Can we consider returning a graceful failure like -ENODATA or something?
BUG_ON would instantly cause a kernel panic without providing no 
opportunity for the system to log the failure or attempt a graceful
teardown of the 'preserved' mapping.

> +	ser = phys_to_virt(argp->data);
> +	obj->ser = ser;
> +
> +	iommu_liveupdate_restore_objs(ser->iommu_domains_phys);
> +	obj->iommu_domains = phys_to_virt(ser->iommu_domains_phys);
> +
> +	iommu_liveupdate_restore_objs(ser->devices_phys);
> +	obj->devices = phys_to_virt(ser->devices_phys);
> +
> +	iommu_liveupdate_restore_objs(ser->iommus_phys);
> +	obj->iommus = phys_to_virt(ser->iommus_phys);
> +
> +	argp->obj = obj;
> +
> +	return 0;
> +}
> +
> +static struct liveupdate_flb_ops iommu_flb_ops = {
> +	.preserve = iommu_liveupdate_flb_preserve,
> +	.unpreserve = iommu_liveupdate_flb_unpreserve,
> +	.finish = iommu_liveupdate_flb_finish,
> +	.retrieve = iommu_liveupdate_flb_retrieve,
> +};
> +
> +static struct liveupdate_flb iommu_flb = {
> +	.compatible = IOMMU_LUO_FLB_COMPATIBLE,
> +	.ops = &iommu_flb_ops,
> +};
> +
> +int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
> +{
> +	return liveupdate_register_flb(handler, &iommu_flb);
> +}
> +EXPORT_SYMBOL(iommu_liveupdate_register_flb);
> +
> +int iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
> +{
> +	return liveupdate_unregister_flb(handler, &iommu_flb);
> +}
> +EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
> diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
> new file mode 100644
> index 000000000000..59095d2f1bb2
> --- /dev/null
> +++ b/include/linux/iommu-lu.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2025, Google LLC
> + * Author: Samiullah Khawaja <skhawaja@google.com>
> + */
> +
> +#ifndef _LINUX_IOMMU_LU_H
> +#define _LINUX_IOMMU_LU_H
> +
> +#include <linux/liveupdate.h>
> +#include <linux/kho/abi/iommu.h>
> +
> +int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
> +int iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
> +
> +#endif /* _LINUX_IOMMU_LU_H */
> diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
> new file mode 100644
> index 000000000000..8e1c05cfe7bb
> --- /dev/null
> +++ b/include/linux/kho/abi/iommu.h
> @@ -0,0 +1,119 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2025, Google LLC
> + * Author: Samiullah Khawaja <skhawaja@google.com>
> + */
> +
> +#ifndef _LINUX_KHO_ABI_IOMMU_H
> +#define _LINUX_KHO_ABI_IOMMU_H
> +
> +#include <linux/mutex_types.h>
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +
> +/**
> + * DOC: IOMMU File-Lifecycle Bound (FLB) Live Update ABI
> + *
> + * This header defines the ABI for preserving IOMMU state across kexec using
> + * Live Update File-Lifecycle Bound (FLB) data.
> + *
> + * This interface is a contract. Any modification to any of the serialization
> + * structs defined here constitutes a breaking change. Such changes require
> + * incrementing the version number in the IOMMU_LUO_FLB_COMPATIBLE string.
> + */
> +
> +#define IOMMU_LUO_FLB_COMPATIBLE "iommu-v1"
> +

Let's call this "iommu-liveupdate-v1" or "iommu-lu-v1" instead?

> +enum iommu_lu_type {
> +	IOMMU_INVALID,
> +	IOMMU_INTEL,
> +};
> +
> +struct iommu_obj_ser {
> +	u32 idx;
> +	u32 ref_count;
> +	u32 deleted:1;
> +	u32 incoming:1;
> +} __packed;
> +
> +struct iommu_domain_ser {
> +	struct iommu_obj_ser obj;
> +	u64 top_table;
> +	u64 top_level;
> +	struct iommu_domain *restored_domain;
> +} __packed;
> +
> +struct device_domain_iommu_ser {
> +	u32 did;
> +	u64 domain_phys;
> +	u64 iommu_phys;
> +} __packed;
> +
> +struct device_ser {
> +	struct iommu_obj_ser obj;
> +	u64 token;
> +	u32 devid;
> +	u32 pci_domain;
> +	struct device_domain_iommu_ser domain_iommu_ser;
> +	enum iommu_lu_type type;
> +} __packed;
> +
> +struct iommu_intel_ser {
> +	u64 phys_addr;
> +	u64 root_table;
> +} __packed;
> +
> +struct iommu_ser {
> +	struct iommu_obj_ser obj;
> +	u64 token;
> +	enum iommu_lu_type type;
> +	union {
> +		struct iommu_intel_ser intel;
> +	};
> +} __packed;
> +
> +struct iommu_objs_ser {
> +	u64 next_objs;
> +	u64 nr_objs;
> +} __packed;
> +
> +struct iommus_ser {
> +	struct iommu_objs_ser objs;
> +	struct iommu_ser iommus[];
> +} __packed;
> +
> +struct iommu_domains_ser {
> +	struct iommu_objs_ser objs;
> +	struct iommu_domain_ser iommu_domains[];
> +} __packed;
> +
> +struct devices_ser {
> +	struct iommu_objs_ser objs;
> +	struct device_ser devices[];
> +} __packed;
> +
> +#define MAX_IOMMU_SERS ((PAGE_SIZE - sizeof(struct iommus_ser)) / sizeof(struct iommu_ser))
> +#define MAX_IOMMU_DOMAIN_SERS \
> +		((PAGE_SIZE - sizeof(struct iommu_domains_ser)) / sizeof(struct iommu_domain_ser))
> +#define MAX_DEVICE_SERS ((PAGE_SIZE - sizeof(struct devices_ser)) / sizeof(struct device_ser))
> +
> +struct iommu_lu_flb_ser {
> +	u64 iommus_phys;
> +	u64 nr_iommus;
> +	u64 iommu_domains_phys;
> +	u64 nr_domains;
> +	u64 devices_phys;
> +	u64 nr_devices;
> +} __packed;
> +
> +struct iommu_lu_flb_obj {
> +	struct mutex lock;
> +	struct iommu_lu_flb_ser *ser;
> +
> +	struct iommu_domains_ser *iommu_domains;
> +	struct iommus_ser *iommus;
> +	struct devices_ser *devices;
> +} __packed;
> +

Please let's add some comments describing the structs & their members
here like we have in memfd [2]. This should be descriptive for the user.
For example:

+/**
+ * struct iommu_lu_flb_ser - Main serialization header for IOMMU state.
+ * @iommus_phys:        Physical address of the first page in the IOMMU unit chain.
+ * @nr_iommus:          Total number of hardware IOMMU units preserved.
+ * @iommu_domains_phys: [...]
+ * @nr_domains:         [...]
+ * @devices_phys:       [...]
+ * @nr_devices:         [...]
+ *
+ * This structure acts as the root of the IOMMU state tree. It is hitching a ride
+ * on the iommufd file descriptor's preservation flow.
+ */
+struct iommu_lu_flb_ser {
+	u64 iommus_phys;
+	u64 nr_iommus;
+	u64 iommu_domains_phys;
+	u64 nr_domains;
+	u64 devices_phys;
+	u64 nr_devices;
+} __packed;

> +#endif /* _LINUX_KHO_ABI_IOMMU_H */

Thanks,
Praan

[1] https://docs.kernel.org/process/coding-style.html#use-warn-rather-than-bug
[2] https://elixir.bootlin.com/linux/v7.0-rc3/source/include/linux/kho/abi/memfd.h

