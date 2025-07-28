Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8A822E004
	for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753736162; cv=none; b=FA05ZNYT+jfmGBuDVEk5+Ld+os9hisxrwCGzM4l7B4PdLzgBPdFeGpPG93lcf1NeGu5TfSRKcRcyFlCXFQBZbZUWmniBBPR3n6ZZGtFWp/q2EYZE2ZITodqaOVUwrd8kNYivZh0BOfnEQu6HePN08dmja6XZdhRnnq+JbDeUhj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753736162; c=relaxed/simple;
	bh=nRpzG9wCRVLX56km469LJwsErSpZhF+6HuuhqwgnJd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P32C4VBmeNI6oX4jfeTiRNx6xDpWfWfPGVstqgUSQ1yWM2Scr9rZWoEzOHgnzvUalBXGN8eGyuCf/UxOk7balsv7z8xcqcgf4KzyntCQN01Y0FAmzjMhkZtUdVh9G1XlgxD2ctfRTz5Cah57Mg8ib0T4UZHVJFydq4OVtMw9ouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BksYy3et; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BksYy3et"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753736159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lAhpTjpbvFQu27uIQ7LZXIQUIKIfZHhU7pyfNlOjpc=;
	b=BksYy3etYjW8K7sUTxLeFPie7KXRx9gJQ/sRIXOQjL/L9ALBu5I2yr4R5f4NiDCtD5+PvE
	CKuTKYDC+hk1I9vxXzZZqsl4FgjlHMko4Uu8bw/QIZZlBIvxkvkHi/jV1nMNHpPmujxv/e
	Tuu4KvgWYUSB2iogdIyG/pXMEShBn8M=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-1hVsLsfeMwuYvtJ4D1W2Hg-1; Mon, 28 Jul 2025 16:55:58 -0400
X-MC-Unique: 1hVsLsfeMwuYvtJ4D1W2Hg-1
X-Mimecast-MFC-AGG-ID: 1hVsLsfeMwuYvtJ4D1W2Hg_1753736157
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df359a108bso11012015ab.3
        for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 13:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753736157; x=1754340957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lAhpTjpbvFQu27uIQ7LZXIQUIKIfZHhU7pyfNlOjpc=;
        b=Q6U+TcLQbxy3ahkC9zNBKFMDyQH6ZpKtrL6SHc7GtZwgfc25YiQB8UH/17Cwu6Pdcr
         jNjKrCh1xlFIylLbaL6DDmiL1zZ+gjeFB3RFMT6Uu83aTePgQbreiN9hre2MpESCr5OQ
         UvlXgdY5s/9z9b9t+vvF3H7bV/mmd3lKGeQPZTYtXqNxxf5mr4fMskzBLvMfIqFhaOAT
         VHsP9nDaNHBmYsmGQK1SVSSUlo67b7SqMg4HUfN/uXyGQ9UAkbvL6lKV+vDMytQ4M3hu
         vOIQtJLPKHy+x1VU4JrqOAwx6Soge6L5VzDe3Cwg2E8Ea290FyzDBr5ZcgyiRvN1OuIw
         g5OA==
X-Forwarded-Encrypted: i=1; AJvYcCUJcQEmcTYzdMaIo6zUX8oJrsxoveicIb/tll2zartBmVH2sU6N5wR0yrY/Wb/ZLUjhF+mZhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWgDTlHkEeU6n9zJVcyT630NDK6TCRCsjvAFxXMn5FUhyy9AuH
	Nu523FCOoU1vMD2t0lOV0X3wDVRF5dwaDtiGwpj9hmul3G7XYI4l+MNBNp63vFb3HFBv4aYJ5MO
	t/mPPnAe1wv64P0hlkrKR8oSE9aEvh4b/el1OlhG4BYTvo3oaWCNy3XAw
X-Gm-Gg: ASbGncuL+La84mhqWupYNh+Rd4IJflNuQLQ4aCwBM1reJ2YK//idCpYPCk99XJNcA2Z
	JeHn3lO9EgySZegA93bIe25pTnq6GGc3ZdOFKq2VVf5l976ZVxae9LMUVOqY3kfdYloY3y1tdJY
	FPw49dEbPU+iTuRSI2FSVGWx30a+ENRHsndeXdm2VJFdVDJ/DnOTUNe8dm4eKcXq9Bm86D2/0TF
	uMEh6clPRFwE7WNel5rv6UbxrVTkHnqKKfCy2Szz5WGn4SyNJKBFJkU4P/FCDIj8ebg01L6gZhn
	wljwfS2S3VjJnV/VkqHtru9lYBD26hH29tzO58FHvA4=
X-Received: by 2002:a05:6e02:3389:b0:3e3:e461:4617 with SMTP id e9e14a558f8ab-3e3e4614777mr12699045ab.2.1753736157518;
        Mon, 28 Jul 2025 13:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaMLNGgu4ToITqnk/t+y4I2RkNZuq3J6YSgL+Stwkf8Y5Ta3HhAl493hrL7HwiUxfbSIOjGA==
X-Received: by 2002:a05:6e02:3389:b0:3e3:e461:4617 with SMTP id e9e14a558f8ab-3e3e4614777mr12698925ab.2.1753736157034;
        Mon, 28 Jul 2025 13:55:57 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c9341e4csm2109194173.76.2025.07.28.13.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:55:55 -0700 (PDT)
