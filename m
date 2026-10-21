Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792621180;
	b=OI5TKnAJ+Uk0CvdTq8yP1k5q12uLWKGnf6y8VzN1FDwpIStJlnmTi0jXohhEzAY/yPkz
	 RQaAag2YXTpRx37SNWwq9UKFXDU+npnPRZ+7ajRHjz8hfv/I8HRsPnyN/kMtQsHxXx2Ql
	 1gR8wo1MHzhWb7MAhyZqAuW3h/9M+cBcvAFjYnNThFou+/24cQjZhQs4zNVWIkUY6oUDB
	 2l2+Xzy92a+ACi09DWzV42bSxNBMfDZshO6puOSw3AvsMzy91TuMr7n4spIrBdm3c4ZsC
	 lMrv0H9YT1QemT1IljLnS9J7AkNMtZ91Mol9sVcCY8upfffyyOcDIxQtouueAZ7212A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792621180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=iYS+i0Ds8xFF5qZV2X2fbTLhmpre7IccGcufFJNUJH8=;
	b=1z2oSJj60pURZnHLNEII/HahLYziRAvnNfm5QddvRqy3c/s0lSAFKl9SYOVT2SK07e4q
	 AXOUyC6Ca00yCh/ThEdqzu5mRQVJmdtY9iaBI/zaiMxRjbRsdaQE3rt14drIDPBfrLAI4
	 GJ7bRL0Hc1e+prXcnlolSsWJuzgwVx5Enwh2XUhR3uO8Kd3RW+9lxBmqNqoh25wroYCEw
	 MTJiEpdYLZPjuIj+VEk3j100wUsmW1B5iJOw9blHCkQOGEN6fniPLvc42XjdkQNi65ODq
	 CZu7y2Mq+Gn/guGtQ4XN4dvaULahTLCCAaJdPoGfCfBjAvwMoP6e8iAIiT7gjKEtBNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gp27czvp;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD31606A319
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 22:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD31606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gp27czvp
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9f6a16aedso7267785ad.2
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 15:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792621179; x=1793225979; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iYS+i0Ds8xFF5qZV2X2fbTLhmpre7IccGcufFJNUJH8=;
        b=gp27czvp+QosB6Ft9KUfTSCY3XO1Dwl91/TzHP/bVfYT8FFW2V9tsUZbwid3RYE5KG
         +QHO9qoSLM5nCkNuWSo2dpRNSSfNJBQZEzoAORCyI/MlN8LRWLgVjOC4ztpz/VaIVkNE
         sRgbtHYusKoDpf6NMtB/zV7g7JcBD5oWVcKwDEO2yX7U7TxVy9+DxBWUuqneFxLVVlua
         qf+XX/gqHfOmn3ORhuvF8gjmV8uMvQ1m3A0nFxy11CI38IpveXPetaitHyUgssRnZAAp
         cfU2cLZSadkzWSl0qRbKGSDTQftgYWEygqa/Lx+xT2hoyO/K2lnuruRlZpJ/uWgOoMI/
         cFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792621179; x=1793225979;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iYS+i0Ds8xFF5qZV2X2fbTLhmpre7IccGcufFJNUJH8=;
        b=fuXdUQaQ+k4Cn2bQC7BCUttVpF93OAGLh3c52jpA/uBvv1i/DEf8BDTfV/rlghUWyw
         xOScHJIdtgRyStS7Zxd2HuJz891J8kBPquSucSM7G5qH6oJUKpNsV9TUvkaGy9VyBGko
         LiGu2mqcw/q6TNF0VvzdqCnonrQqch7jRPO8wZkil/oxwNsg2z0UMEYWhTuHfLomRGI/
         1RkQ1ms5xnd1Xz4smxh96rj43InrzMDYKdMFPDigYNjbQrGsjW3FbexwrZ7cke0Yj17h
         +3DO9uwuqrGzXv+2xGY8dY03LHxaEkrqcUCaDGcVLVxUHa6JdV8rkCQlPNQ7yqxBU6ij
         LxsQ==
