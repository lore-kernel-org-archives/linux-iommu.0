Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933723D090E
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298352; cv=none; b=WVQOc+OosmV0k3d3DuyMiHK/sdaPEHfUlXtDHamBmNGguF+8rwHvoAuTYpO19AE/Hl24l6sWYulR+T1utOoBmg8A3XN32i6FSjyM6ycHGGHxg1cAznJivmYdjtYMwQlur516RpG/Wm3IXN4e2/2zf2m56Ys04e56Sa8eY2DJMbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298352; c=relaxed/simple;
	bh=pC7LNCoqLHqtSu4IvN5L+bojdwlxNMiMUpCfRrWXA80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxj1FR3YpZe/37iODjrO2pW+kOCwaeHBYrJ+DSyT9r+pwcBpkclBAxkU4Fk55ulFLLy0o1FSZBfkCsVbdt3CAs0U0N2HTc3WikpbKgEhtN0jmzTQp4haYXVvnTvsFMTbNgEiRwWnxNY8gZ6gpa1i1WO5RmHHgYAyHQYAlJAveKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Vd82g0h9; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Vd82g0h9"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d7e7f48499so1156820985a.1
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777298348; x=1777903148; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0ud/a/8Bcj3BJq0RBIUY01Jvn+6rT7JhYkFAFghx3g=;
        b=Vd82g0h9VT0yhrgYaVKgsWYX3Tadie04ut9zY41Cf1FoTav0Q/AEb1aTInMX2rvpT3
         10xzXavQ4pAPo7NAxrxu9qvavaf531ug5pwC/J43DrMCbAZ8DOltNwad5I4EGU3f8qFx
         +7ZxHra+vVpM7Uqy5B1Hcn/5pGSmm13HQXXfOmUyxZCvMEtc7308aUjUe4MUGveOXPLR
         grldNOZN9mIO87IljIN2kUKCoJHvPhxcUNaxhaI8jfOOKUfMR5Jfzfo2AJj2e0rwxQ6b
         Kc9RPziWUR7+375ivEm2etCSpZqfjZXb3JcNwu+tuofAaHnAopOyB6ZDpUtgEWwuRf7t
         bdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298348; x=1777903148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0ud/a/8Bcj3BJq0RBIUY01Jvn+6rT7JhYkFAFghx3g=;
        b=TOhrfH1f0Ul2VBLwKbW7KkLO2JUDtGOTFg1ev4ZSV30A7i3yA3iGQegfi+mh4pbOaC
         J5aUzft+aLvCWF+wvDbGjl9z0xRrw+0nAL0YNagNEZPkVcVh0WkXA3YwrbCTeoah/9sy
         RaYEyyvZAUTNkcxrZsy5vbD4SGfnOAe3xSiRESbeBKWqb1ZpQcC9CEnOTEm3UFgVDNGP
         bCdM/RAGenDUUtFVuIVOKqayA7JlqpB9GN5t0EUM2t4gFCYeVODOcpJ/fI/kNtFPYwOh
         5o/ERIzfihyfW8FSGXAva1w2LhGRzN7Ppw71oa8tbheKjUM6u8LVI8+Cn1mxc4qYyqQd
         +Blg==
X-Gm-Message-State: AOJu0YzqN3ROiq+5gah2ofK97qWRwXvBUmwGktO5l1seO4DDnVk9zHVQ
	Pk5RQw8RO1lBU9tXcS4xtyNVmyb4ZlvLOr06bNs+zrQxbp8uePqyzYWHsSO5w2TZ0No=
X-Gm-Gg: AeBDietK2Km464xi4DzLa6E5aX6fuEd4cyR6yFrRVieo8inIQgMyI0b7JHvIvT4oTSl
	+4bogdCkt19DAKgQxjCaMJW24DIBq7MrlbStPUimf4aXIIEV0MEzDQSj+NFZMPQaX9Y+JAf4J4L
	6+RJtzH37DQTeQAPxx13vGDllAvkTeDdIVNiFIJQlZw27rfI5zK8n2u/inIh8bMfm1qVhOPnDcf
	aQJP9yhyBrGhdyoIO7fM9OhJFVtaklLvyfdvf4SvVHGpEcfmmLEYq/b5Jor7vBYve9aesvvBA4Z
	v/m6Fkq5Mo5O9OZbs6pFNGLdANFd+X1taFxmghy/k9kzmfot3nZerv+vjRptQcGHRws1KiYJdoj
	banhqy0tEKFddaKPpZy1xkWPxYB0xufrDNTDixq89DIwPN4V8aZxGM5/1WXqt3x0WH7YDwtC3jr
	M2d0zP5GuqsZ+1d4VicQrtTK6h93HPNHmOyfNMLmcqoizuvtyoeyqO4/m2DQSVaobm9JJoQXCZr
	VkohIjJueG+LLynyhMgtKzFh1o=
X-Received: by 2002:a05:620a:2a03:b0:8cf:dd93:acb3 with SMTP id af79cd13be357-8e79295ec07mr6190424085a.56.1777298348210;
        Mon, 27 Apr 2026 06:59:08 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe8f3csm2690335485a.2.2026.04.27.06.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:59:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHMUM-00000003Vhg-452w;
	Mon, 27 Apr 2026 10:59:06 -0300
Date: Mon, 27 Apr 2026 10:59:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/4] iommufd/device: Associate a kvm pointer to
 iommufd_device
Message-ID: <20260427135906.GB740385@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-2-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427061005.901854-2-aneesh.kumar@kernel.org>

On Mon, Apr 27, 2026 at 11:40:02AM +0530, Aneesh Kumar K.V (Arm) wrote:
> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> Add a struct kvm * to iommufd_device_bind() fn and associate it
> with idev if bind is successful.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> [nicolinc: fix build error in iommufd_test_mock_domain()]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/iommufd/device.c          | 5 ++++-
>  drivers/iommu/iommufd/iommufd_private.h | 2 ++
>  drivers/iommu/iommufd/selftest.c        | 2 +-
>  drivers/vfio/iommufd.c                  | 2 +-
>  include/linux/iommufd.h                 | 4 +++-
>  5 files changed, 11 insertions(+), 4 deletions(-)

> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 344d620cdecc..453fbceb9219 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -203,6 +203,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>   * iommufd_device_bind - Bind a physical device to an iommu fd
>   * @ictx: iommufd file descriptor
>   * @dev: Pointer to a physical device struct
> + * @kvm: Pointer to struct kvm if device belongs to a KVM VM
>   * @id: Output ID number to return to userspace for this device
>   *
>   * A successful bind establishes an ownership over the device and returns
> @@ -216,7 +217,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>   * The caller must undo this with iommufd_device_unbind()
>   */
>  struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> -					   struct device *dev, u32 *id)
> +					   struct device *dev, struct kvm *kvm,
> +					   u32 *id)

I thought we were trying to get away from struct kvm?

https://lore.kernel.org/all/adf29Rn7q9Db0hxc@google.com/

Ie this should be a 'struct file *kvm_fd'

?

Though I am wondering how practical it is to do this at this moment :\

Maybe ask Paolo how his series is going?

>  {
>  	struct iommufd_device *idev;
>  	struct iommufd_group *igroup;
> @@ -266,6 +268,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>  	if (!iommufd_selftest_is_mock_dev(dev))
>  		iommufd_ctx_get(ictx);
>  	idev->dev = dev;
> +	idev->kvm = kvm;

If we do that then I'd take a file refcount here ^^^

And then put it back when the idev is freed

That makes the lifecycle robust.

Jason
