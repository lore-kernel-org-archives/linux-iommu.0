Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4202134F
	for <iommu@lists.linux.dev>; Wed, 13 Mar 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323114; cv=none; b=qYbcmox6reTTAKCOvmmknfP6y86ldvm1gqJojKfVX/mR0T+uJu4pPwxr8oIRFvaXXOX0H+gbMxfL6nOremAHRgPrH+ygh3zN33NEONEbHwBiJ2EoVBdr4PKYvpWBLJ+ThVXY/b+Lcvbyzghnbdx34Uh5PAs6fnH0bVeFWiJN5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323114; c=relaxed/simple;
	bh=6+O2iKOE3Jj3gwUL7+/h5aMcbfpMUZO5x/EpZQIVazw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Imz9YbI2ESpKbQS3yYRgqrFxvmd/uok1pPM2sVdUaI+t//fTn+fLi07rxaTHwBuhsoGAHD4lIXzBabcshAIWxOA0/yPAOr6who7kXc++jUc1QtBPbpVxlsnCDgR4AUShdTBKpfi3lyVVrkSEM6V90gxKrXbDsWe4o8u9USvzLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oKV1P7cu; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oKV1P7cu"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43095dcbee6so24571cf.0
        for <iommu@lists.linux.dev>; Wed, 13 Mar 2024 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710323111; x=1710927911; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1wnDZ3Rgj1Kw0kQPoUQHAcTboIqhUZo59kgwC+6YyY=;
        b=oKV1P7cubttI1TPVbjVcFEZXrfmre3DgG0aa1KZvnlzX2oSBXHoP2zIRuqKDV4wQ3d
         vjymoTCpNq63cw6bufaZeLb/or65erkgOe70isIm8Yx5aLD4bJzL3etM3hhXGLnvKtNF
         m/zOlCJCe/HKkQtQeu9oRs81ZSwxgVUQ/SxbqFHm2hyWh51Ox1ij6KViu02TA1d8vgsr
         z2ei5qNSeGjfWkUEJ1I+dxzXzILFN+rQeUNAGDqtDLiAoGINys61hUT+Ks+u2cytfVwk
         gOMtWxlI1mu8vH0NJVMeKBnt+7y2AtE5LyUBFt15yXGZaAafAtdmTrBkWoc0NwAxgNcY
         xeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710323111; x=1710927911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1wnDZ3Rgj1Kw0kQPoUQHAcTboIqhUZo59kgwC+6YyY=;
        b=uEx7gAlfC9DV5jmxEGQASnoH/hebXHiuBjqT7IxrT4e89G+z7nrEBES1J9KEPrgNDT
         btoHO7eCWYVP3nAV52QPBVs0bEFBqZwloenJAZQWU9yEnWAF7Fx67cGlNCP512nFzAVT
         OGMk/FhBGXGEtmwG2VBDe0tYTgm2oItxV7LfsuSUzLVgRAoPbhSFdLxYsiHqhs6fwUXf
         Cgj2ICpTbBjT1dU/MwBWqA6e60ROYFgYJjRy5KVk3l+Vj0G4amsC3wdXgH4wLff9zq9l
         HLxZaJux4vtqQaxhnCEuB0jj4UDJi95Rm5gOl5EvEM1R/m1wCFwSE4SVdDt0V+9zM9tw
         SBvg==
X-Gm-Message-State: AOJu0YxwlB0nW7nIklVyTUosBQsufIW2Fe9lA7UzaEA9zLye4drf4A51
	5aa0rPNwJSQszCI4nmf6HzMksxhuT30kYtIIKmCiDKbqza8fRGtdRBujM81F1CLUzGvEmnR9hql
	2s4skGh2fitNI8wO5vY/q4x3o7+G0rBIeUHgM
X-Google-Smtp-Source: AGHT+IG7wyHGlyTdND6BKRwYhMMBR6pcIJ9HgiOfKTn/KDq+DpWWVX5/y30/sLbR8K5D0bL3ugvJZUe1tML4z2zhdEc=
X-Received: by 2002:ac8:4895:0:b0:430:867d:3dbe with SMTP id
 i21-20020ac84895000000b00430867d3dbemr258809qtq.16.1710323111220; Wed, 13 Mar
 2024 02:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com> <3-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <3-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 13 Mar 2024 17:44:35 +0800
