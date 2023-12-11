Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D74CDFB
	for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chIFSCY7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702314309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vf61yoq47ivJlsZLQPeNQqLuBRNn9/vpoIvzy095ZJA=;
	b=chIFSCY75sbRrZEGJVrcpOYr/jQNUD6nidzfvlJOYIwwyLTMCZRmYJiQfqtS/RZHi7Z4qJ
	ZwcN2ZCkZzk+dXnKWxVbUrbBstqCCE5++ofJjr2KkBtdFQv8pq+fyRCB2TKf2LX0rgcEA/
	PXvOMu1qgxx7T0A4d0V8i/Ak6gs34uw=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-AXdiu4BkNt-F2wYghkbtvA-1; Mon, 11 Dec 2023 12:05:07 -0500
X-MC-Unique: AXdiu4BkNt-F2wYghkbtvA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1fb34e3da36so8233107fac.1
        for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 09:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702314306; x=1702919106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vf61yoq47ivJlsZLQPeNQqLuBRNn9/vpoIvzy095ZJA=;
        b=aQ1txve1LKpY9MtwIMI/zmVnuzg/9+DrcMOVkgu8YUZ9Z/cuM3xy+kSqpC03ZMnVUD
         lplcvHCq3vM1M65N0rKK/i3ejyfh23sSJe9ZzVn3Zg9d2IPm5hpw+BrMNhKsO3mn0cLs
         MuIGfbCSdIFQ61aBDZ9g5rIB15uzrRag3hZuJaPpJCncWWcprM+lua+hLXvVPRUIq589
         yYe3E/tyslgD3zPxskpkON4zAxL/BtqteBEnmN6D8XHAmM3tkDgDGa4OYT95yQkMHbqa
         cFLagUXSh1EnhMPacLgvEUN+cK1TStZ0cBCl4ubhbmMLiP3/737/uULu4Nqrlwa5ei4N
         uKbg==
X-Gm-Message-State: AOJu0YwEtpHrJFqTfHfrWItuek5UB4lH0JEQzCKXWX1UptFuR++X8zJ4
	iPCVixlvkEl+La+sp6GOSVBwZgyz9aiCLMfgEKRMk28srSFF2Ybl2WvrxeQY89F5dk6zq7HR03Z
	BWbGBBqEWsmWbGSQ=
X-Received: by 2002:a05:6870:f80a:b0:1fb:75a:c427 with SMTP id fr10-20020a056870f80a00b001fb075ac427mr4985660oab.80.1702314306443;
        Mon, 11 Dec 2023 09:05:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFhrETJonEXrQjlh2mPHiZP3//QFKXmo58R+PKFDFVyI6IF3dcDP9kAOwdekNmdu56hvOvRw==
X-Received: by 2002:a05:6870:f80a:b0:1fb:75a:c427 with SMTP id fr10-20020a056870f80a00b001fb075ac427mr4985640oab.80.1702314306116;
        Mon, 11 Dec 2023 09:05:06 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id hf15-20020a0568707a0f00b001fae2d2630dsm2514301oab.18.2023.12.11.09.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:05:05 -0800 (PST)
Date: Mon, 11 Dec 2023 10:05:01 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
 robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
 yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
 shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com, xin.zeng@intel.com,
 yan.y.zhao@intel.com
Subject: Re: [PATCH 2/3] vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
Message-ID: <20231211100501.1c4032ce.alex.williamson@redhat.com>
In-Reply-To: <20231127063909.129153-3-yi.l.liu@intel.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
	<20231127063909.129153-3-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
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

On Sun, 26 Nov 2023 22:39:08 -0800
Yi Liu <yi.l.liu@intel.com> wrote:

