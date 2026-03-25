Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DB63290B7
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470758; cv=none; b=itiN6YMQXkMcG6aMbyIkR+J7xagJd4X08s6a3Bn6hXechOfJeSZjnxt+Rufbz8wVGesrd5hUC6vun51fpwRJszp8iOZtdv4vboiS9sjBs2ByEZtdvnw3T2yasJY8r11K7dfnFqFtZwpS3wlacC+BPdajTkiqLlcn1w7df8Q8ELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470758; c=relaxed/simple;
	bh=c2Re+EgFCoW2XcWe3knpZZHfWMH6rEiA+TLduLsNTRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFBvZK3NyhXU7CRmTzxatHwujbqmHuw4/3QFTrQlRw9M6UhjXUP9X3crqB2XZvDcmBSeRKcFqrQHVDmE+Qr0AV5O9fhWKMygjkda7IIl2/1K2dHcAKCgdpxQNwT9Lx5Tbpk4bTlL55zQSviu9o9em9JpU4nQs80VhBNBKA1t8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GrgjItgb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrgjItgb"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b0b260d309so6735ad.1
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774470756; x=1775075556; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkMewwKhuvoE+7qaONKVdMT35br8+vEdrYW8a0o4IFc=;
        b=GrgjItgbcmt4jqV0A4+0DSTmT89U/KVPB5KxFjeZfJrIAGJomk10fL1j3NvEC+7IfR
         GIGya3aVmCE3o7aEYCIxY6Wu7JgokRXFrDSMsbeH7QBhvdPmb2N1DgqfX5liK8Z6Vv7V
         wFiubOXL47AAHo3AVxxpK4LwX9kNvJytzoOHTjwxZm83P2MLLxy7fnh3O9k5+1b3AGjV
         /xK4Vbfp0L/2QnJqF2pJOKh1zRb3cJZPUYVbN7KhRVdSVRVtDHpSl0A8CzhW7dIHYIWG
         xZpbEPdDWmLS+SnmB/Umieg0oH4Q4BENBeg/J/SuZWgh7Re84lMaPN8XSb0TXi1xhnQ1
         V5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774470756; x=1775075556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkMewwKhuvoE+7qaONKVdMT35br8+vEdrYW8a0o4IFc=;
        b=FrIhDtzoW9YZIlrS1vS0CHlZDwZaNLq2fi1c7HbwzaYfd58obvUkuRsUvw6F6rCNKW
         K6k/9orLbL4NwBlb4xGePZwDbtgLZMLDqcbfQm4NzeGg/uN/uUuyBt4LyDfkt0rfed4t
         DNxA1IHouSftmKSko+4Pv2RPbBZVhKP9EXS0ZS1goONMWUXlcpigC0BfEt7YGICPZnb4
         UYSZfGKwmE23WD5iy9+ms5H/lSaRGvobnQu3OQ6bTbKvZkomHTa2jraKMF1KBJjtA0T+
         OVTylSde5/POx41fVO0xGi9g5i5AFENqpsclAlsPDIsSidFVImeFrAyk3MzMHP+hJA8V
         b8ww==
X-Forwarded-Encrypted: i=1; AJvYcCX8Zz9BimmfcZy4MOgMen3NNnd2FWzTz+jb83kON0vffwcJqWkC4Rc7tz/jd3g69Zf8qIuXdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfLm35mbO8JyoEni5c3v9iENL0ds8/pyAzYSLMw7p2LcAiyTL+
	IQgmkisi5S5zN3MbBVkntZILq3HMSU552r1+YXO/jSiYsX54ffYkdLJy+NLoORdaGA==
X-Gm-Gg: ATEYQzxeit6n8KlJPoPLp3avApBZOc3aSlp6gWTTKtF6NYQ5O9UeTA/hA7+1bIoYuaO
	jbOJhF3tBSmB2XBgIMy64ei+k7VIPsjGfgBRJb7/ERfmtVs5WoA9u84AyXjgf6dnWg1MMmz8PMN
	7Kbg5q9vAo9VAvuRqpa1XXFQCVkxbtp5CxVTkc/8rhA+z+bLKXNPkohtyTTRIrvRI8tswM1x4iw
	v51rX2mNMLjgvP+5wsuPeHrkVWEn+p64YJAt1rSc/pij4dmOwx9qHobqi7WuEdVkeMBqFX0iRsf
	TYyHKqN+zMO4d2sKLrSHYLn8UziOnXnMEhabBIyJDNjOFDNrEScNgySKWMnzVmSfq22Mv4uCAs9
	a6s7siqFmXrY52v9Na+mogtx+dUN5h6bbxu709YdxldD+9+QscV2nNHBg8zp7Uxzyz40vbNwXG9
	ImXt0vee+4SV3QBfJRtS38AkLuI/lOmYIneeP7O8rh2SRe6zR2QfCjUA/soCsSug==
