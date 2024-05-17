Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D72D168B9
	for <iommu@lists.linux.dev>; Fri, 17 May 2024 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930400; cv=none; b=u4cYAbI4qj0VfbG+3q8Kem000ImLNYjk15o6rbDRQ19Z8ts92jE1pn3Zwqr9KyqnfT7pCLAhYU5ngNdsHrJRWAh98q7dRJgMB6DAIYBapwb7c5kCDehyLH3V5eQw2eXY22B7bqmH4XYZlwrN2ZFOYrV8CX5PZQWqA85CPg3rEK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930400; c=relaxed/simple;
	bh=VPdVtsCdvH0FWtAzjEnwbG4aKW0bLBPevKsTmJFxsLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YR/MqaJlHeHkAXINmEbiPPLszj6BoH03XLsFp/dHGkSMyAlhozkj0R7py5WV8afEgVsJfaTD2y+nMr1eF1XZOoO4VWC8mB4JGgD5YuxVLg79bfQcfMNstRsEPFMGD2iuGu6zGkMdgQtxozvLe1tPcpXJBLMkIBRyli4LWQFO2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WILnOzdx; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WILnOzdx"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7e1b5173ddcso101940439f.1
        for <iommu@lists.linux.dev>; Fri, 17 May 2024 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715930398; x=1716535198; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DARwQ7xcLW9SgOpwsz1tepc/1IVi/5Qc1nde5sSyF/U=;
        b=WILnOzdxf7PnMx1ntVMQJlJ3f1xgBSKzI+dS3HVwyXpCdDyoLJNVmR86BPbHj2Ehcd
         TJYXHeIGMRU+kFcNV0S7dR8GsvpfFYMruMEBTSWIw1n613VqplsIKlY7/OPQ2mfW33Vh
         3W5brD6y/22x3zqiJefJXZpkb1ImOymBc8ATnH8jUGSeNh9ZaqZf0xHdLtu4EWGDSKAu
         RU8ad64/PHF+udxQJdawDbvXTXwO2GjC57Xb2zpd6wG7ZlQUBmoJu/ZDsaohw9HvLiea
         x9kolJRLCmolqb5CUAgx0nQxdFCMaXqMNzZO63cn5O3rQ5cNchwOWwzsHTLblA4ix/yC
         Aq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715930398; x=1716535198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DARwQ7xcLW9SgOpwsz1tepc/1IVi/5Qc1nde5sSyF/U=;
        b=dTcJp8CRfG4sTdsxZmOeMEnSVfHei+8XP6upXFo1a+WOQdmUxRQDHxcgTYGxPosQT7
         ANjswK7+9mVSuF9QHIoZbooHns56bgXwtYAXKXARIpYsUKpvQoNti4yrMW1J2FoOci//
         Gw8cBUgE+pl+6zlQHGPN7sqRx+nVNj0Md9uNLjfE1Oh4Klu0QGRGyN2i8VljpJM7yNM2
         b2R57rTvmv62yU2P72rIoZghPh7v3xq63mxJpRQd3j2rKytXUp9WrLeCTdMe2XIdPbDQ
         MXL7cIUp6wmHJkTL84ZzB6KKjzJEhLlrpaX2fNcHPmq8UXoLZJawuCfLlzEoJ7eNsPOG
         RjKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeDm47EMNX4FeaFs2mVmj+9pVBINNAx/ZNh9zO+NFHrq1/FiyWnIzCQ2NKxsDADowvqS8RQvoO62K7NKbjEFhXSWhNIvk=
X-Gm-Message-State: AOJu0Yzpy4hL5q2KRJwJ7LHmUQnsgkMV6y3IeUMdJ0bk9MHF8r+c78EB
	231PALNqeJVrm9st7PBjBR5GHPhDG0wEL2W4FL1XCJWoh2ccJ0RJ9bXauXuyDc1j8SrMnjKlrRQ
	Bo4cG02LMAAiFk/ebv1cUo/3Mfz46lPO+cleh8Q==
X-Google-Smtp-Source: AGHT+IG1fjp7xxbg2syelNzLcWdSnkAmZ5HEN4zUxVFk7Uehy8tOYpkomfU3wpTuk49Q+M+PRGzHlSGJOXy2iAV7KzU=
X-Received: by 2002:a6b:7f42:0:b0:7e1:839e:5ab3 with SMTP id
 ca18e2360f4ac-7e1b51ba8a6mr2350130739f.6.1715930398577; Fri, 17 May 2024
 00:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1715708679.git.tjeznach@rivosinc.com> <518a4b0bf651707a9508c169fe3868e669ec2c6d.1715708679.git.tjeznach@rivosinc.com>
