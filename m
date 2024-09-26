Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503A13777E
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376218; cv=none; b=XyDOVovzSlRkNcWReKNNStn7sNj3QIciPYO9xzNsSXcQcQdPF6EJKv+Fb7UQ5R1kfkPWgZKiji+rSoh+okloMQY2Cn+QvLRV5Z7slXgxHstRZlLvuoMpkztVq2X93DIKpRyxLLX0bmf/OzkYnKTkmjQFaWHIerxxj6OLFj8rNgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376218; c=relaxed/simple;
	bh=a/5m2zK58zkx4nM/V+xJ6JyzxFdkSfEPu9cHhxirWfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS99qLRw7aD8pHCMnSuNVd4FVjZhg5Lp4Hl8BsBdV26PVx8ooKyFQ2WyBhU7XonkgnAUXpu97Q82NhpSAYEYiqVPXqzaAUBNpRWtD8oZCavkzptT4qprzLmFfPDWbBVcGRxrxyGJBZrLcwPaTF5tm+DsN1QNCVPkewhWoZ7NRt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Fu8szUlC; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Fu8szUlC"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a99de9beb2so95817185a.3
        for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727376215; x=1727981015; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KvJvu5IaRTnr9xdXUsqatTaQ8tmdeCfcwtrsxrBZQ1g=;
        b=Fu8szUlCSYwD6Wk8uRc83uNqh3BoBQ4m4UjU3FJGxsD16gtrcfFmYkunIxFnq74GZi
         Lk57IBZL5Ouaox7OZ62FGNPmvuBBKoxSWfb7ryQKrW14snkQVTNszi9iod/zAbim9Jke
         a70JcwkUgGfZPpUShBSUN/iVdb3uNoP28kHnIw+5yiS8yV5XXoLaXlhZmxkiz9kJ/vod
         pbYNUMpuLlF/g3IdjfmmeSrW8zM7nPmZOGg5qD15pxah6FI+yJHm0f4+Lrc5xTw8mslm
         g42SPtZ2TKhHzSNI1/sz6PX+By5AzlXMAoPs337EYL6dhcgsF+EG5ziQsewzZA1LvDm/
         xfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727376215; x=1727981015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvJvu5IaRTnr9xdXUsqatTaQ8tmdeCfcwtrsxrBZQ1g=;
        b=JdcWzzz/roUZgGFBPvJyfG04ZnhzptS7D6g7fZTH7ifJ7GNZ6ehVxyELwHI6NQ0Xsy
         bwIkb9fL37eOzOUSr05hEr6fzoGZXMn1rMq/H5eh9cqm1NXsEBiOLvfE4cFpPpWpcPTk
         LKVJr5nU4iYi+dEwTdICKe8AbefqnCTB1S4TBNZ0Aqi6hBZjg589Azaqlgynq7BGCE1w
         p68ZcqIC3L3sFgxrwgF/AZRxmssvcbmS8f8ZGQCQOwtQDfL/FYPkTX0LFVrB+5NbfK01
         VO1JcGNBW9c4k/vr/uOllroitlEPWO35pCvWm9w0B7+94byvDfmbxKIRUmYa4Aur+HeO
         WUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfJO2c4rLccwqmIQ9T54U4WkEwbXL0NvVCT4K4eH5YCgU/DRcwgvdlXh0yc8J1+DN2jjGrsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoWZR6sBJH1mPSX6C3ymWySn35dPHZW2PsEq2u9aC1SvSrL5Md
	kJSxY3gwxI6GE0jbidi5n4s/g8HVp+LrRzlwTpd9KJf3/WdNgTMoyZvTaMHORmQ=
X-Google-Smtp-Source: AGHT+IHahoaHFJtuu1gsK0aQtYJow2bdyMNiogW2IcChPTuHJqaCLBrGWEI30mWx2ZRm25asoXWR5w==
X-Received: by 2002:a05:620a:44c2:b0:7a9:b425:6 with SMTP id af79cd13be357-7ae37838380mr75987185a.24.1727376214700;
        Thu, 26 Sep 2024 11:43:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3782a221sm15168385a.73.2024.09.26.11.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:43:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sttSf-000qCj-2k;
	Thu, 26 Sep 2024 15:43:33 -0300
Date: Thu, 26 Sep 2024 15:43:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
	baolu.lu@linux.intel.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, svens@linux.ibm.com, jroedel@suse.de,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v4] iommu/s390: Implement blocking domain
Message-ID: <20240926184333.GD9634@ziepe.ca>
References: <20240910211516.137933-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910211516.137933-1-mjrosato@linux.ibm.com>

On Tue, Sep 10, 2024 at 05:15:16PM -0400, Matthew Rosato wrote:
> This fixes a crash when surprise hot-unplugging a PCI device. This crash
> happens because during hot-unplug __iommu_group_set_domain_nofail()
> attaching the default domain fails when the platform no longer
> recognizes the device as it has already been removed and we end up with
> a NULL domain pointer and UAF. This is exactly the case referred to in
> the second comment in __iommu_device_set_domain() and just as stated
> there if we can instead attach the blocking domain the UAF is prevented
> as this can handle the already removed device. Implement the blocking
> domain to use this handling.  With this change, the crash is fixed but
> we still hit a warning attempting to change DMA ownership on a blocked
> device.
> 
> Fixes: c76c067e488c ("s390/pci: Use dma-iommu layer")
> Co-developed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> Changes for v4:
> - fix lockdep assert
> Changes for v3:
> - make blocking_domain type iommu_domain
> - change zdev->s390_domain to type iommu_domain and remove most uses
> - remove s390_iommu_detach_device, use blocking domain attach
> - add spinlock to serialize zdev->s390_domain change / access to counters
> ---
>  arch/s390/include/asm/pci.h |  4 +-
>  arch/s390/pci/pci.c         |  3 ++
>  arch/s390/pci/pci_debug.c   | 10 ++++-
>  drivers/iommu/s390-iommu.c  | 73 +++++++++++++++++++++++--------------
>  4 files changed, 59 insertions(+), 31 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
