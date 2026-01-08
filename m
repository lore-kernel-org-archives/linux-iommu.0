Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB00517A2E8
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767832156; cv=none; b=DB/PYrTuLJwL0bLy6GgYqrffnPiMmvj4G+BdQv5xK/gEwELD4T+dVCkUi7fMrkymxTSgNXmDxkxYE3v6itdV4/hSDOJwRAxeojQZaUAAP1W8p4WXM7KEUZrAi//6hO9HUc80q9f/HYy47y97kKiph5bqOL+XHnLzSzsiJljnMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767832156; c=relaxed/simple;
	bh=y0jt2cE1P+j7rJT+g0xnFsyoSivRTKD6u+xbOgxrqLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYIB7ZywLvpHLi/ZleoVWWVt64ZQYw8AEhlM1JgWqJbDkBXP40eDXjU900751BR6pe1zFpVHyHd0Jfn8/X5zXrcG/rfkc2t8T6RZ8qGXAfZBDqOwpRtJJgPC5UXfqYskHsbT8cfsFfH92HcnHQ65q/VUMvUYf+WnQ4VSTzSGR5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3GwMP73x; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3GwMP73x"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34b75fba315so1856111a91.3
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 16:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767832154; x=1768436954; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcZcyJiLF8HS+AClJpaGIu834K8Vn/IXieYeMs6wTFQ=;
        b=3GwMP73xN2y1TcLHl/WgbtWsq7QubbG7+M2ReXL24lBH/QifPaPXB370R42jbaicWr
         CR8FVh19dXuoEqbJhL4wtjZvfy+7EuN43LYRgY2T4h7XWLFRrxHYyEYBAWOWzh4fcakL
         PJOdgySItgPHrFFP6SPX2BS0Jb2xsCYdwmxh3KcbfduXrjBl6GFB04mc+/O4jKl/f+eU
         4kGti1L7SXb6MEtvZx/USX1vtbws96NQ73JH5u6aZpJXD9blQDfDxeg5qptJznIJHMeb
         fhIvJIdIJZ008WwN/UDG0urEyfV5EPy0Y8AV2OsL1aH4qxLDlPwh1NoVCSsukZ2YoXez
         JpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767832154; x=1768436954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcZcyJiLF8HS+AClJpaGIu834K8Vn/IXieYeMs6wTFQ=;
        b=Lm2zpCHeOabm+ie941hVbNTds+lK7Q+EOiumtuCujr570/h9B1AJ0AOqsHnlvsPGOc
         /PZzXxgij7h57OT5ppRB85oY3b0h8bJZocPYtDwlOf5YDumixarAuhtaQmENDVW1Q/nP
         +P49vMdM0h/HzyAxR9+9Fx9FDeAeWNBgIkHfD0E/5RuWLXkjhg4qmRn6H/Xp6G+zI7/n
         Z0zNg01vbYy4gtBxmr7k4cFfiAq6SyYdia2uqdpII9R/3dwG9H2ZG1lWR+pgW+/tBA+W
         RYkan7xBFza14NxS5YrWyIy/vPBsDC2Gf6fVRyZKvcXgXcVCzHZbrg47bJxQ43k+FnX/
         JFYg==
X-Forwarded-Encrypted: i=1; AJvYcCULVp2UIkl4p5skHJZAyKcIKFscPmOUL8t5bS023G8dDk+v1/YlWIVy4fhCY26ngE/lAQ2Vrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeFwXwuZTSH8rICts9Z5FoGAvLfbGTT2PRfJLk+le5LQ2ywUgC
	WKwDBW+E+23ObtzRmJ2+HA4ibo655L0Am1SqzuTnvX0VOMo7UaRT2pnzcj5r8PT4Pw==
