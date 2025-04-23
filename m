Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901AA2857F6
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429789; cv=none; b=DrprwQ+hdTfqC1iK/qVxiPJF+HTFukYsee2Iqs+kxLGYtdzGo3XzhGx1iPSiYXE9JJ4v1jXk73bFApbcmrrx9s3Lxjn7TWbruGd0HT3iu0FnNkXdy/5pkFra9jL3mfxTEeY5xTRjM24lA5u86bTrG7qgWUMyMBpgVkqOjoDXnBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429789; c=relaxed/simple;
	bh=drAiBKTIiyi9mLR+BwbEskkyvzsYVuH4EzXGje0dF0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Khh1iwo2HRKiQjYd6uAMol8V/qUX0ojlgWsr7BgTe83GNhJQg7vXjVY9KjjYKZcML9QMhx76CjQk5tqs01CC8SPKbWxT7ip8cAREExcjml5q0sgXtMuXRFPvK+h7W+C4DQU09CiKbZTdGbRrlPqiE5yTOgxVZyvjAHybwxx45rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ahPO/+rN; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ahPO/+rN"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c54b651310so14110485a.0
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745429786; x=1746034586; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNJodNA/CGOE8qYPmCoAIvEyeqrCcwNf4apB4pxSGaA=;
        b=ahPO/+rNImC89kWaKlTRzTYxUI4u1u6vfmpJ+Pg5MnJW0SOOXv3BLPxat055a+cfYl
         Pb6gLHrnKpKlhUWNb2p0PKpA7VaZmm58xvmWTf7QE7+poX74n3IEfW/m3uuAQJSp0UrN
         rQ1f7EsgLfNiX7zeqbbYxiuoWTp4QODSi2zai26dL7cPN2hc1fBcLdCY5aqKM8M54QBX
         i3kwlmHmgAh/VdeuCPtZDwnAwftf3bVTFu3Ezz8mk3jx74wWRTGYTgayYieQRjvUo/R9
         UtapocTbwJSPVUulBZfkt5WCzNZifZLjcpblxyGdgrOk6vD6VDmY9QO+oSUJmhNoeC6l
         77NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429786; x=1746034586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNJodNA/CGOE8qYPmCoAIvEyeqrCcwNf4apB4pxSGaA=;
        b=ACpCBRxhEFRaAP8C/KnqLas3yg3LDOoSCGd2C+qPrPIlyxoH0XPMhwzIrHXnSMQE27
         G8vlglME29/Dp2OqPhpxXHimmU8C2tlwZL/6++hAZvQGUx5Gn92aLG+VRWzz7yUDDBiP
         9+0VMKxEI7XFf878IKMXH6rxkrXeLvpxczfkcKt5HAET57Q3SMsqggQRMzs6JexknhBU
         0C4WzxQBe7FpNTyRI3gWLW2IknuXVWCeykggSbeEgMcoYftZG4MjTUs5qjPhk23K/gNI
         QasrIERAddt1FwpsPQLrBl94JRXylwBKbshApDfhts/J9tbFWhCjP1xi9/k38o1cWv/L
         bJ2g==
X-Forwarded-Encrypted: i=1; AJvYcCXINaX2cTSUV7qwzpvRKpR/03CPdF+qn/Qwu8Y6doyiice94sXopzOhtdWkIQNm3UcT4ugRiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjW9QQGYoVgG8T1Tx5KHbKaj/tHrRc9fScao5J2sjJgbOE/D6U
	WVzmgXRpbaFHRPUxgAR/s3mzBXQ5mumoo/1GPCdeXcka86vZd2Xqkxi2WLuyx4Q=
X-Gm-Gg: ASbGncvVd7iLaeBjrD14io7Q3vXaPWR/kUmFoW4F6Q6bvB+QOpODF/fdIrbuXURfi99
	v5MOScaVFeLvqZV2akZnOlZEwNtWhvm2e3cX2yC7X/uFl3KvP3Tqh0h+GhXuw3lULnqMmSP1d2P
	YaK09DlIpwdJH8D6M8czTOAEDTzVqKW4vncE8k+6AxhKrbN+mTmYwQp8c5dbPNC/tbjY5PFPjQD
	ALHwmCttZLmUpdbUh1fF7liRfU+xAUeYkYG89rB9DpNRu3VEe0rE0gUdNFIUwdzBXl4I+X29of3
	re75mHHKeDSb/xFJvK3yZLjZSyVoXAlpY8qsmjDFKYWPXMrD3gAHjy4LbUMr+uFwBcy+RH7V5kX
	4j1O3HrbutirgiU6h5WM=
X-Google-Smtp-Source: AGHT+IFfYFJ3H6MHGXkZxUwtNrKhvKS2i7aEibqmChB9ejFnkuFqgY0c21HHcZ68bh6mda7wa7inKA==
X-Received: by 2002:a05:620a:44d3:b0:7c7:a5ce:aaf1 with SMTP id af79cd13be357-7c928018e95mr2986289985a.35.1745429786563;
        Wed, 23 Apr 2025 10:36:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6eb31sm709808085a.3.2025.04.23.10.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:36:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7e1J-00000007Lca-2cT8;
	Wed, 23 Apr 2025 14:36:25 -0300
Date: Wed, 23 Apr 2025 14:36:25 -0300
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
Subject: Re: [PATCH v9 13/24] RDMA/core: Convert UMEM ODP DMA mapping to
 caching IOVA and page linkage
Message-ID: <20250423173625.GO1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <7d6f3d50c4e6eb3ab75fd4c5bbaa8efcb1a15b3c.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d6f3d50c4e6eb3ab75fd4c5bbaa8efcb1a15b3c.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:04AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Reuse newly added DMA API to cache IOVA and only link/unlink pages
> in fast path for UMEM ODP flow.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c   | 104 ++++++---------------------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  11 +--
>  drivers/infiniband/hw/mlx5/odp.c     |  40 +++++++----
>  drivers/infiniband/hw/mlx5/umr.c     |  12 +++-
>  drivers/infiniband/sw/rxe/rxe_odp.c  |   4 +-
>  include/rdma/ib_umem_odp.h           |  13 +---
>  6 files changed, 71 insertions(+), 113 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
