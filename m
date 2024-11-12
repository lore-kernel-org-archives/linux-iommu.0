Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1CB3C0B
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369796; cv=none; b=F2fKbMzDI3Zhoj4Yiur6kmxJTK20ZEKaRuJn+u0ViNKe2JCmY7YZ1zOyjEO5nIiX2pygmi6PTUUOP4FzvFHFUmZxrld1TYfn5rsuqYNBiPgaPFgIRVTtJeAkZfW26L1qz9EAdzeDTaJ1YJElRBfGkT27A42bHHF4KQUFRBQvFtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369796; c=relaxed/simple;
	bh=LnXyPKY2IyZxYBCdDm3Lz+iKuwOmQlzw6lO505QTA64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ux4ng2eZ84Rb6br9siLxhRaUP5DmTiGyeNtSQzSaOvkLYzx1Ez9hrkXjyn0q/BLPOYe8tOYFMB8wCphACpJmxDsBh2x1v4PaG0tNVohSuy4urAlTa44Jsz+hrXrmaCBAgNvIZWmYErk2SpYhOXYrIh547sv99T6c5iwCihyfpkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXEGaZon; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXEGaZon"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731369792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3pBdOWCPRmncVQk4ueck/gairwtTj/00dz1e3lH3oI=;
	b=GXEGaZon6NhE0mWc63vPH8bBDD0gKaHD3CFTDpiAra9GpXxn7KYBbceIaop2O8sJ5/wA6N
	NYzqcxwAUFniYALN2UBmaxkH5bQ36RLJwgbV6BnIWhDAus5xWUFvGk1xGQjKrU2A5Pjtld
	2wJ/cj5bRjMaijYdMqb7OWXdwrOnP74=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-fU2sWAmHPeWpEzUXGdIP_Q-1; Mon, 11 Nov 2024 19:03:11 -0500
X-MC-Unique: fU2sWAmHPeWpEzUXGdIP_Q-1
X-Mimecast-MFC-AGG-ID: fU2sWAmHPeWpEzUXGdIP_Q
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aa8c7edb7so26451339f.3
        for <iommu@lists.linux.dev>; Mon, 11 Nov 2024 16:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731369791; x=1731974591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3pBdOWCPRmncVQk4ueck/gairwtTj/00dz1e3lH3oI=;
        b=lYlTRM+wselDwTkdI/W7T/Y02EPnXaDo4nI8xd23UL9dux0sWMcYpkrAuHewM97VPC
         9/5SztzPy08bTiTYSTMN791YH3RlqgeJ252b4bi2/HSmCG+kRfdL8ImH0TKeMnxTBH1a
         kbppqrW6UMUFv1QoHy+odwm6b8pCLAqF8SdLYt2ESrprJcrQiSeKW0fKo1WRfPzrsV4b
         J/lhcLWLlxpAU0aBFgR3WnFiOQPPGAWFcM75oxoueOEYmFxgxJvB1iQo0usXd3WedsVL
         kTWhoUiHsrHm1A9lv5siKzLzI4X/48/r5u9/E0dmvSJ/5Roz44yDMpzQWNXpcZBHX883
         3bIg==
X-Forwarded-Encrypted: i=1; AJvYcCXZhI/6YhJdW83Y1zSmKuvNmoM6SjLKvjEHQfTybFTnVdJaTze80Uj4ddiQC9sAwkAVT8h3Og==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+5cFNkIJ/rejIXaE2JWWm1MKu+GlTRMWOUOpyQsK3EzoXvFwV
	Ygb/PZ0OeOXrfP5+DGu3tZxA5jFZwUMjYB6lo9G0WDg/Ox8riEdfhp4N43ODRSi4gAA6F8/EaQg
	3XAw59P4HQ7ICBeLYOwcN7Wsv2qala546zM7UPKPhYTAoPluSfchi
X-Received: by 2002:a05:6e02:1fc9:b0:3a0:9c8e:9647 with SMTP id e9e14a558f8ab-3a6f198ae93mr44116275ab.1.1731369790785;
        Mon, 11 Nov 2024 16:03:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSfv9JNmgETpx4sRcFf2+uMjT/XRUSwgIK+TUgZlYDRMx0/JaQ+HFFjfQsVdnrQsm/GKYoxg==
X-Received: by 2002:a05:6e02:1fc9:b0:3a0:9c8e:9647 with SMTP id e9e14a558f8ab-3a6f198ae93mr44116095ab.1.1731369790191;
        Mon, 11 Nov 2024 16:03:10 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6f98437b9sm17573635ab.38.2024.11.11.16.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 16:03:09 -0800 (PST)
Date: Mon, 11 Nov 2024 17:03:08 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, baolu.lu@linux.intel.com,
 joro@8bytes.org, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com, will@kernel.org
