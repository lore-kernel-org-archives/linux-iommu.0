Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F833FE2F
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110044; cv=none; b=gV1O2/URoSLJWQkmXSg51oubbO/XnO/D+uTczICxXIKVeJnl+dXwWTHPOi8Os9poZal381GmYfQwlSKY960c68ClTlH1EN1hdD8iHgo2b/ccMHUfptNMm7TqBd4w9Wl8PEe/Utz0nFlrdF0mk+5DpQj/kT7RRACjAy2SRpNOKPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110044; c=relaxed/simple;
	bh=btSIhGMvdP0aU851la5oG7im9lsPLy+PBN4yq1F8bgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e79BxOkgsvGlMUOdt+CCTg4NXl7QI2UHAmIKXoqbXs3hbD31VeuhwqVvdfJlPkm7xQ3z3uk6Ke55UmFKbKv3stTYW0wvj0YY78uZ4PgPWQifLfN5IZ+wKcn+x0/l6JhPM8cXSZG3jka9LrEPOov1bxEXkhQIbOIjSGW4CHxhEX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1p9DhWu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1p9DhWu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so305ad.0
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 06:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779110040; x=1779714840; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8z6jY/uEBmrxhBdQT2bu54FMFgYLzRCWsXgjpGmf3I=;
        b=c1p9DhWuSjHLutcf550Auhtu/o1mQZDaFrRrtB5zh4vr2cnNyGkCbTy4TdCGitEoE1
         vo6DAoMDviEBhuiGULWbzHxbAog5y+3xri6g9b0hrO8hw1JNgdsQPcOQra30ZrC1LrtB
         y6f+q8JdyAXumX/vkgCBUAzZyMK3NdIT+p6m8NkfDGNSkHoHoNlRcqH77EFENZRySlXw
         F14gXVHY7BugA97XIukFXn9gjbO4D1uIUHJb+shucGKVscUlNcYOxD9QZYX24eA6jnjs
         sjNQFy4JTbYFFPRtSb7f11LNPZ5bNXp/AxZzvgr2dxyvrOixAUxFtEDzhxvRlZKdX7az
         B5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110040; x=1779714840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8z6jY/uEBmrxhBdQT2bu54FMFgYLzRCWsXgjpGmf3I=;
        b=RsLUFIIz/gJVLy1s1RiC8U3w/d1TEnGpLJN+wiyPDCcCiLWtcyw4LIRoP4llzvz3jm
         dyzRUcl7VgjbwKDt+XIF10yw2o2AKoiZft/sWBckgVM6aN1exAqv3b/6feDKjv6llwYi
         MfQu5abn4JZlfLH2gqqq2fIMnluSSgG7tQQ9T40+icwZ9j/0iZCDyLh8Qh5fHU5RAljB
         rot8l8c57FByKlhhfTtK4ulPP9WO4Ssv7X1vinUv6K+dfXtOWUOKp1DruZjEb0AN4/ID
         w0qCp/DZUuVeAXMZxJyEk6ptr/TOQ2q8n/dWOIbuB+3WgugQ2VBTn+Vm1/ZnuSDpbtNI
         grjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pOmHkrVndV8ZUbE4ibrQ2ylCxKm+wb9ZSjhpPgi+n8TaTia8zq3/gzJoHQLNpNaXdg3T1qg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5UFaB3437P/slFxHKxDuerZH5p1MM5BdS/MZ0aqcZ/eMwQtGk
	UhIAF6TRMGunA9TNb9DlhXSrrW84UknJzS/2J575UTVYKrezZocVdkA0G5BNF31tFQ==
X-Gm-Gg: Acq92OFT4JkXAdPyMYJXNzabqd/BoTxJRo3+Nhc4xpVgUs2upJZxdZi2mthScI/0zOb
	zYYUa9Skx9qrjwfDI4Ad7vbPlVmUIsiLd265ZTnbZGoFXSKWtKvbI16cMqfzTZzyWXepgmY+jIC
	z9stcqQcsJu7EpUzPC7fOhND0lMo1C5Geyvt5n4EbgmwK1UatxQSoHgqVJHFy7UZCyO0Ga5OWfv
	B+PSzHFB+KSRCnm5kAfV0p5AdvIMA7O8N+SB7YsVeEWv5AnSUA67vXPN12CDWJ/kYqd2R8EEwVi
	l2yzugFjTzbv6VATV1GHM0ewvD9v2VpIeXEdXGQ/5qeZJAaq4Q61FtDu4r+0jBTDq+P9VDl3KSz
	UNXd6r6taqXSq2rLRPdtNc6bgjmBsnrWLcg5232TvCKftihNbteORxdYLxwfBG80NpYy6tUj1V2
	JuqViLWbSvNXJ5K6UO3CiriCwalz4WNJA/X3m3EL6QDsBNMN7OugsvJUNZ7tsyNIXSyi/T
