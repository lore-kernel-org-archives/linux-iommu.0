Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354EE1842
	for <iommu@lists.linux.dev>; Wed, 25 Jan 2023 08:54:50 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id x5so15403062qti.3
        for <iommu@lists.linux.dev>; Wed, 25 Jan 2023 00:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4i0NQxBxCgG41kmz90B1V7AlGxxGPtE8fvvNdHh0fI4=;
        b=RRj7XpWo6ffZ3BvuTTCZP7YFx4kBf5lP7c15UDofzYTzafGS1jXGsBCilMtKX8bUTQ
         UKjGaVlTtEwtAagFmCJu35ccDrPDd8+XbMT1+8xVeXEnatdse9h9mCKCc7o+2IOCjvxX
         Vx4RKVCpqBPaCEJWn6mtIk/Nlyb3Od0mejvfa+CnDiJjgc/bzURgAp95OE2yb6qmuqlM
         k6dASFu342Oisl3qo2Rw1sVzUmRao83lKpnXaefTrWKpPFk/xYxXL+IntQqh1uBGXS27
         ABKNuwSNlb0C1HxxVZ6Mz82/IQAIEp1Ffmh8yS5dOq6CxwsByDlef1AMMFdw8bEpHOLl
         iTPw==
X-Gm-Message-State: AFqh2kq9GY9ygMUgrYXfsN+R9p3vQHchh85MQsVGCOt/05XKp5eU58YS
	J8qhFpQkbeS6WSrr7R0gFFaNly2JqMeYHw==
X-Google-Smtp-Source: AMrXdXt1GfWWYY1km7RPOKUEk/+cC5N5OAN02inDnjUViDkgw8VGm32GjgtoWtj3JRIdAtoAVa5+Mg==
X-Received: by 2002:ac8:478c:0:b0:3a9:8353:aeeb with SMTP id k12-20020ac8478c000000b003a98353aeebmr43436876qtq.5.1674636888740;
        Wed, 25 Jan 2023 00:54:48 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id z10-20020ac8430a000000b003b6325dfc4esm2932245qtm.67.2023.01.25.00.54.47
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 00:54:48 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id d132so603675ybb.5
        for <iommu@lists.linux.dev>; Wed, 25 Jan 2023 00:54:47 -0800 (PST)
X-Received: by 2002:a25:dd8:0:b0:80a:6a1c:7c3b with SMTP id
 207-20020a250dd8000000b0080a6a1c7c3bmr1186104ybn.89.1674636887719; Wed, 25
 Jan 2023 00:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230123012940.1250879-1-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdX92KMeON0xC9p17kiqWT7ksEBX_NyPiiQk0fLaucDZBA@mail.gmail.com> <TYBPR01MB5341B023178B4A10DE52B844D8CE9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5341B023178B4A10DE52B844D8CE9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Jan 2023 09:54:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXXnu88Tn2ucuHZK=3G18v-nCfaTYpomchRXBu3bD7UuA@mail.gmail.com>
Message-ID: <CAMuHMdXXnu88Tn2ucuHZK=3G18v-nCfaTYpomchRXBu3bD7UuA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iommu: renesas,ipmmu-vmsa: Update
 descriptions for R-Car Gen4
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Shimoda-san,

On Wed, Jan 25, 2023 at 1:49 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Geert Uytterhoeven, Sent: Tuesday, January 24, 2023 11:35 PM
> > On Mon, Jan 23, 2023 at 2:35 AM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > Since R-Car Gen4 doens't have the main IPMMU IMSSTR register, but
> > > each cache IPMMU has own module id. So, update descriptions of
> > > renesas,ipmmu-main property for R-Car Gen4.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

> > > ---
> > >  The old R-Car S4-8 datasheet had described IPMMU IMSSTR register, but
> > >  the latest datasheet undocumented the register. So, update the propeties
> > >  description. Note that the second argument is not used on the driver.
> >
> > DT describes hardware, not software policy.
>
> I think so.
>
> > >  So no behavior change.
> >
> > So where do we get the module id numbers to use, if they are no longer
> > documented in the Hardware Manual?
>
> If so, we cannot get the module id numbers. So, should we use other
> information which is completely fixed instead? I have some ideas:
> 1) Just 0 (or other fixed value) if the IMSSTR register doesn't exist.
> 2) Sequential numbers from register base offset.
>    In R-Car S4: ipmmu_rt0 is the first node from register base offset,
>    and ipmmu_rt1 is the second one.
>    So, ipmmu_rt0 is 0, ipmmu_rt1 is 1, ipmmu_ds0 is 2 and ipmmu_hc is 3.
> 3) Using base address upper 16-bits.
>    In R-Car S4: ipmmu_rt0 is 0xee480000. So, the value is 0xee48.
>
> Perhaps, the option 1) is reasonable, I think. But, what do you think?

I would not make up numbers, as that would cause confusion with SoCs
where the numbers do match the hardware.
As the driver doesn't use the module id number (it already loops
over all domains, instead of checking IMSSTR, probably because of
historical (R-Car Gen2) reasons?), what about dropping it from the
property? I.e. add "minItems: 1", possibly only when compatible with
renesas,rcar-gen4-ipmmu-vmsa?

BTW, the related IMCTR register is still documented, and the driver
does enable the interrupt bit (IMCTR_INTEN), so I'm wondering how the
hardware (documentation) people intend this to be used...
Perhaps IMCTR_INTEN will be removed/undocumented, too?
Or perhaps the removal/undocumentation of IMSSTR was a mistake?

> > > --- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> > > +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> > > @@ -76,14 +76,15 @@ properties:
> > >      items:
> > >        - items:
> > >            - description: phandle to main IPMMU
> > > -          - description: the interrupt bit number associated with the particular
> > > -              cache IPMMU device. The interrupt bit number needs to match the main
> > > -              IPMMU IMSSTR register. Only used by cache IPMMU instances.
> > > +          - description: The interrupt bit number or module id associated with
> > > +              the particular cache IPMMU device. The interrupt bit number needs
> > > +              to match the main IPMMU IMSSTR register. Only used by cache IPMMU
> > > +              instances.
> > >      description:
> > >        Reference to the main IPMMU phandle plus 1 cell. The cell is
> > > -      the interrupt bit number associated with the particular cache IPMMU
> > > -      device. The interrupt bit number needs to match the main IPMMU IMSSTR
> > > -      register. Only used by cache IPMMU instances.
> > > +      the interrupt bit number or module id associated with the particular
> > > +      cache IPMMU device. The interrupt bit number needs to match the main
> > > +      IPMMU IMSSTR register. Only used by cache IPMMU instances.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
