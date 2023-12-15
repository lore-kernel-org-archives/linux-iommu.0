Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD137166
	for <iommu@lists.linux.dev>; Fri, 15 Dec 2023 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6da16eab6fcso626933a34.3
        for <iommu@lists.linux.dev>; Fri, 15 Dec 2023 07:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702653948; x=1703258748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1OnF5rGFzI5RvYpjVRPlVSvXceBOIEFaHqDyOjiYTA=;
        b=WF8EmGjhtKZP5cD/0VLGg9WDxExe5L/UchMvrb+pDL+TZGN2ZouUkacLHmmI6tFmlh
         ksu6gY85USvNj4GyqJz1E3dLUf/QKqb4DkGD/SrLoQwQQbi86d0pQ9utYh0IguYOGaHl
         ZrBnjwGXjFHGrh1Y8tUrEZwBioFFCP+KuMJlYcLyDlaJPMuupWv115wFsUIuc3LS91OS
         Iuf3o5t/5X5lt3OpPLP3tkD365swO8sxN6FBdiGsatNjuPsY6sT6cKbgsHe6V9CXMKJh
         Q9KnR/8R0uJxtG8F4J4nIlbJvvevTEdxFZ+/5FE8EjFHOiKv1VGxa5UFJkPZ9KtQbndz
         N7UA==
X-Gm-Message-State: AOJu0YyOII/CCrBs2gRQvS/Vie7yQLyDNrPtZDdccakMiRelgymv0fa3
	G3IHZ3W4IbFc8edXL8b8OA==
X-Google-Smtp-Source: AGHT+IFsgHE029QXbOE4x52loz8JfsphgGoxGT3Z/OzVbTeZDrjy5prKIU2NDeJ5VZf7w9GpT5FMig==
X-Received: by 2002:a05:6830:1517:b0:6d9:f68e:ded7 with SMTP id k23-20020a056830151700b006d9f68eded7mr11507380otp.64.1702653948485;
        Fri, 15 Dec 2023 07:25:48 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d16-20020a056830139000b006d874fc2555sm3671547otq.26.2023.12.15.07.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:25:47 -0800 (PST)
Received: (nullmailer pid 3996339 invoked by uid 1000);
	Fri, 15 Dec 2023 15:25:46 -0000
Date: Fri, 15 Dec 2023 09:25:46 -0600
From: Rob Herring <robh@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Dexuan Cui <decui@microsoft.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-acpi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, 
	Christoph Hellwig <hch@lst.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-arm-kernel@lists.infradead.org, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Wei Liu <wei.liu@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
	WANG Xuerui <kernel@xen0n.name>
Subject: Re: [PATCH v2 7/7] dma-mapping: Simplify arch_setup_dma_ops()
Message-ID: <170265394575.3996198.15248667149121379629.robh@kernel.org>
References: <cover.1702486837.git.robin.murphy@arm.com>
 <7e6af148e0df9a10b51cd60234ec6b35f7d4cc20.1702486837.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e6af148e0df9a10b51cd60234ec6b35f7d4cc20.1702486837.git.robin.murphy@arm.com>


On Wed, 13 Dec 2023 17:18:00 +0000, Robin Murphy wrote:
> The dma_base, size and iommu arguments are only used by ARM, and can
> now easily be deduced from the device itself, so there's no need to pass
> them through the callchain as well.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2: Make sure the ARM changes actually build (oops...)
> ---
>  arch/arc/mm/dma.c               |  3 +--
>  arch/arm/mm/dma-mapping-nommu.c |  3 +--
>  arch/arm/mm/dma-mapping.c       | 18 ++++++++++--------
>  arch/arm64/mm/dma-mapping.c     |  3 +--
>  arch/mips/mm/dma-noncoherent.c  |  3 +--
>  arch/riscv/mm/dma-noncoherent.c |  3 +--
>  drivers/acpi/scan.c             |  3 +--
>  drivers/hv/hv_common.c          |  6 +-----
>  drivers/of/device.c             |  4 +---
>  include/linux/dma-map-ops.h     |  6 ++----
>  10 files changed, 20 insertions(+), 32 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

