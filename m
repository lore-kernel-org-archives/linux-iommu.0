Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0756185931
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825048; cv=none; b=LCH26GilDUDFDEqRSfyfMzc2egPRPbyKdWwSUoGa1h1rhEnJ8pWS/8h1bErdGazKTtsnHLUxXdHeq+riPvS+PKj3gqtfaBLKOYDkOHXrtnJFz8UlYqgMZLSDVxzqh4SGcLhV8oKq9YkaXVF+q0Tc61QjmSjslnJ8hTBJd1AYGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825048; c=relaxed/simple;
	bh=s6wUZFBzlnzCYz9OAO3FsO7lybksMejV2MvZlfsae3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e96+LrhPGQvwy8SdWShuo0F/6EynhIZS6eBFHkW4MDf0X8dvP8Tsq/fBcpRhDAeHbGfxuE34Y9qQKQOVeGen1escjoxUAAXEt7he+uLP90eWs4o8FtEiJS7UJukSDnBfV8YOJKoegaZtI9jAPm7BvxbmiLSPo9X1H2a5MPh73zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K/QPu/nG; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K/QPu/nG"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c8e422c40cso1454951a91.2
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 02:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719825046; x=1720429846; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VvOaQzlpnKiFlOfEz9Er17nO3pgB9yQmQ0QBuBPFt4=;
        b=K/QPu/nGAmVC5FHKZXy75P9fPGYdmB/G4rX6Ah5w2BZNV6XoJL6qrqmKR/UFvzvi6j
         P4yKF1yR0mjZO5Ci7MM+DBYf8E9tpVriFvBfoEfFUT6w/CMMxut3fskxWa0L0aIEchFX
         D+EwlREQQOzmKma4azT7zX23zzWvKG+1fgprsah3n8+jZ4m4wBpQ0RG8P3G86dBo93II
         NFFWkCZy+Ry3YtvP90tHEuAK4f6zFN+jBn4Gpg1epK8eODoGxKNncdOBdi2yfdOn0x5V
         ivX8rUN7ffL68ZCAo3cELRUekfWrwr1+F8umoUIMc5oPYRHuU5RRsv16fK1PgWMVrG+/
         ZNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719825046; x=1720429846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VvOaQzlpnKiFlOfEz9Er17nO3pgB9yQmQ0QBuBPFt4=;
        b=GxtQIPOtd2axmFMvQqXYIrdAmWrV8BXo49PFs4F04CWpnMz7cPluqxbBnF7vaN8LwT
         HPq2Sx64edhmQYJeeGcnM0lnBsC6FHpGv2W/FRaNZ80GvetGCqssJpKXukHw1nZigCrL
         MNkGZwP9ty26cfNEu0Nt6Vv5GbtRxLKdhiFC28NxbLc41x9i/8p2gxpZgvnDnZqGa1fR
         EHzIGLI4zpZ4vHKcXAjOQN1yck0VgdTJ/aUtM6/BRz8TnnCzYy6SNsxSnrLfnZ2Mnv7V
         aWAMUETyP2VFcb8okikz6bSAaykJLlpbU8eFlqZwMj5vo6Mz+sp3ZK+1vTP08+uBiH1w
         iRcw==
X-Forwarded-Encrypted: i=1; AJvYcCVzD0DhhJ69Xm0i4SudB3S88MjqJUyTBLEfMcE0qj+U/WfeCRDoKXF3pdxRSIXMTTG4WMxrVIBHXKRWTccNzDiiCO1769g=
X-Gm-Message-State: AOJu0YyOZhkFTRAQnyQ4ehhijJCaxGQfJ6ljN8oOHaWHCw5xZvLiAHWt
	N+DnotyGWERoO4yQRXMT8nH9R9vlSOOYwsp+cXZjrbWlg8EWpHjUDxJHlSAQWGyWByJbS3PRE5m
	WRx2RklblMVqu6+dHowILBU+hL+2tadQp+OPCIQ==
X-Google-Smtp-Source: AGHT+IGwkj24vCYggigVErwYUWeLyyQPYaxqLK9M4dtT+l3m8GW14hK5AXbiZ8Timfu0ZgNDZaYV9PwlM36bnRlfo7g=
X-Received: by 2002:a17:90a:fa03:b0:2c8:ec4c:436 with SMTP id
 98e67ed59e1d1-2c93d767652mr2217306a91.33.1719825046205; Mon, 01 Jul 2024
 02:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240701072908.25503-1-luxu.kernel@bytedance.com>
 <20240701072908.25503-2-luxu.kernel@bytedance.com> <CAH2o1u7j6pXhWHL2rBZak6LeXxn_KUbQHjygRGQKuEfS_vmtkQ@mail.gmail.com>
