Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793340190;
	b=p81ASQbogRk06MsVIWDHUs2BNCt1vdRuGrEyYb/+WrL+BahDGABtG8CzJd1A0Dx3GUZt
	 pk8L740Vzq8PL4+2t9wBNX1NFze8HUtkV5pfJivTL2zJG4YdAqrx+TAjJGhLDcHnBaoN3
	 JIhZfb7tAWsff6UUhv7KD/dq2gXTXdmN4ss/kThgeYAJfK+zXeXihhHGjbHnLOKUxozu9
	 6cH/+fX8adOjuCSHRFLuwITYxDYi7q9nRPLb6Uv66Ri98t/U09jONGdoo3MlcoUHS4kFj
	 DX6gxWE9O8xok2MTgEwegpifRC7J1dDRurpPy0yhvOzuWWVEgxM6G0Ooce/mhNo6s5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340190;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=VtcJuCZbkTR1B/dAPiQGQiUlPLtsiDv+mz9ozJRNgs8=;
	b=JbYNOAvuST9oFj8XwAjbUrFMbMIvwPnAlUTtOpFEWzkN5c3MV7mcIHUVf5ZuTZNvMYSZ
	 jKG4gh0xvXgb4JgZsfCeiNskOpDvnjVuioWoNTLi4rUNbuIpm/PHHs0z0SR1s3gWaFoUO
	 DisLjtfUYaJxOxxosnQmu97J6lOJVUus3QE/txl/+5NIixg45BPY9p2+OZ4CSUhVn4Xzm
	 9uS9e24z9M6qAAqqQgHNZPG6GKXOkey0EnO6p4dwGpnImVCi4LZoIXQbypKVryocb+9oo
	 auqXWueYrPwrfVmVHfifXTWRy+DFGFdgPfU+QjLJQu+QFLHJXoSvhHqtJysYvcorj9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MNF3r4Rj;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD6606A31C
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 06:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34BD6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MNF3r4Rj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793340189; x=1824876189;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vkUod3HvNArzznyB/W3yEhAQuKbLtUYUiGRlZqqQ/h4=;
  b=MNF3r4RjNRBz1SyeWA8WlkBvRCWOxSRriJeKM1IMzwW+ObJJAi+F02nM
   FV+7Zjnpt+mVrEOnHvvz1zHU7qlqWkEiPhq3nLc5/0Sj1OoQlpqgeUO13
   b++yE4KuzFG2i8oyqRNR4L5fcjRiDwd77VEDZCfLYLwrjCjjGmdNDmVOb
   pGyyrlPPtLGVKJdVXhmzK1tqQ9Z8AuXuXr+BaUwKZ/PxdrJI9lJVC4W17
   TRsfg2nFCH8lJlwQqFcKxr8QuItp3Ls6ocNh8OS8xcE8cpPu3u3lhNwBg
   mam1TIOBLpfTXKGRoZ5HPCLP3ZfNdLLP3nnCaStNGI5Dt8ySu8AldiAMV
   g==;
X-CSE-ConnectionGUID: bn7z6v7ITb68OtFVqHbN+Q==
X-CSE-MsgGUID: hpTu8ILURpiftgMsXvqAvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2122884"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2122884"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 23:03:08 -0700
X-CSE-ConnectionGUID: H0sUnuwZScqJCN0L146Q2g==
X-CSE-MsgGUID: D4iZkS9vQCuTTp4m4goS+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5485151"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 23:03:04 -0700
Message-ID: <7e73da77-3cd2-491a-9ea2-68263f2b5d71@linux.intel.com>
Date: Fri, 30 Oct 2026 14:03:01 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Pranjal Shrivastava <praan@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma
 <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>,
 Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 08/18] iommu: Add APIs to get iommu and device
 preserved state
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-9-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-9-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
> The preserved state of the device and IOMMU needs to be fetched during
> shutdown and boot in the next kernel. Add APIs that can be used to fetch
> the preserved state of a device and IOMMU. The APIs will only be used
> during shutdown and after liveupdate so no locking needed.
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/liveupdate.c       | 88 ++++++++++++++++++++++++++++++++
>   include/linux/iommu-liveupdate.h | 70 +++++++++++++++++++++++++
>   2 files changed, 158 insertions(+)
> 

