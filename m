Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D32DEA64
	for <iommu@lists.linux.dev>; Sat, 11 Apr 2026 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775926331; cv=pass; b=jBe8azV5qtsHVRKu/3dYp87h64AiY3wm+ucHaSAE+tcrDvPBjWAYFPcIoL4VP7YM1pP+wqKqIDv3YccOV8WSN4Qyye2xdBe22q34rVmD2byNwkMtwnVYqwzSkjbkOyJXOcD+F4GjE2UUpQ7dmwaDA1uMVoK6vXe0F9VhTA9aGUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775926331; c=relaxed/simple;
	bh=zNrkKOpKqfxopkFq4JWTH/REP5Hr2OcHJ+4QW9d0hvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1xe3VpJiqppQ88UFgAe2Nu57f0E+FNOy7dWBTiDL/JAAIjVfKFUsgNI8/d+Eem0c60v0q4mTJFtaFCEDcoWDVaveLWFv9Y67nSOAf9RoWyxBvWVFWI6GimBhKA05Gu+jFn9Wbn+wEDjbL/DhB6rO6jCeuXmUyGTjsEZjBvpUzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=tU4P03qm; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="tU4P03qm"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbdcb85067so2649090a34.1
        for <iommu@lists.linux.dev>; Sat, 11 Apr 2026 09:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775926329; cv=none;
        d=google.com; s=arc-20240605;
        b=KBU91ZdZLEIb5R/Mvf2MKhhcsmXqZNRkQAeHC+5HkumNS4e5HlKvNqqXmsKMPqQ6mS
         TIMDdUApTmhTz5E2KfjhO28OC2m1gjDfus6bWT05WgwpCT/L/g+AdjXnvC7TalpSs+HY
         fPrVMbaiFverQpFwZTgS9/We0B07BoSQeUGmm4K/HgHrwDUnOTdWFkc2cRxY4s6ZO8Jg
         GuenaLtj4nvC5bmqXopHpJUbH5HL1/H2LN9d1BQkOkit2p8XndotYH7IT/s0CDmeM6tw
         fkpgoXsQDMqz7ZkOJZyoTHv9z/BYnfuWNYz9kNr02t2BNoBHpvEQnps3t7gAIYFP/Gde
         CS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FX/lULpKSMagkle3KXgfcJbERn4/bCQpLyp4j5tdJGs=;
        fh=vX5AdrTA+7R0ALA62UfyN85y68i2h5q9U+rMfKQv7oM=;
        b=FRM4gMe2HhSEjqz5VVjmx7V4LZIsE6Gba0T4qxFMwBOK1aFjFZSRVriwclr2Lw2g7V
         7MTDBHIGkooccgnu6IdXIXQ5/xoProqJuBz2aBFIwdZmapJhkeQ+vRWo3dU3yyB/fhw6
         rMhBeyq2fjPZHZzbhA/k+IywpRbkuf248pb5m6GRURSBNKhiTJhntdeJhO88rvBDE2+F
         tF0y+UcF3bzqG+s+edCRkH6HN5GpliDsBWTob+/h4fHRfdbdAnp1NshRPi4LZdQH2ldU
         FM2+O0UGwP7TVdYidki3h0p+VyPzttHC4HcOMjPsLeJBZ+TicNR+Oj6C8bhHL5yCt+rN
         /NKA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1775926329; x=1776531129; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX/lULpKSMagkle3KXgfcJbERn4/bCQpLyp4j5tdJGs=;
        b=tU4P03qmBAAGVbwxcl3X04A1bFdfdX3hZ28ihlh76PRkVvGFYXSCWt69s72/B6Jv0Q
         WFkVm7Ya0zIcGqspaPkmRwV++cGQiXopknuLjg2VgcBHjNti0DCRKvdXQztJYNq794O+
         8oa5OtFuMwZKXUt/6O2cHXDHwNiNF+j30SElwSLoG+AlqWUHlRLEct2VaJzxBDeznYY4
         EG0SaVlP2unGsGa8+vyXP2s8nntAATKH+IkECQFH6QFuC67A8hgTZZ9rXRwk4vlkex7F
         g66o1ar+8JvFuUwffUPiA9sWVG1nhazQnofCO7VSjs6XkuzhY6SXJXX3rCLBEbc7X2im
         ncxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775926329; x=1776531129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FX/lULpKSMagkle3KXgfcJbERn4/bCQpLyp4j5tdJGs=;
        b=dJHOU4PYEaCeKPdYf/07llTgY7GaUK/mnYJh1stTy/IHmGFc3qoUix2nQUlsUvnbQv
         tfrOiMFMJfeSghU7tQxhCspO5Wyy/+dEOnirpQvl4Jc+WXPF4cC2+IkVCwrcy6KIoixX
         vArlXhJKSOQpUm8Lks3alXA3ZHVae1D/tRujNeg4rOFcnilp8Ml7/YmGQk0L60mz1byQ
         SzS/oSFLEAZ1/XHhoQ8rc85CTajb8xTvX5DNrwVgFjjQ4MmSN1bvLN/g3ZZk0dvFX11P
         9I4YurYz4TOssVMfwVMiMk6G2U7D0RJNbfkFikGroPDWYStn6lYAAt/TAgwL6PspKBzY
         aZUg==
