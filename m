Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F0139587
	for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019738; cv=none; b=clWo6qkb4FsyJY28OS//iQVTU87pdjE8RS8oll2PFhn4fWqDe0PDy4k5K3A2HjJIvUbGLI2Wz+FJ0wq8dvvtATFHUsyfTE13TYl5A8cJD7VvIuYz3sgPRzlPtSe4Lf6bt+0SFXowituDyPFOSdwywsLiC/f8UxO1X0c/x1iGQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019738; c=relaxed/simple;
	bh=/SLEGSo/SHbwoeas/K5MCYXMBvqDE3jcVt8yVAVUk0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxcFXpQk0GOWIwIL3k+tK0kG1IgV3+Ai2KYTPo37RqF7gAnN+zTHm2mCC8IxWR863o78j0b8KefnZclIQ2VXFIUqUvKu8ip/vh2rUykFVzRGZtBR+V4x0lRp9yDCeVAneRRNJLzZ/5c8gmWGRv9tMbzLqRdnxWTI2WvLmo2AjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MU426Rjy; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MU426Rjy"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68ee2c0a237so8214766d6.1
        for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 09:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708019735; x=1708624535; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3Cfkf/rcH8ZZ55nenqvlzLTt+2joha7tbZ1+3P7cVI=;
        b=MU426RjyelpNPOu/qMyIFbs/tGe0urEBywGJD8lg9GVnJgw3vrVrfrx8Yv/IuDDtXK
         W/5Fd60WVfipP+oGgj7PVtRF84/sulUjYW5yKGN+wSIRQv12zV/Y6IuE0boqIKXQ1jbl
         7ubZhPGj7naaFiO0dujxAeakgjJIr5QbIE3dsuXm78TXTDeQ0l66KRzkZ60ifds1VacZ
         kwenFonoX23TvcYgm6/OXI2cqhL5+BaVWH2Fd5vDpVMbKKgWH+OdgYXHy4tWPMeVIuQU
         owh56cwYvi+bw8X+T1Dkjy5Uzt6FUE5yJNt8Gzjj5K8jhMKK7qWgvrGHmYgUKF7KoGhQ
         kcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019735; x=1708624535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3Cfkf/rcH8ZZ55nenqvlzLTt+2joha7tbZ1+3P7cVI=;
        b=L+lc5rlddMCaifhT2bMQrBBdftuy9Hp+pyxvpdbku7oalYqVFyZ/8uMEycDe7XQp9L
         9dJoKh5Yd5CP+guwq+0qwuGEZFIZuyOn2WoPBN/Uim8NDYq+6DdJ7/InYwcFaX3w1Q1Y
         JdE1qMo3rcGxVpuf/hQGK+jKRXVN5+8EApYVpLA9F8MCSuLH+83DqXcEr8A4sMIanwH7
         wzZ8bSZ3TXXrZ2rgZgJJxIvedJUzwypS+1oM0Lg/g/9bqH42pvsfvXW3kjX9GrPMWSU/
         A+D/WX5bjqm0dAAtJsiMe8ypsNChsbWZTfVvbYT8CQ0V+9M34Y/tQTYNXCEHSmwQB3UM
         TchQ==
X-Forwarded-Encrypted: i=1; AJvYcCV58rKQ54U86/q0vcLTtU3H/zhe4E0HcK48uM5GBc2RWtXnSstDFG+McJ5zraX7erH8kOL009sptL5vNy6FkuwX+8p2VYs=
X-Gm-Message-State: AOJu0Ywy6Zc5Bj//jIhjQHzrNNCQOUdy2mPRNi2XqMXV6Sm1VIcRSwDM
	ajiLr+yvfjQnbkxR1vcNAlBCu+fomnXWv4ORWv3/TmW5nk8ZDddvzUQukVKaBvo=
X-Google-Smtp-Source: AGHT+IGn1LZhOlvnHNCbJfgG5iiTUX0ZYq//pMkCGfQ2vC9DNSvgr14XQvyYuGMbLuzdjQz0+dF1uA==
X-Received: by 2002:a0c:e247:0:b0:68e:fbbe:2eea with SMTP id x7-20020a0ce247000000b0068efbbe2eeamr3750395qvl.3.1708019735060;
        Thu, 15 Feb 2024 09:55:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id lv4-20020a056214578400b0068ee4c74941sm860253qvb.132.2024.02.15.09.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:55:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rafxO-001Gax-1t;
	Thu, 15 Feb 2024 13:55:34 -0400
Date: Thu, 15 Feb 2024 13:55:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Huang Jiaqing <jiaqing.huang@intel.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Use device rbtree in iopf reporting path
Message-ID: <20240215175534.GD1299735@ziepe.ca>
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215072249.4465-3-baolu.lu@linux.intel.com>

On Thu, Feb 15, 2024 at 03:22:49PM +0800, Lu Baolu wrote:
> The existing IO page fault handler currently locates the PCI device by
> calling pci_get_domain_bus_and_slot(). This function searches the list
> of all PCI devices until the desired device is found. To improve lookup
> efficiency, a helper function named device_rbtree_find() is introduced
> to search for the device within the rbtree. Replace
> pci_get_domain_bus_and_slot() in the IO page fault handling path.
> 
> Co-developed-by: Huang Jiaqing <jiaqing.huang@intel.com>
> Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h |  1 +
>  drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
>  drivers/iommu/intel/svm.c   | 14 ++++++--------
>  3 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 54eeaa8e35a9..f13c228924f8 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1081,6 +1081,7 @@ void free_pgtable_page(void *vaddr);
>  void iommu_flush_write_buffer(struct intel_iommu *iommu);
>  struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
>  					       const struct iommu_user_data *user_data);
> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid);
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  void intel_svm_check(struct intel_iommu *iommu);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 09009d96e553..d92c680bcc96 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -120,6 +120,35 @@ static int device_rid_cmp(struct rb_node *lhs, const struct rb_node *rhs)
>  	return device_rid_cmp_key(&key, rhs);
>  }
>  
> +/*
> + * Looks up an IOMMU-probed device using its source ID.
> + *
> + * If the device is found:
> + *  - Increments its reference count.
> + *  - Returns a pointer to the device.
> + *  - The caller must call put_device() after using the pointer.
> + *
> + * If the device is not found, returns NULL.
> + */
> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid)
> +{
> +	struct device_domain_info *info;
> +	struct device *dev = NULL;
> +	struct rb_node *node;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
> +	node = rb_find(&rid, &iommu->device_rbtree, device_rid_cmp_key);
> +	if (node) {
> +		info = rb_entry(node, struct device_domain_info, node);
> +		dev = info->dev;
> +		get_device(dev);

This get_device() is a bit troubling. It eventually calls into
iommu_report_device_fault() which does:

	struct dev_iommu *param = dev->iommu;

Which is going to explode if the iomm driver release has already
happened, which is a precondition to getting to a unref'd struct
device.

The driver needs to do something to fence these events during it's
release function.

If we are already doing that then I'd suggest to drop the get_device
and add a big fat comment explaining the special rules about lifetime
that are in effect here.

Otherwise you need to do that barrier rethink the way the locking
works..

Aside from that this looks like a great improvement to me

Thanks,
Jason
