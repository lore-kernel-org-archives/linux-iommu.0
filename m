Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7042117
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 08:12:25 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7878e573827so161458439f.1
        for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 01:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690791145; x=1691395945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHauh0efPqBTqf56QAv8YjVP272Ig9QLMnZTsT29Eps=;
        b=TulGKMcX321aWapxcZccg9DOsP4HNkn2WTblLDm26pSR0fGnsJcdGRD/TzCyDxqhHk
         mU+S8phtTNqeqm4bZD/j4KV4vQSUH//JL9+fD5b4MphnWCAlkYaR9wD4xTeeBtI3WlXE
         heYDFjVKSD7pk1bpwKDno2Kcqc6I1ycWAwNIkqP4zXl+ZV583LOlYYbCfHsd6g0T10BY
         fIfcJLYPvQNBnFWYQ3NoqCsorXChKjAmIBR/M6NDJIp78N3k6H+HJtCawVHNJpZrReEA
         8czg7aUa2sUuR2yiInxZ0cG1A7XahnbXvkiqGSgY5S342d4vdSy/jzvDHDFodXku/YQx
         23Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690791145; x=1691395945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHauh0efPqBTqf56QAv8YjVP272Ig9QLMnZTsT29Eps=;
        b=B4mMvVc0HXfszXzxj5I8v5fvaGLzegcA5K3naaXDu4Wy1V0D0oPxT83lX2lyaoGa4v
         9WBM6vGoiHv61esg5sptDrHiPMCtCtJkUHWm+KF43x/Hqc+ySwlXRpEog/BFpFgdJppU
         MXcNQJ34ucC88R6cCfH4O1BugkXky6DkyJRXP88vF+D/kUWzP5CqWz10em+f9cxZH+36
         YP+Ce3YWteuaWd/semG/68YIU09gbkJypKHewwqtL9QflU+ctNgRM90ahOv+V8GfmAFF
         pb8WcFieiUu7SJroX2zjaVNa+qhGstz4Ed0kDuKN+NKmHfKMzcMPYwQXRKrTuTcN3uoC
         sKGQ==
X-Gm-Message-State: ABy/qLby8AoZUuKd3N3GUQM4RWHNVNXLSlwlZfOyXyVSipuiIqev5BZW
	FRgWBxkPt8geNQ4tnmBPAik5l+BmdO1HF4+GNZTsUw==
X-Google-Smtp-Source: APBJJlFd8FXntafRgv49ekXY4iSLX1SKmvW8LypYEXY0DQr5GzWG7o/hXai+HnoNflLPhvQeZLlH51As3NP47P+py2Y=
X-Received: by 2002:a92:cda5:0:b0:348:cd6b:d593 with SMTP id
 g5-20020a92cda5000000b00348cd6bd593mr7885407ild.27.1690791144902; Mon, 31 Jul
 2023 01:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <0c391072fe0be52b3bdf3d826e4313d960aecba0.1689792825.git.tjeznach@rivosinc.com>
In-Reply-To: <0c391072fe0be52b3bdf3d826e4313d960aecba0.1689792825.git.tjeznach@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 31 Jul 2023 16:12:14 +0800
Message-ID: <CANXhq0q9bMm4m6AJ=3uy81+GsQ+bav+TLbdB-oTBu-wu+f5beQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] RISC-V: drivers/iommu/riscv: Add G-Stage
 translation support
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, 
	linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 3:34=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> This change introduces 2nd stage translation configuration
