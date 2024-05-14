Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548718EAB
	for <iommu@lists.linux.dev>; Tue, 14 May 2024 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715666209; cv=none; b=iT1KlQxSd1dM5WTXQ9No3WWn7DYNJGWGh4Lv2LJvUX2j9jX5Ho0lr9a6DLBw1A8G2+mY6RYlxHhxhxhfqYymIgoF/54NlEW4tAaMHOwsz0ok3xVY3fAhVIR1lLaQ3F3vdF7N2O44w+MElONjHJERpjRqPY/qLU82ixxdKbkis2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715666209; c=relaxed/simple;
	bh=YFv/xreV8sszgCh+v63BHFOd+heWfDqr5JVAp+/+CrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kz6XMpWsWUVbd/OUcYglVxMZuErqLv4+amwk4rxjkdRnyLwbjPGbwv1PZyrH+b82TbrXB+FvSFGA+RDOijrX+JY0dek6CB5XCb1VYWZp5TK6Sb/a+qpRp2QyGAkGVsOW+NbpKDhLWMxbjLP929PaCdIEqelTWHWBHg+Upr8J1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=J5PenTvE; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="J5PenTvE"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7e1c2ea8481so107649039f.0
        for <iommu@lists.linux.dev>; Mon, 13 May 2024 22:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715666206; x=1716271006; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=440oD4b9Bphk4WWjPWWaKFmIBo6vJ3VIwixVh9ybBDo=;
        b=J5PenTvERCn92CESsR7CtSO3d7np0A/8qkRXvODz/rKy7S/rVOvxwvKNBexjDLc96o
         +zSDRUaSkPpmvVHWuNRo2qjQc/9vzaywSuHIb0j+PEhyaMaVYMlv5DLVzHnEk44hBID6
         U1B9vYSssYgUOJ9poM9XXJHmDZHzx0Fg3QT+061EgS3H1oOCnzaxHM0D1iMOajfOl1fj
         7oEyfVwRCfVU4nTIV6znLmOupxf8rIitX91uDFPVfYsH562EWZ/iDjf9+U3CZbxHOyd6
         jRdB1HFQ9LjnCarEdmBMHdvbhMWkehe1mABtouzYTM3N5V+MDUBrvv2h+y3Sj4RFMPMy
         To7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715666206; x=1716271006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=440oD4b9Bphk4WWjPWWaKFmIBo6vJ3VIwixVh9ybBDo=;
        b=reMNpK9ROm8qmr6yVpbGbMwE+PNTexAGeR2xzDojMIF7oORa56IAS5Hzw35u4q4DHK
         zC+vlTv7T4nFhesAYfd8aTzkRoSThQKxmmCHxwC2eKwUiwpjCH0GHuUGwUtC3Hy85vEK
         pGfqjylq3E+/g1xGPP1qw1QLXjdi2KlrIAECsPuycRLrPmXJ2LVCqD8p282WOfbb2JLD
         3ARaNbOlTIDhf/x6xmjnzqRD5foPco28Hda/hdBxpFeYn3OGFOgpwfExjwprGtoa/qjA
         iSGFpAYlD77AFLnvo6Ps41ucmeXGAyWhNjIVJceUJ5IByVu9Bu71M2N8dnjQVuJidS0W
         VmsA==
X-Forwarded-Encrypted: i=1; AJvYcCVVt/iZN0qEj1MKUiEhpM/4pOSHu6C1fimOrcGuvSshqixTvDOnWvLkwplt4pAS59SD31LxN4hGYX+vUsp20gFq52ms17I=
X-Gm-Message-State: AOJu0YxEa4Dpfy/b+I9oyaTWOKP7EeP5bqyXQUXSi5UZ9gwAindy+sFb
	yzcgIQ9DTLQn3x+VktxCiRLqoDK51CkcNO4N5oXEzMp+dH0b5SSHElf7a/d5rGPq7Xg1Vh64Uqw
	+l0lvf2JbnjCXytDRxRrStJfxMQ6bcOCUk4HclA==
X-Google-Smtp-Source: AGHT+IF9N9dfmP7bVHVJo2ZfC3OHvLjDan409QcJv1aNsscxhoEEW8h6W1834/OEIiZpFBCIoCKO6oKWs8pWyT7uDD8=
X-Received: by 2002:a05:6602:3049:b0:7e1:d5cc:84bf with SMTP id
 ca18e2360f4ac-7e1d5cc851dmr559335339f.6.1715666206518; Mon, 13 May 2024
 22:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1714752293.git.tjeznach@rivosinc.com> <b28d4fe49c5fe4e3ece9de789cfd92cfa5b3c16c.1714752293.git.tjeznach@rivosinc.com>
In-Reply-To: <b28d4fe49c5fe4e3ece9de789cfd92cfa5b3c16c.1714752293.git.tjeznach@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 14 May 2024 13:56:35 +0800
Message-ID: <CANXhq0q+aQ1T37j4uQi5ryUyPxBtvQkaBJ9qvS9iGwSRGaQSyQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] iommu/riscv: Enable IOMMU registration and device probe.
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

On Sat, May 4, 2024 at 12:13=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
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
> index 3c5a6b49669d..1f889daffb0e 100644
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
> +       if (!fwspec->iommu_fwnode->dev || !fwspec->num_ids)
> +               return ERR_PTR(-ENODEV);

It seems to me that we might need to ensure fwspec is not NULL before
accessing fwspec->iommu_fwnode, otherwise, it will cause NULL pointer
dereference.

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
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