> This adds ioctls for the userspace to attach a given pasid of a vfio
> device to/from an IOAS/HWPT.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/device_cdev.c | 45 +++++++++++++++++++++++++++++++
>  drivers/vfio/vfio.h        |  4 +++
>  drivers/vfio/vfio_main.c   |  8 ++++++
>  include/uapi/linux/vfio.h  | 55 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 112 insertions(+)
> 
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index e75da0a70d1f..c2ac7ed44537 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -210,6 +210,51 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
>  	return 0;
>  }
>  
> +int vfio_df_ioctl_pasid_attach_pt(struct vfio_device_file *df,
> +				  struct vfio_device_pasid_attach_iommufd_pt __user *arg)
> +{
> +	struct vfio_device *device = df->device;
> +	struct vfio_device_pasid_attach_iommufd_pt attach;
> +	unsigned long minsz;
> +	int ret;
> +
> +	minsz = offsetofend(struct vfio_device_pasid_attach_iommufd_pt, pt_id);
> +
> +	if (copy_from_user(&attach, arg, minsz))
> +		return -EFAULT;
> +
> +	if (attach.argsz < minsz || attach.flags)
> +		return -EINVAL;
> +
> +	mutex_lock(&device->dev_set->lock);
> +	ret = device->ops->pasid_attach_ioas(device, attach.pasid, &attach.pt_id);

These callbacks were only implemented for vfio-pci in the previous
patch but they're called unconditionally.  Thanks,

Alex

> +	mutex_unlock(&device->dev_set->lock);
> +
> +	return ret;
> +}
> +
> +int vfio_df_ioctl_pasid_detach_pt(struct vfio_device_file *df,
> +				  struct vfio_device_pasid_detach_iommufd_pt __user *arg)
> +{
> +	struct vfio_device *device = df->device;
> +	struct vfio_device_pasid_detach_iommufd_pt detach;
> +	unsigned long minsz;
> +
> +	minsz = offsetofend(struct vfio_device_pasid_detach_iommufd_pt, flags);
> +
> +	if (copy_from_user(&detach, arg, minsz))
> +		return -EFAULT;
> +
> +	if (detach.argsz < minsz || detach.flags)
> +		return -EINVAL;
> +
> +	mutex_lock(&device->dev_set->lock);
> +	device->ops->pasid_detach_ioas(device, detach.pasid);
> +	mutex_unlock(&device->dev_set->lock);
> +
> +	return 0;
> +}
> +
>  static char *vfio_device_devnode(const struct device *dev, umode_t *mode)
>  {
>  	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 307e3f29b527..d228cdb6b345 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -353,6 +353,10 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
>  			    struct vfio_device_attach_iommufd_pt __user *arg);
>  int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
>  			    struct vfio_device_detach_iommufd_pt __user *arg);
> +int vfio_df_ioctl_pasid_attach_pt(struct vfio_device_file *df,
> +				  struct vfio_device_pasid_attach_iommufd_pt __user *arg);
> +int vfio_df_ioctl_pasid_detach_pt(struct vfio_device_file *df,
> +				  struct vfio_device_pasid_detach_iommufd_pt __user *arg);
>  
>  #if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)
>  void vfio_init_device_cdev(struct vfio_device *device);
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 8d4995ada74a..ff50c239873d 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1240,6 +1240,14 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
>  		case VFIO_DEVICE_DETACH_IOMMUFD_PT:
>  			ret = vfio_df_ioctl_detach_pt(df, uptr);
>  			goto out;
> +
> +		case VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT:
> +			ret = vfio_df_ioctl_pasid_attach_pt(df, uptr);
> +			goto out;
> +
> +		case VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT:
> +			ret = vfio_df_ioctl_pasid_detach_pt(df, uptr);
> +			goto out;
>  		}
>  	}
>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 94b3badefde3..495193629029 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -977,6 +977,61 @@ struct vfio_device_detach_iommufd_pt {
>  
>  #define VFIO_DEVICE_DETACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 20)
>  
> +/*
> + * VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 21,
> + *					      struct vfio_device_pasid_attach_iommufd_pt)
> + * @argsz:	User filled size of this data.
> + * @flags:	Must be 0.
> + * @pasid:	The pasid to be attached.
> + * @pt_id:	Input the target id which can represent an ioas or a hwpt
> + *		allocated via iommufd subsystem.
> + *		Output the input ioas id or the attached hwpt id which could
> + *		be the specified hwpt itself or a hwpt automatically created
> + *		for the specified ioas by kernel during the attachment.
> + *
> + * Associate a pasid (of a cdev device) with an address space within the
> + * bound iommufd. Undo by VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT or device fd
> + * close. This is only allowed on cdev fds.
> + *
> + * If a pasid is currently attached to a valid hw_pagetable (hwpt), without
> + * doing a VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT, a second
> + * VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT ioctl passing in another hwpt id is
> + * allowed. This action, also known as a hwpt replacement, will replace the
> + * pasid's currently attached hwpt with a new hwpt corresponding to the given
> + * @pt_id.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vfio_device_pasid_attach_iommufd_pt {
> +	__u32	argsz;
> +	__u32	flags;
> +	__u32	pasid;
> +	__u32	pt_id;
> +};
> +
> +#define VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT	_IO(VFIO_TYPE, VFIO_BASE + 21)
> +
> +/*
> + * VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 22,
> + *					      struct vfio_device_pasid_detach_iommufd_pt)
> + * @argsz:	User filled size of this data.
> + * @flags:	Must be 0.
> + * @pasid:	The pasid to be detached.
> + *
> + * Remove the association of a pasid (of a cdev device) and its current
> + * associated address space.  After it, the pasid of the device should be in
> + * a blocking DMA state.  This is only allowed on cdev fds.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vfio_device_pasid_detach_iommufd_pt {
> +	__u32	argsz;
> +	__u32	flags;
> +	__u32	pasid;
> +};
> +
> +#define VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT	_IO(VFIO_TYPE, VFIO_BASE + 22)
> +
>  /*
>   * Provide support for setting a PCI VF Token, which is used as a shared
>   * secret between PF and VF drivers.  This feature may only be set on a

