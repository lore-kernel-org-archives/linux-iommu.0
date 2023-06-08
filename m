Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44B17740
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 20:05:12 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-3f9b7de94e7so287351cf.0
        for <iommu@lists.linux.dev>; Thu, 08 Jun 2023 13:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686254712; x=1688846712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIV4LjcD36Raxv3M+Ag2LHAyDiN4jPlJxEgpmm5HAXE=;
        b=ryhL8UJia9g5S9RPy+hrb7vPPXgT9o8MGy4TCS9EOIibHpqUl2uXkfajgT51A5hk7b
         EujLBWke8ypBQlowkALAU04JjJuWEzsePXVfFMFlPxdzbTA3XKIammlwin6Hbl1yZoys
         zwrBxzzDu+QknfG0UbOV1BCdGegs8r2/66x1/vGXN2RglVQIomqGCqKVMOHKt2E7u6z1
         cFme/LVWAbnG/29F92z/pDPEOC+K7uUX6pjMBVpBC8BBL3QBNV1d9ViU7GhDcUAOMWom
         SmPnZ6L94/O7UuUJq3xNB1pizW4/wYbGHBDINxdO/eOmM6bu+sactlsQmtGPTtI58p5g
         Q+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686254712; x=1688846712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIV4LjcD36Raxv3M+Ag2LHAyDiN4jPlJxEgpmm5HAXE=;
        b=lFCkDkx/0bxe7y90EneMSG5xseCi+iyzLMjlQIy8P8OoDJnFGvBekbk75XiseY6fhM
         +ZgC0B4g0aoYj57mrcSgUNsp4QviE1Rr3l13GbhYyuPai8JM1aqdJyqoezCPQI/xIlKc
         dGn02jHCs3c0ydHDA0HamsPRCHSQApkwrYhiwfnruOExCXjtsKO4BF4IroGxWk+t898X
         OCaESaFlhdo+4YhMDS42BHxToSXZlFB/xB1qYCXRMsxVstc/dPIXncrdcrxGQjlTrpV9
         dKxh0QxA++fSpbSXt6T0GzTjo7OVN3UgJZC4DaiJ/MrCy2FkhvDDFjlMXNyFJZG084db
         c4uw==
X-Gm-Message-State: AC+VfDxtPPs+1LsG9FfaAS7NL8BUiPY0UpxsugR+QjZJf28W4pwUTVg8
	4bvYdw1js9UQbt3A0eJdpufxukIXDaTtSVVWLomF0Q==
X-Google-Smtp-Source: ACHHUZ4CIbONl7q3IxgWipvcRK0WIl5R4yl0ilwzDhwV1nhu8O2kmYKeF+sJyJtKS8kZQQ8bnUw8T5mHJeT9LNiKz7A=
X-Received: by 2002:ac8:4e85:0:b0:3f3:75c2:7466 with SMTP id
 5-20020ac84e85000000b003f375c27466mr170826qtp.8.1686254711773; Thu, 08 Jun
 2023 13:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-3-apatel@ventanamicro.com> <20230608182828.GA3183987-robh@kernel.org>
In-Reply-To: <20230608182828.GA3183987-robh@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 8 Jun 2023 13:04:35 -0700
Message-ID: <CAGETcx_4OH=EmSUL2-rwKa=1uoOj+AH_xn4PoPsc0kt_aU0WOg@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] of/irq: Set FWNODE_FLAG_BEST_EFFORT for the
 interrupt controller DT nodes
To: Rob Herring <robh@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Marc Zyngier <maz@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 8, 2023 at 11:28=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> +Saravana
>
> On Mon, May 08, 2023 at 07:58:33PM +0530, Anup Patel wrote:
> > The RISC-V APLIC interrupt controller driver is a regular platform
> > driver so we need to ensure that it is probed as soon as possible.
> > To achieve this, we mark the interrupt controller device nodes with
> > FWNODE_FLAG_BEST_EFFORT (just like console DT node).
> >
> > Fixes: 8f486cab263c ("driver core: fw_devlink: Allow firmware to mark d=
evices as best effort")
>
> It is good practice to Cc the commit author of what you are fixing.
>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/of/irq.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index 174900072c18..94e1d9245cff 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -535,6 +535,16 @@ void __init of_irq_init(const struct of_device_id =
*matches)
> >       INIT_LIST_HEAD(&intc_desc_list);
> >       INIT_LIST_HEAD(&intc_parent_list);
> >
> > +     /*
> > +      * We need interrupt controller platform drivers to work as soon
>
> If it's platform drivers/devices you care about, then perhaps this
> should be done when platform devices are created.
>
> > +      * as possible so mark the interrupt controller device nodes with
> > +      * FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
> > +      * the probe of the interrupt controller device for suppliers
> > +      * without drivers.
> > +      */
> > +     for_each_node_with_property(np, "interrupt-controller")
>
> This function only operates on nodes matching 'matches', but this
> operates on everything.
>
> It does make sense that if we init an interrupt controller here, then we
> will surely want to probe its driver later on. So maybe just move
> setting FWNODE_FLAG_BEST_EFFORT within
> for_each_matching_node_and_match() below.
>
> > +             np->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;
> > +

Definite Nack. You are pretty much disabling fw_devlink for all
interrupt controllers. There are plenty of examples of the IRQ drivers
being needed very early on and still probing properly without the need
for this flag. Please fix your driver/DT.

-Saravana


> >       for_each_matching_node_and_match(np, matches, &match) {
> >               if (!of_property_read_bool(np, "interrupt-controller") ||
> >                               !of_device_is_available(np))
> > --
> > 2.34.1
> >
