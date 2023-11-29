Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC28D7462
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--moritzf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdW49oU2"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5cd2100f467so84452747b3.1
        for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 22:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701238837; x=1701843637; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+OWUPjfBbVNUCejaH4Zx1SnJx7h3HvWotJzN/ystxs=;
        b=TdW49oU2y477HmMgPBPswONdfuom3jAhDc842p5XJnwONj3sJqwUfdUt51BamM254E
         guJZNTowwSKEHnLoD3E4VBLEjAm8MQDi2uFriGoL4z8/M+3KrGPQ37sWyXokeuhMuGzo
         ciD7VpVoS99uiwynVINQxy8vmJEJG7ZL7It2GFP/5bOlLsS5zOBTaZywE5IYszjau3gk
         uMgVqzv6qP6AsuZtSBmSvGiWolMYtl/CVrbg84IxFWrSktFXPyCr2V4CMjrbaRiIlk+l
         Qh2SpEKr9PD6RN6uRYvxABDiBV4YcECs4iDShWM3Lu/WS4H1KCSZqVHJe+ne4Qs1CSmO
         PXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701238837; x=1701843637;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+OWUPjfBbVNUCejaH4Zx1SnJx7h3HvWotJzN/ystxs=;
        b=DhGyAd/R5iQvZrhzJ37IbBvbqfzTkq7IEz53osEfrdXkYG11lbxP8+DkbWPs/mg4/g
         BZRd0Msc7IrltICdPPxfy6EQ+yPi0wM7hG/Rp9miUNnHt9iHss1Ru5PCjQ9QQzhXp8Gq
         LmoAhGLrcNjLeYjVCnOqIwUF9EjKzkeioKSaaYY10CSnQXzjLA3Ux11oba+8Thps255x
         r3VVn0fAa4HjmcTjGxJA//nT2WC4HtjwuuLWPCWn+Sy4+GJRCuBC6J5/MuOz9c5QOy3Z
         nlAm4w2Et1l7VISRpadj2L3tl76UGWP7VAicoYVuc9KrnQr7wq15BBcTz3/QCch6hTL5
         zkNg==
X-Gm-Message-State: AOJu0Yx20cUwKzxoeftTV2ll21KfGjctndLXDUkO/rwYIkxrPL2o6/cx
	8z0h0yjA/I9XHmIJjKLGlpFvvwqG9uX6
X-Google-Smtp-Source: AGHT+IGl2m8o4vcxyKfaevYjBuf0ZzzfYYiBjYjYyoamKSyXXxyRdZkkwSrexsSNRUrkDVXuH7e+Nb5/Bf9p
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a05:690c:4041:b0:5ce:550:685b with SMTP id
 ga1-20020a05690c404100b005ce0550685bmr480488ywb.5.1701238836860; Tue, 28 Nov
 2023 22:20:36 -0800 (PST)
Date: Wed, 29 Nov 2023 06:20:36 +0000
In-Reply-To: <10-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <0-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com> <10-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
Message-ID: <20231129062036.urdezihvds2pkuyo@google.com>
Subject: Re: [PATCH 10/10] ACPI: IORT: Allow COMPILE_TEST of IORT
From: Moritz Fischer <moritzf@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich <dakr@redhat.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, iommu@lists.linux.dev, 
	Jon Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
	Karol Herbst <kherbst@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Laxman Dewangan <ldewangan@nvidia.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
	linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, nouveau@lists.freedesktop.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter <sven@svenpeter.dev>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@lst.de>, 
	Jerry Snitselaar <jsnitsel@redhat.com>, Hector Martin <marcan@marcan.st>, Moritz Fischer <mdf@kernel.org>, 
	patches@lists.linux.dev, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

On Tue, Nov 28, 2023 at 08:48:06PM -0400, Jason Gunthorpe wrote:
> The arm-smmu driver can COMPILE_TEST on x86, so expand this to also
> enable the IORT code so it can be COMPILE_TEST'd too.

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/acpi/Kconfig        | 2 --
>   drivers/acpi/Makefile       | 2 +-
>   drivers/acpi/arm64/Kconfig  | 1 +
>   drivers/acpi/arm64/Makefile | 2 +-
>   drivers/iommu/Kconfig       | 1 +
>   5 files changed, 4 insertions(+), 4 deletions(-)

> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f819e760ff195a..3b7f77b227d13a 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -541,9 +541,7 @@ config ACPI_PFRUT
>   	  To compile the drivers as modules, choose M here:
>   	  the modules will be called pfr_update and pfr_telemetry.

> -if ARM64
>   source "drivers/acpi/arm64/Kconfig"
> -endif

>   config ACPI_PPTT
>   	bool
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index eaa09bf52f1760..4e77ae37b80726 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -127,7 +127,7 @@ obj-y				+= pmic/
>   video-objs			+= acpi_video.o video_detect.o
>   obj-y				+= dptf/

> -obj-$(CONFIG_ARM64)		+= arm64/
> +obj-y				+= arm64/

>   obj-$(CONFIG_ACPI_VIOT)		+= viot.o

> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index b3ed6212244c1e..537d49d8ace69e 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -11,6 +11,7 @@ config ACPI_GTDT

>   config ACPI_AGDI
>   	bool "Arm Generic Diagnostic Dump and Reset Device Interface"
> +	depends on ARM64
>   	depends on ARM_SDE_INTERFACE
>   	help
>   	  Arm Generic Diagnostic Dump and Reset Device Interface (AGDI) is
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 143debc1ba4a9d..71d0e635599390 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -4,4 +4,4 @@ obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>   obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>   obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
>   obj-$(CONFIG_ARM_AMBA)		+= amba.o
> -obj-y				+= dma.o init.o
> +obj-$(CONFIG_ARM64)		+= dma.o init.o
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 7673bb82945b6c..309378e76a9bc9 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -318,6 +318,7 @@ config ARM_SMMU
>   	select IOMMU_API
>   	select IOMMU_IO_PGTABLE_LPAE
>   	select ARM_DMA_USE_IOMMU if ARM
> +	select ACPI_IORT if ACPI
>   	help
>   	  Support for implementations of the ARM System MMU architecture
>   	  versions 1 and 2.
> --
> 2.42.0


Reviewed-by: Moritz Fischer <moritzf@google.com>

Ok, now the previous patch makes sense :)

Cheers,
Moritz
