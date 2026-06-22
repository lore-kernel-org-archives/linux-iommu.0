Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802722853E0
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782097928; cv=none; b=Rle1w0/mJzLGCcuJnccxlrmiqByN2qws7ZOu2RkobqjqYRv2us2HHkH1cowEHPFz62n/5Lk5LcZNkqKiJ7ESd8VLq11r1vjuG5Rvv1SmvHjw+pdWfqTCTnINzC7eRJiFRm5Ysw0zIB4nWr3zr91vsuIKxS5SLJiY4u83lFsEu9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782097928; c=relaxed/simple;
	bh=zImvOuePFdZg7H+6UnjoJXpQ1HYUUu1uXxUhmcu5Hgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GclzxbGBzOVubYg1jxBMrRZyn145O8urMN+YrbfjGojYBhG71AeJzEdFJgVo4up2WiUjMDBHkEjIlBLo593CjNSRO1hewIY5FtF/KHbgNgBhfFb9PPujEa/cgrP5yc5N2Tjf629EeeFM2qOoEseooYeG9BCQUUrRxtJnZf3jyrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXLS6Wd8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXLS6Wd8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782097927; x=1813633927;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zImvOuePFdZg7H+6UnjoJXpQ1HYUUu1uXxUhmcu5Hgk=;
  b=iXLS6Wd8yG4YXbjl4SPRKMNZCfZdFeb8BvPdDBrjr8aUHkBs6jVzWWC1
   EfN7pH/8XusHuOw7YGN3RZclakehJM9xFAzZIp+2owuVFNNgVAqW0bzC8
   lGdJMPSyNpUj/oR2L82WQlCM7a8+QsWRI41e2HR/tQ+spIJPd6LOCLNp2
   GEyRONJRv//YgkiPVt6tFb7yVzAkuEvQ2F9+hsBSnQ7PmSvuqfJVC90ug
   8ShCTneEpyz/9BPY1I96fklbX4QAfCraUpZqmBEQ4wqGigMui8ILwGY0n
   Sard7FRhZYBJw/1CAqKm3X4D9HAJqHxwyrMEt/jVI5It8nb23O5Q6tDoP
   w==;
