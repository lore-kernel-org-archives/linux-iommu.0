Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049337B3F2
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998918; cv=pass; b=RUXnYLfVD1yFVQ/9PYyoKzXEiwKwza9t23DIIwogEuTM8i5yc5a/BcXrr2kHmqwNwLeFuGGf9Um8YLJYAEfUVfeGbwRGFRhZ6BiVNFYR/6M4YZGLiGEFWa/x43gvU6iCfw1FKFKDaHzdJnpZ33xSOtMh4OMGyCsUpdgZ8beucO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998918; c=relaxed/simple;
	bh=CTonTKixj9AKgBHFu3WR/xrozDujgnWc94kv9TkdB38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msue/HRZGfTUwIl7YacF88DqaEWajBEmkZcX2tPkm/Y4kP8ft41v5PrXIg5wtgnL7DGSD4G2a9pgM+jhjwWFrN/igFNa3EDVFXsZBmRo9J/FLOI8VCjwA4WMpQaCNh+sZrS3Q47nEoNs1RP9/F3vc3mI73k580gIirSveSwttBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Oer2vdBt; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Oer2vdBt"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-67e09232daeso3623111eaf.2
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 09:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777998916; cv=none;
        d=google.com; s=arc-20240605;
        b=Y2MqT7Oi6rlKw48cBbNbVm47+IC+A9dtAurrJKFwiN6vrhNHL3f9FLul2iBHJFk4Ru
         HhIMdHRfYowAN3ZzpeSW62xW/1HzW4hNXG7Auw4Jk/rDV81x3FiiCDTRd+VjE+7qy1Dq
         jrL1s06efOBO+F5m0WKg/FyELUU9kjcrPE2wS9U8EyJEVjsc3o3bpFO7iLPdM00S/YLl
         ht1P+v/0KoN68IPnwmZLRROdnkWYn2RWNh/q+KAFThlywCFzUyfePrudY+bCmWJ1PJmk
         mMQIdoyNiE6I+6EkKkLZs2hsTJw/qj6fdKnTwxFlTBIbvSoQX+utcDwOjzS10YR6xiK5
         zD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PZwRlD35/Ni4eJ8ZVe6U+Aw5CsKjsJO0tLj7syFGyqI=;
        fh=LH2kAxhhOENv+QbyPLsql48cBv+DdZl+l3au8i+It9k=;
        b=NQoT7ZGATXYwrUKQRyP8iFKWAOPnS3pXaW+Gbi3oXtOhLN7k2bDU+VSf3EeQ0J7Wta
         1Gl274w432xW67HVJ2U88AuJqb8tkDj44sxcLKWFcIBz57JcrIbhwQteEEOntplT1NS9
         2J68aGHSCqEHsCv6SFuS/mI7tK5D4UUwqnYm2zVDCostZYGwtqNnHoIngsQudr8DfcJr
         o95XQWPAJ0izxAcft0gndUmVtL0HbqrRBagrRiJLApjqHK3cgGD7OCcS1CcCtUY1Ubj/
         I1BACOZ4dk0m6FNUS/lPuwd79RCqWxERAZPzLENz86IWrZao47Np2RhIAgmoWXCe3Bct
         5H9w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1777998916; x=1778603716; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZwRlD35/Ni4eJ8ZVe6U+Aw5CsKjsJO0tLj7syFGyqI=;
        b=Oer2vdBt0EKRS8MSn4UP2PtdZFkDYKByVR4cRiCtmmbPr9sonp7deQgaFPzhwCIHdh
         VN3Fo/3jJ5COInEZGGnuYnkx9yQUNAO13jwb5x5vrdPgieg3C+RWuwBu9KkO/8qOaJwM
         fbQqNTmGQlK9ujZ6eOFGHP12QcGiP+UOV8fqhVk2GsBCcvRDD+UG5qJnpkbt5f9dHu9a
         cMNcal356DIEOZNJqR+14+my95mwDyOXRJH3imj0SwklkwZJqz5CtX/hbkmPmVdjWyxQ
         fridzYBKFPGaVpfu7gUS8ZouDCoUttxx1e5Z7FJEOLf0rX4uDo9d7vY2gqnftR4xOFds
         PAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777998916; x=1778603716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PZwRlD35/Ni4eJ8ZVe6U+Aw5CsKjsJO0tLj7syFGyqI=;
        b=RkE7FjtNH78MPMfttfuYT84n1yQp59hkZeFRgNShzZrP/5MS+M3T7VPhaViTNL8IjC
         C/WbV40yM+cQJhiBFchld0KoILeqmTBEEMQyeB2hhZ8MzXcKSPBtBkigYglAd9yPVEIb
         w7uBj8AWa47t/8ILwP+2ddklGndIiHp26ORVzk2TpSMHekjnANN+BHcT32ywKlLkzKuH
         Q8YL2eOOP7k/XNYVqeKlzaDYrOmeYX7wiFklaDGQDiYeCWwtIk7kPtvSMLBp6lzNQxTy
         irJHZmKZaKVUoitMVLuDUPe/n1idTfgQ2Aw9sQTbrl0Pj1quVM3mPzJepgg28RsUHTYI
         tc9g==