X-Received: by 2002:a17:903:2987:b0:2ae:45cc:aeb6 with SMTP id d9443c01a7336-2b0bf751217mr468405ad.6.1774470755595;
        Wed, 25 Mar 2026 13:32:35 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc915f72sm6784925ad.80.2026.03.25.13.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:32:34 -0700 (PDT)
Date: Wed, 25 Mar 2026 20:32:31 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH 11/14] iommufd-lu: Persist iommu hardware pagetables for
 live update
Message-ID: <acRECIdaf4d4h8TD@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-12-skhawaja@google.com>
 <acRA0Ir1gzgtZiEN@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <acRA0Ir1gzgtZiEN@google.com>

On Wed, Mar 25, 2026 at 08:08:48PM +0000, Pranjal Shrivastava wrote:
>On Tue, Feb 03, 2026 at 10:09:45PM +0000, Samiullah Khawaja wrote:
>> From: YiFei Zhu <zhuyifei@google.com>
>>
>> The caller is expected to mark each HWPT to be preserved with an ioctl
>> call, with a token that will be used in restore. At preserve time, each
>> HWPT's domain is then called with iommu_domain_preserve to preserve the
>> iommu domain.
>>
>> The HWPTs containing dma mappings backed by unpreserved memory should
>> not be preserved. During preservation check if the mappings contained in
>> the HWPT being preserved are only file based and all the files are
>> preserved.
>>
>> The memfd file preservation check is not enough when preserving iommufd.
>> The memfd might have shrunk between the mapping and memfd preservation.
>> This means that if it shrunk some pages that are right now pinned due to
>> iommu mappings are not preserved with the memfd. Only allow iommufd
>> preservation when all the iopt_pages are file backed and the memory file
>> was seal sealed during mapping. This guarantees that all the pages that
>> were backing memfd when it was mapped are preserved.
>>
>> Once HWPT is preserved the iopt associated with the HWPT is made
>> immutable. Since the map and unmap ioctls operates directly on iopt,
>> which contains an array of domains, while each hwpt contains only one
>> domain. The logic then becomes that mapping and unmapping is prohibited
>> if any of the domains in an iopt belongs to a preserved hwpt. However,
>> tracing to the hwpt through the domain is a lot more tedious than
>> tracing through the ioas, so if an hwpt is preserved, hwpt->ioas->iopt
>> is made immutable.
>>
>> When undoing this (making the iopts mutable again), there's never
>> a need to make some iopts mutable and some kept immutable, since
>> the undo only happen on unpreserve and error path of preserve.
>> Simply iterate all the ioas and clear the immutability flag on all
>> their iopts.
>>
>> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/iommufd/io_pagetable.c    |  17 ++
>>  drivers/iommu/iommufd/io_pagetable.h    |   1 +
>>  drivers/iommu/iommufd/iommufd_private.h |  25 ++
>>  drivers/iommu/iommufd/liveupdate.c      | 300 ++++++++++++++++++++++++
>>  drivers/iommu/iommufd/main.c            |  14 +-
>>  drivers/iommu/iommufd/pages.c           |   8 +
>>  include/linux/kho/abi/iommufd.h         |  39 +++
>>  7 files changed, 403 insertions(+), 1 deletion(-)
>>  create mode 100644 include/linux/kho/abi/iommufd.h
>>
>> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
>> index 436992331111..43e8a2443793 100644
>> --- a/drivers/iommu/iommufd/io_pagetable.c
>> +++ b/drivers/iommu/iommufd/io_pagetable.c
>> @@ -270,6 +270,11 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
>>  	}
>>
>>  	down_write(&iopt->iova_rwsem);
>> +	if (iopt_lu_map_immutable(iopt)) {
>> +		rc = -EBUSY;
>> +		goto out_unlock;
>> +	}
>> +
>>  	if ((length & (iopt->iova_alignment - 1)) || !length) {
>>  		rc = -EINVAL;
>>  		goto out_unlock;
>> @@ -328,6 +333,7 @@ static void iopt_abort_area(struct iopt_area *area)
>>  		WARN_ON(area->pages);
>>  	if (area->iopt) {
>>  		down_write(&area->iopt->iova_rwsem);
>> +		WARN_ON(iopt_lu_map_immutable(area->iopt));
>>  		interval_tree_remove(&area->node, &area->iopt->area_itree);
>>  		up_write(&area->iopt->iova_rwsem);
>>  	}
>> @@ -755,6 +761,12 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
>>  again:
>>  	down_read(&iopt->domains_rwsem);
>>  	down_write(&iopt->iova_rwsem);
>> +
>> +	if (iopt_lu_map_immutable(iopt)) {
>> +		rc = -EBUSY;
>> +		goto out_unlock_iova;
>> +	}
>> +
>>  	while ((area = iopt_area_iter_first(iopt, start, last))) {
>>  		unsigned long area_last = iopt_area_last_iova(area);
>>  		unsigned long area_first = iopt_area_iova(area);
>> @@ -1398,6 +1410,11 @@ int iopt_cut_iova(struct io_pagetable *iopt, unsigned long *iovas,
>>  	int i;
>>
>>  	down_write(&iopt->iova_rwsem);
>> +	if (iopt_lu_map_immutable(iopt)) {
>> +		up_write(&iopt->iova_rwsem);
>> +		return -EBUSY;
>> +	}
>> +
>>  	for (i = 0; i < num_iovas; i++) {
>>  		struct iopt_area *area;
>>
>> diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
>> index 14cd052fd320..b64cb4cf300c 100644
>> --- a/drivers/iommu/iommufd/io_pagetable.h
>> +++ b/drivers/iommu/iommufd/io_pagetable.h
>> @@ -234,6 +234,7 @@ struct iopt_pages {
>>  		struct {			/* IOPT_ADDRESS_FILE */
>>  			struct file *file;
>>  			unsigned long start;
>> +			u32 seals;
>>  		};
>>  		/* IOPT_ADDRESS_DMABUF */
>>  		struct iopt_pages_dmabuf dmabuf;
>> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>> index 6424e7cea5b2..f8366a23999f 100644
>> --- a/drivers/iommu/iommufd/iommufd_private.h
>> +++ b/drivers/iommu/iommufd/iommufd_private.h
>> @@ -94,6 +94,9 @@ struct io_pagetable {
>>  	/* IOVA that cannot be allocated, struct iopt_reserved */
>>  	struct rb_root_cached reserved_itree;
>>  	u8 disable_large_pages;
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	bool lu_map_immutable;
>> +#endif
>>  	unsigned long iova_alignment;
>>  };
>>
>> @@ -712,12 +715,34 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
>>  }
>>
>>  #ifdef CONFIG_IOMMU_LIVEUPDATE
>> +int iommufd_liveupdate_register_lufs(void);
>> +int iommufd_liveupdate_unregister_lufs(void);
>> +
>>  int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd);
>> +static inline bool iopt_lu_map_immutable(const struct io_pagetable *iopt)
>> +{
>> +	return iopt->lu_map_immutable;
>> +}
>>  #else
>> +static inline int iommufd_liveupdate_register_lufs(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline int iommufd_liveupdate_unregister_lufs(void)
>> +{
>> +	return 0;
>> +}
>> +
>>  static inline int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd)
>>  {
>>  	return -ENOTTY;
>>  }
>> +
>> +static inline bool iopt_lu_map_immutable(const struct io_pagetable *iopt)
>> +{
>> +	return false;
>> +}
>>  #endif
>>
>>  #ifdef CONFIG_IOMMUFD_TEST
>> diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
>> index ae74f5b54735..ec11ae345fe7 100644
>> --- a/drivers/iommu/iommufd/liveupdate.c
>> +++ b/drivers/iommu/iommufd/liveupdate.c
>> @@ -4,9 +4,15 @@
>>
>>  #include <linux/file.h>
>>  #include <linux/iommufd.h>
>> +#include <linux/kexec_handover.h>
>> +#include <linux/kho/abi/iommufd.h>
>>  #include <linux/liveupdate.h>
>> +#include <linux/iommu-lu.h>
>> +#include <linux/mm.h>
>> +#include <linux/pci.h>
>>
>>  #include "iommufd_private.h"
>> +#include "io_pagetable.h"
>>
>>  int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd)
>>  {
>> @@ -47,3 +53,297 @@ int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd)
>>  	return rc;
>>  }
>>
>> +static void iommufd_set_ioas_mutable(struct iommufd_ctx *ictx)
>> +{
>> +	struct iommufd_object *obj;
>> +	struct iommufd_ioas *ioas;
>> +	unsigned long index;
>> +
>> +	xa_lock(&ictx->objects);
>> +	xa_for_each(&ictx->objects, index, obj) {
>> +		if (obj->type != IOMMUFD_OBJ_IOAS)
>> +			continue;
>> +
>> +		ioas = container_of(obj, struct iommufd_ioas, obj);
>> +
>> +		/*
>> +		 * Not taking any IOAS lock here. All writers take LUO
>> +		 * session mutex, and this writer racing with readers is not
>> +		 * really a problem.
>> +		 */
>> +		WRITE_ONCE(ioas->iopt.lu_map_immutable, false);
>> +	}
>> +	xa_unlock(&ictx->objects);
>> +}
>> +
>> +static int check_iopt_pages_preserved(struct liveupdate_session *s,
>> +				      struct iommufd_hwpt_paging *hwpt)
>> +{
>> +	u32 req_seals = F_SEAL_SEAL | F_SEAL_GROW | F_SEAL_SHRINK;
>> +	struct iopt_area *area;
>> +	int ret;
>> +
>> +	for (area = iopt_area_iter_first(&hwpt->ioas->iopt, 0, ULONG_MAX); area;
>> +	     area = iopt_area_iter_next(area, 0, ULONG_MAX)) {
>> +		struct iopt_pages *pages = area->pages;
>> +
>> +		/* Only allow file based mapping */
>> +		if (pages->type != IOPT_ADDRESS_FILE)
>> +			return -EINVAL;
>
>That's an important check! should we document it somewhere for the user
>to know about it too? Perhaps in the uAPI header for the preserve IOCTL,
>so VMM authors are aware of the anonymous memory restriction upfront?

Agreed. Will add this in next revision.
>
>> +
>> +		/*
>> +		 * When this memory file was mapped it should be sealed and seal
>> +		 * should be sealed. This means that since mapping was done the
>> +		 * memory file was not grown or shrink and the pages being used
>> +		 * until now remain pinnned and preserved.
>> +		 */
>> +		if ((pages->seals & req_seals) != req_seals)
>> +			return -EINVAL;
>> +
>> +		/* Make sure that the file was preserved. */
>> +		ret = liveupdate_get_token_outgoing(s, pages->file, NULL);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int iommufd_save_hwpts(struct iommufd_ctx *ictx,
>> +			      struct iommufd_lu *iommufd_lu,
>> +			      struct liveupdate_session *session)
>> +{
>> +	struct iommufd_hwpt_paging *hwpt, **hwpts = NULL;
>> +	struct iommu_domain_ser *domain_ser;
>> +	struct iommufd_hwpt_lu *hwpt_lu;
>> +	struct iommufd_object *obj;
>> +	unsigned int nr_hwpts = 0;
>> +	unsigned long index;
>> +	unsigned int i;
>> +	int rc = 0;
>> +
>> +	if (iommufd_lu) {
>> +		hwpts = kcalloc(iommufd_lu->nr_hwpts, sizeof(*hwpts),
>> +				GFP_KERNEL);
>> +		if (!hwpts)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	xa_lock(&ictx->objects);
>> +	xa_for_each(&ictx->objects, index, obj) {
>> +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
>> +			continue;
>> +
>> +		hwpt = container_of(obj, struct iommufd_hwpt_paging, common.obj);
>> +		if (!hwpt->lu_preserve)
>> +			continue;
>> +
>> +		if (hwpt->ioas) {
>> +			/*
>> +			 * Obtain exclusive access to the IOAS and IOPT while we
>> +			 * set immutability
>> +			 */
>> +			mutex_lock(&hwpt->ioas->mutex);
>
>Doubling down on Ankit's comment here, we should absolutely avoid taking
>sleepable locks in atomic context. I can attempt testing the next series
>with lockdep enabled.
>
>> +			down_write(&hwpt->ioas->iopt.domains_rwsem);
>> +			down_write(&hwpt->ioas->iopt.iova_rwsem);
>> +
>> +			hwpt->ioas->iopt.lu_map_immutable = true;
>> +
>> +			up_write(&hwpt->ioas->iopt.iova_rwsem);
>> +			up_write(&hwpt->ioas->iopt.domains_rwsem);
>> +			mutex_unlock(&hwpt->ioas->mutex);
>
>Additionally, I'm wondering if this could be a helper function?
>iommufd_ioas_set_immutable?

I will have to restructure this part of the code to not take the mutex
in the atomic context. I will move it to a helper function in next
revision if there is opportunity to do that.
>
>> +		}
>> +
>> +		if (!hwpt->common.domain) {
>> +			rc = -EINVAL;
>> +			xa_unlock(&ictx->objects);
>> +			goto out;
>> +		}
>> +
>> +		if (!iommufd_lu) {
>> +			rc = check_iopt_pages_preserved(session, hwpt);
>
>This seems slightly redundant, we are calling check_iopt_pages_preserved
>for every single preserved HWPT. However, multiple HWPTs can share the
>same underlying IOAS.

Agreed. I think this check and the earlier immutable thing need to be
done at IOPT level. I think the rework for that should also remove the
redundant checks here.
>
>If a VMM has 5 devices sharing a single IOAS, this code will walk the
>exact same iopt_area_itree and validate the exact same memfd seals 5
>times. Should we perhaps track which iopts have already been validated
>during the loop to avoid this redundant tree traversal?
>
>> +			if (rc) {
>> +				xa_unlock(&ictx->objects);
>> +				goto out;
>> +			}
>> +		} else if (iommufd_lu) {
>> +			hwpts[nr_hwpts] = hwpt;
>> +			hwpt_lu = &iommufd_lu->hwpts[nr_hwpts];
>> +
>> +			hwpt_lu->token = hwpt->lu_token;
>> +			hwpt_lu->reclaimed = false;
>> +		}
>> +
>> +		nr_hwpts++;
>> +	}
>> +	xa_unlock(&ictx->objects);
>> +
>> +	if (WARN_ON(iommufd_lu && iommufd_lu->nr_hwpts != nr_hwpts)) {
>> +		rc = -EFAULT;
>> +		goto out;
>> +	}
>> +
>> +	if (iommufd_lu) {
>> +		/*
>> +		 * iommu_domain_preserve may sleep and must be called
>> +		 * outside of xa_lock
>> +		 */
>> +		for (i = 0; i < nr_hwpts; i++) {
>> +			hwpt = hwpts[i];
>> +			hwpt_lu = &iommufd_lu->hwpts[i];
>> +
>> +			rc = iommu_domain_preserve(hwpt->common.domain, &domain_ser);
>> +			if (rc < 0)
>> +				goto out;
>> +
>> +			hwpt_lu->domain_data = __pa(domain_ser);
>> +		}
>> +	}
>> +
>> +	rc = nr_hwpts;
>> +
>> +out:
>> +	kfree(hwpts);
>> +	return rc;
>> +}
>> +
>> +static int iommufd_liveupdate_preserve(struct liveupdate_file_op_args *args)
>> +{
>> +	struct iommufd_ctx *ictx = iommufd_ctx_from_file(args->file);
>> +	struct iommufd_lu *iommufd_lu;
>> +	size_t serial_size;
>> +	void *mem;
>> +	int rc;
>> +
>> +	if (IS_ERR(ictx))
>> +		return PTR_ERR(ictx);
>> +
>> +	rc = iommufd_save_hwpts(ictx, NULL, args->session);
>> +	if (rc < 0)
>> +		goto err_ioas_mutable;
>> +
>> +	serial_size = struct_size(iommufd_lu, hwpts, rc);
>> +
>> +	mem = kho_alloc_preserve(serial_size);
>> +	if (!mem) {
>> +		rc = -ENOMEM;
>> +		goto err_ioas_mutable;
>> +	}
>> +
>> +	iommufd_lu = mem;
>> +	iommufd_lu->nr_hwpts = rc;
>> +	rc = iommufd_save_hwpts(ictx, iommufd_lu, args->session);
>
>We call iommufd_save_hwpts twice (first to count/validate & second to
>serialize). Because xa_lock is dropped between these two calls to
>allocate KHO memory, we have a TOCTOU race.

Agreed. Will handle this in next revision.
>
>If userspace concurrently creates or destroys a preserved HWPT during
>this window, nr_hwpts will change, and the second pass will hit:
>WARN_ON(iommufd_lu && iommufd_lu->nr_hwpts != nr_hwpts)
>
>I'm not sure if that's a situation to WARN? Also, what about kernels
>which have panic_on_warn?
>
>> +	if (rc < 0)
>> +		goto err_free;
>> +
>> +	args->serialized_data = virt_to_phys(iommufd_lu);
>> +	iommufd_ctx_put(ictx);
>> +	return 0;
>> +
>> +err_free:
>> +	kho_unpreserve_free(mem);
>> +err_ioas_mutable:
>> +	iommufd_set_ioas_mutable(ictx);
>> +	iommufd_ctx_put(ictx);
>> +	return rc;
>> +}
>> +
>> +static int iommufd_liveupdate_freeze(struct liveupdate_file_op_args *args)
>> +{
>> +	/* No-Op; everything should be made read-only */
>
>Is there a plan to populate this in a future series? If it's a permanent
>No-Op because the lu_map_immutable flag already handles the read-only
>enforcement during the preserve phase, we should probably update the
>comment to explicitly state that, rather than implying there is missing
>logic?

Agreed. Will update the comment.
>
>> +	return 0;
>> +}
>> +
>
>[ ---- >8 ----- ]
>
>> diff --git a/include/linux/kho/abi/iommufd.h b/include/linux/kho/abi/iommufd.h
>> new file mode 100644
>> index 000000000000..f7393ac78aa9
>> --- /dev/null
>> +++ b/include/linux/kho/abi/iommufd.h
>> @@ -0,0 +1,39 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +/*
>> + * Copyright (C) 2025, Google LLC
>> + * Author: Samiullah Khawaja <skhawaja@google.com>
>> + */
>> +
>> +#ifndef _LINUX_KHO_ABI_IOMMUFD_H
>> +#define _LINUX_KHO_ABI_IOMMUFD_H
>> +
>> +#include <linux/mutex_types.h>
>> +#include <linux/compiler.h>
>> +#include <linux/types.h>
>> +
>> +/**
>> + * DOC: IOMMUFD Live Update ABI
>> + *
>> + * This header defines the ABI for preserving the state of an IOMMUFD file
>> + * across a kexec reboot using LUO.
>> + *
>> + * This interface is a contract. Any modification to any of the serialization
>> + * structs defined here constitutes a breaking change. Such changes require
>> + * incrementing the version number in the IOMMUFD_LUO_COMPATIBLE string.
>> + */
>> +
>> +#define IOMMUFD_LUO_COMPATIBLE "iommufd-v1"
>> +
>> +struct iommufd_hwpt_lu {
>> +	u32 token;
>> +	u64 domain_data;
>> +	bool reclaimed;
>> +} __packed;
>> +
>
>Nit: Because of __packed, putting the u64 after the u32 forces an
>unaligned 8-byte access at offset 4. Also, it's generally safer to use
>explicitly sized types like u8 instead of bool for cross-kernel ABI
>structs to avoid any compiler-specific sizing ambiguities. (This is the
>reason most uAPI defs avoid using bool)
>
>We can achieve natural alignment without implicit padding by ordering it
>from largest to smallest and explicitly padding it out:
>
>struct iommufd_hwpt_lu {
>	__u64 domain_data;
>	__u32 token;
>	__u8 reclaimed;
>	__u8 padding[3];
>} __packed;
>
>This guarantees an exact 16-byte footprint with perfectly aligned 64-bit
>and 32-bit accesses.
>
>> +struct iommufd_lu {
>> +	unsigned int nr_hwpts;
>> +	struct iommufd_hwpt_lu hwpts[];
>> +};
>
>Same here regarding explicitly sized types and packing (as pointed by
>Vipin too)
>
>> +
>> +#endif /* _LINUX_KHO_ABI_IOMMUFD_H */
>
>Thanks,
>Praan