X-Forwarded-Encrypted: i=1; AKwUvByjfoknFsJXmmsoy4ok0dZfbWP7RpCLWr7QqhPQw/0iB5a4Gz3tEqQY8d2NR9yuWwvdYgkCEQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJVuF04buNIi8BeQbIx8PE1YlzDeBlQq/oYk3gajuWGCzQpYcen
	HjWaJnHNIgWvmLJGO6mkXGUthkSrZ5m6VJ1x/9Ht26OqFcg8prnb2hbBiDg5IJHfug==
X-Gm-Gg: AYBFou0VOIDmXlqtlM51Oywwn1wj1pLZG5/IsLO4e+P8CsPEsnvE7ti6sx34ZONo8vX
	hKz3uALgG52mxW47TFVQJiY8Z+Aa34mtRXY5hBEBC3ZOvfKGae4x6/gGyff1EWQeI7uCEchApMT
	4+wENTFe4x9ZIqlRizToS0F4nRBnXBYMpA0SSCWNRpSm8D0J2uaitMxD7fDSrM0PsABvQA0h0Aj
	SudW0/vjsyiguQU44vVbDxdtCOWLh1EjAZf1SGm5DP9JUDMu5iBn+rO6AGtdQaHTEwFH7aAwR1E
	yRupslK04r+7GuHjvrVjA9s3plFQa3P7QBYSuN2hKPN5QT9uazF1t4qNNkzhM8kVsxx+7KcnM47
	Iw7y2W6WBSkmgSwdY27miAixQbCxZAjcy7w6JKmiXVZolzxmsmZBLEoFxIBei8GPjUxYTffAvZE
	D7bYP1TjXSPHnbR4cxeV+WWWPQS8mAtlhGasdpRv+WDt7wMkDsXAXPtHNz16Izh6FGOO+avOf8j
	APPyKAlFJf6ceGP63tWL2azEb0UqtuEwtJovhjvPy8pafMAr70FbIJvPpIUGrfb7swJ7DZB7/rq
	ugfnR/ypKa/+Z1iT
X-Received: by 2002:a17:903:1a44:b0:2e9:3f26:5d83 with SMTP id d9443c01a7336-2ea43dbc13fmr25913965ad.12.1792621178933;
        Wed, 21 Oct 2026 15:19:38 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b453a4dsm16082615ad.42.2026.10.21.15.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:19:38 -0700 (PDT)
Date: Wed, 21 Oct 2026 22:19:34 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [RFC PATCH 1/3] vfio: selftests: Add support of creating iommus
 from iommufd
Message-ID: <atk6drL0jn8A9Ocm@google.com>
References: <20260925011308.3381953-1-skhawaja@google.com>
 <20260925011308.3381953-2-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925011308.3381953-2-skhawaja@google.com>

On 2026-09-25 01:13 AM, Samiullah Khawaja wrote:
> Add API to init a struct iommu using an already opened iommufd instance
> and attach devices to it.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  .../vfio/lib/include/libvfio/iommu.h          |  2 +
>  .../lib/include/libvfio/vfio_pci_device.h     |  2 +
>  tools/testing/selftests/vfio/lib/iommu.c      | 60 +++++++++++++++++--
>  .../selftests/vfio/lib/vfio_pci_device.c      | 25 ++++++--
>  4 files changed, 80 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
> index e9a3386a4719..62f1e8affd2b 100644
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
> index e19bd94b8dd2..4dcc23bc9b78 100644
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
> @@ -82,6 +83,7 @@ static inline void vfio_pci_cmd_clear(struct vfio_pci_device *device, u16 bits)
>  	vfio_pci_config_writew(device, PCI_COMMAND, cmd & ~bits);
>  }
>  
> +void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, struct iommu *iommu);
>  void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
>  			 u32 vector, int count);
>  void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
> diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
> index b6f3c5c84e01..6d2d5c82813c 100644
> --- a/tools/testing/selftests/vfio/lib/iommu.c
> +++ b/tools/testing/selftests/vfio/lib/iommu.c
> @@ -405,6 +405,18 @@ struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges)
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
> @@ -415,17 +427,25 @@ static u32 iommufd_ioas_alloc(int iommufd)
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
>  	iommu = calloc_assert(1, sizeof(*iommu));
>  
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
> @@ -449,10 +469,42 @@ struct iommu *iommu_init(const char *iommu_mode)
>  	return iommu;
>  }
>  
> +struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id)