Message-ID: <CAKHBV26ATewvBtf4tkyEP8CTS5SFj3-FBySwt6jsrLd3tH0VyA@mail.gmail.com>
Subject: Re: [PATCH v5 03/27] iommu/arm-smmu-v3: Add a type for the CD entry
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 7:44=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> Instead of passing a naked __le16 * around to represent a CD table entry
> wrap it in a "struct arm_smmu_cd" with an array of the correct size. This
> makes it much clearer which functions will comprise the "CD API".
>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++++---------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  7 ++++++-
>  2 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 9e9233331c4636..c60b067c1f553e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1219,7 +1219,8 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
>         WRITE_ONCE(*dst, cpu_to_le64(val));
>  }
>
> -static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 s=
sid)
> +static struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *m=
aster,
> +                                              u32 ssid)
>  {
>         __le64 *l1ptr;
>         unsigned int idx;
> @@ -1228,7 +1229,8 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_=
master *master, u32 ssid)
>         struct arm_smmu_ctx_desc_cfg *cd_table =3D &master->cd_table;
>
>         if (cd_table->s1fmt =3D=3D STRTAB_STE_0_S1FMT_LINEAR)
> -               return cd_table->cdtab + ssid * CTXDESC_CD_DWORDS;
> +               return (struct arm_smmu_cd *)(cd_table->cdtab +
> +                                             ssid * CTXDESC_CD_DWORDS);

Can we define cd_table.cdtab as a union type to avoid this cast and
make the struct definition more explicit?

>
>         idx =3D ssid >> CTXDESC_SPLIT;
>         l1_desc =3D &cd_table->l1_desc[idx];
> @@ -1242,7 +1244,7 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_=
master *master, u32 ssid)
>                 arm_smmu_sync_cd(master, ssid, false);
>         }
>         idx =3D ssid & (CTXDESC_L2_ENTRIES - 1);
> -       return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
> +       return &l1_desc->l2ptr[idx];
>  }
>
>  int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
> @@ -1261,7 +1263,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master =
*master, int ssid,
>          */
>         u64 val;
>         bool cd_live;
> -       __le64 *cdptr;
> +       struct arm_smmu_cd *cdptr;
>         struct arm_smmu_ctx_desc_cfg *cd_table =3D &master->cd_table;
>         struct arm_smmu_device *smmu =3D master->smmu;
>
> @@ -1272,7 +1274,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master =
*master, int ssid,
>         if (!cdptr)
>                 return -ENOMEM;
>
> -       val =3D le64_to_cpu(cdptr[0]);
> +       val =3D le64_to_cpu(cdptr->data[0]);
>         cd_live =3D !!(val & CTXDESC_CD_0_V);
>
>         if (!cd) { /* (5) */
> @@ -1289,9 +1291,9 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master =
*master, int ssid,
>                  * this substream's traffic
>                  */
>         } else { /* (1) and (2) */
> -               cdptr[1] =3D cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MAS=
K);
> -               cdptr[2] =3D 0;
> -               cdptr[3] =3D cpu_to_le64(cd->mair);
> +               cdptr->data[1] =3D cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TT=
B0_MASK);
> +               cdptr->data[2] =3D 0;
> +               cdptr->data[3] =3D cpu_to_le64(cd->mair);
>
>                 /*
>                  * STE may be live, and the SMMU might read dwords of thi=
s CD in any
> @@ -1323,7 +1325,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master =
*master, int ssid,
>          *   field within an aligned 64-bit span of a structure can be al=
tered
>          *   without first making the structure invalid.
>          */
> -       WRITE_ONCE(cdptr[0], cpu_to_le64(val));
> +       WRITE_ONCE(cdptr->data[0], cpu_to_le64(val));
>         arm_smmu_sync_cd(master, ssid, true);
>         return 0;
>  }
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.h
> index 23baf117e7e4b5..7078ed569fd4d3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -282,6 +282,11 @@ struct arm_smmu_ste {
>  #define CTXDESC_L1_DESC_L2PTR_MASK     GENMASK_ULL(51, 12)
>
>  #define CTXDESC_CD_DWORDS              8
> +
> +struct arm_smmu_cd {
> +       __le64 data[CTXDESC_CD_DWORDS];
> +};
> +
>  #define CTXDESC_CD_0_TCR_T0SZ          GENMASK_ULL(5, 0)
>  #define CTXDESC_CD_0_TCR_TG0           GENMASK_ULL(7, 6)
>  #define CTXDESC_CD_0_TCR_IRGN0         GENMASK_ULL(9, 8)
> @@ -591,7 +596,7 @@ struct arm_smmu_ctx_desc {
>  };
>
>  struct arm_smmu_l1_ctx_desc {
> -       __le64                          *l2ptr;
> +       struct arm_smmu_cd              *l2ptr;
>         dma_addr_t                      l2ptr_dma;
>  };
>
> --
> 2.43.2
>
>

Reviewed-by: Michael Shavit <mshavit@google.com>
