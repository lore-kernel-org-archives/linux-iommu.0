Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C48F2C21C3
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779235257; cv=none; b=X6c4Ye6kwozAUHgfUR+5v65SFu1gMr9RWq3WYL+PmFpqrhOUqwjtdgDB2s2D4xGfRMd8CJqiqsbJu8ivCblubU9CTGmp0+a3L72x7Zufxx8OQhxdRdhdL6OftkErH2Pj0qwoxDwM+kbx+PPlmKJKj8/5X49+aQEwaLhlbOQ6pRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779235257; c=relaxed/simple;
	bh=jpvnt3ftnCiDpJEFsRJhSt0OudI/eFfW1G6557k/W9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POfXneW8ZzyOMYgL+Eg2YI6DrfU9uqoBOOQ5NynygnMP+jJxF3QKufv0+mcgW4qMu70ACGCiWt7PLQHYrzn1pijgNtGTrkzz8Cdqmz8rUIJe/WJOKb6Q6zFivRUeV0TIx+/Kz/BDAIsiYbCIlEnmKqxDvIzOLKon1FJfloG0Cdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m3uP0d2C; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3uP0d2C"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso85ad.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 17:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779235255; x=1779840055; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDXlbxCgWYcNAExiIzDJxR3GZdN2Et+p8bEHKaezArw=;
        b=m3uP0d2CYgef0Uo91hyAj8GND6WhvSQbP4YDrg+3DrIV7Gi/eq9HEs0KVuh5SMc+55
         QXYjL59I3Hu68loOy5ypbjwC3WKB3HSoY6+sX7BNGPeKoX06aodD6+M/gKuPS6BK+rZg
         jkBCNAZzxxb6DChsuYg348Bo3nl+vovPr7PcKyFy4YCcdiy/W910aVKRfNrGMffD0w2/
         NmYae/fc2qn324nD2Y/MMi7Y2gM0tY96WHBHHAuiaywbjmBEzN3pMxv9I4DSO5DyCLxO
         h1al2THygEUbksVHXnjPh1A516A4qbU9zJ4xxcYxiXazKL/OXfhQFJR7M8fIjwcle2K5
         3ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779235255; x=1779840055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDXlbxCgWYcNAExiIzDJxR3GZdN2Et+p8bEHKaezArw=;
        b=HgYYYowtg/s6lzq+Z88uAgBTHsz/vlyMbn6qYPhOEVMMbc8DKj9v6oWkm9Jhf5+7pK
         ZL6A/AW+d9BSZcChoPFe+eakeOXKlwLugQFI3T+izbH7EkN4LMU4XF1i3iqPm8BPvpOQ
         1F0mizg5J2opiys9Q3sJJcteFoUrNnzMJlF2Vl2QE+DCrl7imCnXqNkbF4eCB3iZ0Xzb
         JiIzhXXbU3Vy/5c1DMNnBTHKmGyEHhNbXovNRoGIocIyDEo8WiSELYx0LFjZem2TRxzq
         GtI5iyZb/ayzlS2DTeWhgeGaznPUyPfF0ib8HsS80/KrLNYljE0l6Raq+uSpTLsRfdK5
         3n7g==
X-Forwarded-Encrypted: i=1; AFNElJ/PpxsiHr2hUACN9VIdvz4h2AciCVlxrPu3qn7aROB8nZBtW6kwXpquy7VCOelYAUaN/JZsxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFwUCyXTkkV8UCu0KyST3uFibG/K28IQcTQ/WpJkNFDkHDPHBZ
	mm3pliuRK4zI9dgjbWCkxoa1KV9kC/xut9vC4ABVvQufNPfgRaSFL9+fU+9ux0yoTg==
X-Gm-Gg: Acq92OH0PG5XxIfF8gvH8psk/oeChxKNF4ZCgKKh0ibCmgBQHQ4uz88qSGtdWVDekUe
	PIchsdTh/iIunapDUhRjfxhT10kYxkBSsp/HDRJVIG8KWcz9scxj0tqzkXgeONCsbVGkIa2+mDR
	N52zWJWUhh7voEVkAI5CFk3WqWdibEJVf6CrxycBSo+0q9V7RazACLuT1wrXxO2FjUHq7BWyqh3
	UPwrwfoKDdvAIZchUNke5JSTaE2xf53gpjvrC/Jg03x1YEeubp0eRrW5oT/6pWNOrScVaS1R093
	7NsKKZW0X+yB9XCic3e2U2YkRI6QMY4fPJpXAyiTN2yM7TeDjNDw7xIm4m63KfeLNs4+8UTy/wB
	/+rKgsIS4vAER8sgfDa4h5ssgA2OWmAEEB6WEoUaPSRLed50x4m7GQYxsBkItfQnrZDplvUhXUe
	H8/S+MTahD2zvS9E1ZPF6PZUuD9D3jyX0vt/qGPE1lzOcVBNnSO1naZNrsyv/Qv4XtpH6m
