Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078942AA5
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 03:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751252991; cv=none; b=IrZEatk+kPnna4FXfbpZKDV0NehpLyqed6ov4h2u4K4zGwlv3xYyP6b9flMOMWy/OUhBzn5aGvj8V/Td/N4Ogk/U6HhAkfZHlGdry4B0NYM4dZ/60R5vuD4zuo+G+EAMGH8O7+frEKvpDtG9Q+TGIK0y05Rkcq/UNmoc11DV2XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751252991; c=relaxed/simple;
	bh=t5JwbbNEl0lnqERUNCit63TPZ7Qwsr0qqua3KN/g6I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aILLfjgmsHigbS1VY/XXHlb+S5doV75eDcNCjVGfvJwX28mvav7r2S2Zo9LPbWoAM9r5Y3iCqNn7F6wzXpGTl6Tp1ymVwFA5c29oBN+l0iYvU+BqWLxeGjoy7TP8Xg3knLPkQutB5NHcrGxLbWFtjkHIWZ3HZLuQTkHy1bUIoYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gz5IdP0F; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gz5IdP0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751252990; x=1782788990;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t5JwbbNEl0lnqERUNCit63TPZ7Qwsr0qqua3KN/g6I8=;
  b=gz5IdP0FyNlrAcUzKrwfP9ccSVpofdSpieN8CrW2FGyBHwDqgj65/UlN
   CfI5bSGXdbt8FZpGVdYzwtKZQfTivcJCDWp96QacIXkRgpd92z+4tsV9O
   9/LGmbfm5RPgkZXSl629X7jVyE5QNFamB3inW+ymEg9U2QJDngExZxM3/
   t/tUdSAV0x+7LOljMl6E5AARTLqzQXO7idim0e+7zYrPCeiQ2se6zJINj
   dkbQtbdJk4d5s7Pd9NOLuYlhgUbZTv5U1IVnF60J0lBbiBajLGaKBvnKb
   Qe2F17R+3luDJ1fcqvzUj9UNmrTkQPf96egjakp/78QWFso9Gx4eldcEI
   A==;
X-CSE-ConnectionGUID: fIadQtCqQMun9cyaRohREw==
X-CSE-MsgGUID: cAvOIMrkRNOsc0WDXf4JJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53591351"
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="53591351"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 20:09:49 -0700
X-CSE-ConnectionGUID: E4oAp4QZRLSUDeJtJj1lsQ==
X-CSE-MsgGUID: 7PAEcqyeQySnkpDCiiggrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="152958221"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 20:09:46 -0700
Message-ID: <b531ec51-625b-4ea0-a0e1-a90c02cb5e8a@linux.intel.com>
Date: Mon, 30 Jun 2025 11:08:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] iommufd: Add iommufd_object_tombstone_user()
 helper
