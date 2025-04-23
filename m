Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40B6289370
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428542; cv=none; b=NNFyszri1bIhi0pg146DMa9datdi6gaTogpBiV4NWUyAl8g11PtEUexKoRsAK5yE4IfBnFkMotSeeFnvSHgvIX2/T11pEtTil+k/RUtK3I3caFVlvz2YvMZp9MJoSFHZhB4lMWgN1sTPuBR62OFTo6s3/Y/HDg++iDq/h/JirhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428542; c=relaxed/simple;
	bh=ZSWmIXnoHeqHpg22is4DCb+FQUxyjWQhdchI0xl2uAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSyAqLlXouc5qSL7NvSNGwqjv02EeZKhY+rOhFQSk5v2+IoSfqATYdHw8BpTEbGbZ+G1oDqDf7YpGW/30f/e8Y8aaePSdPRBS7/10xloLFAeeWCBIkhhVndZYlI6eeqDpZKLE9TYpQDRaQyJq7Zb5exmL5MZOTU0pOfDOXI8M5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LmWbJ2k6; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LmWbJ2k6"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86b9d1f729eso63924241.3
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745428539; x=1746033339; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sAA3ahIS+2Nb+9ARKVTXCSjk2uwR/TOFzjA5DEQnqxg=;
        b=LmWbJ2k6ImWz+pcLW/E8UGhCOkUbFk9qiiQIw0q4ed2KLGI1Taf6upbdXcUdekQl20
         Az4oAZYvNTPoEMaXq9QIKYTEo6t6s0SYj6Jy9NNdlKDuIw/61LhYWViixdCI4vaQntxE
         iNzlBXx/8dxDOOJOK2Djx0ZVMp71T2achobHhiQRbF8PZhHnMwOmCwqHnpkqJ+2OLQd0
         QPj7a1cDzpVnJQThNE11TJmT8tZsFd71wBZo46qH3vaR++xg8K5bP0mytkJynNJPLHf7
         x2A6cwEZGM6ypzrQMNqxmqaYFERFxq5RP8+l0PuyykhgokOC05BBbsykA9aOqLTo+RZh
         zjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428539; x=1746033339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAA3ahIS+2Nb+9ARKVTXCSjk2uwR/TOFzjA5DEQnqxg=;
        b=V8rzyA3YrP7It/euhbyTBYNXAdx3iQ7bX0ILmGND9ysYEUwi1pf3cJKj1w9MKOK7Xk
         b6LOOQ88V0ejOp8W8U72ASWKohWllsbsfPJVjeFIi4vZBhZRbWmuecOooCDGuLeFcnLI
         5R2uX5Sq5uXoyBuOaTZcv0H3BQzWSRPnc2JSNpDBMN/pUU6hLvNVH3s0FRAOe1Y3mAD5
         dE9qVlSwWqt5aurnLyiycJLMh7BdhFV52OkfhXErYPepxyztWR+4Ju0XYsgdsDtK+Xna
         AZlnWK4CbK4VtXY+pELKC9MeL/+hJTbf82WgpE90zLEwjA1ThkSJWqyflMoZ/uMe/0lq
         NNmw==
X-Forwarded-Encrypted: i=1; AJvYcCXsaBRVavYFqtLvAOxfhQboMIpGe9pib2VAHrFsaZ9jQXFCBd5OZjlYz6wW6gkQ/a09x375LA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzltAFenfGev9OG9hIrIyzHiI0pIKmJ4oN9uU1LA0aNmaQ2eIb3
	TLe9ZcnKWBSlTHiBWpIs78D3sGtWDLAxzEale79lsa29hb9Hq+3Sv2VC5croS4I=
X-Gm-Gg: ASbGnculAN6kbvUNSqP9kkZ/y4khmRwNARmNcAG9mVxNpvFvW7lAAQFnxJYiwoWgwNg
	EAGvOCpDZlcNG9ewDpGf8VuGDc6RMjRa9eQ7APV0TfuBOj4pn2qAqp3JSNPdszPoU21mLYlQJXC
	xhgdWpdsZdyWGLf8rx27bE+FpsbzvQLM0d4n5XlY+gaBhlJq5pXBAX4TLGWCGDoH3Lx4nybUjlF
	srg6uUwSRP18jSib9UEhcTcxY1gj7dFYZ2L3/a1TpfyHM0bSyRunXFahDygSwIcNQiJrr46d7yn
	Nnc0cKjaip6w2Dbb1z6zEhTVfeH8dGXdrD1yo+pm8P3N6Q3SzG2jpAOkT2y4OPk+bPZx1HJFvUb
	wwwVxbNVobenkaNp0MSU8dW8hgcLmPw==
X-Google-Smtp-Source: AGHT+IG91ka296h4XrJ4QPDo73jdYlZoOj1Zkc9PInMILwbVuqXEZMd5w4C/WgEttaatAxBubBvu3Q==
X-Received: by 2002:a05:6122:3c54:b0:529:24f8:dbdd with SMTP id 71dfb90a1353d-529253da601mr17813854e0c.4.1745428538734;
        Wed, 23 Apr 2025 10:15:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52a74d3a2d0sm79186e0c.40.2025.04.23.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:15:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dhB-00000007LQW-2UhV;
	Wed, 23 Apr 2025 14:15:37 -0300
Date: Wed, 23 Apr 2025 14:15:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v9 03/24] iommu: generalize the batched sync after map
 interface
Message-ID: <20250423171537.GJ1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <2ce6a74ddf5e13a7fdb731984aa781a15f17749d.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce6a74ddf5e13a7fdb731984aa781a15f17749d.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:12:54AM +0300, Leon Romanovsky wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> For the upcoming IOVA-based DMA API we want to use the interface batch the
> sync after mapping multiple entries from dma-iommu without having a
> scatterlist.

Grammer:

 For the upcoming IOVA-based DMA API we want to batch the
 ops->iotlb_sync_map() call after mapping multiple IOVAs from
 dma-iommu without having a scatterlist. Improve the API.

 Add a wrapper for the map_sync as iommu_sync_map() so that callers don't
 need to poke into the methods directly.

 Formalize __iommu_map() into iommu_map_nosync() which requires the
 caller to call iommu_sync_map() after all maps are completed.

 Refactor the existing sanity checks from all the different layers
 into iommu_map_nosync().

>  drivers/iommu/iommu.c | 65 +++++++++++++++++++------------------------
>  include/linux/iommu.h |  4 +++
>  2 files changed, 33 insertions(+), 36 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +	/* Discourage passing strange GFP flags */
> +	if (WARN_ON_ONCE(gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
> +				__GFP_HIGHMEM)))
> +		return -EINVAL;

There is some kind of overlap with the new iommu_alloc_pages_node()
here that does a similar check, nothing that can be addressed in this
series but maybe a TBD for later..

Jason