X-Gm-Gg: AY/fxX4DRXd/O7IkQMwlOcky3nsX9V79JLFX4fQ6INkCUJdpyd45/VQQ/8k1J/2cyVB
	/WkzE4V3mNAW0BmonI/hmY4uqpA+2FMpUUD86ZWyGN+CVk4b06u7Bk2daw3Bm/+oypFmTtYQewA
	bs67enfMD36AJTrL4xzBU3AUsL4ocq7Owjcf2WUqFjzlJ+9Y9yDYISNjwQwOMnL/mkTgP5A9xtp
	1oIrNnRPzlDPbPYeRU+/E6ARShMfQr05oYTaIsQTrsNZ5XajGcQmGwyJ/+sy2rfSiGiQkn8qGgC
	t4PpgvoUJpvQn1vh2JN7gSb8a2NkzTg3dUCFxao32S0GJvC1hugmPmg3RU0w7a8sSMmsLpjeTjK
	QxTVgNfmDoq/ttpLRPmqmWbjKdlMClrp4b14KZ/me8TR6nOMMGqLHWfheWK3MBOiPkawHgEmHQq
	vdQtQBv8xK6Pi//copJ7qpwfnPHTeqPdxmxboYr/4ZAEM1
X-Google-Smtp-Source: AGHT+IEbuyNUqlgrsTUnzfoDSdmbkVXotfmsBBmCZod3IqA+XAJ+irVSzdiiPZ+TGJZ2jTg45YSeBQ==
X-Received: by 2002:a17:90b:4b10:b0:340:e529:5572 with SMTP id 98e67ed59e1d1-34f68bcf4aemr3883473a91.8.1767832153895;
        Wed, 07 Jan 2026 16:29:13 -0800 (PST)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fa955f7sm6052768a91.8.2026.01.07.16.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 16:29:13 -0800 (PST)
Date: Thu, 8 Jan 2026 00:29:09 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>
Subject: Re: [PATCH 2/3] vfio: selftests: Add support of creating iommus from
 iommufd
Message-ID: <aV76VWKNxMw2t2kH@google.com>
References: <20260107201800.2486137-1-skhawaja@google.com>
 <20260107201800.2486137-3-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107201800.2486137-3-skhawaja@google.com>

