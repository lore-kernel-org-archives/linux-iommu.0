Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B62281344
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428644; cv=none; b=XRr2baI2KAN72AUgL1DjErt/vallV63AaMxkUBl0XTKAcUmEClOzNgDvPTBX0J52pnyyOU0dD89QIcSwxG36a2J3r3aYNNtE5ZO/+481ZNYmZnJ1Nn5+y18osAuc7ac3hBouNoFzareIrEbJ0xt2eZAylWVV2TmAnLcngYzbMXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428644; c=relaxed/simple;
	bh=EiBhyUfzV2Z7UDyJtWT+jDVz3vG5z4pmjKVdd/tf4pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNhjfVrKFSeBk/r6bcx6ql+BH44IrWbOJd4UYX2XAk8r4AXmciOfNKPvXMb3+IjbhMNwB8Sib+WVnJO7m/8aJ3lKqVx5EY9fFKQCLFWukgimV1qP9iXiwQ2S8JbifiQ+KEdmP3d00xboGwkJ38vMJVlvMU0xF9H0EmivRL4bfOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oqIHgNRa; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oqIHgNRa"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4766631a6a4so837531cf.2
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745428641; x=1746033441; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFsItIzcNoABKT1tTnR+L3KluEl/QW6UiWkd3yuS4gc=;
        b=oqIHgNRa7SjX2d1Bkh5lsVB5yWsF4dtg7cRbPIqJ7y8f/27AMIUu2ofeunKMWtdTar
         nyERhRNfKPU0kXo1MeMyxkJaXA0jSZjrJI99qRZpVfyfJFG1G5Dp/GfkitH1AneGmwXH
         PtcR4y9N8epmTzlzWhc3keODB9SVLQJPs6gv6MNkDdgQjvH7IDgMi9lfjCRb9e6Hgjmk
         jafwv7cVfHyQMlexo/cHl8Qq/tmdCSK3SvsTUygWafplYJAswV1FAmsVvffee+vTNhgP
         K4JdHBnU0bt/JAeXFTlgeoxZqhSKatzl2Nv6zJFX/aPOvuXgFV8abW0dG0mwF8e9eBi/
         oZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428641; x=1746033441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFsItIzcNoABKT1tTnR+L3KluEl/QW6UiWkd3yuS4gc=;
        b=Rgd0NseWjLozHPUTiOVxI8htEnFI6wXjR0Ke/BjrgpbX80SBfqwoGuMYDUT+Ne0aZD
         /hzEP0pNpNs8G814rAr7ji2z+N+uHUAEuQaKSdjfkW9UZd6LCAvOyM+PzBiH/07UPq/O
         AQkX6JbWc0YGRigJPUy7rWuRVt7aqEfmlzPI8Hd1xvQweBXW/66j21lRuFe4bK/5DJOP
         3kRj/KBdC0AvEW38xkizzrShnbke4EkWAf6b/j9z/H39QRlvLme15Aj+88l0XFvZN9Sm
         rPFP8nvUjmuzKMAbXlmFoH1yyoOayAY9NxGhN3IFItH4i8LHuUpZ9BB5D64/rOiInFBm
         KWVg==
X-Forwarded-Encrypted: i=1; AJvYcCVgMAtli6RiN2yMynlhdcOgP0JxLR3dCt5vQu/Hgcg85fTxRXN10iUUw3zcEcv/qCtgDe+6Zw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4FC1Ron374rVu4yUU91jC2RcuvRR6cq+nMX2wEFQRmp+XhvBo
	n2ijntbq7bPt0DVVsT7Z2aBOt1cyjHZbISz/tfvHuV6ntkkhz3YAlmuPZuWQPg8=
X-Gm-Gg: ASbGncujk3ZeiZ0okY1zI9Zv4DOEk3XPPAMD9N09fbQhp3ypJTHqTClWk7Ek2EcMMx3
	IHJU68RGw+KsHtZNHB4XW8hoMpsV4dpcU87uQDw7KDv89eTcO5yChHuCSDlAUJdPWdhhLjGLde7
	ZIlJrMgWVL9o7Ze4yueblRcgx3qlYqMr7ReOaYFxOQ6Cv4g3Ttx5KSpN82bTSSPKsEz3IkjAHjX
	46aLXuq0EYoXi9lL/Dkd0KQJYEUW9sXPjdZIpaDyYlkNxUdGL05c5SEBMIjtOfXV8JFGJuL7IfF
	2xHeKnWmCHmHo3hxKCfQ4SeqNQ11rLT7uqgzuV6jW4Fvdh0Uufrw7yy0n5nWfSX8bHJkUcCx7Ij
	hUC8kOe3MmZl35+M3HQY=
X-Google-Smtp-Source: AGHT+IFtKlYmuMPWfMKQK8kh2VV5wwxeBA4j6ePEQHIEvAPMlC2NtpfOcLZrcYI7RZQRiXVuJwSHAw==
X-Received: by 2002:ac8:7f51:0:b0:476:838c:b0ce with SMTP id d75a77b69052e-47e7607d5ddmr844071cf.13.1745428641397;
        Wed, 23 Apr 2025 10:17:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cf9f29sm70808611cf.71.2025.04.23.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:17:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7diq-00000007LSZ-1iS9;
	Wed, 23 Apr 2025 14:17:20 -0300
Date: Wed, 23 Apr 2025 14:17:20 -0300
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
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250423171720.GL1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:01AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Introduce new sticky flag (HMM_PFN_DMA_MAPPED), which isn't overwritten
> by HMM range fault. Such flag allows users to tag specific PFNs with
> information if this specific PFN was already DMA mapped.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/linux/hmm.h | 17 +++++++++++++++
>  mm/hmm.c            | 51 ++++++++++++++++++++++++++++-----------------
>  2 files changed, 49 insertions(+), 19 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This would be part of the RDMA bits

Jason
