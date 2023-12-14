Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566ED60B9E
	for <iommu@lists.linux.dev>; Thu, 14 Dec 2023 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuLlAScU"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3364c9ba749so135081f8f.1
        for <iommu@lists.linux.dev>; Thu, 14 Dec 2023 08:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702572678; x=1703177478; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Usgg76jsYIefadLxnuqF6rdoT8QTltStQ3cD7RxnFLY=;
        b=AuLlAScUF/aksR1BrtRaK9vMpvx4wGJ5SiOiClGEyadds81Mdv8xlO9MI/wD1Qm2mw
         f2yk6LBxWEoY+Dj/x+dyohJfsSpsWy3WAFvr0lS9dYSBP/G3CXw49lWYCSxmicLHpoet
         9/+3gmf77W55HR7mLl94wCBK86quWj4F9dOb5uTmt5pf3ftzYVm/tc0/kl/kf4g2CX1W
         4D31Ei8ZqjY2KF41VH4xaf2pQsWno9vpxb1YGuK6w5mRf/EI3nb7p6KSmd/Sf19R9PoB
         ef/E871ltcaoqr5YoVU27VopWjbbqvdiO/d4aSqADk0sVPZevIaDXHeURNhHG+x4To4X
         K00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572678; x=1703177478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Usgg76jsYIefadLxnuqF6rdoT8QTltStQ3cD7RxnFLY=;
        b=FKAgn1p8bCwuqiazYFmOfkg/2ZOsZwISD0H2+PJQOI4zf3Blf3Jv4GfzsUEZK8HbUT
         Zyzo84ZIc0dOi5gsr4iLImdMxD73TWAWiqp+E7++dbxaq4mdTkCs/RTnpYA8GGtTmX2G
         tEOaRZgNZZwmSoLjbG9SfQr3FWf3BbRvY0Ig9MWdG1yjxKw4Y3OJeS/QxM54j+rgviGA
         MPWDCFgvQsBI7dgYRilDvLdSsS+8CGYR46DMLSf/c3AN9Q+j7OY1/FRh/GrVtqSY1ylO
         cxcQ09ngbP8eqCCCM8G8XrEo9bGd7A547qlYOcod5UG3K2PAB7UDHgDaLuBLyW4jVfyq
         404A==
X-Gm-Message-State: AOJu0Yy7Mbjm/SN58ODNfgqsNBJn2F5yMaQx6euFviOjKVMoSqzKUciY
	zqZM4vw1hbe9fXHzEhYAh4+7kAjH0gBEc2kDNvXgpA==
X-Google-Smtp-Source: AGHT+IFBMhJj6OgBJFoBT/wwSuMBs9mGXlacijvXWzHs6AsF1SDBWLDmS4Y/dcB+WWbQ8eP+CZ35gg==
X-Received: by 2002:a05:6000:1e8e:b0:336:4256:c7d7 with SMTP id dd14-20020a0560001e8e00b003364256c7d7mr632414wrb.111.1702572678542;
        Thu, 14 Dec 2023 08:51:18 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id q18-20020adff952000000b0033609b71825sm16076369wrr.35.2023.12.14.08.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:51:18 -0800 (PST)
Date: Thu, 14 Dec 2023 16:51:26 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
Message-ID: <20231214165126.GA3726750@myrica>
References: <cover.1702486837.git.robin.murphy@arm.com>
 <5d89190b35720bf5b66621f46b6d3c85323d8eab.1702486837.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d89190b35720bf5b66621f46b6d3c85323d8eab.1702486837.git.robin.murphy@arm.com>

On Wed, Dec 13, 2023 at 05:17:59PM +0000, Robin Murphy wrote:
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 27a167f4cd3e..d808c8dcf5cb 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1724,25 +1724,20 @@ static const struct dma_map_ops iommu_dma_ops = {
>  	.opt_mapping_size	= iommu_dma_opt_mapping_size,
>  };
>  
> -/*
> - * The IOMMU core code allocates the default DMA domain, which the underlying
> - * IOMMU driver needs to support via the dma-iommu layer.
> - */
> -void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
> +void iommu_setup_dma_ops(struct device *dev)
>  {
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>  
> -	if (!domain)
> -		goto out_err;
> +	if (dev_is_pci(dev))
> +		dev->iommu->pci_32bit_workaround = !iommu_dma_forcedac;
>  
> -	/*
> -	 * The IOMMU core code allocates the default DMA domain, which the
> -	 * underlying IOMMU driver needs to support via the dma-iommu layer.
> -	 */
>  	if (iommu_is_dma_domain(domain)) {

...

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 824989874dee..43f630d0530e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -560,10 +560,10 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  		if (list_empty(&group->entry))
>  			list_add_tail(&group->entry, group_list);
>  	}
> -	mutex_unlock(&group->mutex);
>  
> -	if (dev_is_pci(dev))
> -		iommu_dma_set_pci_32bit_workaround(dev);
> +	iommu_setup_dma_ops(dev);

With Intel VT-d (QEMU emulation) I get a crash in iommu_setup_dma_ops()
because at this point group->domain and group->default_domain are still
NULL, group_list is non-NULL.

No problem with x86 virtio-iommu, it goes through
iommu_setup_default_domain() earlier in the function. Arm virtio-iommu is
fine too.

Thanks,
Jean

