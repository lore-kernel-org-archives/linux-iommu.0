Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90326A1B9
	for <iommu@lists.linux.dev>; Sat, 11 Apr 2026 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775926327; cv=pass; b=TdkNsvT5sr5k0F8a5YqUGKxPfKE7060quayuUMJE5DXELsYtZhUXsvk/Ys4MpetV6gxksP5L0Qye1zSBQrk2EgeGw4uIK2gYsqbaBw/LMBVz5o/NDprZSuBJA54O5jzb4UJumrrMCWb3PUrGTwT3Av335oB6kZqP+mHCfkXfQAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775926327; c=relaxed/simple;
	bh=JmvSAPjRk/HsUkomgtLWfH9iDYh0FonlK9ZcVwDVddc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cE5WnioI8EdI/59FHdN11445iDCFc3NGK9qkAuiJrayOCfcnX65skfcwcOyJDol3dph5xJzf2dzt7k5ah/D31BIWCjraOSGDG0rOK6tZinPUFnMUKY2tAM6J2Kohwr8eElkUi+b+dvdEzy0U+O2vaetAmb1aK4zKFuz5Ivjz0Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=Qu3kysSb; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="Qu3kysSb"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dbcd92eda5so2303456a34.2
        for <iommu@lists.linux.dev>; Sat, 11 Apr 2026 09:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775926325; cv=none;
        d=google.com; s=arc-20240605;
        b=gbdEEFaqytDTQiCdoadBIvcFBDSIX7duoOSBFt+drrvefqIzY1t6akru8jJSzWzv7y
         +tnqUp/dceLP/XJnGZAp2PmoFjEDF1XbXFb8NcffM6VsLmXzZsPvNRhi44TY/gIX6kX7
         xoIizyrxqXZPCJAQh5jsXJDe3mnZVCFEUknfgl5+UcQPWwgzRU0K5ij1noW8XlLkWznC
         PfkigTVLX/Zl+cfvC2N5ILDw9lg+riK+6oX9yAA3hofCSxv5ohzcFCItyQlHWXaHtduB
         ZIQW+/Hlv5pughWuA/g0x5sesQnpjLLXloyrQz4uwXq/4qRHIWKNIrjN1MUoByh86qSx
         IN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wqSJZdgJoODeu8kv1hRE+cGfzsSFkA9szelcDJzZHDc=;
        fh=5yyv9CgcVhcSgeZVcYT7zJGcDgX3VxrabmXFNW0sHyA=;
        b=lC/kNTspxk2Zp4uUZPiV5hbbNChSiquxNVkxT9GkIjc8Rn6jrcbdBs9lGRcAYfSGlZ
         5baf1v5xfZbZmOktzILwME/eKo+l5C6MYrCkUZBBAiWxoORysRYc24l4+ByqrdgGZn3O
         elBsTpNbHxtbRKZP8aGfXdyb+nAtrxUU2VPu0SRmPiLBlwcO0ChwN0KN4HPKnGKOF0QW
         i2U2Cl3rOUWr/82CIDGEjDz82IwwyCBE/9bvuZ/yN1MrJTfWH/Hd+mwzK4CRm82xOUKd
         0T5IKXb9e8A3NRRUymyUpP2pnF6vLfLsabjUGj5JtoXGrXmTGeTbwlVH9766B7pQ6O4z
         bdGA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1775926325; x=1776531125; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqSJZdgJoODeu8kv1hRE+cGfzsSFkA9szelcDJzZHDc=;
        b=Qu3kysSbUinzz9gjm6Wkw8PEBvJlLca/NvGX2UrkqURX7L+mHnZyXYXosXweaykbCZ
         0lNAAYN7u+47O5x2U7Qjav9pPR4/8KHXQx+b0q3gmivR11xm0pvNR3tqKEKjA8DNlJoL
         1moD/aM0zrgCi0NGbzFEphTP1zy7F1+9bX6lDbpakX6VaOACbhW/A0eIjW8/jx9hCd88
         joKH5ZIbc6jdkZ2jb+CkxJITsVmizxJLqSC+7y05IhoGkfCcKX/QpmWVCoyHkgUvT29L
         l1+CXJ+dW3pSG0gNm0M+vIihPnYdB6LnIeA3yHd+nDtBOY20DUSL3fGMGq7xssXuXbL4
         dDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775926325; x=1776531125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wqSJZdgJoODeu8kv1hRE+cGfzsSFkA9szelcDJzZHDc=;
        b=SuFPmv5xyEvbqLmwc0EUTMkjA79d9v3xhlsqL+kwnwiWvkpSqkb82fmoPRDZ0LloAd
         5O620ybtn84qeh7DAzvfObpxG8yGHcVMpPCEMSMNWV37dHBvj0pZALDGJdgUznAPE9MM
         /3XctUAvMyEksFXxN1P2y0BVz3cfRbYCQ0eVxlBR27NH39q6xtdbwXDNPN6zAsJl9Qys
         SnaffxBfFrLa727BmItcrowIfTW9+ToMinriHYP9iljpox1y72ZjzRp//sb5swpjFLuK
         7vE4m2/Ft2+AgcZOoS3CdTkZwTxA3o4X2GmOrNGp6ti+cMyfmQmLJCRCSR4wjlAKdrvU
         emQg==
