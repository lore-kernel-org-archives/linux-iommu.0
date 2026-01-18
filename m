Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3F3321CA
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744507; cv=none; b=OqlIbQRJZsBYQHf80jpu1DgwmebJQOrHZmzjFyPVGHYozfNsV6cV+Td2ez2loNtYdDhTtJ9L95pxlpo3PMt5fCosndvz2/m9Koqd8J+gqoI21XUt8G6SMiQxUUUQxCwlaGiPlOIc66gClEqQLtWw0GghUVEu3MDO/Zqh9nVvwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744507; c=relaxed/simple;
	bh=FKWTmNimx3MbgYioDLLJDryyVXwwwtttG7AEz2i5aZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqh/wgOj19aRmJi40TchXod7u2Op+c8hr1ou8RIWws29N2XWmh0zUU0hLcu3HetyqwcHwRGDDsOINSdBMEXrdmzKBopKJX6tS6POzSavxrew58477yZrqRxNQ9I3lvdunQW4fyaCjChjYJswSQKB9a5DpcCUYySQg/1Fgmp5d7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIP/Prhc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIP/Prhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1883C4AF18
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 13:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768744506;
	bh=FKWTmNimx3MbgYioDLLJDryyVXwwwtttG7AEz2i5aZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FIP/PrhcGyCREmoUUA8Ns/+8/JLuIv0dpc73lW4TZhbD6PAQ5z+XOZkzhO+Raw+Eb
	 o44a9LX5HH8nT8B6nYhKdakQ0E0YvUodS8UbV4aQLMR0BgrUwFVCDVh7aswi21r90M
	 HjaEpJY8PrV1VdSmZV74JcSgc4WqrkZ99P0iOmQ4vbR5eSRwbZM7obwfuVAhsoXWLJ
	 ta8m+xQkFp7c8fx1WQOWxOr/cKha7EpHjfpBmwj1pG6fRW3meORBL97rKHpy3eNZ8I
	 /yGk0yP2vgpMSGVD8g8WYjX3nBBwVYeYLz7JYBkC8Q6k6bPGmKUhKSdXXmjCrT/A1I
	 2d/J1rYMOmZ6A==
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-432755545fcso1881048f8f.1
        for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 05:55:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUh/S9dSKuzox9YuOUXMskO5H2lbcU5sVeehcQBKlw5VLkXYj/NrQgXxRPp9EwaVCfxyoatsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsG/L6gWRuzDwMdjMAKDzwhzexR4knFwvjZBmxAqC03+CUYI+N
	NQI+XLnykToKPhNI3eOBY4tZuq4YIw2SPyMB47Q/iofNjmiAw3nteIMu3g2FS7rgIIfRMBtLP3R
	fnHOxUk5XTRaD9I2fQz3DPJRICk/hFx4=
X-Received: by 2002:a5d:5d0f:0:b0:42f:bc61:d1be with SMTP id
 ffacd0b85a97d-43569bbeb66mr10470396f8f.32.1768744505242; Sun, 18 Jan 2026
 05:55:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260108134855.91341-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260108134855.91341-1-fangyu.yu@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 18 Jan 2026 21:54:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQj-mtbg8Q9fN6=EprfV0XaXy-X=auP9iwrF-nLAJ4Ovg@mail.gmail.com>
X-Gm-Features: AZwV_QjeKgF7sRyNJKuXAuRmrWSQuvfL5Fc_bniUpiz9Hxw1fdq6t8IEbcF1Fug
Message-ID: <CAJF2gTQj-mtbg8Q9fN6=EprfV0XaXy-X=auP9iwrF-nLAJ4Ovg@mail.gmail.com>
Subject: Re: [PATCH] iommu/riscv: Add IOTINVAL after updating DDT/PDT entries
To: fangyu.yu@linux.alibaba.com
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, ajones@ventanamicro.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi fangyu,

