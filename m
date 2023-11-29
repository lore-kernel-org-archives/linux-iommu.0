Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A2B1DDCE
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UL7BLVqX"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6d84ddd642fso164147a34.0
        for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 12:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701290444; x=1701895244; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4is+UaFXgNmfUwcjSjgaiG0RVAiB9ug48COJL1kEfc=;
        b=UL7BLVqXj2LByqaHMJTxfx6PoGNkX8SOm7lraB7KAX4hgEN+i+cYhxWSRloFUnVFB0
         lQneV5A7mvYJwSBBJq8M6mjsdZwiA0X0c9unTDhq4lIxY+q/mpWRs71+YZf2apgagEbC
         c8DcrqRfwGnYlOilIRVLdWCld9Hq9Jkcd554Xgye4801Zgy9heM+s9n7+EzhgwHUUgAP
         sXkJfr1c/vfvcStu5Luq3KUQfK9fcMxBjWMRM6uVr0ziwg4sn1YhdOP/Q9ZNhhWd5h5u
         a+AWRzJHwsn7IbSoAA9q4v1INIQ04ebOd8b3pKnPeTLl0NsDbeCj2UXA15dsMbwGhB5v
         rRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701290444; x=1701895244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4is+UaFXgNmfUwcjSjgaiG0RVAiB9ug48COJL1kEfc=;
        b=C0OEmy4hT9zslC1Wqyhe7z53BzujOYFgRfZeUPoHKRrVmyVu4JH+qyyBp29Vqsvx/f
         TOB+Vhvg52fTACYUTIYkI6hgGUoBFyosYX1bitSdk5dRJ2a8WHC9McPtFrl2CYKy2lOL
         XjuBPc3cF/Dbz03XIPW3RXDYVil9YO9QpelQ4/+P3jV6ktG7DMNNCOpAMuCLtN9Cva9m
         +QqsiJSmLGgewC8rsvQ8pEnhJZwrk3LHZNedFDKYboOmN8pN132fegaKKrlBttpoqU1l
         /P+0+9KQ1xlIyARvbMtQK6xMwMjO4ccTTmk9AwELDmqFGgrDhuotusg1e6OgV60sxXmy
         ZhHg==
X-Gm-Message-State: AOJu0YzcOPPV+BxgaqqRA9DrUtt/ro7CaCgfT8NZ9a4I29ziEy5ZE5dZ
	O8slsk3STwZG8weVpi7ho48uVQ==
X-Google-Smtp-Source: AGHT+IEnrq+40pWqc9tikvXUqS6Y6R2hs7giuPFXyADBt3dDnfao9L3w+T91fxfG4h2rkEvYDjFXYw==
X-Received: by 2002:a05:6830:1d41:b0:6d6:3ff8:aab7 with SMTP id p1-20020a0568301d4100b006d63ff8aab7mr19895331oth.1.1701290444152;
        Wed, 29 Nov 2023 12:40:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id e11-20020a9d560b000000b006d3161e612dsm2113398oti.30.2023.11.29.12.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:40:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8RMQ-005pfu-R5;
	Wed, 29 Nov 2023 16:40:42 -0400
Date: Wed, 29 Nov 2023 16:40:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
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
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/7] dma-mapping: Add helpers for dma_range_map bounds
Message-ID: <20231129204042.GP1312390@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <b6626985d97ddc33a23b4b9fafa881b35001547e.1701268753.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6626985d97ddc33a23b4b9fafa881b35001547e.1701268753.git.robin.murphy@arm.com>

On Wed, Nov 29, 2023 at 05:43:01PM +0000, Robin Murphy wrote:
> Several places want to compute the lower and/or upper bounds of a
> dma_range_map, so let's factor that out into reusable helpers.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/loongarch/kernel/dma.c |  9 ++-------
>  drivers/acpi/arm64/dma.c    |  8 +-------
>  drivers/of/device.c         | 11 ++---------
>  include/linux/dma-direct.h  | 18 ++++++++++++++++++
>  4 files changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