X-Received: by 2002:a17:903:2f03:b0:2bd:6727:d689 with SMTP id d9443c01a7336-2bdb03a2b85mr3036825ad.12.1779110038827;
        Mon, 18 May 2026 06:13:58 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977c494sm14213643b3a.21.2026.05.18.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:13:58 -0700 (PDT)
Date: Mon, 18 May 2026 13:13:49 +0000
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
Subject: Re: [PATCH v2 03/16] iommu: Implement IOMMU domain preservation
Message-ID: <agsQE1lFGdo-b_IF@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-4-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:20PM +0000, Samiullah Khawaja wrote:
> Add IOMMU domain ops that can be implemented by the IOMMU drivers if
> they support IOMMU domain preservation across liveupdate. The new IOMMU
> domain preserve, unpreserve and restore APIs call these ops to perform
> respective live update operations.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/liveupdate.c       | 97 ++++++++++++++++++++++++++++++++
>  include/linux/iommu-liveupdate.h | 14 +++++
>  include/linux/iommu.h            | 13 +++++
>  3 files changed, 124 insertions(+)
> 
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index a26099b145c3..f71f14518248 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -13,6 +13,9 @@
>  #include <linux/iommu.h>
>  #include <linux/errno.h>
>  
> +#define iommu_max_objs_per_page(_array) \
> +	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
> +
>  static void *iommu_liveupdate_restore_array(u64 array_phys)
>  {
>  	struct iommu_array_hdr_ser *array_hdr;
> @@ -196,3 +199,97 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>  	liveupdate_unregister_flb(handler, &iommu_flb);
>  }
>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
> +
> +static int alloc_object_ser(struct iommu_array_hdr_ser **curr_array_ptr, u64 max_objs)
> +{
> +	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
> +	struct iommu_array_hdr_ser *next_array;
> +
> +	if (curr_array->nr_objects >= max_objs) {
> +		next_array = kho_alloc_preserve(PAGE_SIZE);
> +		if (IS_ERR(next_array))
> +			return PTR_ERR(next_array);
> +
> +		curr_array->next_array_phys = virt_to_phys(next_array);
> +		*curr_array_ptr = next_array;
> +		curr_array = next_array;
> +	}
> +
> +	return curr_array->nr_objects++;
> +}
> +
> +static struct iommu_domain_ser *alloc_iommu_domain_ser(struct iommu_flb_obj *flb)
> +{
> +	int idx;
> +
> +	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_domain_array,

Nit: Such type-casts could be brittle and risk strict-aliasing warnings
based on the compiler. 

Since alloc_object_ser only updates the top-level tracking pointer, we 
can make this much cleaner by changing alloc_object_ser to take a 
void curr_array_ptr. That way, we can pass (void )&flb->curr_domain_array
cleanly without the double-pointer type-punning. Something like:

static int alloc_object_ser(void **curr_array_ptr, u64 max_objs)
{
	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
	struct iommu_array_hdr_ser *next_array;

	...
}

and we can pass it as:

idx = alloc_object_ser((void **)&flb->curr_domain_array,
		       iommu_max_objs_per_page(flb->curr_domain_array));

> +			       iommu_max_objs_per_page(flb->curr_domain_array));
> +	if (idx < 0)
> +		return ERR_PTR(idx);
> +
> +	flb->curr_domain_array->objects[idx].hdr.ref_count = 1;
> +	return &flb->curr_domain_array->objects[idx];
> +}
> +
> +int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser)
> +{
> +	struct iommu_domain_ser *domain_ser;
> +	struct iommu_flb_obj *flb_obj;
> +	int ret;
> +
> +	if (!domain->ops->preserve)
> +		return -EOPNOTSUPP;
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&flb_obj->lock);
> +	domain_ser = alloc_iommu_domain_ser(flb_obj);
> +	if (IS_ERR(domain_ser))
> +		return PTR_ERR(domain_ser);
> +
> +	ret = domain->ops->preserve(domain, domain_ser);
> +	if (ret) {
> +		domain_ser->hdr.deleted = true;

Nit: This will become domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
once we convert the bitfields in PATCH 2 to flags.

> +		return ret;
> +	}
> +
> +	domain->preserved_state = domain_ser;
> +	*ser = domain_ser;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_domain_preserve);
> +

[...]

>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> @@ -752,6 +757,11 @@ struct iommu_ops {
>   *                           specific mechanisms.
>   * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
>   * @free: Release the domain after use.
> + * @preserve: Preserve the iommu domain for liveupdate.
> + *            Returns 0 on success, a negative errno on failure.
> + * @unpreserve: Unpreserve the iommu domain that was preserved earlier.
> + * @restore: Restore the iommu domain after liveupdate.
> + *           Returns 0 on success, a negative errno on failure.
>   */
>  struct iommu_domain_ops {
>  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev,
> @@ -782,6 +792,9 @@ struct iommu_domain_ops {
>  				  unsigned long quirks);
>  
>  	void (*free)(struct iommu_domain *domain);
> +	int (*preserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
> +	void (*unpreserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
> +	int (*restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser);

Nit: Should we add restore in the patch we implement it?

>  };

With the above nits,

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
