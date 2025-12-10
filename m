Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6C309F14
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765375673; cv=none; b=Ye2SOCjzwbzVFMA2xWQto1U0vYZrBl1k63b+PXzlh3HIVby6KdEEqoh0utBT3JJ0JeDGt8QLW2cMXnXro6rQ8tvnpAiwsAK+Vnbsc+lA+1jo5yuClYCFXEZjPvOa9ISL2x5U+i+9QxtCa2aC2GtztuXKdc+lsR5F9b6pDbfo6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765375673; c=relaxed/simple;
	bh=yQrmP/ddz2UFF9U8IaDxmVhZCjQWvJ69Icm4YAnbV68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kt42kXMasCkp2fDrVwrvwSJBOSdkacOMUTY7ENXiYBXgibn0njXW9DFkehMR9W/AI4JYDW4c7OBZqID24UdjE6rym69ycLAkQewB+dmBluqTuMhc6btdN7Pwxdrn8kcgt8efLneTM5Z2GQVnlBl1iqe6Cu0coDL5GDyiYMOPJ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw0wItrX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw0wItrX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB85C19421
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765375673;
	bh=yQrmP/ddz2UFF9U8IaDxmVhZCjQWvJ69Icm4YAnbV68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iw0wItrX7C0nJcgcSkuC2hPfsGcyLB+ObuJw3KhWylu8TCWzr0Uuw9lpypfQciGLA
	 OEmua7XZnAhspzkOU5AP33CxzmlqcwrVgiFVI0WPjaiz5wa2u9fk2gmUheeNwPM65I
	 dFIeto2jezE70L2ILAcodRANSBBGWCyrJZKTIv3KRqALGll0ddmfJM4+qMDS5599XQ
	 k0L3dfKTTlug2JWo4bnomNFy437u8W8ITiwUqGHwagayHzCgHoOTsjbqXET6lhvLQT
	 7t4VM9GuAO7OMMdJZdZGdEYm4pD8D4013NyVCCFCWk7gB9RCc9otpX4s1owPB02CZX
	 lvae0ygL90EBQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so8925993a12.0
        for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 06:07:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOKWphzB6+Ea0e1qQlv+zjLZmlusDhPZJ992oPj0YQVHBsQ6LOI87SeGit3/vZTRFoQbY3nQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqJXUaCrHfn0ZxKMBw3/Eh21zk4/R75cmanIKvssQDQsiCmIed
	ip9d9vlWnreCGr5/QcQC+630mj3TWkOBg823ZCDeN8ZopujwZpH5tZZGu1JU9ymcs3JB1e6wt/s
	JUwvZeIu+LUa6zcmQpFbigzQSFqW5ZA==
X-Google-Smtp-Source: AGHT+IHR6xFYszK4+K1zJ7x34fdqaraQe5y8W2mKlsyfVWqY61VgJjpoj/hoG+yp3nKa95huvBVNGi6O5OEIefwAUag=
X-Received: by 2002:a05:6402:35cb:b0:647:57c5:549a with SMTP id
 4fb4d7f45d1cf-6496da194dfmr2513983a12.20.1765375671662; Wed, 10 Dec 2025
 06:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 10 Dec 2025 08:07:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL6VVQ7K_ZAbHJ8Gb7ei_jusLx6wRn=AdOVgV50dX0ejQ@mail.gmail.com>
X-Gm-Features: AQt7F2p_dxGJAxRHeQhlsZFZpT-Z5idQ0sbvxfj8M1nY1-hCH2HKJsHw2kaRQuU
Message-ID: <CAL_JsqL6VVQ7K_ZAbHJ8Gb7ei_jusLx6wRn=AdOVgV50dX0ejQ@mail.gmail.com>
Subject: Re: [PATCH] of: reserved_mem: Allow reserved_mem framework detect
 "cma=" kernel param
To: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Cc: m.szyprowski@samsung.com, ye.li@oss.nxp.com, kernel@oss.qualcomm.com, 
	saravanak@google.com, akpm@linux-foundation.org, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, robin.murphy@arm.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, quic_c_gdjako@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 6:20=E2=80=AFPM Oreoluwa Babatunde
<oreoluwa.babatunde@oss.qualcomm.com> wrote:
>
> When initializing the default cma region, the "cma=3D" kernel parameter
> takes priority over a DT defined linux,cma-default region. Hence, give
> the reserved_mem framework the ability to detect this so that the DT
> defined cma region can skip initialization accordingly.

Please explain here why this is a new problem. Presumably the
RESERVEDMEM_OF_DECLARE hook after commit xxxx gets called before the
early_param hook. And why is it now earlier?

I don't really like the state/ordering having to be worried about in 2 plac=
es.

> Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
> ---
>  drivers/of/of_reserved_mem.c | 19 +++++++++++++++++--
>  include/linux/cma.h          |  1 +
>  kernel/dma/contiguous.c      | 16 ++++++++++------
>  3 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 2e9ea751ed2d..bef68a4916b5 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -158,7 +158,7 @@ static int __init __reserved_mem_reserve_reg(unsigned=
 long node,
>         phys_addr_t base, size;
>         int len;
>         const __be32 *prop;
> -       bool nomap;
> +       bool nomap, default_cma;
>
>         prop =3D of_get_flat_dt_prop(node, "reg", &len);
>         if (!prop)
> @@ -171,6 +171,12 @@ static int __init __reserved_mem_reserve_reg(unsigne=
d long node,
>         }
>
>         nomap =3D of_get_flat_dt_prop(node, "no-map", NULL) !=3D NULL;
> +       default_cma =3D of_get_flat_dt_prop(node, "linux,cma-default", NU=
LL);
> +
> +       if (default_cma && cma_skip_dt_default_reserved_mem()) {
> +               pr_err("Skipping dt linux,cma-default for \"cma=3D\" kern=
el param.\n");
> +               return -EINVAL;
> +       }
>
>         while (len >=3D t_len) {
>                 base =3D dt_mem_next_cell(dt_root_addr_cells, &prop);
> @@ -256,12 +262,15 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
>
>         fdt_for_each_subnode(child, fdt, node) {
>                 const char *uname;
> +               bool default_cma =3D of_get_flat_dt_prop(child, "linux,cm=
a-default", NULL);
>
>                 prop =3D of_get_flat_dt_prop(child, "reg", &len);
>                 if (!prop)
>                         continue;
>                 if (!of_fdt_device_is_available(fdt, child))
>                         continue;
> +               if (default_cma && cma_skip_dt_default_reserved_mem())
> +                       continue;
>
>                 uname =3D fdt_get_name(fdt, child, NULL);
>                 if (len && len % t_len !=3D 0) {
> @@ -406,7 +415,7 @@ static int __init __reserved_mem_alloc_size(unsigned =
long node, const char *unam
>         phys_addr_t base =3D 0, align =3D 0, size;
>         int len;
>         const __be32 *prop;
> -       bool nomap;
> +       bool nomap, default_cma;
>         int ret;
>
>         prop =3D of_get_flat_dt_prop(node, "size", &len);
> @@ -430,6 +439,12 @@ static int __init __reserved_mem_alloc_size(unsigned=
 long node, const char *unam
>         }
>
>         nomap =3D of_get_flat_dt_prop(node, "no-map", NULL) !=3D NULL;
> +       default_cma =3D of_get_flat_dt_prop(node, "linux,cma-default", NU=
LL);
> +
> +       if (default_cma && cma_skip_dt_default_reserved_mem()) {
> +               pr_err("Skipping dt linux,cma-default for \"cma=3D\" kern=
el param.\n");
> +               return -EINVAL;
> +       }
>
>         /* Need adjust the alignment to satisfy the CMA requirement */
>         if (IS_ENABLED(CONFIG_CMA)
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 62d9c1cf6326..3d3047029950 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -47,6 +47,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys=
_addr_t size,
>                                         unsigned int order_per_bit,
>                                         const char *name,
>                                         struct cma **res_cma);
> +extern bool cma_skip_dt_default_reserved_mem(void);
>  extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsi=
gned int align,
>                               bool no_warn);
>  extern bool cma_pages_valid(struct cma *cma, const struct page *pages, u=
nsigned long count);
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index d9b9dcba6ff7..9071c08650e3 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -90,6 +90,16 @@ static int __init early_cma(char *p)
>  }
>  early_param("cma", early_cma);
>
> +/*
> + * cma_skip_dt_default_reserved_mem - This is called from the
> + * reserved_mem framework to detect if the default cma region is being
> + * set by the "cma=3D" kernel parameter.
> + */
> +bool __init cma_skip_dt_default_reserved_mem(void)
> +{
> +       return size_cmdline !=3D -1;
> +}
> +
>  #ifdef CONFIG_DMA_NUMA_CMA
>
>  static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
> @@ -463,12 +473,6 @@ static int __init rmem_cma_setup(struct reserved_mem=
 *rmem)
>         struct cma *cma;
>         int err;
>
> -       if (size_cmdline !=3D -1 && default_cma) {
> -               pr_info("Reserved memory: bypass %s node, using cmdline C=
MA params instead\n",
> -                       rmem->name);
> -               return -EBUSY;
> -       }
> -
>         if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
>             of_get_flat_dt_prop(node, "no-map", NULL))
>                 return -EINVAL;
> --
> 2.34.1
>
>
