Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFAA79E5
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 11:40:58 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ba8cd61ee2dso4000446276.1
        for <iommu@lists.linux.dev>; Fri, 09 Jun 2023 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686310858; x=1688902858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJt3feXs6SxyQtoTGkEhwKTgAeqCp1KzPotYyZ8bIc4=;
        b=Y1My6pemRG3jJeTY2XZLEGCaA4W6dI+/ilaXi1H7/t5ar1Xt08MRq8dPmkoDStDMXm
         kT2xMT9WUoCFhPjjVnNLR8FpVjjfLYljLuWfy8+gOcf4qMNF/4Tck3DfURhGh74b+61z
         5GXCx94pwXORCfv023PbhMTxYlyvhBya7BIUcVnWvxxeGZcEgH5TX6NbHW18bpW1nuGw
         Zu7ssPlBukM6546UMTV8PcfcFD6llsNDuNBHHzOZtqi1Ok3QZgWECjoiRzVFRgFzyVHD
         DMbQV34S2wEd4j9azFOrRar6xAS/7Ve1/EQCLv7a1Gpoq0xRaDBwip/8ZWJP5a1jFG/J
         z5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686310858; x=1688902858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJt3feXs6SxyQtoTGkEhwKTgAeqCp1KzPotYyZ8bIc4=;
        b=O1mn3YbTJh+MBgI0I07r0klJPmPkU50JkR7htnjL7qNj6NrD8lRonH2sDlAWoUr24H
         bwK78AUm88qaiA30eYf3wwrgu+FKAGYie61+Myx1DGT79JDmkEZQAnTqaYGqjJvrbum/
         JkYsofPhDP9n1nRAdROGwS0iTD2enDYTJkdc9PXJDNpOieREjr9aAF9alYBP8i0h5C33
         pF4EsbDR3OPAF4vTM/ryzO7qOpXvvwgy/qN84IntdTyQtTADvqqoZMki8U7t2DMqjPjM
         Wi8xhl26Ce/90CSE0xo4b1+A/UD0SOgaVnkjHTD6wOqpNY3kiB9qpYjd8oW6GKBbPxKQ
         TlfQ==
X-Gm-Message-State: AC+VfDwITPUSddVmSHs/gEpvhXP+B5NrDJ8LGZG2yVnjT/Xadu0GVj/o
	ZiD0SW33bmePnXPvCkRnKRWapAGVd8I7mYG8o97MBA==
X-Google-Smtp-Source: ACHHUZ6tcnye369zFXBV2bBHJWRzfVKRU8NYtwA27HSSc5WJJxk9tivdQDX48v29djspGuooSVUxeE1q+GAIw2Q6QXE=
X-Received: by 2002:a81:4e4e:0:b0:568:ed48:21bb with SMTP id
 c75-20020a814e4e000000b00568ed4821bbmr1746710ywb.13.1686310857937; Fri, 09
 Jun 2023 04:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-3-apatel@ventanamicro.com> <20230608182828.GA3183987-robh@kernel.org>
 <CAGETcx_4OH=EmSUL2-rwKa=1uoOj+AH_xn4PoPsc0kt_aU0WOg@mail.gmail.com>
In-Reply-To: <CAGETcx_4OH=EmSUL2-rwKa=1uoOj+AH_xn4PoPsc0kt_aU0WOg@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 9 Jun 2023 17:10:45 +0530
Message-ID: <CAK9=C2V1LH0739Nq5Ji7gGbgbyFtNAtBYR43fU7vr9omD5tKSA@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] of/irq: Set FWNODE_FLAG_BEST_EFFORT for the
 interrupt controller DT nodes
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Marc Zyngier <maz@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 9, 2023 at 1:35=E2=80=AFAM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> On Thu, Jun 8, 2023 at 11:28=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> >
> > +Saravana
> >
> > On Mon, May 08, 2023 at 07:58:33PM +0530, Anup Patel wrote:
> > > The RISC-V APLIC interrupt controller driver is a regular platform
> > > driver so we need to ensure that it is probed as soon as possible.
> > > To achieve this, we mark the interrupt controller device nodes with
> > > FWNODE_FLAG_BEST_EFFORT (just like console DT node).
> > >
> > > Fixes: 8f486cab263c ("driver core: fw_devlink: Allow firmware to mark=
 devices as best effort")
> >
> > It is good practice to Cc the commit author of what you are fixing.
> >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > ---
> > >  drivers/of/irq.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > > index 174900072c18..94e1d9245cff 100644
> > > --- a/drivers/of/irq.c
> > > +++ b/drivers/of/irq.c
> > > @@ -535,6 +535,16 @@ void __init of_irq_init(const struct of_device_i=
d *matches)
> > >       INIT_LIST_HEAD(&intc_desc_list);
> > >       INIT_LIST_HEAD(&intc_parent_list);
> > >
> > > +     /*
> > > +      * We need interrupt controller platform drivers to work as soo=
n
> >
> > If it's platform drivers/devices you care about, then perhaps this
> > should be done when platform devices are created.
> >
> > > +      * as possible so mark the interrupt controller device nodes wi=
th
> > > +      * FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
> > > +      * the probe of the interrupt controller device for suppliers
> > > +      * without drivers.
> > > +      */
> > > +     for_each_node_with_property(np, "interrupt-controller")
> >
> > This function only operates on nodes matching 'matches', but this
> > operates on everything.
> >
> > It does make sense that if we init an interrupt controller here, then w=
e
> > will surely want to probe its driver later on. So maybe just move
> > setting FWNODE_FLAG_BEST_EFFORT within
> > for_each_matching_node_and_match() below.
> >
> > > +             np->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;
> > > +
>
> Definite Nack. You are pretty much disabling fw_devlink for all
> interrupt controllers. There are plenty of examples of the IRQ drivers
> being needed very early on and still probing properly without the need
> for this flag. Please fix your driver/DT.

Okay, I will try to set FWNODE_FLAG_BEST_EFFORT only for
APLIC device_node via IRQCHIP_DECLARE().

Regards,
Anup


>
> -Saravana
>
>
> > >       for_each_matching_node_and_match(np, matches, &match) {
> > >               if (!of_property_read_bool(np, "interrupt-controller") =
||
> > >                               !of_device_is_available(np))
> > > --
> > > 2.34.1
> > >
