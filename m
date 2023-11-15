Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8A31A598
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NOOAXAQO"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-41ea9c5e83cso364491cf.0
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700061362; x=1700666162; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/NfrA/AhI3IBeh3+JaRNZ83ErlUjI5ivLDH7Qt1YZA=;
        b=NOOAXAQO0vH0ARxxzr/zCjkzKrSo/bnV+buV/MsX/wifLA7TVMEw9g+uoG29ZNFxxt
         /907NQDToq28O+ht2B9xN7RVT/WnuJE+y1ME2leN6xm56ly4cQnKNwfNwMY3crFOEgH2
         uw9Z9XunwZFagZDyr85tGRPLOeucckS+/Wf0qsKC731M9+oP16V+TXyFbBgt8heq4QyV
         +cIC5emODQwysXOAwmBDUtsXvlzeiS+rXAshZOZgv2ocIRUgmoF2cdzdBvpS2jY/w/eD
         KsCeOX28k9ukkPnDPnklC6hl5nJRi9pPYGTx/VjBTP3StVo+W3cs4vXGk8uu7shyCJqf
         NmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700061362; x=1700666162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/NfrA/AhI3IBeh3+JaRNZ83ErlUjI5ivLDH7Qt1YZA=;
        b=i58+jltrdNBdR2iDPR7RPsvpoH3QGzF4KR86H8NUziqip/HA2DLiww4/1a8sekD7Wx
         QNzJ3g08E2JdQQ9afuyx+XIv5IeUPRjkB7EkMoNplnoXmRSqZWSaC9MwXQjP9PFKkWf5
         wM/CVpG4vA274uZeZmEncYhP2RTwSRXV0GU2Al+9Lx5AadY/RP0VPcge4Th5hzwG1cSR
         Pg4BCrJM5oX3UwNQCiM2iMZQq4enw5ify8IXB0yVX6K1CW3xRnqKaHVIMffiSulpoQPv
         1MnB0979wYdPwolnfQWEL1aX+MyU051lHLXiPK5VoQT0oBW8AJuHn/HdO6C9tj7vcbjz
         /vlw==
X-Gm-Message-State: AOJu0Yw+kcnJosFkNaNPNV6SYxfDeKlCv47sQZV+8t+73Xyz7oWBgNuW
	Xd5j/r9nbeCygglTWjeIri/+M5NVXmPUZvNaTaS/dw==
X-Google-Smtp-Source: AGHT+IHsLkfd1mxk7ecbuNweGdtB1UIAK1+qdYZ92dNVDoJ/1Sup4inheYKgSuDVVFZQROqhBwKMmpHYkE8Z3XuTeTY=
X-Received: by 2002:ac8:520b:0:b0:41e:3c2f:13cb with SMTP id
 r11-20020ac8520b000000b0041e3c2f13cbmr205910qtn.19.1700061361403; Wed, 15 Nov
 2023 07:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com> <11-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <11-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 15 Nov 2023 23:15:23 +0800
Message-ID: <CAKHBV24X4-Mf3R8OqwBdAJf9P7UD9fep2fOmJVrcx_rkfABxBA@mail.gmail.com>
Subject: Re: [PATCH v2 11/19] iommu/arm-smmu-v3: Do not change the STE twice
 during arm_smmu_attach_dev()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 1:53=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> This was needed because the STE code required the STE to be in
> ABORT/BYPASS inorder to program a cdtable or S2 STE. Now that the STE cod=
e
> can automatically handle all transitions we can remove this step
> from the attach_dev flow.
>
> A few small bugs exist because of this:
>
> 1) If the core code does BLOCKED -> UNMANAGED with disable_bypass=3Dfalse
>    then there will be a moment where the STE points at BYPASS. Since
>    this can be done by VFIO/IOMMUFD it is a small security race.
>
> 2) If the core code does IDENTITY -> DMA then any IOMMU_RESV_DIRECT
>    regions will temporarily become BLOCKED. We'd like drivers to
>    work in a way that allows IOMMU_RESV_DIRECT to be continuously
>    functional during these transitions.
>
> Make arm_smmu_release_device() put the STE back to the correct
> ABORT/BYPASS setting. Fix a bug where a IOMMU_RESV_DIRECT was ignored on
> this path.
>
> Notice this subtly depends on the prior arm_smmu_asid_lock change as the
> STE must be put to non-paging before removing the device for the linked
> list to avoid races with arm_smmu_share_asid().

I'm a little confused by this comment. Is this suggesting that
arm_smmu_detach_dev had a race condition before the arm_smmu_asid_lock
changes, since it deletes the list entry before deactivating the STE
that uses the domain and without grabbing the asid_lock, thus allowing
a gap where the ASID might be re-acquired by an SVA domain while an
STE with that ASID is still live on this device? Wouldn't that belong
on the asid_lock patch instead if so?

>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 4b157c2ddf9a80..f70862806211de 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2482,7 +2482,6 @@ static void arm_smmu_disable_pasid(struct arm_smmu_=
master *master)
>  static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>  {
>         unsigned long flags;
> -       struct arm_smmu_ste target;
>         struct arm_smmu_domain *smmu_domain =3D master->domain;
>
>         if (!smmu_domain)
> @@ -2496,11 +2495,6 @@ static void arm_smmu_detach_dev(struct arm_smmu_ma=
ster *master)
>
>         master->domain =3D NULL;
>         master->ats_enabled =3D false;
> -       if (disable_bypass)
> -               arm_smmu_make_abort_ste(&target);
> -       else
> -               arm_smmu_make_bypass_ste(&target);
> -       arm_smmu_install_ste_for_dev(master, &target);
>         /*
>          * Clearing the CD entry isn't strictly required to detach the do=
main
>          * since the table is uninstalled anyway, but it helps avoid conf=
usion
> @@ -2852,9 +2846,18 @@ static struct iommu_device *arm_smmu_probe_device(=
struct device *dev)
>  static void arm_smmu_release_device(struct device *dev)
>  {
>         struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
> +       struct arm_smmu_ste target;
>
>         if (WARN_ON(arm_smmu_master_sva_enabled(master)))
>                 iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
> +
> +       /* Put the STE back to what arm_smmu_init_strtab() sets */

Hmmmm, it seems like checking iommu->require_direct may put STEs in
bypass in scenarios where arm_smmu_init_strtab() wouldn't have.
arm_smmu_init_strtab is calling iort_get_rmr_sids to pick streams to
put into bypass, but IIUC iommu->require_direct also applies to
dts-based reserved-memory regions, not just iort.

I'm not very familiar with the history behind disable_bypass; why is
putting an entire stream into bypass the correct behavior if a
reserved-memory (which may be for a small finite region) exists?

> +       if (disable_bypass && !dev->iommu->require_direct)
> +               arm_smmu_make_abort_ste(&target);
> +       else
> +               arm_smmu_make_bypass_ste(&target);
> +       arm_smmu_install_ste_for_dev(master, &target);
> +
>         arm_smmu_detach_dev(master);
>         arm_smmu_disable_pasid(master);
>         arm_smmu_remove_master(master);
> --
> 2.42.0
>
