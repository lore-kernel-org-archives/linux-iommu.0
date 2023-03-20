Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12557C
	for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 17:41:21 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id x3so49888875edb.10
        for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 10:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhzCf2AYkG2YKumzfeJoTiU2MHsDxNe3IlKWgvXLaW0=;
        b=RC0umeVbHufdLOsagfGFHQ8jBr3HrWm5xkMr+QyzbjWf49eAceGJPtItx2iZ+nwipl
         CLu4ULU/VGZwdgamIqG4kUKMt3xiguYdRe/ybiHjrnmNhF1JWs3w75uFtvmBVPTUaFh8
         80FD/gLYsJAjzFSmo6F+1/BOQYt4s0yw5W7KR0Qm3YWfPnGYL4zCmGKxhJXiFY5jsuv6
         9OAVRd9Xc5scmR7PSlAJSv7FyClXgeQXCw2gSR1fxfWu5njZ3JcqkpGT4d7+rLsVxLys
         ghutG6MYuxSU7WeaXZY7eyUfF+B9fGDt2uURUAye0NmN2cOMA8dhf2xCB1k5L2gsMrnE
         fkFA==
X-Gm-Message-State: AO0yUKV90coWn9Ljr2DxUaIK9quZzkyGV0gbg2+Ywp0vpbBSE6epjs1b
	m1T98mCq7UUe1YE4Ubpoko36R3ApVdzq/yfPKWg=
X-Google-Smtp-Source: AK7set9ZCAYDwyxGwq/HMIy1Gb0EKrHg3nzqco/G8arJp4ry6hL+DmB7yNw9qpkQBarZZxH1LyrOpeWTV6W5OcD7cio=
X-Received: by 2002:a17:907:86a9:b0:934:b5d6:14d0 with SMTP id
 qa41-20020a17090786a900b00934b5d614d0mr2173109ejc.2.1679334080021; Mon, 20
 Mar 2023 10:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230314164416.2219829-1-jean-philippe@linaro.org>
In-Reply-To: <20230314164416.2219829-1-jean-philippe@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Mar 2023 18:41:09 +0100
Message-ID: <CAJZ5v0jS_YAR8kwEVsi4XZ6Qd2Y1O2nMjaUSaj=NXLPMgw2O0g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: VIOT: Initialize the correct IOMMU fwspec
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: eric.auger@redhat.com, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev, 
	Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This should have been posted with a CC to linux-pci really (now added).

I would recommend resending afresh with linux-pci in the CC list, so
that the people on it don't miss this.

On Tue, Mar 14, 2023 at 5:44=E2=80=AFPM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> When setting up DMA for a PCI device, we need to initialize its
> iommu_fwspec with all possible alias RIDs (such as PCI bridges). To do
> this we use pci_for_each_dma_alias() which calls
> viot_pci_dev_iommu_init(). This function incorrectly initializes the
> fwspec of the bridge instead of the device being configured. Fix it by
> passing the original device as context to pci_for_each_dma_alias().
>
> Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> This fixes issue (1) reported here:
> https://lore.kernel.org/all/Y8qzOKm6kvhGWG1T@myrica/
> ---
>  drivers/acpi/viot.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> index ed752cbbe636..c8025921c129 100644
> --- a/drivers/acpi/viot.c
> +++ b/drivers/acpi/viot.c
> @@ -328,6 +328,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pd=
ev, u16 dev_id, void *data)
>  {
>         u32 epid;
>         struct viot_endpoint *ep;
> +       struct device *aliased_dev =3D data;
>         u32 domain_nr =3D pci_domain_nr(pdev->bus);
>
>         list_for_each_entry(ep, &viot_pci_ranges, list) {
> @@ -338,7 +339,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pd=
ev, u16 dev_id, void *data)
>                         epid =3D ((domain_nr - ep->segment_start) << 16) =
+
>                                 dev_id - ep->bdf_start + ep->endpoint_id;
>
> -                       return viot_dev_iommu_init(&pdev->dev, ep->viommu=
,
> +                       return viot_dev_iommu_init(aliased_dev, ep->viomm=
u,
>                                                    epid);
>                 }
>         }
> @@ -372,7 +373,7 @@ int viot_iommu_configure(struct device *dev)
>  {
>         if (dev_is_pci(dev))
>                 return pci_for_each_dma_alias(to_pci_dev(dev),
> -                                             viot_pci_dev_iommu_init, NU=
LL);
> +                                             viot_pci_dev_iommu_init, de=
v);
>         else if (dev_is_platform(dev))
>                 return viot_mmio_dev_iommu_init(to_platform_device(dev));
>         return -ENODEV;
> --
