Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979C2EAD1B
	for <iommu@lists.linux.dev>; Sun, 12 Apr 2026 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002912; cv=none; b=pL8SBU3WKRlSwQzttxwGlszLfSOdAHpKroKIo8/evNrTYNZHS6H+R5MEo3equwjWsWfgrWzDbNIHcx5/OpRuXif9JJUzH1zEu7+8MSKJDNt9F/sjMJ1gwPFB3Is/JsE4XTi+p3ulh10EmVlg+WMYBJvrR+rECcIv2a6Q+9nvWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002912; c=relaxed/simple;
	bh=pUaZBofqyiHuJdKG/enoIrmnfmfGyZY0tKTyJtHdNeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+UQKSM6Vlu/5FInyQ1bSq/PMaPqzaKJSDYSMPsFBm5HhE5Qg9zSsKN1Ha3Y06ODTxH0l0QOacrl2jL0uGRyKWqn0DY+x4vYxdSdzXuERc9/R1C5pmBDddEaYnQFLAiidXN+mksrhWgqPY+wDxJQ2j41xQXLHZ0g1tqeNHJImSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCUHkeC/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCUHkeC/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02F1C2BCB5
	for <iommu@lists.linux.dev>; Sun, 12 Apr 2026 14:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776002911;
	bh=pUaZBofqyiHuJdKG/enoIrmnfmfGyZY0tKTyJtHdNeU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QCUHkeC/lWY1eEbswyN4H5ZM36Gg7F3hsPCtnpn6VdMtpF5tKVwr0zCWjAE45jjD7
	 qbJWcGs88NRboXCKLMeEIQWLGWxiMLBQYOf7XYKxNN9yBaUVoiSJBMjhED1C8ktVkc
	 2ZWUjIxiy0Wz7ndJ/oHPMtcoxlCwq3HyH3ZjGFY67lpfTXQe7UgMVOAwvc6RFlwruA
	 0hBfiajjwr1JH8mvV3l9EwEGC/Oc1zJ73UKjk6whSMKPJ1YOLV0noEV0arFUCruKnP
	 FCBEy8zb/QalsQAZugoLsVquT5CekJJSrH46ugbZDfz8EFJklyy0bXxffLHf+auAHr
	 4/9xswFXXuE+Q==
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so2083962f8f.3
        for <iommu@lists.linux.dev>; Sun, 12 Apr 2026 07:08:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+qhtpH0eMde0jOvX6uaScBg4X83xhjsMsbt36+uKwfWc/HNlv63BhMygk4Syi4yv+CceGAYg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1b9TI0qUo2hipMLK4OMYjJIYSJGXcSqwbcTBpbRMYm0u6FAyP
	uWT+I2N8bGpxLzuGrlj4VpGPtw1QSPaFot+R7TNC4VoZXAikIiwGqKOJpf1UKmPRi18bxza21/B
	TojGBnrncywLyivPk7RYBQ/VrZ8JJ1Gs=
X-Received: by 2002:a5d:5f46:0:b0:43c:f8b4:e58 with SMTP id
 ffacd0b85a97d-43d642c088fmr14300636f8f.41.1776002910085; Sun, 12 Apr 2026
 07:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260411022223.91029-1-fangyu.yu@linux.alibaba.com> <20260411022223.91029-3-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260411022223.91029-3-fangyu.yu@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 12 Apr 2026 22:08:17 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSq-JT3TWJ5C_zBP+8_fVC7vNYCq_7eiMVT0X+4sM5ceA@mail.gmail.com>
X-Gm-Features: AQROBzC4Rc4aMZc6sUhMK9JYRkMncLQ0Cgf8xyWGV5aVeZpU8wsqLom86aWm950
Message-ID: <CAJF2gTSq-JT3TWJ5C_zBP+8_fVC7vNYCq_7eiMVT0X+4sM5ceA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V
 Svpbmt bits
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	tjeznach@rivosinc.com, jgg@ziepe.ca, kevin.tian@intel.com, 
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 10:22=E2=80=AFAM <fangyu.yu@linux.alibaba.com> wrot=
e:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> When the RISC-V IOMMU page table format support Svpbmt, PBMT provides
> a way to tag mappings with page-based memory types. Encode memory type
> via PBMT in RISC-V IOMMU PTEs:
>
>   - IOMMU_MMIO   -> PBMT=3DIO
>   - !IOMMU_CACHE -> PBMT=3DNC
>   - otherwise    -> PBMT=3DNormal (PBMT=3D0)
>
> Clear the PBMT field before applying the selected encoding, and only
> touch PBMT when PT_FEAT_RISCV_SVPBMT is advertised.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/generic_pt/fmt/riscv.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/iommu/generic_pt/fmt/riscv.h b/drivers/iommu/generic=
_pt/fmt/riscv.h
> index a7fef6266a36..02051bb3c6e5 100644
> --- a/drivers/iommu/generic_pt/fmt/riscv.h
> +++ b/drivers/iommu/generic_pt/fmt/riscv.h
> @@ -58,6 +58,8 @@ enum {
>         RISCVPT_G =3D BIT(5),
>         RISCVPT_A =3D BIT(6),
>         RISCVPT_D =3D BIT(7),
> +       RISCVPT_NC =3D BIT(61),
> +       RISCVPT_IO =3D BIT(62),
>         RISCVPT_RSW =3D GENMASK(9, 8),
>         RISCVPT_PPN32 =3D GENMASK(31, 10),
>
> @@ -237,6 +239,13 @@ static inline int riscvpt_iommu_set_prot(struct pt_c=
ommon *common,
>                 pte |=3D RISCVPT_R;
>         if (!(iommu_prot & IOMMU_NOEXEC))
>                 pte |=3D RISCVPT_X;
> +       if (common->features & BIT(PT_FEAT_RISCV_SVPBMT)) {
> +               pte &=3D ~RISCVPT_PBMT;
> +               if (iommu_prot & IOMMU_MMIO)
> +                       pte |=3D RISCVPT_IO;
> +               else if (!(iommu_prot & IOMMU_CACHE))
> +                       pte |=3D RISCVPT_NC;
> +       }
>
>         /* Caller must specify a supported combination of flags */
>         if (unlikely((pte & (RISCVPT_X | RISCVPT_W | RISCVPT_R)) =3D=3D 0=
))
> --
> 2.50.1
>
I'm okay with the current way of  MMIO & CACHE mapping to IO & NC.

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