X-Forwarded-Encrypted: i=1; AJvYcCUWTcN0qD7TLTmw3dlhSiuJzd/Y/KtjY0/8AWuKDNITeD61F1y0lqo1yeDSVaJRnpeBOgGPKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9hwkgNKZlTg7pgjJMsRm38zbsqkSQWQfvm+nVN33Z8xlomC8t
	LyQwlTaRTC+TWgED/jAvu2Wq3pXLAtf5lLGJopmev8KOzicHoFe8MuccAAtTQXTUqYP3wiRAYVm
	ByOWd//DMiz80L3Qbcss6rwht3s8ykLLYr3YvLOpAlg==
X-Gm-Gg: AeBDietIQTp2k6Pz2NDRYN8n3zD3Ezc62Dfhnxl/+oVUbufKhYR50nkdvebpdj3rnp7
	F+WCwm6PovydpF1AnZ9eAhw5FgdkydjRHq5R/BwPy55gPGbyPiCEvgP+VM5VbjGs+jAunOIPrNz
	iKzrewA5XRi34ocrhnhy73dbzVc0oDte6KxqQM5J6htXl/uT17CBSFfwcHhWlDeOOBFb3VjA0jl
	2q01o+oBlG1QaO9IX0mPYwas1001AZJDxqYIEloj6G0pxO1cSMDa4GFaqpa1mPyW59pk/ZGbPQ8
	GzTouzcQk9W3gxdyf5RJ4yz1wnGgN3GBzGf1lDO8VuEamH2soC/Q8HtKflTa60NUzKGGXEXWEjJ
	mo/5XRE45DXSFtpjnevHU9qdhLzFFXOCc3rYfnA==
X-Received: by 2002:a05:6820:62a:b0:67e:313e:22c4 with SMTP id
 006d021491bc7-68be85d32e6mr4077914eaf.47.1775926329262; Sat, 11 Apr 2026
 09:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260411022223.91029-1-fangyu.yu@linux.alibaba.com> <20260411022223.91029-2-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260411022223.91029-2-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 11 Apr 2026 22:21:57 +0530
X-Gm-Features: AQROBzBrpzfznEAFbbO-vdp8iuvh-4Q6CVGLr2K3uMPPDNj279HD1Tp5_HAL7qw
Message-ID: <CAAhSdy3azZ2hiO_zEC4-eu3EfHYeWJh5D5LfihYRkw-2XyYbQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/riscv: Advertise Svpbmt support to generic page table
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
> The RISC-V IOMMU can optionally support Svpbmt page-based memory types
> in its page table format. When present,the generic page table code can
> use this capability to encode memory attributes (e.g. MMIO vs normal
> memory) in PTEs.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Looks good from RISC-V perspective.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup


> ---
>  drivers/iommu/riscv/iommu.c       | 2 ++
>  include/linux/generic_pt/common.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index c7d0342aa747..e53883935563 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1194,6 +1194,8 @@ static struct iommu_domain *riscv_iommu_alloc_pagin=
g_domain(struct device *dev)
>         cfg.common.features =3D BIT(PT_FEAT_SIGN_EXTEND) |
>                               BIT(PT_FEAT_FLUSH_RANGE) |
>                               BIT(PT_FEAT_RISCV_SVNAPOT_64K);
> +       if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SVPBMT)
> +               cfg.common.features |=3D BIT(PT_FEAT_RISCV_SVPBMT);
>         domain->riscvpt.iommu.nid =3D dev_to_node(iommu->dev);
>         domain->domain.ops =3D &riscv_iommu_paging_domain_ops;
>
> diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt=
/common.h
> index fc5d0b5edadc..dfadf8a5752a 100644
> --- a/include/linux/generic_pt/common.h
> +++ b/include/linux/generic_pt/common.h
> @@ -188,6 +188,7 @@ enum {
>          * Support the 64k contiguous page size following the Svnapot ext=
ension.
>          */
>         PT_FEAT_RISCV_SVNAPOT_64K =3D PT_FEAT_FMT_START,
> +       PT_FEAT_RISCV_SVPBMT,
>
>  };
>
> --
> 2.50.1
>
>
