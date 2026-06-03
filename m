Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29140306774
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780518513; cv=pass; b=G8YH+HSxtJVcFJvOFXk00+JFxmHEa+nTnlQ3kzUqbrxvmCGYyBqDozEinpCNkk9CfZeS74q+Lq7RILkYtFKv7gm4muqWJAfNcGni9/bSDNGFLFr0RwbcYKvPWBztYboxFYiGcxpH029z9s2KrAdQzaF/Sa43S0lUx8nYmlkNsLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780518513; c=relaxed/simple;
	bh=XXTC1iNbh7mzgIHM1JDiHsK9X5q+HBrUp5e5MJzCbbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkXuXOi1fRyEJwO5zD5OZUkuDZsiGDdp3xxpcKz6W/ZyEcZex2ppSrg8L0QitBE7mzbC20WRs5Km8VuOdVEmWxM+sza2NkHRQ7WZ/aG2w3ykyhtSgFjZ3XS+ss5VtmP17r77MNjMpNK903ZbRq5wlu64tdqnA2wXpkutvOC/Z44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ou607PxM; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ou607PxM"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5177d1ff061so18111cf.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 13:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780518511; cv=none;
        d=google.com; s=arc-20240605;
        b=YSpjJpROGTcnEu8u8Atmv22wUDmbcYpEGjGLAfPwR32HtEHuufUsGCVtutxlvijzF9
         vONY6hxkCh4IgfFe/CcsrBYNU+tb4S5475jBJVB5QjWlBDzjq+j5VdkOx1MLyvFmGIBH
         5CRJ4Xd20YbtWL2qVjKG/fkhcAwHooc5Y/1BEQcJg4s95weKdqhStOEmaFlsQ65hvqzv
         LXwJLY+wy2/Qu9csR0EHk1pOSZr+sU1aaETkNK4A5i5GP11ok1eTi55n9Ei8PaJdp8ni
         mjvLf/+xF8880yB1gKdTvuu00OZoKDKHE83jWiJNg/pCfokyaGOH+3BSiJI3d0dG7pvD
         rb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ApU/K57t3O5MI8pSYn2nS7zINbg4YW/6w5BoGxO/xm0=;
        fh=0u6trxL0zZwA0/1Sge/7uQQnOlSSVTu7AIo0GAZRpig=;
        b=GlHfXvd3j6tfChAUVF/MwwHjWvr45FIOrHvezPH38cMFdM7f5MNcCDC0/l8Y15bBjm
         lJlIukOu7oibEXkIUnjJOW9lA/Jbf2S5stNjPAVr/T3YDRMQLIZdZqbzrxTbpc7tfMq9
         iUn6Zw/16fyTSwQ4NFLZ2IYjdUx7HRt0wejBUPv/pzAuGjUIQwlov1ieQBPouM2b/x6H
         ckAH+KuutdApZniM0KxcIgQBhzf86XP4XPyPtuTDpicTmaavgUdZKw6v93LrZh5Z578J
         JXEx3/VlEBvx35GotglX6ih1c4eBpB/ai6aIZ8twxxwNzJhXFzoBwODCRA7Ma5jWczMY
         HbKA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780518511; x=1781123311; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApU/K57t3O5MI8pSYn2nS7zINbg4YW/6w5BoGxO/xm0=;
        b=ou607PxMk1CO88QpF0toLAIyuQ/6l+4gdg63Cg/XLZIjJ37yqsTqFz44l+b6Cs+6jI
         zv3UOKDTPdzu+iVrAYPlUQvYS943cIYU4pqpj1JbLFfJN8XVYqqg8Wbc9o+MgQz8ZS7Y
         Vne/pPrkC/UwMFzM6M/zWi4ae+u0AKr/rb+rYBPBdoTB+VqvxvaAMNKSDCUZ/Yt4F638
         GrBQrvxru4SE7Bd0PfoZxTmwBVAfUIVK1oZrWrhDK7GXdqQJCK06uf0ZwJxcdGCrx6fd
         U9n10DMgoRfRSntyOakJoNvdktRFUe6OGEiHKyDOqtNBExy0+pW7svULUSJnzzpsGGOh
         UVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780518511; x=1781123311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ApU/K57t3O5MI8pSYn2nS7zINbg4YW/6w5BoGxO/xm0=;
        b=E2U8TYNwXk8SgXzoQ9j5nC58wg07biIK5BEqBT+rGbqb2y6du5PUEfLz0q/HavOaGz
         jbnIaQxobqH1kKyl6tb0sSKcPamhRKdf0vXk30MANpVsTfOnzb4ic9MZPluQhl7xwSSm
         c8w9yGAkYTKHkjKUjBt2LTDyn3U4wfh9JN4BFbm8PkbI8/ObnCvLBVe7SbCU3jeYdjD0
         6tJRI1EgyKTd8xD0+DGHg9u9Zzr8hC0XwkQdY26/X1K2apxpU9Xu4N5y7Bul7W3VVMIR
         ZGiCsOBfS9jQC5FZCRMQ2zKFWgpC656u8VikgBT8uUVEgKVyzOLQzdNiVChoT32Wg6Ey
         WbCw==