X-Forwarded-Encrypted: i=1; AFNElJ9bBGk9R8PrgNDRoGsN2MVyFRrs6df9U4pZ4JQcYFbSqntPisfg2lIM+oJTzLUDiG4zWdS+xw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1Z/DppbL9PsMs7EzqgcLB1wN0IBSXySupmA0NEkzmTpsL9ONg
	IAiulNlcQpnsNSEfjxbXURo9un0rsUTJ10Vat6tiTDtxTuW+3kZLDPFUm50sO0PBCOsg/FfyCeh
	8keR38L60eiJNXDNjGQHM50cvzsvpHk1iYlg8V9OWlw==
X-Gm-Gg: AeBDievFlJJwGKx54wTklx4jaWvGIIl9al8lG7XzvbT+P2Gw/jshqoOFsCfRiGkGhKf
	Qu/b6V38DAmyLr2Wc4K4pl+rblD7mkyKUsVDL0z6bzR03ZSrIb/QGNwhdkRQrpWq96HnhnPXMaW
	EsJlLkGOrp+JXYEFJeKhEEopWJpbPpJjO7//AWQEsr2wpZHdj+UGuob1YEGfkMCQ50dVrvzZWMn
	/4c7e4GIGH1SmtTKvjokuoD3AMZNruhoLemKEdc59ywjmE71gDfp4DOBpGSl5oqVH1X1rjG9WfG
	uS+sVFGf7f6/e4UrNQ==
X-Received: by 2002:a05:6820:f001:b0:696:2cf3:3bc3 with SMTP id
 006d021491bc7-699981ea5efmr81275eaf.41.1777998915996; Tue, 05 May 2026
 09:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-54e7264d71b4+17cc3-iommu_riscv_inv_jgg@nvidia.com> <6-v1-54e7264d71b4+17cc3-iommu_riscv_inv_jgg@nvidia.com>
