Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA128DB0;
	Mon,  6 Nov 2023 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5841a3ffd50so1009632eaf.1;
        Mon, 06 Nov 2023 06:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281182; x=1699885982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdHOkDDDq2uDsqnfkV1g2ITyJ/uBNt8L8qaNucWn9Lg=;
        b=qHkFtZmJQjs+O7SbMvfczB+EvSOwNe6XJ8R9yE+cjOoGHr7sKSiiwEBN5UFuWoZfIc
         6JyWphwBvZXqCJnN9feqyox0xeZlzUNttoaoXXyX6tJVTlxqB8IG8VG77TvrQzsQQ5AU
         45mu0pDbTsp2jdRkdKRInsrm3vKCBn8dp7dlizL7noE66ETgGRrMt3Gcg7XQgy7SgBXh
         3cFWHc+dH3dcIfxC4RJQX3C92EBbSfF3AZ56xuvd8qoqv/J9rmWXVkzcYhEpzHkrQdwa
         0oCl2XVHJRri8lB5q9PViQR7pb0PVVYmqoos/UoZF96iMJpEy8hPhn14BvfWOSbegRF2
         cU7Q==
X-Gm-Message-State: AOJu0Yw1hf20gz94tMQcKB0/gqcNLR6r/pdjf4xtAUwQ3z8LWnhvyYrg
	hspWWjGYha8hSw1LvBZwofOiwszXXwZlkM7awhw=
X-Google-Smtp-Source: AGHT+IHyHB4kzvcjkEhTb+3sUVIPXXX0cO5Y7IiQxSg2gu4OXnnfVIuOscNqmkEqJcDtSiyYa7NRTI4+Cg8Mb+uLm9Y=
X-Received: by 2002:a4a:d68a:0:b0:584:1080:f0a5 with SMTP id
 i10-20020a4ad68a000000b005841080f0a5mr31132550oot.1.1699281182420; Mon, 06
 Nov 2023 06:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com> <4-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <4-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Nov 2023 15:32:51 +0100
Message-ID: <CAJZ5v0hepKO0QKuBF3d38r=7nG0tjTtEwXdPNPv_2jYPnToUsg@mail.gmail.com>
Subject: Re: [PATCH RFC 04/17] acpi: Do not return struct iommu_ops from acpi_iommu_configure_id()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linuxfoundation.org, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
	linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Hector Martin <marcan@marcan.st>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter <sven@svenpeter.dev>, 
	Thierry Reding <thierry.reding@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, 
	virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Zhenhua Huang <quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 5:45=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> Nothing needs this pointer. Return a normal error code with the usual
> IOMMU semantic that ENODEV means 'there is no IOMMU driver'.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/scan.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a6891ad0ceee2c..fbabde001a23a2 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1562,8 +1562,7 @@ static inline const struct iommu_ops *acpi_iommu_fw=
spec_ops(struct device *dev)
>         return fwspec ? fwspec->ops : NULL;
>  }
>
> -static const struct iommu_ops *acpi_iommu_configure_id(struct device *de=
v,
> -                                                      const u32 *id_in)
> +static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>  {
>         int err;
>         const struct iommu_ops *ops;
> @@ -1574,7 +1573,7 @@ static const struct iommu_ops *acpi_iommu_configure=
_id(struct device *dev,
>          */
>         ops =3D acpi_iommu_fwspec_ops(dev);
>         if (ops)
> -               return ops;
> +               return 0;
>
>         err =3D iort_iommu_configure_id(dev, id_in);
>         if (err && err !=3D -EPROBE_DEFER)
> @@ -1589,12 +1588,14 @@ static const struct iommu_ops *acpi_iommu_configu=
re_id(struct device *dev,
>
>         /* Ignore all other errors apart from EPROBE_DEFER */
>         if (err =3D=3D -EPROBE_DEFER) {
> -               return ERR_PTR(err);
> +               return err;
>         } else if (err) {
>                 dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> -               return NULL;
> +               return -ENODEV;
>         }
> -       return acpi_iommu_fwspec_ops(dev);
> +       if (!acpi_iommu_fwspec_ops(dev))
> +               return -ENODEV;
> +       return 0;
>  }
>
>  #else /* !CONFIG_IOMMU_API */
> @@ -1623,7 +1624,7 @@ static const struct iommu_ops *acpi_iommu_configure=
_id(struct device *dev,
>  int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>                           const u32 *input_id)
>  {
> -       const struct iommu_ops *iommu;
> +       int ret;
>
>         if (attr =3D=3D DEV_DMA_NOT_SUPPORTED) {
>                 set_dma_ops(dev, &dma_dummy_ops);
> @@ -1632,10 +1633,15 @@ int acpi_dma_configure_id(struct device *dev, enu=
m dev_dma_attr attr,
>
>         acpi_arch_dma_setup(dev);
>
> -       iommu =3D acpi_iommu_configure_id(dev, input_id);
> -       if (PTR_ERR(iommu) =3D=3D -EPROBE_DEFER)
> +       ret =3D acpi_iommu_configure_id(dev, input_id);
> +       if (ret =3D=3D -EPROBE_DEFER)
>                 return -EPROBE_DEFER;
>
> +       /*
> +        * Historically this routine doesn't fail driver probing due to e=
rrors
> +        * in acpi_iommu_configure()
> +        */
> +
>         arch_setup_dma_ops(dev, 0, U64_MAX, attr =3D=3D DEV_DMA_COHERENT)=
;
>
>         return 0;
> --
> 2.42.0
>