X-Received: by 2002:a17:903:17cf:b0:2b4:60e6:44bc with SMTP id d9443c01a7336-2bdb329b5eamr7581245ad.13.1779235253983;
        Tue, 19 May 2026 17:00:53 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19794e6esm17816740b3a.25.2026.05.19.17.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:00:53 -0700 (PDT)
Date: Wed, 20 May 2026 00:00:44 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	YiFei Zhu <zhuyifei@google.com>,
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
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v2 13/16] iommufd: Persist iommu hardware pagetables for
 live update
Message-ID: <agz5rFcl27H8yzTY@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-14-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-14-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:30PM +0000, Samiullah Khawaja wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> Register iommufd with the LUO framework and implement the preserve and
> unpreserve ops to save marked HWPTs.
> 
> To make sure mappings do not change during preserved state, add a
> liveupdate_immutable flag to IOAS. When an HWPT is preserved, its IOAS
> is marked immutable and any map/unmap attempts will fail with -EBUSY.
> This is synchronized using the domains_rwsem to prevent races with
> concurrent mapping operations.
> 
> The preserve callback iterates over the marked HWPTs, verifies that the
> backing memory pages are preserved, and calls iommu_domain_preserve() to
> preserve the associated IOMMU domain.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

[...]

> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 111f4d42e210..3c88aa115d08 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -98,6 +98,9 @@ struct io_pagetable {
>  	/* IOVA that cannot be allocated, struct iopt_reserved */
>  	struct rb_root_cached reserved_itree;
>  	u8 disable_large_pages;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	bool liveupdate_immutable;
> +#endif
>  	unsigned long iova_alignment;
>  };
>  
> @@ -379,7 +382,7 @@ struct iommufd_hwpt_paging {
>  	bool enforce_cache_coherency : 1;
>  	bool nest_parent : 1;
>  #ifdef CONFIG_IOMMU_LIVEUPDATE
> -	bool liveupdate_preserve : 1;
> +	bool liveupdate_preserved : 1;

Ahh okay, that's why I didn't find any reference earlier. (I searched
for liveupdate_preserve), Please ignore the remnant comment in Patch 12.

>  	u64 liveupdate_token;
>  #endif

[...]

> +
> +static int iommufd_preserve_hwpt(struct iommufd_hwpt_paging *hwpt,
> +				 struct iommufd_hwpt_ser *hwpt_ser,
> +				 struct liveupdate_session *session)
> +{
> +	struct iommu_domain_ser *domain_ser;
> +	bool ioas_made_immutable = false;
> +	int rc;
> +
> +	if (!hwpt->ioas->iopt.liveupdate_immutable) {
> +		/*
> +		 * Make IOAS immutable so the DMA mappings do not change while
> +		 * the HWPT is preserved. Since one IOAS can have multiple
> +		 * HWPTs, if an error occurs this call needs to make the IOAS
> +		 * mutable again if it was the one that made it immutable.
> +		 */
> +		ioas_made_immutable = true;
> +		ioas_set_immutable(hwpt->ioas, true);
> +
> +		rc = check_iopt_pages_preserved(session, hwpt);
> +		if (rc)
> +			goto err;
> +	}

Nit:
I'm thinking what happens for a shared IOAS situation? Say, 2 devices,
in the same container, behind 2 different IOMMUs, sharing the IOAS. Each
device will have it's own HWPT (N:1 mapping for HWPT v/s IOAS)

So, what happens if Device 1 succeeds with preservation but device 2
doesn't? For example:

1. Preserve Device 1:
 - It sees liveupdate_immutable is false.
 - Sets ioas_made_immutable = true on its local stack.
 - Flips IOAS to immutable.
 - Preservation succeeds.

2. Preserve Device 2:
 - It sees liveupdate_immutable is already true (because Device 1 set it).
 - Sets ioas_made_immutable = false on its local stack.
 - The Failure: iommu_domain_preserve fails for Device 2.
 - The Jump: Hits goto err;

Now, inside the err: label for device 2, it checks 
if (ioas_made_immutable), since it is FALSE for device 2,
it does nothing. 

I agree we return an error code to the caller which finally cleans it up
well, but I'm considering if we should make liveupdate_immutable
refcountable? Since the error handling in iommufd_preserve_hwpt() is
logically incomplete for shared IOAS as it only attempts to restore 
mutability if the current HWPT set immutable = true;

> +
> +	hwpt_ser->token = hwpt->liveupdate_token;
> +	hwpt_ser->reclaimed = false;
> +
> +	rc = iommu_domain_preserve(hwpt->common.domain, &domain_ser);
> +	if (rc < 0)
> +		goto err;
> +
> +	hwpt_ser->domain_data = virt_to_phys(domain_ser);
> +	return 0;
> +
> +err:
> +	if (ioas_made_immutable)
> +		ioas_set_immutable(hwpt->ioas, false);
> +
> +	return rc;
> +}

[...]

> +
> +static int iommufd_liveupdate_preserve(struct liveupdate_file_op_args *args)
> +{
> +	struct iommufd_ctx *ictx = iommufd_ctx_from_file(args->file);
> +	struct iommufd_hwpt_paging *hwpt;
> +	struct iommufd_ser *iommufd_ser;
> +	struct iommufd_object *obj;
> +	unsigned int nr_hwpts;
> +	unsigned long index;
> +	unsigned int i;
> +	void *mem;
> +	int rc;
> +
> +	if (IS_ERR(ictx))
> +		return PTR_ERR(ictx);
> +
> +	mutex_lock(&ictx->liveupdate_mutex);
> +
> +	/* Count the number of HWPTs to preserve */
> +	nr_hwpts = 0;
> +	xa_lock(&ictx->objects);
> +	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
> +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
> +			continue;
> +
> +		hwpt = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
> +		if (!hwpt->common.domain) {
> +			rc = -EINVAL;
> +			xa_unlock(&ictx->objects);
> +			goto out_unlock;
> +		}
> +		nr_hwpts++;
> +	}
> +	xa_unlock(&ictx->objects);
> +
> +	mem = kho_alloc_preserve(struct_size(iommufd_ser,
> +					     hwpt_array, nr_hwpts));
> +	if (!mem) {
> +		rc = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	iommufd_ser = mem;
> +	iommufd_ser->nr_hwpts = nr_hwpts;

Nit: Can there be a TOCTOU here? We first count nr_hwpts in the first
loop, but actually preserve them in the loop below. Is it possible for a
Guest to race with these loops and destroy a HWPT? 

That could cause a bug in the new kernel as it may try to restore
nr_hwpts which is one more than the preserved HWPTs.

> +
> +	/* Preserve HWPTs */
> +	i = 0;
> +	xa_lock(&ictx->objects);
> +	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
> +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
> +			continue;
> +
> +		if (!iommufd_lock_obj(obj)) {
> +			rc = -ENOENT;
> +			xa_unlock(&ictx->objects);
> +			goto out_unpreserve;
> +		}
> +
> +		/*
> +		 * HWPT is locked so it will not be destroyed. The xarray lock
> +		 * can be released here before preserving the HWPT.
> +		 */
> +		xa_unlock(&ictx->objects);
> +		hwpt = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
> +		rc = iommufd_preserve_hwpt(hwpt, &iommufd_ser->hwpt_array[i++], args->session);
> +		if (rc) {
> +			iommufd_put_object(ictx, obj);
> +			goto out_unpreserve;
> +		}
> +
> +		/* Mark as preserved */
> +		hwpt->liveupdate_preserved = true;
> +		xa_lock(&ictx->objects);
> +	}
> +	xa_unlock(&ictx->objects);

[...]

> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 9bdb2945afe1..3b0c0acb8856 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -55,6 +55,7 @@
>  #include <linux/overflow.h>
>  #include <linux/slab.h>
>  #include <linux/sched/mm.h>
> +#include <linux/memfd.h>
>  #include <linux/vfio_pci_core.h>
>  
>  #include "double_span.h"
> @@ -1421,6 +1422,7 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
>  
>  {
>  	struct iopt_pages *pages;
> +	int seals;
>  
>  	pages = iopt_alloc_pages(start_byte, length, writable);
>  	if (IS_ERR(pages))
> @@ -1428,6 +1430,11 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
>  	pages->file = get_file(file);
>  	pages->start = start - start_byte;
>  	pages->type = IOPT_ADDRESS_FILE;
> +
> +	seals = memfd_get_seals(file);
> +	if (seals > 0)
> +		pages->seals = seals;
> +

Can caching memfd seals create a TOCTOU issue?
IIUC, iopt_alloc_file_pages happens at map time, However, the userspace
is allowed to map a memfd and then apply the F_ADD_SEALS via fcntl() 
later in its setup sequence? For example a sequence like:

1. VMM creates a memfd. It has 0 seals.
2. VMM calls IOMMU_IOAS_MAP_FILE. IOMMUFD caches pages->seals = 0.
3. VMM finishes its setup and calls:
   fcntl(fd, F_ADD_SEALS, F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL).

4.VMM initiates Live Update.
5.check_iopt_pages_preserved looks at the cached pages->seals 
  (which is still 0), sees the seals are missing, & kills the LiveUpdate
  with -EINVAL, even though the file is properly sealed..

Thus, I guess we should dynamically check seals via memfd_get_seals() 

>  	return pages;
>  }
>  

Thanks,
Praan
