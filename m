Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57DD18CC11
	for <iommu@lists.linux.dev>; Fri, 27 Sep 2024 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727445061; cv=none; b=PgH4TKhPBiL675vhpiYLdo5FBVdOBw+Z0xHrJYQFAHRlT5YKvZHJFtyPcwTKyoWufo47xUANTeJNd5W1m4jtbiTd9cUd4MO/SZ6gyZbLIqcYiEH4x/YdTXhIPYfshLqMzNxxzBRade5ON8fgvY5GuztTPS88BrFaVgqDvT/gJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727445061; c=relaxed/simple;
	bh=ZPVUm3ywQ6FI2H6TG/nRldosfyxx1+wOOj4hQa8ViiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQLdPkmHe0Yqo+cCiZcxuFMhOzy35SVz+zfW+63Vge4fMTce/NE1fkG9o58JYq1kzqL4wBRlDh7LsPe1N/kkhI1T9TOdYENh7gjrJ0VQRmekClqCwyJ9BvBpr7wdC/fU7B4CKkkeKE3VLZIKHH6xeQhtgF93xsQ+7Fr6tl7R51U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4IDh1DzO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4IDh1DzO"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-536552fcc07so20614e87.1
        for <iommu@lists.linux.dev>; Fri, 27 Sep 2024 06:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727445058; x=1728049858; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zzx6oozJdX/kfg2gPAt8X0HRxrMRG20NImzc+qe9leg=;
        b=4IDh1DzOQfZetpOmVEiQaljSRS5ImkPoWSaFwWTqWHETvzG5oKV/Kq7ponjdXFrlVn
         eRjEV08xjOPckMEAR5lHJ10M10NQo+UlRjqrh9WZsvRpUIsqtKh4Ih+SxYiu9qptDjqk
         PF/YmAMHROaTQCBKEzY919el1TxZZVpd1p7MLbbV1oBl15rQ4zS3yCXWxYMKaOt3SJg6
         8W4CE3xOu1o65HMZ/CtDUhzVv+0sRi0jO7vR0vkgkNHGdsPyLTiurgSEhJ0bhPg9snM4
         fkmFqajPOzceXh1eFLfHO8f5o82dSemyw8hQ5kQA0xIFyKEV3Zt0Re1W7Vnm4jyREkRj
         tc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727445058; x=1728049858;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zzx6oozJdX/kfg2gPAt8X0HRxrMRG20NImzc+qe9leg=;
        b=b2ApPJ19w016LtIKR+sDRxR3qaG6v8zg4YLHfeCpPpCdlmu4J6GC44e6lEyrcCf1mn
         cLrSLMClfzHU7o2iwg/4uUb7ZZPnGCYKqFz3qwqwmE0iXkL5WSIbjs2cQW6EAGQuJOLM
         U9SBVwCj/CJTIHm6I7oSRrokiuPEveHl/NBJkv8DCaVaKS7A8Q0YRlya0whOPXVUIr/0
         +BLTo0/FNWUUpF0IMt5/XZzEnXOMK4quZ8rrUn24/7EveKtvNlKrzMY6wfZWZEAdzMkw
         K/tZ7DI4dNX0g5Yr/KyG0sfuJi9SqwUJaQy9jlpBktZjxPiLpsDSFU3jdL6RO5arx7sx
         7Tgg==
X-Forwarded-Encrypted: i=1; AJvYcCWxMbRDBugiNmQK6sJtZUthwV2Ad657WEWfp2gJQecxAvNy3HbEzW3ul2yPhX5SVAdLIsUERg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyczm3GMzdyQIfguk7YUlQGIK/KwaDTVvvAXSRKUmcVQWgXm/RF
	N7xJ/N9MBsl3Zvd7GNJIqWoHQ2w56csymz/McmqQQUwHAZXphBk8r4BSUuk5Dw==
X-Google-Smtp-Source: AGHT+IE4cquSMqnSIkNOYvzP4mf+EjxpWo+6lvqw1vEYhgsv6NYFCxWx7JURpC+N3lnj/vz+qtEIhQ==
X-Received: by 2002:a05:6512:3da7:b0:52e:8475:7c23 with SMTP id 2adb3069b0e04-5394bb84da1mr324032e87.7.1727445057592;
        Fri, 27 Sep 2024 06:50:57 -0700 (PDT)
