Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9171D5ACE
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 05:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751260202; cv=none; b=k7JjxLotjMU82/vyGQIyS7JkOClGspC9+BT4vOxe5yDs+1LI4PBhE+oLAPDTiX/OkjN/qu7nPeNQOa0nPfvtkCKYWquPvWCj2hmeU5kzybaHY4TbaDaZkkJLuG6M97rnkMOZTFDVBaZu1rElOdrd13WtIlMb+oZbokTSOE+Ful0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751260202; c=relaxed/simple;
	bh=JWjmnMSXqklq9IN9cj/a+e53I1kMdgV5VDC4jVZ/pek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSQjCQGiGcHr5/0tUprdLXUwK7VN7y6F4YJt7d7oNMxcCZU6iVXVou8ba62Q7AwT8G2dd544Es/H9yF+3/pk7jskZMOPNJIQO/A6nAEI/aUhGrQntwLWaecOxGqWcoWWHytyNVPEjfW1D8Uuooi6c7aTXCrulaIvU4KAkxrKFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tpog0BUF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tpog0BUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751260200; x=1782796200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JWjmnMSXqklq9IN9cj/a+e53I1kMdgV5VDC4jVZ/pek=;
  b=Tpog0BUF1xMSofIU8gh49/C7IL1S3f2yEn7dvmDxSHSS+tVhy/IIdLJ0
   uV1WPWj8Rah58rVEOMmpF9WAZmrlaF2JrhADrnFiTz6pqxS7T52Amro6E
   C54H9qPIg0tPJUgAYWcbpSLOH4ujKetdS8/gLFJD8vf8K3LWlEimtuH3m
   Z6qCjxZfaOkc40TZkMYuccwD8vCpH5QHPefwQ7SwzlEvNB0AwAGhoIqqa
   NKBXcF3wjZR+fdcagL60tdqXao1GRyirgeGu0sbIy2tdgK+RBvcCHlM/O
   R9zAyTr0CTmBHBvL7iHjvn8//Nj5Ol5yVxb8bjgcKojH5cP6pz66i97aw
   g==;