I think this is a good opportunity to start adding kernel-doc comments.
It's not very obvious how and when to use both iommufd_iommu_init() and
vfio_pci_device_attach_iommu(). A kernel-doc comment would help clarify
that.

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
> +static void iommufd_cleanup(struct iommu *iommu)
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

Please put IOMMU_DESTROY into its own helper so this can be:

if (iommu->hwpt_id)
        iommufd_iommu_destroy(iommu, iommu->hwpt_id);

iommufd_iommu_destroy(iommu, iommu->ioas_id);

> +
> +	VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
> +}
> +
>  void iommu_cleanup(struct iommu *iommu)
>  {
>  	if (iommu->iommufd)
> -		VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
> +		iommufd_cleanup(iommu);
>  	else
>  		VFIO_ASSERT_EQ(close(iommu->container_fd), 0);
>  
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 774d1e90ec0e..81d3879d064f 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -469,15 +469,15 @@ int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
>  	if (ioctl(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args))
>  		return -errno;
>  
> -	return 0;
> +	return args.out_devid;

This breaks vfio_pci_sriov_uapi_test for all iommufd variants (9/45
fail). iommufd_setup() in that test returns the result of
__vfio_device_bind_iommufd() directly, and the
fixture/ASSERT_COND_VF_CREATION() treat any non-zero value as failure.

Something like the following is needed to fix it:

diff --git a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
--- a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
@@ -32,9 +32,14 @@ static int container_setup(struct vfio_pci_device *device, const char *bdf,
 static int iommufd_setup(struct vfio_pci_device *device, const char *bdf,
		  const char *vf_token)
 {
+    int ret;
+
     vfio_pci_cdev_open(device, bdf);
-    return __vfio_device_bind_iommufd(device->fd,
-                      device->iommu->iommufd, vf_token);
+    ret = __vfio_device_bind_iommufd(device->fd,
+                     device->iommu->iommufd, vf_token);
+
+    /* On success, __vfio_device_bind_iommufd() returns the device ID. */
+    return ret < 0 ? ret : 0;
 }

 static int device_init(const char *bdf, struct iommu *iommu,

>  }
>  
> -static void vfio_device_bind_iommufd(int device_fd, int iommufd,
> -				     const char *vf_token)
> +int vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
>  {
>  	int ret = __vfio_device_bind_iommufd(device_fd, iommufd, vf_token);
>  
> -	VFIO_ASSERT_EQ(ret, 0, "Failed VFIO_DEVICE_BIND_IOMMUFD ioctl\n");
> +	VFIO_ASSERT_GE(ret, 0, "Failed VFIO_DEVICE_BIND_IOMMUFD ioctl\n");
> +	return ret;
>  }
>  
>  static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
> @@ -503,10 +503,25 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
>  				   const char *bdf, const char *vf_token)
>  {
>  	vfio_pci_cdev_open(device, bdf);
> -	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd, vf_token);
> +	device->dev_id = vfio_device_bind_iommufd(device->fd, device->iommu->iommufd, vf_token);
>  	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
>  }
>  
> +void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, struct iommu *iommu)
> +{
> +	u32 pt_id = iommu->ioas_id;
> +
> +	/* Only iommufd supports changing struct iommu attachments */
> +	VFIO_ASSERT_TRUE(iommu->iommufd);
> +
> +	if (iommu->hwpt_id)
> +		pt_id = iommu->hwpt_id;
> +
> +	VFIO_ASSERT_NE(pt_id, 0);

Is this assert needed? (Will vfio_device_attach_iommufd_pt() not handle
this appropriately?)

> +	vfio_device_attach_iommufd_pt(device->fd, pt_id);
> +	device->iommu = iommu;
> +}
> +
>  struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu)
>  {
>  	struct vfio_pci_device *device;
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