> support, enabling nested translation for IOMMU hardware.
> Pending integration with VMM IOMMUFD interfaces to manage
> 1st stage translation and IOMMU virtialization interfaces.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/riscv/iommu.c | 58 ++++++++++++++++++++++++++++---------
>  drivers/iommu/riscv/iommu.h |  3 +-
>  2 files changed, 46 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 7b3e3e135cf6..3ca2f0194d3c 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1418,6 +1418,19 @@ static struct iommu_domain *riscv_iommu_domain_all=
oc(unsigned type)
>         return &domain->domain;
>  }
>
> +/* mark domain as second-stage translation */
> +static int riscv_iommu_enable_nesting(struct iommu_domain *iommu_domain)
> +{
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +
> +       mutex_lock(&domain->lock);
> +       if (list_empty(&domain->endpoints))
> +               domain->g_stage =3D true;
> +       mutex_unlock(&domain->lock);
> +
> +       return domain->g_stage ? 0 : -EBUSY;
> +}
> +
>  static void riscv_iommu_domain_free(struct iommu_domain *iommu_domain)
>  {
>         struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> @@ -1433,7 +1446,7 @@ static void riscv_iommu_domain_free(struct iommu_do=
main *iommu_domain)
>                 free_io_pgtable_ops(&domain->pgtbl.ops);
>
>         if (domain->pgd_root)
> -               free_pages((unsigned long)domain->pgd_root, 0);
> +               free_pages((unsigned long)domain->pgd_root, domain->g_sta=
ge ? 2 : 0);
>
>         if ((int)domain->pscid > 0)
>                 ida_free(&riscv_iommu_pscids, domain->pscid);
> @@ -1483,7 +1496,8 @@ static int riscv_iommu_domain_finalize(struct riscv=
_iommu_domain *domain,
>
>         /* TODO: Fix this for RV32 */
>         domain->mode =3D satp_mode >> 60;
> -       domain->pgd_root =3D (pgd_t *) __get_free_pages(GFP_KERNEL | __GF=
P_ZERO, 0);
> +       domain->pgd_root =3D (pgd_t *) __get_free_pages(GFP_KERNEL | __GF=
P_ZERO,
> +                                                     domain->g_stage ? 2=
 : 0);
>
>         if (!domain->pgd_root)
>                 return -ENOMEM;
> @@ -1499,6 +1513,8 @@ static u64 riscv_iommu_domain_atp(struct riscv_iomm=
u_domain *domain)
>         u64 atp =3D FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE, domain->mode);
>         if (domain->mode !=3D RISCV_IOMMU_DC_FSC_MODE_BARE)
>                 atp |=3D FIELD_PREP(RISCV_IOMMU_DC_FSC_PPN, virt_to_pfn(d=
omain->pgd_root));
> +       if (domain->g_stage)
> +               atp |=3D FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain-=
>pscid);
>         return atp;
>  }
>
> @@ -1541,20 +1557,30 @@ static int riscv_iommu_attach_dev(struct iommu_do=
main *iommu_domain, struct devi
>         if (!dc)
>                 return -ENODEV;
>
> -       /*
> -        * S-Stage translation table. G-Stage remains unmodified (BARE).
> -        */
> -       val =3D FIELD_PREP(RISCV_IOMMU_DC_TA_PSCID, domain->pscid);
> -
> -       if (ep->pasid_enabled) {
> -               ep->pc[0].ta =3D cpu_to_le64(val | RISCV_IOMMU_PC_TA_V);
> -               ep->pc[0].fsc =3D cpu_to_le64(riscv_iommu_domain_atp(doma=
in));
> +       if (domain->g_stage) {
> +               /*
> +                * Enable G-Stage translation with initial pass-through m=
ode
> +                * for S-Stage. VMM is responsible for more restrictive
> +                * guest VA translation scheme configuration.
> +                */
>                 dc->ta =3D 0;
> -               dc->fsc =3D cpu_to_le64(virt_to_pfn(ep->pc) |
> -                   FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE, RISCV_IOMMU_DC_FS=
C_PDTP_MODE_PD8));
> +               dc->fsc =3D 0ULL; /* RISCV_IOMMU_DC_FSC_MODE_BARE */ ;
> +               dc->iohgatp =3D cpu_to_le64(riscv_iommu_domain_atp(domain=
));
>         } else {
> -               dc->ta =3D cpu_to_le64(val);
> -               dc->fsc =3D cpu_to_le64(riscv_iommu_domain_atp(domain));
> +               /* S-Stage translation table. G-Stage remains unmodified.=
 */
> +               if (ep->pasid_enabled) {
> +                       val =3D FIELD_PREP(RISCV_IOMMU_DC_TA_PSCID, domai=
n->pscid);
> +                       ep->pc[0].ta =3D cpu_to_le64(val | RISCV_IOMMU_PC=
_TA_V);
> +                       ep->pc[0].fsc =3D cpu_to_le64(riscv_iommu_domain_=
atp(domain));
> +                       dc->ta =3D 0;
> +                       val =3D FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE,
> +                                         RISCV_IOMMU_DC_FSC_PDTP_MODE_PD=
8);
> +                       dc->fsc =3D cpu_to_le64(val | virt_to_pfn(ep->pc)=
);
> +               } else {
> +                       val =3D FIELD_PREP(RISCV_IOMMU_DC_TA_PSCID, domai=
n->pscid);
> +                       dc->ta =3D cpu_to_le64(val);
> +                       dc->fsc =3D cpu_to_le64(riscv_iommu_domain_atp(do=
main));
> +               }
>         }
>
>         wmb();
> @@ -1599,6 +1625,9 @@ static int riscv_iommu_set_dev_pasid(struct iommu_d=
omain *iommu_domain,
>         if (!iommu_domain || !iommu_domain->mm)
>                 return -EINVAL;
>
> +       if (domain->g_stage)
> +               return -EINVAL;
> +
>         /* Driver uses TC.DPE mode, PASID #0 is incorrect. */
>         if (pasid =3D=3D 0)
>                 return -EINVAL;
> @@ -1969,6 +1998,7 @@ static const struct iommu_domain_ops riscv_iommu_do=
main_ops =3D {
>         .iotlb_sync =3D riscv_iommu_iotlb_sync,
>         .iotlb_sync_map =3D riscv_iommu_iotlb_sync_map,
>         .flush_iotlb_all =3D riscv_iommu_flush_iotlb_all,
> +       .enable_nesting =3D riscv_iommu_enable_nesting,
>  };
>

I don't see the GVMA invalidate command, I guess we need do something
likes that in 'riscv_iommu_mm_invalidate'

>  static const struct iommu_ops riscv_iommu_ops =3D {
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 55418a1144fb..55e5aafea5bc 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -102,8 +102,9 @@ struct riscv_iommu_domain {
>         struct riscv_iommu_device *iommu;
>
>         unsigned mode;          /* RIO_ATP_MODE_* enum */
> -       unsigned pscid;         /* RISC-V IOMMU PSCID */
> +       unsigned pscid;         /* RISC-V IOMMU PSCID / GSCID */
>         ioasid_t pasid;         /* IOMMU_DOMAIN_SVA: Cached PASID */
> +       bool g_stage;           /* 2nd stage translation domain */
>
>         pgd_t *pgd_root;        /* page table root pointer */
>  };
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