In-Reply-To: <518a4b0bf651707a9508c169fe3868e669ec2c6d.1715708679.git.tjeznach@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 17 May 2024 15:19:48 +0800
Message-ID: <CANXhq0q60CeN7nx7ubG580HgSOmPQZgu5oJLfcUf0wRhSj-z9g@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] iommu/riscv: Enable IOMMU registration and device probe.
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, 
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, 
	Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 2:17=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> Advertise IOMMU device and its core API.
> Only minimal implementation for single identity domain type, without
> per-group domain protection.
>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/riscv/iommu.c | 66 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 3c5a6b49669d..b8e0e4b62585 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -17,6 +17,7 @@
>  #include <linux/init.h>
>  #include <linux/iommu.h>
>  #include <linux/kernel.h>
> +#include <linux/pci.h>
>
>  #include "iommu-bits.h"
>  #include "iommu.h"
> @@ -36,6 +37,60 @@ static void riscv_iommu_disable(struct riscv_iommu_dev=
ice *iommu)
>         riscv_iommu_writel(iommu, RISCV_IOMMU_REG_PQCSR, 0);
>  }
>
> +static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu=
_domain,
> +                                             struct device *dev)
> +{
> +       /* Global pass-through already enabled, do nothing for now. */
> +       return 0;
> +}
> +
> +static struct iommu_domain riscv_iommu_identity_domain =3D {
> +       .type =3D IOMMU_DOMAIN_IDENTITY,
> +       .ops =3D &(const struct iommu_domain_ops) {
> +               .attach_dev =3D riscv_iommu_attach_identity_domain,
> +       }
> +};
> +
> +static int riscv_iommu_device_domain_type(struct device *dev)
> +{
> +       return IOMMU_DOMAIN_IDENTITY;
> +}
> +
> +static struct iommu_group *riscv_iommu_device_group(struct device *dev)
> +{
> +       if (dev_is_pci(dev))
> +               return pci_device_group(dev);
> +       return generic_device_group(dev);
> +}
> +
> +static int riscv_iommu_of_xlate(struct device *dev, const struct of_phan=
dle_args *args)
> +{
> +       return iommu_fwspec_add_ids(dev, args->args, 1);
> +}
> +
> +static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
> +{
> +       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> +       struct riscv_iommu_device *iommu;
> +
> +       if (!fwspec || !fwspec->iommu_fwnode->dev || !fwspec->num_ids)
> +               return ERR_PTR(-ENODEV);
> +
> +       iommu =3D dev_get_drvdata(fwspec->iommu_fwnode->dev);
> +       if (!iommu)
> +               return ERR_PTR(-ENODEV);
> +
> +       return &iommu->iommu;
> +}
> +
> +static const struct iommu_ops riscv_iommu_ops =3D {
> +       .of_xlate =3D riscv_iommu_of_xlate,
> +       .identity_domain =3D &riscv_iommu_identity_domain,
> +       .def_domain_type =3D riscv_iommu_device_domain_type,
> +       .device_group =3D riscv_iommu_device_group,
> +       .probe_device =3D riscv_iommu_probe_device,
> +};
> +
>  static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
>  {
>         u64 ddtp;
> @@ -71,6 +126,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_d=
evice *iommu)
>
>  void riscv_iommu_remove(struct riscv_iommu_device *iommu)
>  {
> +       iommu_device_unregister(&iommu->iommu);
>         iommu_device_sysfs_remove(&iommu->iommu);
>  }
>
> @@ -95,5 +151,15 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu=
)
>                 return dev_err_probe(iommu->dev, rc,
>                                      "cannot register sysfs interface\n")=
;
>
> +       rc =3D iommu_device_register(&iommu->iommu, &riscv_iommu_ops, iom=
mu->dev);
> +       if (rc) {
> +               dev_err_probe(iommu->dev, rc, "cannot register iommu inte=
rface\n");
> +               goto err_remove_sysfs;
> +       }
> +
>         return 0;
> +
> +err_remove_sysfs:
> +       iommu_device_sysfs_remove(&iommu->iommu);
> +       return rc;
>  }

Reviewed-by: Zong Li <zong.li@sifive.com>

Thanks

> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