Date: Mon, 28 Jul 2025 14:55:53 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>, Christoph Hellwig
 <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, Jens Axboe
 <axboe@kernel.dk>, =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, Logan Gunthorpe
 <logang@deltatee.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin
 Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>, Will
 Deacon <will@kernel.org>
Subject: Re: [PATCH 09/10] vfio/pci: Share the core device pointer while
 invoking feature functions
Message-ID: <20250728145553.53e94d49.alex.williamson@redhat.com>
In-Reply-To: <19f71a0f4d1a5db8c712cb4d094ccf2f10dc22c5.1753274085.git.leonro@nvidia.com>
References: <cover.1753274085.git.leonro@nvidia.com>
	<19f71a0f4d1a5db8c712cb4d094ccf2f10dc22c5.1753274085.git.leonro@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XANEG1dL3lolNtFOPNkVhdNjJuaRwdOeOODKvOQXsIc_1753736157
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 16:00:10 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Vivek Kasireddy <vivek.kasireddy@intel.com>
> 
> There is no need to share the main device pointer (struct vfio_device *)
> with all the feature functions as they only need the core device
> pointer. Therefore, extract the core device pointer once in the
> caller (vfio_pci_core_ioctl_feature) and share it instead.
> 
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 1e675daab5753..5512d13bb8899 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -301,11 +301,9 @@ static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
>  	return 0;
>  }
>  
> -static int vfio_pci_core_pm_entry(struct vfio_device *device, u32 flags,
> +static int vfio_pci_core_pm_entry(struct vfio_pci_core_device *vdev, u32 flags,
>  				  void __user *arg, size_t argsz)
>  {
> -	struct vfio_pci_core_device *vdev =
> -		container_of(device, struct vfio_pci_core_device, vdev);
>  	int ret;
>  
>  	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, 0);
> @@ -322,12 +320,10 @@ static int vfio_pci_core_pm_entry(struct vfio_device *device, u32 flags,
>  }
>  
>  static int vfio_pci_core_pm_entry_with_wakeup(
> -	struct vfio_device *device, u32 flags,
> +	struct vfio_pci_core_device *vdev, u32 flags,
>  	struct vfio_device_low_power_entry_with_wakeup __user *arg,
>  	size_t argsz)

I'm tempted to fix the line wrapping here, but I think this patch
stands on its own.  Even if it's rather trivial, it makes sense to
consolidate and standardize on the vfio_pci_core_device getting passed
around within vfio_pci_core.c.  Any reason not to split this off?
Thanks,

Alex

>  {
> -	struct vfio_pci_core_device *vdev =
> -		container_of(device, struct vfio_pci_core_device, vdev);
>  	struct vfio_device_low_power_entry_with_wakeup entry;
>  	struct eventfd_ctx *efdctx;
>  	int ret;
> @@ -378,11 +374,9 @@ static void vfio_pci_runtime_pm_exit(struct vfio_pci_core_device *vdev)
>  	up_write(&vdev->memory_lock);
>  }
>  
> -static int vfio_pci_core_pm_exit(struct vfio_device *device, u32 flags,
> +static int vfio_pci_core_pm_exit(struct vfio_pci_core_device *vdev, u32 flags,
>  				 void __user *arg, size_t argsz)
>  {
> -	struct vfio_pci_core_device *vdev =
> -		container_of(device, struct vfio_pci_core_device, vdev);
>  	int ret;
>  
>  	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, 0);
> @@ -1475,11 +1469,10 @@ long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_ioctl);
>  
> -static int vfio_pci_core_feature_token(struct vfio_device *device, u32 flags,
> -				       uuid_t __user *arg, size_t argsz)
> +static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
> +				       u32 flags, uuid_t __user *arg,
> +				       size_t argsz)
>  {
> -	struct vfio_pci_core_device *vdev =
> -		container_of(device, struct vfio_pci_core_device, vdev);
>  	uuid_t uuid;
>  	int ret;
>  
> @@ -1506,16 +1499,19 @@ static int vfio_pci_core_feature_token(struct vfio_device *device, u32 flags,
>  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  				void __user *arg, size_t argsz)
>  {
> +	struct vfio_pci_core_device *vdev =
> +		container_of(device, struct vfio_pci_core_device, vdev);
> +
>  	switch (flags & VFIO_DEVICE_FEATURE_MASK) {
>  	case VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY:
> -		return vfio_pci_core_pm_entry(device, flags, arg, argsz);
> +		return vfio_pci_core_pm_entry(vdev, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY_WITH_WAKEUP:
> -		return vfio_pci_core_pm_entry_with_wakeup(device, flags,
> +		return vfio_pci_core_pm_entry_with_wakeup(vdev, flags,
>  							  arg, argsz);
>  	case VFIO_DEVICE_FEATURE_LOW_POWER_EXIT:
> -		return vfio_pci_core_pm_exit(device, flags, arg, argsz);
> +		return vfio_pci_core_pm_exit(vdev, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_PCI_VF_TOKEN:
> -		return vfio_pci_core_feature_token(device, flags, arg, argsz);
> +		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>  	default:
>  		return -ENOTTY;
>  	}

