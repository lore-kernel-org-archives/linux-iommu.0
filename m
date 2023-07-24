Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577536FD2
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 09:47:49 +0000 (UTC)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-78847bb8940so230797139f.0
        for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690192068; x=1690796868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8bfGUj6PVSplOllAd2MEpS6lx5ONn993m33c0NCbEw=;
        b=eG+k/0eQ1dVjbqUi+Fgm5PV75urijLYhKsnv1AN21qidWsleaq1GIF1yDsE1SYlpcS
         T1BxyDHhpVghbdpylHZWvEkgNNXNsUhPOhkVR8ztiRuD38F3hfD5yQS0Kq7CCZmCY1wt
         KsRe23hLlzfw1YizGD0LyDsk9NdWHCl6NGAIqVzPI0doFxxf1ycp5HjHdw2u2iKzaIKk
         TiVKYNEmEpfQmhNW9llQU5t5Xriof54H/K3G5MSMVJ9/HCFuo9E32mevzrPPrJJAaXmt
         fOgsXcbEw7RdxuFumYd8xkSO8kzeatorXj3eZK3kKdFo3ZGLz4dbfiLi8cg6wEHOxhYD
         W6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192068; x=1690796868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8bfGUj6PVSplOllAd2MEpS6lx5ONn993m33c0NCbEw=;
        b=Krcv42vln5/qGfJFvLTFy/AEQjJJoMvgSvRAbd6SwUOAJASWDeHIVTTvv7q6Q1eVG5
         xnnblJIKtWXGfbyYJoj6FJLQANjQUQp51ApHuBDkUhzHQu280BtyIn7/KPzbYK7vNoQw
         tDOUUBXjt3NDFGhuVgohj7pu5QLwVB67pOO5Cpj/ijt3ZCKQT3cKbfTHIROb4IAc3ehG
         oSOtdt57FhkWkwi4YHZcTTrBKYmna7dqIx9rIa8sVrh1Vpwe1uM+EhpmzyfdIMEd4+T/
         JX1K8w9FGUZogLt04J6maZToG2GGjZ55wqVj8u+Q4R/Bv6CxTOGwBsRXP4U45EXkX8aL
         OsbA==
X-Gm-Message-State: ABy/qLYj6eyP1+iJCdcCn66zNYHaPF4s0fdexS20oa1sFVLngkQfeyoP
	s7NsOgJj3diD38LoRupHPb88pnaXkdA3n4TgAD4ImQ==
X-Google-Smtp-Source: APBJJlGfSvBbIxJHAJLERDdIj18GqzcBJdh2D0XeEHGN9JTosZLxsbRqgvszSigLLVQzezIwjDLaussRKBoZe3KwqTw=
X-Received: by 2002:a5d:81d1:0:b0:783:74c0:54ae with SMTP id
 t17-20020a5d81d1000000b0078374c054aemr6940592iol.21.1690192068270; Mon, 24
 Jul 2023 02:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
 <5b8fd18e-8dfa-96bf-cdd4-4498b1d15ab9@ics.forth.gr> <CAH2o1u7uAuXsD6+6Dvam4kzQuUj8s98G0sR26_-q31wvSUYZNA@mail.gmail.com>
In-Reply-To: <CAH2o1u7uAuXsD6+6Dvam4kzQuUj8s98G0sR26_-q31wvSUYZNA@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 24 Jul 2023 17:47:37 +0800
Message-ID: <CANXhq0rz1J+0t9M-e5NY015HhDT1Yy024_-Uan9CSJ4rMqtyng@mail.gmail.com>
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Nick Kossifidis <mick@ics.forth.gr>, Anup Patel <apatel@ventanamicro.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, Will Deacon <will@kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org, 
	Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 2:00=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> On Wed, Jul 19, 2023 at 8:12=E2=80=AFPM Nick Kossifidis <mick@ics.forth.g=
r> wrote:
> >
> > Hello Tomasz,
> >
> > On 7/19/23 22:33, Tomasz Jeznach wrote:
> > > Enables message or wire signal interrupts for PCIe and platforms devi=
ces.
> > >
> >
> > The description doesn't match the subject nor the patch content (we
> > don't jus enable interrupts, we also init the queues).
> >
> > > +     /* Parse Queue lengts */
> > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "cmdq_len", &io=
mmu->cmdq_len);
> > > +     if (!ret)
> > > +             dev_info(dev, "command queue length set to %i\n", iommu=
->cmdq_len);
> > > +
> > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "fltq_len", &io=
mmu->fltq_len);
> > > +     if (!ret)
> > > +             dev_info(dev, "fault/event queue length set to %i\n", i=
ommu->fltq_len);
> > > +
> > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "priq_len", &io=
mmu->priq_len);
> > > +     if (!ret)
> > > +             dev_info(dev, "page request queue length set to %i\n", =
iommu->priq_len);
> > > +
> > >       dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > >
> >
> > We need to add those to the device tree binding doc (or throw them away=
,
> > I thought it would be better to have them as part of the device
> > desciption than a module parameter).
> >
>
> We can add them as an optional fields to DT.
> Alternatively, I've been looking into an option to auto-scale CQ/PQ
> based on number of attached devices, but this gets trickier for
> hot-pluggable systems. I've added module parameters as a bare-minimum,
> but still looking for better solutions.
>
> >
> > > +static irqreturn_t riscv_iommu_priq_irq_check(int irq, void *data);
> > > +static irqreturn_t riscv_iommu_priq_process(int irq, void *data);
> > > +
> >
> > > +     case RISCV_IOMMU_PAGE_REQUEST_QUEUE:
> > > +             q =3D &iommu->priq;
> > > +             q->len =3D sizeof(struct riscv_iommu_pq_record);
> > > +             count =3D iommu->priq_len;
> > > +             irq =3D iommu->irq_priq;
> > > +             irq_check =3D riscv_iommu_priq_irq_check;
> > > +             irq_process =3D riscv_iommu_priq_process;
> > > +             q->qbr =3D RISCV_IOMMU_REG_PQB;
> > > +             q->qcr =3D RISCV_IOMMU_REG_PQCSR;
> > > +             name =3D "priq";
> > > +             break;
> >
> >
> > It makes more sense to add the code for the page request queue in the
> > patch that adds ATS/PRI support IMHO. This comment also applies to its
> > interrupt handlers below.
> >
>
> ack. will do.
>
> >
> > > +static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu=
_command *cmd,
> > > +                                               u64 addr)
> > > +{
> > > +     cmd->dword0 |=3D RISCV_IOMMU_CMD_IOTINVAL_AV;
> > > +     cmd->dword1 =3D addr;
> > > +}
> > > +
> >
> > This needs to be (addr >> 2) to match the spec, same as in the iofence
> > command.
> >
>
> oops. Thanks!
>

I think it should be (addr >> 12) according to the spec.

> > Regards,
> > Nick
> >
>
> regards,
> - Tomasz
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