X-Forwarded-Encrypted: i=1; AJvYcCWGxGCLFBLw/IQ73lFrI8gnArN8ieVMGZNsjZPEgCDZhn2j33SiKqwVGe/8wwbUyLtOyi6WnA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu2ZEKPqjglrS5h88V4YQMXnHZz/ZjIoXSAlSY6wgtIxoNxDqN
	Doem1zu+TXsM7Fa5XixZxZZGUAgMObe9Ha23oJlghwDfym5QWX78B0wrDufeLy39SpAVxJEJ8Po
	oCdw10mRMl3N2rlfzR0NLgosz5hRcCnVqHJYASb6TdQ==
X-Gm-Gg: AeBDieveur4C08J5zBZtATDbyz6NhX4F7oqBPh0U10ddqtUcxJ/pLsv+B2thmfJqJnH
	NXyYKaeDHBfPNUqOyn1UaIXf7pIjfbmyBv1xlNjvT+71KBkRErwSQ9rmSHnLnTT7/GXxQUVDvIU
	UjnlNzDsTPqwOnRVL7C2gq8wvGN5lBxJLwOEvXVu4y7bDU1Rxp9w5smKzNvhbpEk9yrIMUeeRhV
	gxIh46pUs17dlGV+kzNzN6s+ozreP19zGxU/jVQnbRJ4GM+M0oXU9DlUNqatdNXACxBnH7P1mCk
	RoyaIa/t+KFGaodJ1I5UXqKd96effaP80zUhWqBbEhk81QRpIXESWWL9PvclIhYO+xyT+rzCH9X
	UVakra0Vxp3n290LrmqcuzHVtUL8=
X-Received: by 2002:a05:6820:8183:b0:67e:1c67:ebd8 with SMTP id
 006d021491bc7-68be7ee1b88mr3330520eaf.40.1775926324573; Sat, 11 Apr 2026
 09:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260411022223.91029-1-fangyu.yu@linux.alibaba.com> <20260411022223.91029-3-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260411022223.91029-3-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 11 Apr 2026 22:21:53 +0530
X-Gm-Features: AQROBzC78r2FyJGwEr-mo33bIJuUYfyNgNHxCIGcYlLjmwSOUrGfuQso79gUj30
Message-ID: <CAAhSdy3EdaQaPpBCWj9AP0nmB4XP_ApqC6E9XMuJZuH19j3fPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V
 Svpbmt bits
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	tjeznach@rivosinc.com, jgg@ziepe.ca, kevin.tian@intel.com, 
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, guoren@kernel.org, 
	iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 7:52=E2=80=AFAM <fangyu.yu@linux.alibaba.com> wrote=
:
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

Looks good from RISC-V perspective.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup


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
>
