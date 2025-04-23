Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C39628D846
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431787; cv=none; b=HVNmZRzgltryknrbKX1Zfy8a6TGZ/CGcsdn1XtK18BXpbXcBn/6GLZ7Y0CnKDzcgDpU1XdNK707ZFkqG/dj53icU6wmXcYGwMsfpBc45CbfL2MHSAX0y3yGhRCJKV4Njo3/swe0vBCBC+bDCdaOwkOpy6Px+Yn5KhTGSZnQu6c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431787; c=relaxed/simple;
	bh=hE07WPwFRXEpanF4skjNKxYCQC8//IXfbbfB/nEbHRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEFsUjY2Yu5SwXTB1h0G5vyruBLnwgGY7wjU4xjrBwwm8aqhADR6V7Qnku7jQBSHoDWZ4t0aXE3jnbgchPN81J3FgMwo1gVdZ3XPq8G1u995AZxkUNahAAqLfcZ89S+x2iI204OlXLMcXpgnvBZzKfCkp9y/wiFMTga3tzxfb5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jCjfhBYm; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jCjfhBYm"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4775ccf3e56so15637351cf.0
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 11:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745431782; x=1746036582; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kL2C8z2XNRWzrThEWzS/MGHmoZb+Ha7gcgLYUEwZduo=;
        b=jCjfhBYm+ShdcsiqPSRNbBj9wCg/sTRTxRFOUr5lSCwiSb0Pbn22Yh9jMABOz0UGt1
         fh5TLxVmH3rOO0DXp+uRrOps2ZXYqQdm81c7tyzWuZ/N15KeswpoGLU3QxnuFUEYfOxD
         +YC5jZVw4jlLM0yHJwTN0P6kX9AjYmtOVVcG3CPLOP82lN2P/S2aL3GnIuW4N4ble2kx
         0PGw16/nijoPExwdNwglEM6YC9BcPQU7ZAeKctyJ1sZP82dIvghX9bprPLG5QFlhM/iJ
         pkltI4L7lKUzNbF9wltAE7hebp7eTruxaHI32a6eo66v92kvf87XGkp9ShZbCilViM5c
         8S2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431782; x=1746036582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kL2C8z2XNRWzrThEWzS/MGHmoZb+Ha7gcgLYUEwZduo=;
        b=eqLy7FW5ZIXUwDM0yImsiezQeXnNgIzFBsrrsMKraPsli6uBQravBKxOX9CVKfgsGz
         jLuQXzflbWe8Llak1SWxNVo904El+KpoDx9VpOB7rtMZdmq7H9qvS8d/ObAQKZNbB/1h
         AdPCyo90ArLOZdOxa5BMoYjdt9wTg5Y3i+B3pnR7N4lWNARQpicDTAq4+Ptq55oeGFTi
         8E+0ftygz7h8O0XRQIozoR9nrSH85T6NhFN0xCjp0LeP+3Xvfzsqn9gxiW8zjJWXEM5M
         jL+AwURflm11KjADNxRGf971Q/5ktzfYiPx9pTSu+CQGTEUup06wu88sVjXd8YgWc76s
         w6Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUtEwUfKBrJqvvHVzJMP7SUZ4RE8VL8xIxvTOmVCYWNg1LFvZKOMbXSpC/IxtWO+wN/3RETRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPG/NzAtX3youvKgM01P6ggczliKh3vxz7SO/1jLA5PgusJyxL
	8hOjdAjXqD0O4MOdrb5JLxSQzADi+RVG4ZD79a+yR5t+LCzbpw5hpwxRihV0guw=
X-Gm-Gg: ASbGncvMyYJLLqpyZiW/7o3XD0dRyJH1EPZfC2iTstjdRkkx0kFV9E1f/mi6V8tqvOh
	DuAUfpz3Nd5exLeEQYF/vdlanhOSjf2CB3/RQ3Km+MMRj8feKQ8aRjugs6pzkTWG0siGn1MQlzd
	KNsw7Rxx28NXUEb0UJsMqLCbPUpsnBehrz9/VKBNl+jN1C/2j3vZJ4GuDk6qhuyMmhW9XhBUZlW
	BvekHN58bVo9yfJYyDio02VRyd+FCFb3aIXzwZk4O1ALgbxaPRsNZXgGLHjeKnQlqLdQfV6EZEc
	HrErKhz5Emo9CaccjdUzd1qqBFS177k9VZCPg2Pt0F1c3MRSPynFoVHIu6FbZYqRxG1cC+0jc0t
	u6w3W/S+0UdzJsPoIdjA=
X-Google-Smtp-Source: AGHT+IH4xfxeCQIatfvhUgdAx8fM2pKJgYvLzginEQw7PV9Sr3aShEQ97+Q+stgMKvhEecV5S0qx4w==
X-Received: by 2002:a05:622a:248d:b0:477:84f5:a0b with SMTP id d75a77b69052e-47e780b3d65mr2842901cf.2.1745431782337;
        Wed, 23 Apr 2025 11:09:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c3b485sm71764181cf.27.2025.04.23.11.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:09:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7eXV-00000007LuW-1WeA;
	Wed, 23 Apr 2025 15:09:41 -0300
Date: Wed, 23 Apr 2025 15:09:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 17/24] vfio/mlx5: Enable the DMA link API
Message-ID: <20250423180941.GS1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <b7a11f0e93a4b244523e07b82475a7616ba739c9.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a11f0e93a4b244523e07b82475a7616ba739c9.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:08AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Remove intermediate scatter-gather table completely and
> enable new DMA link API.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/mlx5/cmd.c  | 298 ++++++++++++++++-------------------
>  drivers/vfio/pci/mlx5/cmd.h  |  21 ++-
>  drivers/vfio/pci/mlx5/main.c |  31 ----
>  3 files changed, 147 insertions(+), 203 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +static int register_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
> +			      struct page **page_list, u32 *mkey_in,
> +			      struct dma_iova_state *state,
> +			      enum dma_data_direction dir)
> +{
> +	dma_addr_t addr;
> +	size_t mapped = 0;
> +	__be64 *mtt;
> +	int i, err;
>  
> -	return mlx5_core_create_mkey(mdev, mkey, mkey_in, inlen);
> +	WARN_ON_ONCE(dir == DMA_NONE);
> +
> +	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
> +
> +	if (dma_iova_try_alloc(mdev->device, state, 0, npages * PAGE_SIZE)) {
> +		addr = state->addr;
> +		for (i = 0; i < npages; i++) {
> +			err = dma_iova_link(mdev->device, state,
> +					    page_to_phys(page_list[i]), mapped,
> +					    PAGE_SIZE, dir, 0);
> +			if (err)
> +				goto error;
> +			*mtt++ = cpu_to_be64(addr);
> +			addr += PAGE_SIZE;
> +			mapped += PAGE_SIZE;
> +		}

This is an area I'd like to see improvement on as a follow up.

Given we know we are allocating contiguous IOVA we should be able to
request a certain alignment so we can know that it can be put into the
mkey as single mtt. That would eliminate the double translation cost in
the HW.

The RDMA mkey builder is able to do this from the scatterlist but the
logic to do that was too complex to copy into vfio. This is close to
being simple enough, just the alignment is the only problem.

Jason
