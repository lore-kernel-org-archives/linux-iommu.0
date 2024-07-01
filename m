Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4338084D2C
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823654; cv=none; b=MSAJxTNUEAzsGjKIfdTGq0jhTNerLY7MwKSnnKASy88StChMZ3t4JOVmvMK+Be9dY2XYrC+o6mkJSyeOqVQAJQWat3p1XryPu6JjDeQ81fHMDBZX/HPKRutjEbdns2sONbimaSBopwX988AON0aXs4ajuVe9tJjvmGzkUT8TgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823654; c=relaxed/simple;
	bh=ZXOdW4pto5OLdzPfn/Y/DqZDFGN+EvE0zNqkNrOGiqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZ35DA7CsbwHwB6VLmFia7FgRkSfaTskOkfqAhH0+8doxyTsDIV3BadSCR1mcNXraCrhkvmiaT8GmG+nBH9eIY3tiJgAlY8lFnKPvl5RPwN367tisXFOFnuDJ+DGsY9ern3ZJx557ChuIvLA70WgH4r+HKtqc+zVFPALsaBO7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WyoEBvvm; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WyoEBvvm"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d5616d7273so1499815b6e.1
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719823651; x=1720428451; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT4FjvsO28ftxFn/D0RiQIRX4ThKgWSSkQhgt2BnXRM=;
        b=WyoEBvvmqCYcupuDrIQqwst2jZeDEVQL518wr7i1hTnA4iN1DrfqYdrjhCYk7wcNvR
         g7pjzGrIJvlCODHD9GpYEx6sPsRTW0JAIZGQ77kVD7vfCCyJHNto3DCxQF5E14Cc3Smz
         3Dg3WwVPNL7RzgJ8l/UpvzRsYhs6ZuvPeXcb0c6Y0gPX+GCbVu+Vxiz4GwtSzKz/mZUE
         7Wg+ry0k+Zh6UP2UG+ZiGezxoTQ/l9KTtuQEvxxz1OHMrsUIi0A5sczEukk5B3SZn0ZJ
         f4hJiTUCS4ITDUEUXW+J3pS2evc7RwfQwPUBS76uasGzM2qGZWuPWUB9Dlj8vHROFv7h
         fbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823651; x=1720428451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT4FjvsO28ftxFn/D0RiQIRX4ThKgWSSkQhgt2BnXRM=;
        b=F3CBsMDMwaZWSXfHZVeuJy3uVniQDHJHv9X83Nmmq+bdYUZHTAoUZaLv8lsakrAfyX
         GMwfHOwAKrpFVUwp+tJGlr0sCXScxCjDDyOBlqrgKFmEVFm4SyO8d5yWvguwTkH8hs2E
         iGt98tzfkhf8eA7aPih31QO2YpEHPtPpiw9sVGCScs9euM2kopIQa4iVjmEusHvEcyqO
         bbvO49HOS7+rwUsrFK58Y/QbwvM2eNY9NRwD65lIu5l2KZDwZxcANjABY0mOYnGGsGnD
         40o6kro/avheez57YAY2p5OJcOFQE8kXi2JQz6KKe55I19Oa/v7H6RMdwew5cGYhxvRN
         TeTg==
X-Forwarded-Encrypted: i=1; AJvYcCVISyaqwc5BMwFfj3hqP9sRlvVS/XLR2I60Xsi28JjQvCG89umwNPuph1+HoKIo39Y80+j2dcYOc3q9Hq68W1XUSsosVR4=
X-Gm-Message-State: AOJu0Yz+o752axJmIvZ8hbvOl5pcin00Na3SVDSRLkzYfWIhKiQ5mycS
	+TXfO3F8nGCnQfFSn0Moqw9LnLYrZ8QFZULogmEH2pPmWuFHs2cKKA8IiGRtbXCOJLwrn+YsI9o
	SK8hk9TeUFBKQ/Hl0Ck/WvrC9MTz6CnqkhbLS6g==
X-Google-Smtp-Source: AGHT+IEo9sl2VFAmozT72Mcd/Sum+ljFVLZGY4TYZg/jdAg5+RMJL9U3ru88WJ7pMksr0TPVKgSFdnKEZYRME4FZgyE=
X-Received: by 2002:a05:6808:2288:b0:3d6:331d:b52d with SMTP id
 5614622812f47-3d6b2f07e53mr7562751b6e.4.1719823651207; Mon, 01 Jul 2024
 01:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240701072908.25503-1-luxu.kernel@bytedance.com> <20240701072908.25503-2-luxu.kernel@bytedance.com>
In-Reply-To: <20240701072908.25503-2-luxu.kernel@bytedance.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Mon, 1 Jul 2024 10:47:18 +0200
Message-ID: <CAH2o1u7j6pXhWHL2rBZak6LeXxn_KUbQHjygRGQKuEfS_vmtkQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/riscv: Support sharing irq lines between iommu queues
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	apatel@ventanamicro.com, sunilvl@ventanamicro.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@rivosinc.com, baolu.lu@linux.intel.com, lihangjing@bytedance.com, 
	xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:29=E2=80=AFAM 'Xu Lu' via linux <linux@rivosinc.co=
m> wrote:
>
> When the number of wired interrupt lines is less than the number of
> iommu queues, we should assign one irq line for several queues and
> configure csr icvec accordingly.
>

Is this case not already covered by the code in function
riscv_iommu_init_check(), assigning cause to vector register (ICVEC)
based on available interrupt vectors? Interrupt vector selection is
based on accepted ICVEC configuration (see riscv_iommu_queue_vec()).

Relevant code (patch 'Command and fault queue support'):
iommu->icvec =3D FIELD_PREP(RISCV_IOMMU_ICVEC_FIV, 1 % iommu->irqs_count) |
       FIELD_PREP(RISCV_IOMMU_ICVEC_PIV, 2 % iommu->irqs_count) |
       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3 % iommu->irqs_count);

Values in iommu->irqs[] should represent actual interrupts allocated
for the device.

Best,
- Tomasz

> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>  drivers/iommu/riscv/iommu-platform.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/i=
ommu-platform.c
> index da336863f152..1d0af1260d5b 100644
> --- a/drivers/iommu/riscv/iommu-platform.c
> +++ b/drivers/iommu/riscv/iommu-platform.c
> @@ -60,6 +60,10 @@ static int riscv_iommu_platform_probe(struct platform_=
device *pdev)
>         for (vec =3D 0; vec < iommu->irqs_count; vec++)
>                 iommu->irqs[vec] =3D platform_get_irq(pdev, vec);
>
> +       for (vec =3D iommu->irqs_count; vec < RISCV_IOMMU_INTR_COUNT; vec=
++)
> +               iommu->irqs[vec] =3D platform_get_irq(pdev,
> +                                                   (vec % iommu->irqs_co=
unt));
> +
>         /* Enable wire-signaled interrupts, fctl.WSI */
>         if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
>                 iommu->fctl |=3D RISCV_IOMMU_FCTL_WSI;
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux+unsubscribe@rivosinc.com.
> To view this discussion on the web visit https://groups.google.com/a/rivo=
sinc.com/d/msgid/linux/20240701072908.25503-2-luxu.kernel%40bytedance.com.
> For more options, visit https://groups.google.com/a/rivosinc.com/d/optout=
.