Subject: Re: [PATCH v5 4/5] vfio: Add vfio_copy_user_data()
Message-ID: <20241111170308.0a14160f.alex.williamson@redhat.com>
In-Reply-To: <20241108121742.18889-5-yi.l.liu@intel.com>
References: <20241108121742.18889-1-yi.l.liu@intel.com>
	<20241108121742.18889-5-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lLpiFUgLlw0fqbDve4Ih867e4SqGz41C9v3gsil3luc_1731369791
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Nov 2024 04:17:41 -0800
Yi Liu <yi.l.liu@intel.com> wrote:

> This generalizes the logic of copying user data when the user struct
> Have new fields introduced. The helpers can be used by the vfio uapis
> that have the argsz and flags fields in the beginning 8 bytes.
> 
> As an example, the vfio_device_{at|de}tach_iommufd_pt paths are updated
> to use the helpers.
> 
> The flags may be defined to mark a new field in the structure, reuse
> reserved fields, or special handling of an existing field. The extended
> size would differ for different flags. Each user API that wants to use
> the generalized helpers should define an array to store the corresponding
> extended sizes for each defined flag.
> 
> For example, we start out with the below, minsz is 12.
> 
>   struct vfio_foo_struct {
>   	__u32   argsz;
>   	__u32   flags;
>   	__u32   pt_id;
>   };
> 
> And then here it becomes:
> 
>   struct vfio_foo_struct {
>   	__u32   argsz;
>   	__u32   flags;
>   #define VFIO_FOO_STRUCT_PASID   (1 << 0)
>   	__u32   pt_id;
>   	__u32   pasid;
>   };
> 
> The array is { 16 }.
> 
> If the next flag is simply related to the processing of @pt_id and
> doesn't require @pasid, then the extended size of the new flag is
> 12. The array become { 16, 12 }
> 
>   struct vfio_foo_struct {
>   	__u32   argsz;
>   	__u32   flags;
>   #define VFIO_FOO_STRUCT_PASID   (1 << 0)
>   #define VFIO_FOO_STRUCT_SPECICAL_PTID   (1 << 1)
>   	__u32   pt_id;
>   	__u32   pasid;
>   };
> 
> Similarly, rather than adding new field, we might have reused a previously
> reserved field, for instance what if we already expanded the structure
> as the below, array is already { 24 }.
> 
>   struct vfio_foo_struct {
>   	__u32   argsz;
>   	__u32   flags;
>   #define VFIO_FOO_STRUCT_XXX     (1 << 0)
>   	__u32   pt_id;
>   	__u32   reserved;
>   	__u64   xxx;
>   };
> 
> If we then want to add @pasid, we might really prefer to take advantage
> of that reserved field and the array becomes { 24, 16 }.
> 
>   struct vfio_foo_struct {
>   	__u32   argsz;
>   	__u32   flags;
>   #define VFIO_FOO_STRUCT_XXX     (1 << 0)
>   #define VFIO_FOO_STRUCT_PASID   (1 << 1)
>   	__u32   pt_id;
>   	__u32   reserved;

I think this was supposed to be s/reserved/pasid/

>   	__u64   xxx;
>   };
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/device_cdev.c | 81 +++++++++++++-------------------------
>  drivers/vfio/vfio.h        | 18 +++++++++
>  drivers/vfio/vfio_main.c   | 55 ++++++++++++++++++++++++++
>  3 files changed, 100 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index 4519f482e212..35c7664b9a97 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -159,40 +159,33 @@ void vfio_df_unbind_iommufd(struct vfio_device_file *df)
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
> +
>  int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
>  			    struct vfio_device_attach_iommufd_pt __user *arg)
>  {
>  	struct vfio_device_attach_iommufd_pt attach;
>  	struct vfio_device *device = df->device;
> -	unsigned long minsz, xend = 0;
>  	int ret;
>  
> -	minsz = offsetofend(struct vfio_device_attach_iommufd_pt, pt_id);
> -
> -	if (copy_from_user(&attach, arg, minsz))
> -		return -EFAULT;
> -
> -	if (attach.argsz < minsz)
> -		return -EINVAL;
> -
> -	if (attach.flags & (~VFIO_DEVICE_ATTACH_PASID))
> -		return -EINVAL;
> -
> -	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
> -		xend = offsetofend(struct vfio_device_attach_iommufd_pt, pasid);
> -
> -	/*
> -	 * xend may be equal to minsz if a flag is defined for reusing a
> -	 * reserved field or a special usage of an existing field.
> -	 */
> -	if (xend > minsz) {
> -		if (attach.argsz < xend)
> -			return -EINVAL;
> -
> -		if (copy_from_user((void *)&attach + minsz,
> -				   (void __user *)arg + minsz, xend - minsz))
> -			return -EFAULT;
> -	}
> +	ret = vfio_copy_user_data((void __user *)arg, &attach,
> +				  struct vfio_device_attach_iommufd_pt,
> +				  pt_id, VFIO_ATTACH_FLAGS_MASK,
> +				  vfio_attach_xends);
> +	if (ret)
> +		return ret;
>  
>  	if ((attach.flags & VFIO_DEVICE_ATTACH_PASID) &&
>  	    !device->ops->pasid_attach_ioas)
> @@ -227,34 +220,14 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
>  {
>  	struct vfio_device_detach_iommufd_pt detach;
>  	struct vfio_device *device = df->device;
> -	unsigned long minsz, xend = 0;
> -
> -	minsz = offsetofend(struct vfio_device_detach_iommufd_pt, flags);
> -
> -	if (copy_from_user(&detach, arg, minsz))
> -		return -EFAULT;
> -
> -	if (detach.argsz < minsz)
> -		return -EINVAL;
> -
> -	if (detach.flags & (~VFIO_DEVICE_DETACH_PASID))
> -		return -EINVAL;
> -
> -	if (detach.flags & VFIO_DEVICE_DETACH_PASID)
> -		xend = offsetofend(struct vfio_device_detach_iommufd_pt, pasid);
> -
> -	/*
> -	 * xend may be equal to minsz if a flag is defined for reusing a
> -	 * reserved field or a special usage of an existing field.
> -	 */
> -	if (xend > minsz) {
> -		if (detach.argsz < xend)
> -			return -EINVAL;
> +	int ret;
>  
> -		if (copy_from_user((void *)&detach + minsz,
> -				   (void __user *)arg + minsz, xend - minsz))
> -			return -EFAULT;
> -	}
> +	ret = vfio_copy_user_data((void __user *)arg, &detach,
> +				  struct vfio_device_detach_iommufd_pt,
> +				  flags, VFIO_DETACH_FLAGS_MASK,
> +				  vfio_detach_xends);
> +	if (ret)
> +		return ret;
>  
>  	if ((detach.flags & VFIO_DEVICE_DETACH_PASID) &&
>  	    !device->ops->pasid_detach_ioas)
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 50128da18bca..87bed550c46e 100644
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
> +#define vfio_copy_user_data(_arg, _local_buffer, _struct, _min_last,          \
> +			    _flags_mask, _xend_array)                         \
> +	vfio_copy_from_user(_local_buffer, _arg,                              \
> +			    offsetofend(_struct, _min_last) +                \
> +			    BUILD_BUG_ON_ZERO(offsetof(_struct, argsz) !=     \
> +					      0) +                            \
> +			    BUILD_BUG_ON_ZERO(offsetof(_struct, flags) !=     \
> +					      sizeof(u32)),                   \
> +			    _flags_mask, _xend_array)
> +
> +#define XEND_SIZE(_flag, _struct, _xlast)                                    \
> +	[ilog2(_flag)] = offsetofend(_struct, _xlast) +                      \
> +			 BUILD_BUG_ON_ZERO(_flag == 0)                       \
> +
>  extern const struct file_operations vfio_device_fops;
>  
>  #ifdef CONFIG_VFIO_NOIOMMU
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index a5a62d9d963f..c61336ea5123 100644
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
> + * @minsz: The minimum size of the user struct
> + * @flags_mask: The combination of all the falgs defined
> + * @xend_array: The array that stores the xend size for set flags.
> + *
> + * This helper requires the user struct put the argsz and flags fields in
> + * the first 8 bytes.
> + *
> + * Return 0 for success, otherwise -errno
> + */
> +int vfio_copy_from_user(void *buffer, void __user *arg,

This should probably be prefixed with an underscore and note that
callers should use the wrapper function to impose the parameter
checking.

> +			unsigned long minsz, u32 flags_mask,
> +			unsigned long *xend_array)
> +{
> +	unsigned long xend = minsz;
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

I'm already wrestling with whether this is an over engineered solution
to remove a couple dozen lines of mostly duplicate logic between attach
and detach, but a couple points that could make it more versatile:

(1) Test xend_array here:

	if (!xend_array)
		return 0;

(2) Return ssize_t/-errno for the caller to know the resulting copy
size.

> +
> +	/* Loop each set flag to decide the xend */
> +	flags = header->flags;
> +	for_each_set_bit(flag, &flags, BITS_PER_TYPE(u32)) {
> +		if (xend_array[flag] > xend)
> +			xend = xend_array[flag];

Can we craft a BUILD_BUG in the wrapper to test that xend_array is at
least long enough to match the highest bit in flags?  Thanks,

Alex

> +	}
> +
> +	if (xend > minsz) {
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