X-Gm-Message-State: AOJu0YygexCgHtdWfMHBOadyJNspmbARk7lElJy1udeIzil6B+TeTcVQ
	7jjLeEfTpguDJ0QE3ajGIWxGpBjLLPO8WzI8IhRczSiYHZnsPhr5e63PawLfKKcKqcMA+EvwPhO
	LLVUKpl7dH8rJDg7l4c+9m0wP0AVfFWT/qo3Ih8RF
X-Gm-Gg: Acq92OHJD3KhD6X7zRdDQf6NUxE+pBkbyj9dhov2NRx2wmXIYT1PIz1cy+UcA0dkY2N
	IHINB2txGzdnpl0IENoAZPIkxLo6RXTCX4z9uJSfDP3Q8py5vw4ya5gCDReIUUDFNqvMYBPvPF3
	NKgE+VXkvpRjBqTvKhgiNotgUlsME78o7oyZvJ+tWMPZ6aXFKBX3NQHiQaTyqj7u5tpmbyOEMyW
	q2KQpPVYrnVOfNZXh/uOrCZV7/Vx9/IgvAcBM8GfmvmHRS9/LEAlw4TdyfRsyurNKwFh3DJrcUR
	cOVaZ4y13Cl3I4JBN2mzFIx/6BvYV9TM4Fv/7gaM5Q524kPY
X-Received: by 2002:ac8:4708:0:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-51788f12a9emr405971cf.3.1780518510547; Wed, 03 Jun 2026
 13:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-12-praan@google.com>
In-Reply-To: <20260601215909.3958732-12-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Wed, 3 Jun 2026 13:28:19 -0700
X-Gm-Features: AVHnY4JymbHnMeIV5mK3buHx1gPe6ADy62gAl9-kPO-OTjETxZm8VIOEr1XtIsM
Message-ID: <CAE2F3rCPgnFU=d5At1zrOLhsuVEbsweogOHGz9gDddRx73zRtw@mail.gmail.com>
Subject: Re: [PATCH v8 11/12] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 2:59=E2=80=AFPM Pranjal Shrivastava <praan@google.co=
m> wrote:
> @@ -2361,8 +2394,33 @@ static irqreturn_t arm_smmu_handle_gerror(struct a=
rm_smmu_device *smmu)
>  static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
>  {
>         struct arm_smmu_device *smmu =3D dev;
> +       irqreturn_t ret;
> +
> +       /*
> +        * Global Errors are only processed if the SMMU is active.
> +        *
> +        * If the STOP_FLAG is set (can_elide =3D=3D true), the hardware =
is
> +        * either already disabled or in the process of being disabled.
> +        * Any errors captured during the quiesce/drain phase will be
> +        * handled by the explicit arm_smmu_handle_gerror() call at the
> +        * end of arm_smmu_runtime_suspend() callback. On resume, the
> +        * STOP_FLAG is cleared before interrupts are re-enabled, ensurin=
g
> +        * no valid errors are missed.
> +        *
> +        * A lockless check is favoured here over a dynamic PM core check
> +        * since the runtime_pm_get_if_active would return false during
> +        * transient states like RPM_RESUMING & ignore level-triggered
> +        * interrupts.
> +        */
> +       if (arm_smmu_cmdq_can_elide(smmu)) {
> +               dev_err(smmu->dev,
> +                       "Ignoring gerror interrupt because the SMMU is su=
spended\n");
> +               return IRQ_NONE;
> +       }

Have you considered using arm_smmu_rpm_get() here instead?
I can see two issues with the currenlty proposal:
 * Returning IRQ_NONE when an interrupt is indeed active and needs to
be handled. This might be interpreted as a spurious interrupt
 * Nothing is preventing the suspend handler from running while
arm_smmu_gerror_handler is in the middle of handling an interrupt

I understand that using arm_smmu_rpm_get() also has downsides,
including an unnecessary resume operation when the SMMU is already in
RPM_SUSPENDING state. However, using arm_smmu_rpm_get() would make it
easier to ensure correctness.

> +
> +       ret =3D arm_smmu_handle_gerror(smmu);
>
> -       return arm_smmu_handle_gerror(smmu);
> +       return ret;
>  }