In-Reply-To: <6-v1-54e7264d71b4+17cc3-iommu_riscv_inv_jgg@nvidia.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 5 May 2026 09:35:04 -0700
X-Gm-Features: AVHnY4LPfK7qs4OtHxHKG0TGC_8I0pYYVtUUsANuSQbTNv8bjJdgyf0feiYrb7A
Message-ID: <CAH2o1u4opjWDL8pFTstYVYDbML4_hAgQm1D4NH6rR8=RyG=Vig@mail.gmail.com>
Subject: Re: [PATCH 6/7] iommu/riscv: Add RISCV_IOMMU_CAPABILITIES_NL
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, linux-riscv@lists.infradead.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Fangyu Yu <fangyu.yu@linux.alibaba.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 8:57=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> Non-leaf invalidation allows the single invalidate command to also
> clear the walk cache. If NL is available, set the NL bit if the
> gather indicates tables have been changed. The stride is already
> calculated properly.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/riscv/iommu-bits.h |  7 +++++++
>  drivers/iommu/riscv/iommu.c      | 12 +++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu=
-bits.h
> index 29a0040b1c32ea..f01b49ac815586 100644
> --- a/drivers/iommu/riscv/iommu-bits.h
> +++ b/drivers/iommu/riscv/iommu-bits.h
> @@ -63,6 +63,7 @@
>  #define RISCV_IOMMU_CAPABILITIES_PD8           BIT_ULL(38)
>  #define RISCV_IOMMU_CAPABILITIES_PD17          BIT_ULL(39)
>  #define RISCV_IOMMU_CAPABILITIES_PD20          BIT_ULL(40)
> +#define RISCV_IOMMU_CAPABILITIES_NL            BIT_ULL(42)
>
>  /**
>   * enum riscv_iommu_igs_settings - Interrupt Generation Support Settings
> @@ -473,6 +474,7 @@ struct riscv_iommu_command {
>  #define RISCV_IOMMU_CMD_IOTINVAL_PSCV          BIT_ULL(32)
>  #define RISCV_IOMMU_CMD_IOTINVAL_GV            BIT_ULL(33)
>  #define RISCV_IOMMU_CMD_IOTINVAL_GSCID         GENMASK_ULL(59, 44)
> +#define RISCV_IOMMU_CMD_IOTINVAL_NL            BIT_ULL(34)
>  /* dword1[61:10] is the 4K-aligned page address */
>  #define RISCV_IOMMU_CMD_IOTINVAL_ADDR          GENMASK_ULL(61, 10)
>
> @@ -724,6 +726,11 @@ static inline void riscv_iommu_cmd_inval_set_addr(st=
ruct riscv_iommu_command *cm
>         cmd->dword0 |=3D RISCV_IOMMU_CMD_IOTINVAL_AV;
>  }
>
> +static inline void riscv_iommu_cmd_inval_set_nl(struct riscv_iommu_comma=
nd *cmd)
> +{
> +       cmd->dword0 |=3D RISCV_IOMMU_CMD_IOTINVAL_NL;
> +}
> +
>  static inline void riscv_iommu_cmd_inval_set_pscid(struct riscv_iommu_co=
mmand *cmd,
>                                                    int pscid)
>  {
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index fd9c5294dbc082..ea14630430451a 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -966,6 +966,8 @@ static void riscv_iommu_iotlb_inval_iommu(struct risc=
v_iommu_device *iommu,
>                                           int pscid,
>                                           struct riscv_iommu_tlbi *tlbi)
>  {
> +       bool use_nl =3D tlbi->non_leaf &&
> +                     (iommu->caps & RISCV_IOMMU_CAPABILITIES_NL);
>         struct riscv_iommu_command cmd;
>         unsigned long iova;
>         unsigned int i;
> @@ -974,17 +976,17 @@ static void riscv_iommu_iotlb_inval_iommu(struct ri=
scv_iommu_device *iommu,
>         riscv_iommu_cmd_inval_set_pscid(&cmd, pscid);
>
>         /*
> -        * When non-leaf page table entries were changed, the base spec
> -        * requires a full PSCID invalidation (AV=3D0) since there is no
> -        * way to do targeted non-leaf invalidation without the NL
> -        * extension. Force global invalidation to preserve correctness.
> +        * If non-leaf entries were changed and the IOMMU doesn't
> +        * support NL, we must fall back to global invalidation (AV=3D0).
>          */
> -       if (tlbi->single.use_global || tlbi->non_leaf)
> +       if (tlbi->single.use_global || (tlbi->non_leaf && !use_nl))
>                 goto global;
>
>         iova =3D tlbi->start;
>         for (i =3D 0; i < tlbi->single.num; i++) {
>                 riscv_iommu_cmd_inval_set_addr(&cmd, iova);
> +               if (use_nl)
> +                       riscv_iommu_cmd_inval_set_nl(&cmd);
>                 riscv_iommu_cmd_send(iommu, &cmd);
>                 iova +=3D 1ULL << tlbi->single.stride_lg2;
>         }
> --
> 2.43.0
>

Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com>

Thank you,
- Tomasz