In-Reply-To: <CAH2o1u7j6pXhWHL2rBZak6LeXxn_KUbQHjygRGQKuEfS_vmtkQ@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Mon, 1 Jul 2024 17:10:35 +0800
Message-ID: <CAPYmKFtCzQOOsN7vutoY0MrthtvcGxBqRsbr4ZgMQsaY1CrXHQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/1] iommu/riscv: Support sharing irq lines
 between iommu queues
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	apatel@ventanamicro.com, sunilvl@ventanamicro.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@rivosinc.com, baolu.lu@linux.intel.com, lihangjing@bytedance.com, 
	xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for not describing it clearly.

Indeed, the hardware interrupt lines have be configured in
riscv_iommu_init_check().

What I mean is that virtual interrupts of irqs[iommu->irqs_count] to
irqs[RISCV_IOMMU_INTR_COUNT - 1] are not set, which will cause
riscv_iommu_queue_enable() fail:
       const unsigned int irq =3D
iommu->irqs[riscv_iommu_queue_vec(iommu, queue->qid)];
       rc =3D request_threaded_irq(irq, xxx);
       if (rc) {
                 queue->iommu =3D NULL;
                 return rc;
       }

The virtual irq of queue id 'q' should be the same as irqs[q %
iommu->irqs_count] as ICVEC is configured in the same way.

Regards,

Xu Lu

On Mon, Jul 1, 2024 at 4:47=E2=80=AFPM Tomasz Jeznach <tjeznach@rivosinc.co=
m> wrote:
>
> On Mon, Jul 1, 2024 at 9:29=E2=80=AFAM 'Xu Lu' via linux <linux@rivosinc.=
com> wrote:
> >
> > When the number of wired interrupt lines is less than the number of
> > iommu queues, we should assign one irq line for several queues and
> > configure csr icvec accordingly.
> >
>
> Is this case not already covered by the code in function
> riscv_iommu_init_check(), assigning cause to vector register (ICVEC)
> based on available interrupt vectors? Interrupt vector selection is
> based on accepted ICVEC configuration (see riscv_iommu_queue_vec()).
>
> Relevant code (patch 'Command and fault queue support'):
> iommu->icvec =3D FIELD_PREP(RISCV_IOMMU_ICVEC_FIV, 1 % iommu->irqs_count)=
 |
>        FIELD_PREP(RISCV_IOMMU_ICVEC_PIV, 2 % iommu->irqs_count) |
>        FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3 % iommu->irqs_count);
>
> Values in iommu->irqs[] should represent actual interrupts allocated
> for the device.
>
> Best,
> - Tomasz
>
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > ---
> >  drivers/iommu/riscv/iommu-platform.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv=
/iommu-platform.c
> > index da336863f152..1d0af1260d5b 100644
> > --- a/drivers/iommu/riscv/iommu-platform.c
> > +++ b/drivers/iommu/riscv/iommu-platform.c
> > @@ -60,6 +60,10 @@ static int riscv_iommu_platform_probe(struct platfor=
m_device *pdev)
> >         for (vec =3D 0; vec < iommu->irqs_count; vec++)
> >                 iommu->irqs[vec] =3D platform_get_irq(pdev, vec);
> >
> > +       for (vec =3D iommu->irqs_count; vec < RISCV_IOMMU_INTR_COUNT; v=
ec++)
> > +               iommu->irqs[vec] =3D platform_get_irq(pdev,
> > +                                                   (vec % iommu->irqs_=
count));
> > +
> >         /* Enable wire-signaled interrupts, fctl.WSI */
> >         if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
> >                 iommu->fctl |=3D RISCV_IOMMU_FCTL_WSI;
> > --
> > 2.20.1
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to linux+unsubscribe@rivosinc.com.
> > To view this discussion on the web visit https://groups.google.com/a/ri=
vosinc.com/d/msgid/linux/20240701072908.25503-2-luxu.kernel%40bytedance.com=
.
> > For more options, visit https://groups.google.com/a/rivosinc.com/d/opto=
ut.