To: Xu Yilun <yilun.xu@linux.intel.com>, jgg@nvidia.com, jgg@ziepe.ca,
 kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
 robin.murphy@arm.com, shuah@kernel.org, nicolinc@nvidia.com, aik@amd.com,
 dan.j.williams@intel.com, yilun.xu@intel.com
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-2-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250627033809.1730752-2-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/25 11:38, Xu Yilun wrote:
> Add the iommufd_object_tombstone_user() helper, which allows the caller
> to destroy an iommufd object created by userspace.
> 
> This is useful on some destroy paths when the kernel caller finds the
> object should have been removed by userspace but is still alive. With
> this helper, the caller destroys the object but leave the object ID
> reserved (so called tombstone). The tombstone prevents repurposing the
> object ID without awareness of the original user.
> 
> Since this happens for abnomal userspace behavior, for simplicity, the
> tombstoned object ID would be permanently leaked until
> iommufd_fops_release(). I.e. the original user gets an error when
> calling ioctl(IOMMU_DESTROY) on that ID.
> 
> The first use case would be to ensure the iommufd_vdevice can't outlive
> the associated iommufd_device.
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Co-developed-by: Aneesh Kumar K.V (Arm)<aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm)<aneesh.kumar@kernel.org>
> Signed-off-by: Xu Yilun<yilun.xu@linux.intel.com>
> ---
>   drivers/iommu/iommufd/iommufd_private.h | 23 ++++++++++++++++++++++-
>   drivers/iommu/iommufd/main.c            | 19 ++++++++++++++++---
>   2 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 9ccc83341f32..fbc9ef78d81f 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -187,7 +187,8 @@ void iommufd_object_finalize(struct iommufd_ctx *ictx,
>   			     struct iommufd_object *obj);
>   
>   enum {
> -	REMOVE_WAIT_SHORTTERM = 1,
> +	REMOVE_WAIT_SHORTTERM	= BIT(0),
> +	REMOVE_OBJ_TOMBSTONE	= BIT(1),
>   };
>   int iommufd_object_remove(struct iommufd_ctx *ictx,
>   			  struct iommufd_object *to_destroy, u32 id,
> @@ -213,6 +214,26 @@ static inline void iommufd_object_destroy_user(struct iommufd_ctx *ictx,
>   	WARN_ON(ret);
>   }
>   
> +/*
> + * Similar to iommufd_object_destroy_user(), except that the object ID is left
> + * reserved/tombstoned.
> + */
> +static inline void iommufd_object_tombstone_user(struct iommufd_ctx *ictx,
> +						 struct iommufd_object *obj)
> +{
> +	int ret;
> +
> +	ret = iommufd_object_remove(ictx, obj, obj->id,
> +				    REMOVE_WAIT_SHORTTERM | REMOVE_OBJ_TOMBSTONE);
> +
> +	/*
> +	 * If there is a bug and we couldn't destroy the object then we did put
> +	 * back the caller's users refcount and will eventually try to free it
> +	 * again during close.
> +	 */
> +	WARN_ON(ret);
> +}
> +
>   /*
>    * The HWPT allocated by autodomains is used in possibly many devices and
>    * is automatically destroyed when its refcount reaches zero.
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 3df468f64e7d..620923669b42 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -167,7 +167,7 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
>   		goto err_xa;
>   	}
>   
> -	xas_store(&xas, NULL);
> +	xas_store(&xas, (flags & REMOVE_OBJ_TOMBSTONE) ? XA_ZERO_ENTRY : NULL);
>   	if (ictx->vfio_ioas == container_of(obj, struct iommufd_ioas, obj))
>   		ictx->vfio_ioas = NULL;
>   	xa_unlock(&ictx->objects);
> @@ -239,6 +239,7 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
>   	struct iommufd_sw_msi_map *next;
>   	struct iommufd_sw_msi_map *cur;
>   	struct iommufd_object *obj;
> +	bool empty;
>   
>   	/*
>   	 * The objects in the xarray form a graph of "users" counts, and we have
> @@ -249,23 +250,35 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
>   	 * until the entire list is destroyed. If this can't progress then there
>   	 * is some bug related to object refcounting.
>   	 */
> -	while (!xa_empty(&ictx->objects)) {
> +	for (;;) {
>   		unsigned int destroyed = 0;
>   		unsigned long index;
>   
> +		empty = true;
>   		xa_for_each(&ictx->objects, index, obj) {
> +			empty = false;

People like me, who don't know the details of how xa_for_each() and
xa_empty() work, will ask why "empty = xa_empty()" isn't used here. So
it's better to add some comments to make it more readable.

/* XA_ZERO_ENTRY is treated as a null entry by xa_for_each(). */

Others look good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

>   			if (!refcount_dec_if_one(&obj->users))
>   				continue;
> +
>   			destroyed++;
>   			xa_erase(&ictx->objects, index);
>   			iommufd_object_ops[obj->type].destroy(obj);
>   			kfree(obj);
>   		}
> +
> +		if (empty)
> +			break;
> +
>   		/* Bug related to users refcount */
>   		if (WARN_ON(!destroyed))
>   			break;
>   	}

Thanks,
baolu