On Thu, Jan 8, 2026 at 9:49=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Add riscv_iommu_iodir_iotinval() to perform required TLB and context cach=
e
> invalidations after updating DDT or PDT entries, as mandated by the RISC-=
V
> IOMMU specification (Section 6.3.1 and 6.3.2).
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/riscv/iommu.c | 85 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index d9429097a2b5..2900170133fc 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -996,7 +996,82 @@ static void riscv_iommu_iotlb_inval(struct riscv_iom=
mu_domain *domain,
>  }
>
>  #define RISCV_IOMMU_FSC_BARE 0
> +/*
> + * This function sends IOTINVAL commands as required by the RISC-V
> + * IOMMU specification (Section 6.3.1 and 6.3.2 in 1.0 spec version)
> + * after modifying DDT or PDT entries
> + */
> +static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
> +                                   bool inval_pdt, unsigned long iohgatp=
,
> +                                   struct riscv_iommu_dc *dc, struct ris=
cv_iommu_pc *pc)
> +{
> +       struct riscv_iommu_command cmd;
>
> +       if (FIELD_GET(RISCV_IOMMU_DC_IOHGATP_MODE, iohgatp) =3D=3D
> +               RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
> +               if (inval_pdt) {
> +                       /*
> +                        * IOTINVAL.VMA with GV=3DAV=3D0, and PSCV=3D1, a=
nd
> +                        * PSCID=3DPC.PSCID
> +                        */
> +                       riscv_iommu_cmd_inval_vma(&cmd);
> +                       riscv_iommu_cmd_inval_set_pscid(&cmd,
> +                               FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, pc->ta=
));
> +               } else {
> +                       if (FIELD_GET(RISCV_IOMMU_DC_TC_PDTV, dc->tc) || =
(
> +                                   FIELD_GET(RISCV_IOMMU_DC_FSC_MODE, dc=
->fsc) =3D=3D
> +                                   RISCV_IOMMU_DC_FSC_MODE_BARE)) {
> +                               /* IOTINVAL.VMA with GV=3DAV=3DPSCV=3D0 *=
/
> +                               riscv_iommu_cmd_inval_vma(&cmd);
> +                       } else {
> +                               /*
> +                                * IOTINVAL.VMA with GV=3DAV=3D0, and PSC=
V=3D1, and
> +                                * PSCID=3DDC.ta.PSCID
> +                                */
> +                               riscv_iommu_cmd_inval_vma(&cmd);
> +                               riscv_iommu_cmd_inval_set_pscid(&cmd,
> +                                       FIELD_GET(RISCV_IOMMU_DC_TA_PSCID=
, dc->ta));
> +                       }
> +               }
> +       } else {
> +               if (inval_pdt) {
> +                       /*
> +                        * IOTINVAL.VMA with GV=3D1, AV=3D0, and PSCV=3D1=
, and
> +                        * GSCID=3DDC.iohgatp.GSCID, PSCID=3DPC.PSCID
> +                        */
> +                       riscv_iommu_cmd_inval_vma(&cmd);
> +                       riscv_iommu_cmd_inval_set_gscid(&cmd,
> +                               FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, i=
ohgatp));
> +                       riscv_iommu_cmd_inval_set_pscid(&cmd,
> +                               FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, pc->ta=
));
The riscv_iommu_cmd_inval_vma() and riscv_iommu_cmd_inval_set_pscid()
could be moved out to prevent duplicate code.

> +               } else {
> +                       /*
> +                        * IOTINVAL.VMA with GV=3D1,AV=3DPSCV=3D0,and
> +                        * GSCID=3DDC.iohgatp.GSCID
> +                        */
> +                       riscv_iommu_cmd_inval_vma(&cmd);
> +                       riscv_iommu_cmd_inval_set_gscid(&cmd,
> +                               FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, i=
ohgatp));
> +
> +                       /*
> +                        * IOTINVAL.GVMA with GV=3D1,AV=3D0,and
> +                        * GSCID=3DDC.iohgatp.GSCID
> +                        */
> +                       /*
> +                        * For now, the Second-Stage feature have not yet=
 been merged, so
> +                        * let's comment out the code first.
> +                        */
> +#if 0
> +                       riscv_iommu_cmd_send(iommu, &cmd);
> +                       memset(&cmd, 0, sizeof(cmd));
> +                       riscv_iommu_cmd_inval_gvma(&cmd);
> +                       riscv_iommu_cmd_inval_set_gscid(&cmd,
> +                               FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, i=
ohgatp));
> +#endif
All the above should be removed from the patch; we don't need draft code.

> +               }
> +       }
> +       riscv_iommu_cmd_send(iommu, &cmd);
> +}
>  /*
>   * Update IODIR for the device.
>   *
> @@ -1031,6 +1106,11 @@ static void riscv_iommu_iodir_update(struct riscv_=
iommu_device *iommu,
>                 riscv_iommu_cmd_iodir_inval_ddt(&cmd);
>                 riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
>                 riscv_iommu_cmd_send(iommu, &cmd);
> +               /*
> +                * For now, the SVA and PASID features have not yet been =
merged, the
> +                * default configuration is inval_pdt=3Dfalse and pc=3DNU=
LL.
> +                */
> +               riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc,=
 NULL);
The riscv_iommu_iodir_iotinval() is the same level as
riscv_iommu_iodir_update(). Could we move it out and put it after
riscv_iommu_iodir_update()?

>                 sync_required =3D true;
>         }
>
> @@ -1055,6 +1135,11 @@ static void riscv_iommu_iodir_update(struct riscv_=
iommu_device *iommu,
Why do you have two riscv_iommu_iodir_update() function definitions?

>                 /* Invalidate device context after update */
>                 riscv_iommu_cmd_iodir_inval_ddt(&cmd);
>                 riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
> +               /*
> +                * For now, the SVA and PASID features have not yet been =
merged, the
> +                * default configuration is inval_pdt=3Dfalse and pc=3DNU=
LL.
> +                */
> +               riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc,=
 NULL);
If IOTLB invalidation occurs before DDT_CACHE invalidation, the IOTLB
may use DDT_CACHE's stall info, which may cause IOTLB invalidation to
fail.

>                 riscv_iommu_cmd_send(iommu, &cmd);
>         }
>
> --
> 2.50.1
>

--=20
Best Regards
 Guo Ren