[...]

> +
> +/**
> + * iommu_get_preserved_data() - Get preserved data for an IOMMU HW
> + * @token: Token used to preserve this IOMMU HW
> + * @type: IOMMU type in preserved state
> + *
> + * Gets the preserved state of an IOMMU HW using token and the IOMMU type.
> + *
> + * Return: struct iommu_hw_ser on success, NULL if no preserved state found.
> + */
> +struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
> +{
> +	struct iommu_hw_ser *iommu_ser;
> +	struct iommu_flb_obj *flb_obj;
> +	struct kho_block_set_it it;
> +	int ret;
> +
> +	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);

iommu_get_preserved_data() returns the incoming state, while
iommu_preserved_state() returns the outgoing state. The naming is
confusing.

How about using "preserved" for the old kernel before kexec and
"restored" for the new kernel after kexec? For example,
iommu_get_restored_state() would be consistent with
dev_iommu_restored_state() and iommu_domain_restored_state().

> +	if (ret)
> +		return NULL;
> +
> +	iommu_ser_set_for_each(&flb_obj->iommu_set, it, iommu_ser) {
> +		if (iommu_ser->token == token && iommu_ser->type == type)
> +			break;
> +	}
> +
> +	liveupdate_flb_put_incoming(&iommu_flb);
> +	return iommu_ser;
> +}
> +EXPORT_SYMBOL(iommu_get_preserved_data);

Why are different export macros used in the same file?

   EXPORT_SYMBOL(iommu_get_preserved_data);
   EXPORT_SYMBOL_GPL(iommu_preserve_domain);

Should these all be EXPORT_SYMBOL_GPL?

> +
>   /**
>    * iommu_preserve_domain() - Preserve an IOMMU domain across live update
>    * @domain: Domain to preserve
> diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
> index cdf8a82b7f1d..10fcdd41c7a1 100644
> --- a/include/linux/iommu-liveupdate.h
> +++ b/include/linux/iommu-liveupdate.h
> @@ -13,6 +13,16 @@
>   #include <linux/liveupdate.h>
>   #include <linux/kho/abi/iommu.h>
>   
> +/**
> + * iommu_preserved_device_iter_fn - Callback for iterating preserved devices
> + * @ser: Pointer to serialized device state
> + * @arg: User-defined context argument
> + *
> + * Return: 0 to continue iteration, or a negative error code to abort.
> + */
> +typedef int (*iommu_preserved_device_iter_fn)(struct iommu_device_ser *ser,
> +					      void *arg);
> +
>   #ifdef CONFIG_IOMMU_LIVEUPDATE
>   int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
>   void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
> @@ -52,6 +62,46 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
>   	return NULL;
>   }
>   
> +/**
> + * iommu_domain_restored_state() - Get restored state of an IOMMU domain
> + * @domain: Pointer to struct iommu_domain to get restored state of.
> + *
> + * Return: Pointer to restored state on success, NULL on error.
> + */
> +static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
> +{
> +	struct iommu_domain_ser *ser;
> +
> +	ser = domain->domain_ser;
> +	if (ser && (ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
> +		return ser;
> +
> +	return NULL;
> +}
> +
> +/**
> + * dev_iommu_restored_state() - Get restored state of a device
> + * @dev: Target device
> + *
> + * Return: Restored state pointer or NULL.
> + */
> +static inline void *dev_iommu_restored_state(struct device *dev)
> +{
> +	struct iommu_device_ser *ser;
> +
> +	if (!dev->iommu)
> +		return NULL;
> +
> +	ser = READ_ONCE(dev->iommu->device_ser);
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
> @@ -88,6 +138,26 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
>   	return NULL;
>   }
>   
> +static inline void *dev_iommu_restored_state(struct device *dev)
> +{
> +	return NULL;
> +}
> +
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