On 2026-01-07 08:17 PM, Samiullah Khawaja wrote:
> Add API to init a struct iommu using an already opened iommufd instance
> and attach devices to it.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  .../vfio/lib/include/libvfio/iommu.h          |  2 +
>  .../lib/include/libvfio/vfio_pci_device.h     |  2 +
>  tools/testing/selftests/vfio/lib/iommu.c      | 60 +++++++++++++++++--
>  .../selftests/vfio/lib/vfio_pci_device.c      | 16 ++++-
>  4 files changed, 74 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
> index 5c9b9dc6d993..9e96da1e6fd3 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
> @@ -29,10 +29,12 @@ struct iommu {
>  	int container_fd;
>  	int iommufd;
>  	u32 ioas_id;
> +	u32 hwpt_id;
>  	struct list_head dma_regions;
>  };
>  
>  struct iommu *iommu_init(const char *iommu_mode);
> +struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id);
>  void iommu_cleanup(struct iommu *iommu);
>  
>  int __iommu_map(struct iommu *iommu, struct dma_region *region);
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> index 2858885a89bb..1143ceb6a9b8 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> @@ -19,6 +19,7 @@ struct vfio_pci_device {
>  	const char *bdf;
>  	int fd;
>  	int group_fd;
> +	u32 dev_id;
>  
>  	struct iommu *iommu;
>  
> @@ -65,6 +66,7 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
>  #define vfio_pci_config_writew(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u16)
>  #define vfio_pci_config_writel(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u32)
>  
> +void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, struct iommu *iommu);
>  void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
>  			 u32 vector, int count);
>  void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
> diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
> index 58b7fb7430d4..2c67d7e24d0c 100644
> --- a/tools/testing/selftests/vfio/lib/iommu.c
> +++ b/tools/testing/selftests/vfio/lib/iommu.c
> @@ -408,6 +408,18 @@ struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges)
>  	return ranges;
>  }
>  
> +static u32 iommufd_hwpt_alloc(struct iommu *iommu, u32 dev_id)
> +{
> +	struct iommu_hwpt_alloc args = {
> +		.size = sizeof(args),
> +		.pt_id = iommu->ioas_id,
> +		.dev_id = dev_id,
> +	};
> +
> +	ioctl_assert(iommu->iommufd, IOMMU_HWPT_ALLOC, &args);
> +	return args.out_hwpt_id;
> +}
> +
>  static u32 iommufd_ioas_alloc(int iommufd)
>  {
>  	struct iommu_ioas_alloc args = {
> @@ -418,11 +430,9 @@ static u32 iommufd_ioas_alloc(int iommufd)
>  	return args.out_ioas_id;
>  }
>  
> -struct iommu *iommu_init(const char *iommu_mode)
> +static struct iommu *iommu_alloc(const char *iommu_mode)
>  {
> -	const char *container_path;
>  	struct iommu *iommu;
> -	int version;
>  
>  	iommu = calloc(1, sizeof(*iommu));
>  	VFIO_ASSERT_NOT_NULL(iommu);
> @@ -430,6 +440,16 @@ struct iommu *iommu_init(const char *iommu_mode)
>  	INIT_LIST_HEAD(&iommu->dma_regions);
>  
>  	iommu->mode = lookup_iommu_mode(iommu_mode);
> +	return iommu;
> +}
> +
> +struct iommu *iommu_init(const char *iommu_mode)
> +{
> +	const char *container_path;
> +	struct iommu *iommu;
> +	int version;
> +
> +	iommu = iommu_alloc(iommu_mode);
>  
>  	container_path = iommu->mode->container_path;
>  	if (container_path) {
> @@ -453,10 +473,42 @@ struct iommu *iommu_init(const char *iommu_mode)
>  	return iommu;
>  }
>  
> +struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id)

I don't think the name really captures what this routine is doing. How
about iommufd_dup()?

> +{
> +	struct iommu *iommu;
> +
> +	iommu = iommu_alloc("iommufd");
> +
> +	iommu->iommufd = dup(iommufd);
> +	VFIO_ASSERT_GT(iommu->iommufd, 0);
> +
> +	iommu->ioas_id = iommufd_ioas_alloc(iommu->iommufd);
> +	iommu->hwpt_id = iommufd_hwpt_alloc(iommu, dev_id);
> +
> +	return iommu;
> +}
> +
> +static void iommufd_iommu_cleanup(struct iommu *iommu)

nit: iommufd_cleanup()

> +{
> +	struct iommu_destroy args = {
> +		.size = sizeof(args),
> +	};
> +
> +	if (iommu->hwpt_id) {
> +		args.id = iommu->hwpt_id;
> +		ioctl_assert(iommu->iommufd, IOMMU_DESTROY, &args);
> +	}
> +
> +	args.id = iommu->ioas_id;
> +	ioctl_assert(iommu->iommufd, IOMMU_DESTROY, &args);
> +
> +	VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
> +}
> +
>  void iommu_cleanup(struct iommu *iommu)
>  {
>  	if (iommu->iommufd)
> -		VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
> +		iommufd_iommu_cleanup(iommu);
>  	else
>  		VFIO_ASSERT_EQ(close(iommu->container_fd), 0);
>  
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index fac4c0ecadef..9bc1f5ade5c4 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -298,7 +298,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
>  	return cdev_path;
>  }
>  
> -static void vfio_device_bind_iommufd(int device_fd, int iommufd)
> +static int vfio_device_bind_iommufd(int device_fd, int iommufd)
>  {
>  	struct vfio_device_bind_iommufd args = {
>  		.argsz = sizeof(args),
> @@ -306,6 +306,7 @@ static void vfio_device_bind_iommufd(int device_fd, int iommufd)
>  	};
>  
>  	ioctl_assert(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args);
> +	return args.out_devid;
>  }
>  
>  static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
> @@ -326,10 +327,21 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *b
>  	VFIO_ASSERT_GE(device->fd, 0);
>  	free((void *)cdev_path);
>  
> -	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
> +	device->dev_id = vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
>  	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
>  }
>  
> +void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, struct iommu *iommu)
> +{
> +	u32 pt_id = iommu->ioas_id;

/* Only iommufd supports changing struct iommu attachments */
VFIO_ASSERT_TRUE(iommu->iommufd);

> +
> +	if (iommu->hwpt_id)
> +		pt_id = iommu->hwpt_id;
> +
> +	VFIO_ASSERT_NE(pt_id, 0);
> +	vfio_device_attach_iommufd_pt(device->fd, pt_id);

device->iommu = iommu;

> +}
> +
>  struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
>  {
>  	struct vfio_pci_device *device;
> -- 
> 2.52.0.351.gbe84eed79e-goog
> 