Received: from google.com (105.93.155.104.bc.googleusercontent.com. [104.155.93.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969f2083sm74362305e9.15.2024.09.27.06.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 06:50:57 -0700 (PDT)
Date: Fri, 27 Sep 2024 13:50:52 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, yi.l.liu@intel.com
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <Zva4PJ3FhpMlWxhF@google.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>

Hi Nicolin,

On Tue, Aug 27, 2024 at 09:59:43AM -0700, Nicolin Chen wrote:
> Introduce a pair of new ioctls to set/unset a per-viommu virtual device id
> that should be linked to a physical device id via an idev pointer.
> 
> Continue the support IOMMU_VIOMMU_TYPE_DEFAULT for a core-managed viommu.
> Provide a lookup function for drivers to load device pointer by a virtual
> device id.
> 
> Add a rw_semaphore protection around the vdev_id list. Any future ioctl
> handlers that potentially access the list must grab the lock too.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/device.c          |  12 +++
>  drivers/iommu/iommufd/iommufd_private.h |  21 ++++
>  drivers/iommu/iommufd/main.c            |   6 ++
>  drivers/iommu/iommufd/viommu.c          | 121 ++++++++++++++++++++++++
>  include/uapi/linux/iommufd.h            |  40 ++++++++
>  5 files changed, 200 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 5fd3dd420290..3ad759971b32 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -136,6 +136,18 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>  	struct iommufd_device *idev =
>  		container_of(obj, struct iommufd_device, obj);
>  
> +	/* Unlocked since there should be no race in a destroy() */
> +	if (idev->vdev_id) {
> +		struct iommufd_vdev_id *vdev_id = idev->vdev_id;
> +		struct iommufd_viommu *viommu = vdev_id->viommu;
> +		struct iommufd_vdev_id *old;
> +
> +		old = xa_cmpxchg(&viommu->vdev_ids, vdev_id->id, vdev_id, NULL,
> +				 GFP_KERNEL);
> +		WARN_ON(old != vdev_id);
> +		kfree(vdev_id);
> +		idev->vdev_id = NULL;
> +	}
>  	iommu_device_release_dma_owner(idev->dev);
>  	iommufd_put_group(idev->igroup);
>  	if (!iommufd_selftest_is_mock_dev(idev->dev))
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 1f2a1c133b9a..2c6e168c5300 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -416,6 +416,7 @@ struct iommufd_device {
>  	struct iommufd_object obj;
>  	struct iommufd_ctx *ictx;
>  	struct iommufd_group *igroup;
> +	struct iommufd_vdev_id *vdev_id;
>  	struct list_head group_item;
>  	/* always the physical device */
>  	struct device *dev;
> @@ -533,11 +534,31 @@ struct iommufd_viommu {
>  	struct iommufd_ctx *ictx;
>  	struct iommufd_hwpt_paging *hwpt;
>  
> +	/* The locking order is vdev_ids_rwsem -> igroup::lock */
> +	struct rw_semaphore vdev_ids_rwsem;
> +	struct xarray vdev_ids;
> +
>  	unsigned int type;
>  };
>  
> +struct iommufd_vdev_id {
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	u64 id;
> +};
> +
> +static inline struct iommufd_viommu *
> +iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
> +{
> +	return container_of(iommufd_get_object(ucmd->ictx, id,
> +					       IOMMUFD_OBJ_VIOMMU),
> +			    struct iommufd_viommu, obj);
> +}
> +
>  int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
>  void iommufd_viommu_destroy(struct iommufd_object *obj);
> +int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd);
> +int iommufd_viommu_unset_vdev_id(struct iommufd_ucmd *ucmd);
>  
>  #ifdef CONFIG_IOMMUFD_TEST
>  int iommufd_test(struct iommufd_ucmd *ucmd);
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 288ee51b6829..199ad90fa36b 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -334,6 +334,8 @@ union ucmd_buffer {
>  	struct iommu_option option;
>  	struct iommu_vfio_ioas vfio_ioas;
>  	struct iommu_viommu_alloc viommu;
> +	struct iommu_viommu_set_vdev_id set_vdev_id;
> +	struct iommu_viommu_unset_vdev_id unset_vdev_id;
>  #ifdef CONFIG_IOMMUFD_TEST
>  	struct iommu_test_cmd test;
>  #endif
> @@ -387,6 +389,10 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>  		 __reserved),
>  	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>  		 struct iommu_viommu_alloc, out_viommu_id),
> +	IOCTL_OP(IOMMU_VIOMMU_SET_VDEV_ID, iommufd_viommu_set_vdev_id,
> +		 struct iommu_viommu_set_vdev_id, vdev_id),
> +	IOCTL_OP(IOMMU_VIOMMU_UNSET_VDEV_ID, iommufd_viommu_unset_vdev_id,
> +		 struct iommu_viommu_unset_vdev_id, vdev_id),
>  #ifdef CONFIG_IOMMUFD_TEST
>  	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
>  #endif
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 200653a4bf57..8ffcd72b16b8 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -8,6 +8,15 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
>  {
>  	struct iommufd_viommu *viommu =
>  		container_of(obj, struct iommufd_viommu, obj);
> +	struct iommufd_vdev_id *vdev_id;
> +	unsigned long index;
> +
> +	xa_for_each(&viommu->vdev_ids, index, vdev_id) {
> +		/* Unlocked since there should be no race in a destroy() */
> +		vdev_id->idev->vdev_id = NULL;
> +		kfree(vdev_id);
> +	}
> +	xa_destroy(&viommu->vdev_ids);
>  
>  	refcount_dec(&viommu->hwpt->common.obj.users);
>  }
> @@ -53,6 +62,9 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	viommu->ictx = ucmd->ictx;
>  	viommu->hwpt = hwpt_paging;
>  
> +	xa_init(&viommu->vdev_ids);
> +	init_rwsem(&viommu->vdev_ids_rwsem);
> +
>  	refcount_inc(&viommu->hwpt->common.obj.users);
>  
>  	cmd->out_viommu_id = viommu->obj.id;
> @@ -70,3 +82,112 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	iommufd_put_object(ucmd->ictx, &idev->obj);
>  	return rc;
>  }
> +
> +int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_viommu_set_vdev_id *cmd = ucmd->cmd;
> +	struct iommufd_vdev_id *vdev_id, *curr;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	int rc = 0;
> +
> +	if (cmd->vdev_id > ULONG_MAX)
> +		return -EINVAL;
> +
> +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu))
> +		return PTR_ERR(viommu);
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev)) {
> +		rc = PTR_ERR(idev);
> +		goto out_put_viommu;
> +	}
> +
> +	down_write(&viommu->vdev_ids_rwsem);
> +	mutex_lock(&idev->igroup->lock);
> +	if (idev->vdev_id) {
> +		rc = -EEXIST;
> +		goto out_unlock_igroup;
> +	}
> +
> +	vdev_id = kzalloc(sizeof(*vdev_id), GFP_KERNEL);
> +	if (!vdev_id) {
> +		rc = -ENOMEM;
> +		goto out_unlock_igroup;
> +	}
> +
> +	vdev_id->idev = idev;
> +	vdev_id->viommu = viommu;
> +	vdev_id->id = cmd->vdev_id;

My understanding of IOMMUFD is very little, but AFAICT, that means that
it’s assumed that each device can only have one stream ID(RID)?

As I can see in patch 17 in arm_smmu_convert_viommu_vdev_id(), it
converts the virtual ID to a physical one using master->streams[0].id.

Is that correct or am I missing something?

As I am looking at similar problem for paravirtual IOMMU with pKVM, where
the UAPI would be something similar to:

	GET_NUM_END_POINTS(dev) => nr_sids

	SET_END_POINT_VSID(dev, sid_index, vsid)

Similar to what VFIO does with IRQs.

As a device can have many SIDs.

Thanks,
Mostafa

> +
> +	curr = xa_cmpxchg(&viommu->vdev_ids, cmd->vdev_id, NULL, vdev_id,
> +			  GFP_KERNEL);
> +	if (curr) {
> +		rc = xa_err(curr) ? : -EBUSY;
> +		goto out_free;
> +	}
> +
> +	idev->vdev_id = vdev_id;
> +	goto out_unlock_igroup;
> +
> +out_free:
> +	kfree(vdev_id);
> +out_unlock_igroup:
> +	mutex_unlock(&idev->igroup->lock);
> +	up_write(&viommu->vdev_ids_rwsem);
> +	iommufd_put_object(ucmd->ictx, &idev->obj);
> +out_put_viommu:
> +	iommufd_put_object(ucmd->ictx, &viommu->obj);
> +	return rc;
> +}
> +
> +int iommufd_viommu_unset_vdev_id(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_viommu_unset_vdev_id *cmd = ucmd->cmd;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_vdev_id *old;
> +	struct iommufd_device *idev;
> +	int rc = 0;
> +
> +	if (cmd->vdev_id > ULONG_MAX)
> +		return -EINVAL;
> +
> +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu))
> +		return PTR_ERR(viommu);
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev)) {
> +		rc = PTR_ERR(idev);
> +		goto out_put_viommu;
> +	}
> +
> +	down_write(&viommu->vdev_ids_rwsem);
> +	mutex_lock(&idev->igroup->lock);
> +	if (!idev->vdev_id) {
> +		rc = -ENOENT;
> +		goto out_unlock_igroup;
> +	}
> +	if (idev->vdev_id->id != cmd->vdev_id) {
> +		rc = -EINVAL;
> +		goto out_unlock_igroup;
> +	}
> +
> +	old = xa_cmpxchg(&viommu->vdev_ids, idev->vdev_id->id,
> +			 idev->vdev_id, NULL, GFP_KERNEL);
> +	if (xa_is_err(old)) {
> +		rc = xa_err(old);
> +		goto out_unlock_igroup;
> +	}
> +	kfree(old);
> +	idev->vdev_id = NULL;
> +
> +out_unlock_igroup:
> +	mutex_unlock(&idev->igroup->lock);
> +	up_write(&viommu->vdev_ids_rwsem);
> +	iommufd_put_object(ucmd->ictx, &idev->obj);
> +out_put_viommu:
> +	iommufd_put_object(ucmd->ictx, &viommu->obj);
> +	return rc;
> +}
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 51ce6a019c34..1816e89c922d 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -52,6 +52,8 @@ enum {
>  	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
>  	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
>  	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
> +	IOMMUFD_CMD_VIOMMU_SET_VDEV_ID = 0x90,
> +	IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID = 0x91,
>  };
>  
>  /**
> @@ -882,4 +884,42 @@ struct iommu_viommu_alloc {
>  	__u32 out_viommu_id;
>  };
>  #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
> +
> +/**
> + * struct iommu_viommu_set_vdev_id - ioctl(IOMMU_VIOMMU_SET_VDEV_ID)
> + * @size: sizeof(struct iommu_viommu_set_vdev_id)
> + * @viommu_id: viommu ID to associate with the device to store its virtual ID
> + * @dev_id: device ID to set its virtual ID
> + * @__reserved: Must be 0
> + * @vdev_id: Virtual device ID
> + *
> + * Set a viommu-specific virtual ID of a device
> + */
> +struct iommu_viommu_set_vdev_id {
> +	__u32 size;
> +	__u32 viommu_id;
> +	__u32 dev_id;
> +	__u32 __reserved;
> +	__aligned_u64 vdev_id;
> +};
> +#define IOMMU_VIOMMU_SET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_SET_VDEV_ID)
> +
> +/**
> + * struct iommu_viommu_unset_vdev_id - ioctl(IOMMU_VIOMMU_UNSET_VDEV_ID)
> + * @size: sizeof(struct iommu_viommu_unset_vdev_id)
> + * @viommu_id: viommu ID associated with the device to delete its virtual ID
> + * @dev_id: device ID to unset its virtual ID
> + * @__reserved: Must be 0
> + * @vdev_id: Virtual device ID (for verification)
> + *
> + * Unset a viommu-specific virtual ID of a device
> + */
> +struct iommu_viommu_unset_vdev_id {
> +	__u32 size;
> +	__u32 viommu_id;
> +	__u32 dev_id;
> +	__u32 __reserved;
> +	__aligned_u64 vdev_id;
> +};
> +#define IOMMU_VIOMMU_UNSET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID)
>  #endif
> -- 
> 2.43.0
> 