X-CSE-ConnectionGUID: ufJ/Y2OGS5uMxNf0ONXjeg==
X-CSE-MsgGUID: M4Wr1algRgShU+kDkbzK0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82917235"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="82917235"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 20:12:06 -0700
X-CSE-ConnectionGUID: Cbb/fnU2QkKb6OW5SH7kpw==
X-CSE-MsgGUID: 0XFVuEElRQ++Vq9NMIZINw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="248959104"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 20:12:01 -0700
Message-ID: <ce3f6eb2-99c4-4582-a11b-a5578b62d401@linux.intel.com>
Date: Mon, 22 Jun 2026 11:10:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/18] iommu: Add APIs to get iommu and device
 preserved state
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-10-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260614233728.2212104-10-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/26 07:37, Samiullah Khawaja wrote:
> The preserved state of the device and IOMMU needs to be fetched during
> shutdown and boot in the next kernel. Add APIs that can be used to fetch
> the preserved state of a device and IOMMU. The APIs will only be used
> during shutdown and after liveupdate so no locking needed.
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/liveupdate.c       | 75 ++++++++++++++++++++++++++++++++
>   include/linux/iommu-liveupdate.h | 31 +++++++++++++
>   2 files changed, 106 insertions(+)
> 
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index 2d782023407d..90750e78cd2a 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -18,6 +18,17 @@
>   #define iommu_max_objs_per_page(_array) \
>   	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
>   
> +#define iommu_liveupdate_for_each_obj(_arr, _obj, _idx)			\
> +	for ((_idx) = 0, (_obj) = (_arr)->objects;			\
> +	     (_idx) < (_arr)->hdr.nr_objects; (_idx)++, (_obj)++)	\
> +		if (((_obj)->hdr.flags & IOMMU_SER_FLAG_DELETED))	\
> +			continue;					\
> +		else
> +
> +#define iommu_liveupdate_for_each_arr(_arr)				\
> +	for (; (_arr); (_arr) = (_arr)->hdr.next_array_phys ?		\
> +	     phys_to_virt((_arr)->hdr.next_array_phys) : NULL)
> +
>   struct iommu_flb_obj {
>   	struct mutex lock;
>   	struct iommu_flb_ser *ser;
> @@ -216,6 +227,70 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>   }
>   EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
>   
> +int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
> +				    void *arg)
> +{
> +	struct iommu_flb_obj *flb_obj;
> +	struct iommu_device_array_ser *array;
> +	struct iommu_device_ser *device_ser;
> +	int ret, idx;
> +
> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return -ENOENT;
> +
> +	if (!flb_obj->ser->device_array_phys)
> +		return -ENOENT;
> +
> +	array = phys_to_virt(flb_obj->ser->device_array_phys);
> +	iommu_liveupdate_for_each_arr(array) {
> +		iommu_liveupdate_for_each_obj(array, device_ser, idx) {
> +			ret = fn(device_ser, arg);
> +			if (ret)
> +				goto out;
> +		}
> +	}
> +
> +out:
> +	liveupdate_flb_put_incoming(&iommu_flb);
> +	return ret;
> +}
> +EXPORT_SYMBOL(iommu_for_each_preserved_device);
> +
> +struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
> +{
> +	struct iommu_hw_ser *iommu_ser = NULL;
> +	struct iommu_hw_array_ser *array;
> +	struct iommu_flb_obj *flb_obj;
> +	int ret, idx;
> +
> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
> +	if (ret == -ENODATA || ret == -ENOENT)
> +		return NULL;
> +
> +	if (ret)
> +		return ERR_PTR(ret);

Why does this helper return both NULL and an ERR_PTR()? Is NULL
considered an error case here? Also, why are -ENODATA and -ENOENT
treated differently?

> +
> +	if (!flb_obj->ser->iommu_array_phys) {
> +		iommu_ser = ERR_PTR(-EINVAL);
> +		goto out;
> +	}
> +
> +	array = phys_to_virt(flb_obj->ser->iommu_array_phys);
> +	iommu_liveupdate_for_each_arr(array) {
> +		iommu_liveupdate_for_each_obj(array, iommu_ser, idx) {
> +			if (iommu_ser->token == token && iommu_ser->type == type)
> +				goto out;
> +		}
> +	}
> +
> +	iommu_ser = NULL;
> +out:
> +	liveupdate_flb_put_incoming(&iommu_flb);
> +	return iommu_ser;
> +}
> +EXPORT_SYMBOL(iommu_get_preserved_data);

These two helpers are intended for use by IOMMU drivers, correct? If so,
please add kernel-doc style comments to document their usage and guide
how drivers should use them.

> +
>   static int alloc_object_ser(void **curr_array_ptr, u64 max_objs)
>   {
>   	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
> diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
> index f9528c94979d..5ad006892cbd 100644
> --- a/include/linux/iommu-liveupdate.h
> +++ b/include/linux/iommu-liveupdate.h
> @@ -13,6 +13,8 @@
>   #include <linux/liveupdate.h>
>   #include <linux/kho/abi/iommu.h>
>   
> +typedef int (*iommu_preserved_device_iter_fn)(struct iommu_device_ser *ser,
> +					      void *arg);
>   #ifdef CONFIG_IOMMU_LIVEUPDATE
>   static inline void *dev_iommu_preserved_state(struct device *dev)
>   {
> @@ -28,6 +30,20 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
>   	return NULL;
>   }
>   
> +static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
> +{
> +	struct iommu_domain_ser *ser;
> +
> +	ser = domain->preserved_state;
> +	if (ser && (ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
> +		return ser;
> +
> +	return NULL;
> +}
> +
> +int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
> +				    void *arg);
> +struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type);
>   int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
>   void iommu_unpreserve_domain(struct iommu_domain *domain);
>   int iommu_preserve_device(struct iommu_domain *domain,
> @@ -44,6 +60,21 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
>   	return NULL;
>   }
>   
> +static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
> +{
> +	return NULL;
> +}
> +
> +static inline int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn, void *arg)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
> +{
> +	return NULL;
> +}
> +
>   static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
>   {
>   	return -EOPNOTSUPP;

Thanks,
baolu