X-CSE-ConnectionGUID: ywAJnxAVSi6c43jZEEDocQ==
X-CSE-MsgGUID: kkpR2OjrSgWGQT+qIV4F9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="57252711"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="57252711"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 22:10:00 -0700
X-CSE-ConnectionGUID: xF8RxM6vRBy0C1z/ly1kgA==
X-CSE-MsgGUID: lzGPO34hSdmxEwo1n0DoJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="153659062"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 22:09:56 -0700
Message-ID: <b5b84208-e43c-483e-838b-c42375d3bada@linux.intel.com>
Date: Mon, 30 Jun 2025 13:08:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
To: Xu Yilun <yilun.xu@linux.intel.com>, jgg@nvidia.com, jgg@ziepe.ca,
 kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
 robin.murphy@arm.com, shuah@kernel.org, nicolinc@nvidia.com, aik@amd.com,
 dan.j.williams@intel.com, yilun.xu@intel.com
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-3-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250627033809.1730752-3-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/25 11:38, Xu Yilun wrote:
> Destroy iommufd_vdevice (vdev) on iommufd_idevice (idev) destroy so
> that vdev can't outlive idev.
> 
> iommufd_device (idev) represents the physical device bound to iommufd,
> while the iommufd_vdevice (vdev) represents the virtual instance of the
> physical device in the VM. The lifecycle of the vdev should not be
> longer than idev. This doesn't cause real problem on existing use cases
> cause vdev doesn't impact the physical device, only provides
> virtualization information. But to extend vdev for Confidential
> Computing (CC), there are needs to do secure configuration for the vdev,
> e.g. TSM Bind/Unbind. These configurations should be rolled back on idev
> destroy, or the external driver (VFIO) functionality may be impact.
> 
> Building the association between idev & vdev requires the two objects
> pointing each other, but not referencing each other. This requires
> proper locking. This is done by reviving some of Nicolin's patch [1].
> 
> There are 3 cases on idev destroy:
> 
>    1. vdev is already destroyed by userspace. No extra handling needed.
>    2. vdev is still alive. Use iommufd_object_tombstone_user() to
>       destroy vdev and tombstone the vdev ID.
>    3. vdev is being destroyed by userspace. The vdev ID is already freed,
>       but vdev destroy handler is not completed. Destroy the vdev
>       immediately. To solve the racing with userspace destruction, make
>       iommufd_vdevice_abort() reentrant.
> 
> [1]:https://lore.kernel.org/ 
> all/53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com/
> 
> Originally-by: Nicolin Chen<nicolinc@nvidia.com>
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Co-developed-by: Aneesh Kumar K.V (Arm)<aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm)<aneesh.kumar@kernel.org>
> Signed-off-by: Xu Yilun<yilun.xu@linux.intel.com>
> ---
>   drivers/iommu/iommufd/device.c          | 42 +++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h | 11 +++++++
>   drivers/iommu/iommufd/main.c            |  1 +
>   drivers/iommu/iommufd/viommu.c          | 44 +++++++++++++++++++++++--
>   4 files changed, 95 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 86244403b532..0937d4989185 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -137,11 +137,53 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
>   	}
>   }
>   
> +static void iommufd_device_remove_vdev(struct iommufd_device *idev)
> +{
> +	struct iommufd_vdevice *vdev;
> +
> +	mutex_lock(&idev->igroup->lock);
> +	/* vdev has been completely destroyed by userspace */
> +	if (!idev->vdev)
> +		goto out_unlock;
> +
> +	vdev = iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
> +	if (IS_ERR(vdev)) {
> +		/*
> +		 * vdev is removed from xarray by userspace, but is not
> +		 * destroyed/freed. Since iommufd_vdevice_abort() is reentrant,
> +		 * safe to destroy vdev here.
> +		 */
> +		iommufd_vdevice_abort(&idev->vdev->obj);
> +		goto out_unlock;
> +	}
> +
> +	/* Should never happen */
> +	if (WARN_ON(vdev != idev->vdev)) {
> +		iommufd_put_object(idev->ictx, &vdev->obj);
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * vdev is still alive. Hold a users refcount to prevent racing with
> +	 * userspace destruction, then use iommufd_object_tombstone_user() to
> +	 * destroy it and leave a tombstone.
> +	 */
> +	refcount_inc(&vdev->obj.users);
> +	iommufd_put_object(idev->ictx, &vdev->obj);
> +	mutex_unlock(&idev->igroup->lock);
> +	iommufd_object_tombstone_user(idev->ictx, &vdev->obj);
> +	return;
> +
> +out_unlock:
> +	mutex_unlock(&idev->igroup->lock);
> +}
> +
>   void iommufd_device_destroy(struct iommufd_object *obj)
>   {
>   	struct iommufd_device *idev =
>   		container_of(obj, struct iommufd_device, obj);
>   
> +	iommufd_device_remove_vdev(idev);
>   	iommu_device_release_dma_owner(idev->dev);
>   	iommufd_put_group(idev->igroup);
>   	if (!iommufd_selftest_is_mock_dev(idev->dev))
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index fbc9ef78d81f..f58aa4439c53 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -446,6 +446,7 @@ struct iommufd_device {
>   	/* always the physical device */
>   	struct device *dev;
>   	bool enforce_cache_coherency;
> +	struct iommufd_vdevice *vdev;
>   };
>   
>   static inline struct iommufd_device *
> @@ -621,6 +622,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
>   void iommufd_viommu_destroy(struct iommufd_object *obj);
>   int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
>   void iommufd_vdevice_destroy(struct iommufd_object *obj);
> +void iommufd_vdevice_abort(struct iommufd_object *obj);
>   
>   struct iommufd_vdevice {
>   	struct iommufd_object obj;
> @@ -628,8 +630,17 @@ struct iommufd_vdevice {
>   	struct iommufd_viommu *viommu;
>   	struct device *dev;
>   	u64 id; /* per-vIOMMU virtual ID */
> +	struct iommufd_device *idev;
>   };
>   
> +static inline struct iommufd_vdevice *
> +iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
> +{
> +	return container_of(iommufd_get_object(ictx, id,
> +					       IOMMUFD_OBJ_VDEVICE),
> +			    struct iommufd_vdevice, obj);
> +}
> +
>   #ifdef CONFIG_IOMMUFD_TEST
>   int iommufd_test(struct iommufd_ucmd *ucmd);
>   void iommufd_selftest_destroy(struct iommufd_object *obj);
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 620923669b42..64731b4fdbdf 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -529,6 +529,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
>   	},
>   	[IOMMUFD_OBJ_VDEVICE] = {
>   		.destroy = iommufd_vdevice_destroy,
> +		.abort = iommufd_vdevice_abort,
>   	},
>   	[IOMMUFD_OBJ_VEVENTQ] = {
>   		.destroy = iommufd_veventq_destroy,
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 01df2b985f02..632d1d7b8fd8 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -84,16 +84,38 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>   	return rc;
>   }
>   
> -void iommufd_vdevice_destroy(struct iommufd_object *obj)
> +void iommufd_vdevice_abort(struct iommufd_object *obj)
>   {
>   	struct iommufd_vdevice *vdev =
>   		container_of(obj, struct iommufd_vdevice, obj);
>   	struct iommufd_viommu *viommu = vdev->viommu;
> +	struct iommufd_device *idev = vdev->idev;
> +
> +	lockdep_assert_held(&idev->igroup->lock);
> +
> +	/*
> +	 * iommufd_vdevice_abort() could be reentrant, by
> +	 * iommufd_device_unbind() or by iommufd_destroy(). Cleanup only once.
> +	 */
> +	if (!viommu)
> +		return;
>   
>   	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
>   	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
>   	refcount_dec(&viommu->obj.users);
>   	put_device(vdev->dev);
> +	vdev->viommu = NULL;
> +	idev->vdev = NULL;

I feel it makes more sense to reorder the operations like this:

	vdev->viommu = NULL;
	vdev->idev = NULL;
	idev->vdev = NULL;
	put_device(vdev->dev);

put_device(vdev->dev) could potentially trigger other code paths that
might attempt to reference vdev or its associated pointers. Therefore,
it's safer to null all the relevant reference pointers before calling
put_device().

Others look good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu
