Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21B18FDAC
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754029; cv=none; b=X9TI94eof5+ap8jRkYfox/UkrR5WFXgI/AdqQmB6Qqjt8MXHr5busTV8bUATnnbqzP10dPNAR26YlyGQ+qg2qgniNryUO3IoPr4oc3q9ZlkkpfxxGnimmidq2+71DmnNScgJlMtpU6K/oN7e7zMM52fSnxCNIYJNLxfhWf0zHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754029; c=relaxed/simple;
	bh=fH9DOcZIN6KrouwJ4Na0nIH8hwy6801OQVEMkB3+8/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/wEj6KTbehSbUbOeZYDiTRHCVEw9WkrZpZmH7IyMqOmdCwhYFQJ9Mnk9nPFHUMeGj3qfahxmKdWyt2GLlRM1VFW06TrIt/bVSvvXbRejysdhjG5F02UtlNeQkRsPWOuUqWCUfr8RvrwVmcsvDL7lwzaBqtKIzg6D0beMhl5OWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Beeo+KHf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Beeo+KHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730754025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0kJxxRCCEfEbeQIwL5Mxw8/qanc3RzewdzQ6otXVf4=;
	b=Beeo+KHfMBTfZIVthxDS+94jOD62dFdnOwaoh/f6IxM7WvoMdnWkSY+vq44ks/StxAQK1D
	PHlmteKI1LDt84yKktdZ1xOgvgLzc7PZccFJKw9FKUS6dK4y7ZZjCiJuld5XJ0FGN75mmj
	iCNjqyqTLHtVQA480AudjYUepa+psaE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-Zc4O7-3cOfy1usgAMAGYqQ-1; Mon, 04 Nov 2024 16:00:24 -0500
X-MC-Unique: Zc4O7-3cOfy1usgAMAGYqQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83abdaccdb6so57368039f.0
        for <iommu@lists.linux.dev>; Mon, 04 Nov 2024 13:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754024; x=1731358824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0kJxxRCCEfEbeQIwL5Mxw8/qanc3RzewdzQ6otXVf4=;
        b=nkAnRJsFyipHSJdmGiMrGJQDOAVz4UY34XqZewka7d6j3RXhOGmfO2SrG4jAHRvVmq
         G2lQ0gQD7VxYaldM/lJU7SetFkpFQ173ncM/n4nRr5AbVQ8so6MBCmpa7t4jKemUHO0y
         dZrN3DYwf5o532cy4gq4id3AqbBU+t+cbl9qAQ96jL7TsnIE+2/XNbYV0lP9NbQIurSc
         QlDC0fLwlF5JdHelp2SU6A7Z0DDumhDtSg7b7k8RO6df7S8qpGuFFUIAGo06sxJkM2lG
         b4lmnypx9O0bNJBCWR560y8KpCRgehpPEmmGqKaXwF7dmlYaWJnHW2hj0oxh5BfkbRSO
         ERxg==
X-Forwarded-Encrypted: i=1; AJvYcCWuQQXQVVXLWQdxuPNUenygFs481mR6oI96G4KseaztIC86eYu+jmn6yPAFZvwiVWYHb9y/6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YywHry21j9nt8JVc4tgk2mfAaD7244mA5qULlqXSUvjVSuoIcu4
	gU0chbkSVmXh4+VpoBxtXI0c0/ple2RpwwNSMkS6o0wsqkPfzQzLBDdNHlFZaDmo4ByiRTl9XEl
	/fE0b/5kd4yaju4xCZHJ/6U4uv59OqyLErFyS5gcn5Ih/T3rdMbk4
X-Received: by 2002:a05:6e02:b2d:b0:3a6:ac17:13e3 with SMTP id e9e14a558f8ab-3a6ac1717famr46511115ab.7.1730754023812;
        Mon, 04 Nov 2024 13:00:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbxfUphMg8cgfql51cfo+wxy0qNwJ/yuahw0BRYmuZKEcAns6NGqXZ57E+yi9YGoh/pdar+g==
X-Received: by 2002:a05:6e02:b2d:b0:3a6:ac17:13e3 with SMTP id e9e14a558f8ab-3a6ac1717famr46510805ab.7.1730754023138;
        Mon, 04 Nov 2024 13:00:23 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048be972sm2117119173.45.2024.11.04.13.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:00:22 -0800 (PST)
Date: Mon, 4 Nov 2024 14:00:20 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
 eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, vasant.hegde@amd.com,
 willy@infradead.org
Subject: Re: [PATCH v4 3/4] vfio: VFIO_DEVICE_[AT|DE]TACH_IOMMUFD_PT support
 pasid
Message-ID: <20241104140020.2c98173d.alex.williamson@redhat.com>
In-Reply-To: <20241104132732.16759-4-yi.l.liu@intel.com>
References: <20241104132732.16759-1-yi.l.liu@intel.com>
	<20241104132732.16759-4-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Nov 2024 05:27:31 -0800
Yi Liu <yi.l.liu@intel.com> wrote:

> This extends the VFIO_DEVICE_[AT|DE]TACH_IOMMUFD_PT ioctls to attach/detach
> a given pasid of a vfio device to/from an IOAS/HWPT.
> 
> vfio_copy_from_user() is added to copy the user data for the case in which
> the existing user struct has introduced new fields. The rule is not breaking
> the existing usersapce. The kernel only copies the new fields when the
> corresponding flag is set by the userspace. For the case that has multiple
> new fields marked by different flags, kernel checks the flags one by one to
> get the correct size to copy besides the minsz. Such logics can be shared by
> the other uapi extensions, hence add a helper for it.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/device_cdev.c | 62 +++++++++++++++++++++++++++-----------
>  drivers/vfio/vfio.h        | 18 +++++++++++
>  drivers/vfio/vfio_main.c   | 55 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h  | 29 ++++++++++++------
>  4 files changed, 136 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index bb1817bd4ff3..bd13ddbfb9e3 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -159,24 +159,44 @@ void vfio_df_unbind_iommufd(struct vfio_device_file *df)
>  	vfio_device_unblock_group(device);
>  }
>  
> +#define VFIO_ATTACH_FLAGS_MASK VFIO_DEVICE_ATTACH_PASID
> +static unsigned long
> +vfio_attach_xends[ilog2(VFIO_ATTACH_FLAGS_MASK) + 1] = {
> +	XEND_SIZE(VFIO_DEVICE_ATTACH_PASID,
> +		  struct vfio_device_attach_iommufd_pt, pasid),
> +};
> +
> +#define VFIO_DETACH_FLAGS_MASK VFIO_DEVICE_DETACH_PASID
> +static unsigned long
> +vfio_detach_xends[ilog2(VFIO_DETACH_FLAGS_MASK) + 1] = {
> +	XEND_SIZE(VFIO_DEVICE_DETACH_PASID,
> +		  struct vfio_device_detach_iommufd_pt, pasid),
> +};

Doesn't this rather imply that every valid flag bit indicates some new
structure field?

For example, we start out with:

struct vfio_device_attach_iommufd_pt {
        __u32   argsz;
        __u32   flags;
        __u32   pt_id;
};

And then here it becomes:

struct vfio_device_attach_iommufd_pt {
	__u32	argsz;
	__u32	flags;
#define VFIO_DEVICE_ATTACH_PASID	(1 << 0)
	__u32	pt_id;
	__u32	pasid;
};

What if the next flag is simply related to the processing of @pt_id and
doesn't require @pasid?

The xend array necessarily expands, but what's the value?  Logically it
would be offsetofend(, pt_id), so the array becomes { 16, 12 }.

Similarly, rather than pasid we might have reused a previously
reserved field, for instance what if we already expanded the structure
as:

struct vfio_device_attach_iommufd_pt {
	__u32	argsz;
	__u32	flags;
#define VFIO_DEVICE_ATTACH_FOO		(1 << 0)
	__u32	pt_id;
	__u32	reserved;
	__u64	foo;
};

If we then want to add @pasid, we might really prefer to take advantage
of that reserved field and the array becomes { 24, 16 }.

I think these can work (see below), but this seems like a pretty
complicated generalization.  It might make sense to initially open code
the handling for @pasid with a follow-on patch with this sort of
generalization so we can evaluate them separately.

BTW, don't feel obligated to use "xend" based on my email sample code.

> +
>  int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
>  			    struct vfio_device_attach_iommufd_pt __user *arg)
>  {
> -	struct vfio_device *device = df->device;
>  	struct vfio_device_attach_iommufd_pt attach;
> -	unsigned long minsz;
> +	struct vfio_device *device = df->device;
>  	int ret;
>  
> -	minsz = offsetofend(struct vfio_device_attach_iommufd_pt, pt_id);
> -
> -	if (copy_from_user(&attach, arg, minsz))
> -		return -EFAULT;
> +	ret = VFIO_COPY_USER_DATA((void __user *)arg, &attach,
> +				  struct vfio_device_attach_iommufd_pt,
> +				  pt_id, VFIO_ATTACH_FLAGS_MASK,
> +				  vfio_attach_xends);
> +	if (ret)
> +		return ret;
>  
> -	if (attach.argsz < minsz || attach.flags)
> -		return -EINVAL;
> +	if ((attach.flags & VFIO_DEVICE_ATTACH_PASID) &&
> +	    !device->ops->pasid_attach_ioas)
> +		return -EOPNOTSUPP;
>  
>  	mutex_lock(&device->dev_set->lock);
> -	ret = device->ops->attach_ioas(device, &attach.pt_id);
> +	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
> +		ret = device->ops->pasid_attach_ioas(device, attach.pasid,
> +						     &attach.pt_id);
> +	else
> +		ret = device->ops->attach_ioas(device, &attach.pt_id);
>  	if (ret)
>  		goto out_unlock;
>  
> @@ -198,20 +218,26 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
>  int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
>  			    struct vfio_device_detach_iommufd_pt __user *arg)
>  {
> -	struct vfio_device *device = df->device;
>  	struct vfio_device_detach_iommufd_pt detach;
> -	unsigned long minsz;
> -
> -	minsz = offsetofend(struct vfio_device_detach_iommufd_pt, flags);
> +	struct vfio_device *device = df->device;
> +	int ret;
>  
> -	if (copy_from_user(&detach, arg, minsz))
> -		return -EFAULT;
> +	ret = VFIO_COPY_USER_DATA((void __user *)arg, &detach,
> +				  struct vfio_device_detach_iommufd_pt,
> +				  flags, VFIO_DETACH_FLAGS_MASK,
> +				  vfio_detach_xends);
> +	if (ret)
> +		return ret;
>  
> -	if (detach.argsz < minsz || detach.flags)
> -		return -EINVAL;
> +	if ((detach.flags & VFIO_DEVICE_DETACH_PASID) &&
> +	    !device->ops->pasid_detach_ioas)
> +		return -EOPNOTSUPP;
>  
>  	mutex_lock(&device->dev_set->lock);
> -	device->ops->detach_ioas(device);
> +	if (detach.flags & VFIO_DEVICE_DETACH_PASID)
> +		device->ops->pasid_detach_ioas(device, detach.pasid);
> +	else
> +		device->ops->detach_ioas(device);
>  	mutex_unlock(&device->dev_set->lock);
>  
>  	return 0;
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 50128da18bca..9f081cf01c5a 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -34,6 +34,24 @@ void vfio_df_close(struct vfio_device_file *df);
>  struct vfio_device_file *
>  vfio_allocate_device_file(struct vfio_device *device);
>  
> +int vfio_copy_from_user(void *buffer, void __user *arg,
> +			unsigned long minsz, u32 flags_mask,
> +			unsigned long *xend_array);
> +
> +#define VFIO_COPY_USER_DATA(_arg, _local_buffer, _struct, _min_last,          \
> +			    _flags_mask, _xend_array)                         \
> +	vfio_copy_from_user(_local_buffer, _arg,                              \
> +			    offsetofend(_struct, _min_last) +                \
> +			    BUILD_BUG_ON_ZERO(offsetof(_struct, argsz) !=     \
> +					      0) +                            \
> +			    BUILD_BUG_ON_ZERO(offsetof(_struct, flags) !=     \
> +					      sizeof(u32)),                   \
> +			    _flags_mask, _xend_array)

We have a precedence in vfio_alloc_device() that macros wrapping
functions don't need to be all caps.

> +
> +#define XEND_SIZE(_flag, _struct, _xlast)                                    \
> +	[ilog2(_flag)] = offsetofend(_struct, _xlast) +                      \
> +			 BUILD_BUG_ON_ZERO(_flag == 0)                       \
> +
>  extern const struct file_operations vfio_device_fops;
>  
>  #ifdef CONFIG_VFIO_NOIOMMU
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index a5a62d9d963f..7df94bf121fd 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1694,6 +1694,61 @@ int vfio_dma_rw(struct vfio_device *device, dma_addr_t iova, void *data,
>  }
>  EXPORT_SYMBOL(vfio_dma_rw);
>  
> +/**
> + * vfio_copy_from_user - Copy the user struct that may have extended fields
> + *
> + * @buffer: The local buffer to store the data copied from user
> + * @arg: The user buffer pointer
> + * @minsz: The minimum size of the user struct, it should never bump up.
> + * @flags_mask: The combination of all the falgs defined
> + * @xend_array: The array that stores the xend size for set flags.
> + *
> + * This helper requires the user struct put the argsz and flags fields in
> + * the first 8 bytes.
> + *
> + * Return 0 for success, otherwise -errno
> + */
> +int vfio_copy_from_user(void *buffer, void __user *arg,
> +			unsigned long minsz, u32 flags_mask,
> +			unsigned long *xend_array)
> +{
> +	unsigned long xend = 0;
> +	struct user_header {
> +		u32 argsz;
> +		u32 flags;
> +	} *header;
> +	unsigned long flags;
> +	u32 flag;
> +
> +	if (copy_from_user(buffer, arg, minsz))
> +		return -EFAULT;
> +
> +	header = (struct user_header *)buffer;
> +	if (header->argsz < minsz)
> +		return -EINVAL;
> +
> +	if (header->flags & ~flags_mask)
> +		return -EINVAL;
> +
> +	/* Loop each set flag to decide the xend */
> +	flags = header->flags;
> +	for_each_set_bit(flag, &flags, BITS_PER_LONG) {

I suppose it doesn't matter, but there's a logical inconsistency
searching BITS_PER_LONG on a buffer initialized by a u32.

> +		if (xend_array[flag])

Given the earlier concern, this should be:

		if (xend_array[flags] > xend)

Thanks,
Alex

> +			xend = xend_array[flag];
> +	}
> +
> +	if (xend) {
> +		if (header->argsz < xend)
> +			return -EINVAL;
> +
> +		if (copy_from_user(buffer + minsz,
> +				   arg + minsz, xend - minsz))
> +			return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Module/class support
>   */
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 2b68e6cdf190..40b414e642f5 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -931,29 +931,34 @@ struct vfio_device_bind_iommufd {
>   * VFIO_DEVICE_ATTACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 19,
>   *					struct vfio_device_attach_iommufd_pt)
>   * @argsz:	User filled size of this data.
> - * @flags:	Must be 0.
> + * @flags:	Flags for attach.
>   * @pt_id:	Input the target id which can represent an ioas or a hwpt
>   *		allocated via iommufd subsystem.
>   *		Output the input ioas id or the attached hwpt id which could
>   *		be the specified hwpt itself or a hwpt automatically created
>   *		for the specified ioas by kernel during the attachment.
> + * @pasid:	The pasid to be attached, only meaningful when
> + *		VFIO_DEVICE_ATTACH_PASID is set in @flags
>   *
>   * Associate the device with an address space within the bound iommufd.
>   * Undo by VFIO_DEVICE_DETACH_IOMMUFD_PT or device fd close.  This is only
>   * allowed on cdev fds.
>   *
> - * If a vfio device is currently attached to a valid hw_pagetable, without doing
> - * a VFIO_DEVICE_DETACH_IOMMUFD_PT, a second VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl
> - * passing in another hw_pagetable (hwpt) id is allowed. This action, also known
> - * as a hw_pagetable replacement, will replace the device's currently attached
> - * hw_pagetable with a new hw_pagetable corresponding to the given pt_id.
> + * If a vfio device or a pasid of this device is currently attached to a valid
> + * hw_pagetable (hwpt), without doing a VFIO_DEVICE_DETACH_IOMMUFD_PT, a second
> + * VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl passing in another hwpt id is allowed.
> + * This action, also known as a hw_pagetable replacement, will replace the
> + * currently attached hwpt of the device or the pasid of this device with a new
> + * hwpt corresponding to the given pt_id.
>   *
>   * Return: 0 on success, -errno on failure.
>   */
>  struct vfio_device_attach_iommufd_pt {
>  	__u32	argsz;
>  	__u32	flags;
> +#define VFIO_DEVICE_ATTACH_PASID	(1 << 0)
>  	__u32	pt_id;
> +	__u32	pasid;
>  };
>  
>  #define VFIO_DEVICE_ATTACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 19)
> @@ -962,17 +967,21 @@ struct vfio_device_attach_iommufd_pt {
>   * VFIO_DEVICE_DETACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 20,
>   *					struct vfio_device_detach_iommufd_pt)
>   * @argsz:	User filled size of this data.
> - * @flags:	Must be 0.
> + * @flags:	Flags for detach.
> + * @pasid:	The pasid to be detached, only meaningful when
> + *		VFIO_DEVICE_DETACH_PASID is set in @flags
>   *
> - * Remove the association of the device and its current associated address
> - * space.  After it, the device should be in a blocking DMA state.  This is only
> - * allowed on cdev fds.
> + * Remove the association of the device or a pasid of the device and its current
> + * associated address space.  After it, the device or the pasid should be in a
> + * blocking DMA state.  This is only allowed on cdev fds.
>   *
>   * Return: 0 on success, -errno on failure.
>   */
>  struct vfio_device_detach_iommufd_pt {
>  	__u32	argsz;
>  	__u32	flags;
> +#define VFIO_DEVICE_DETACH_PASID	(1 << 0)
> +	__u32	pasid;
>  };
>  
>  #define VFIO_DEVICE_DETACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 20)

