Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F351C08
	for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 15:01:24 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id c10so2149659qtj.10
        for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 08:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679324484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnfGX7Qm2m1ximJzaBiSodqBclPMC2gwUS6QauY2y6c=;
        b=uCGRtGM63WyG+gDwnYKh0HbBNQLYvlEj0FGQA5wGF4m0+X2EiNbvSlhK/idRH6ZPhk
         wc86HigrVi1tK4xXTgAV6XM5ipszao5cW06Q+A7AUcKsyahl6ceoUclnmzvjdekvXRKO
         Epo0c7CsUhDov6iHyqvzo5evmhgEg2xwRuo6OHEixFarmeP+4T7oKq/bi4FgJkUTHNMX
         ICyNM9MSXFe6T++7Zrq8U5YfhDHTmMWwmQseHtOMd6pPzHLsX/GOKOzk6pasqFsAf9Bn
         2BBVH+dsym6XISLFaBS8I34/ZW5kY0UQQk4CRqAhhF4ZQz0Sz5CKim/W8d951kMvKLty
         zSNQ==
X-Gm-Message-State: AO0yUKV1TMOp39BIigo8g/8V6ilMtETKryFabzpTjHzG8b2wo49b1jAL
	UQCihoYAIT81bAoVSc0C6FQmp07xp3zbDg==
X-Google-Smtp-Source: AK7set9iOZbwHopaZwp+oreMQfurOrnmitgBXpnqbqXS+G4ZxzN2SGxT6LuQOglsot9q3VcDt0CX5g==
X-Received: by 2002:a05:622a:156:b0:3bf:c62d:1004 with SMTP id v22-20020a05622a015600b003bfc62d1004mr29604093qtw.38.1679324483707;
        Mon, 20 Mar 2023 08:01:23 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id l5-20020ac87245000000b003d3b9f79b4asm6495413qtp.68.2023.03.20.08.01.22
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 08:01:23 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id r1so13438054ybu.5
        for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 08:01:22 -0700 (PDT)
X-Received: by 2002:a25:f208:0:b0:b6b:841a:aae4 with SMTP id
 i8-20020a25f208000000b00b6b841aaae4mr2274045ybe.12.1679324482409; Mon, 20 Mar
 2023 08:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230313124026.954514-1-yoshihiro.shimoda.uh@renesas.com> <20230320144914.GA1609519-robh@kernel.org>
In-Reply-To: <20230320144914.GA1609519-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Mar 2023 16:01:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUOxNUL9Sm5n+SB01TaF1hgdFvZiAydKGw3OiLbbOCCPw@mail.gmail.com>
Message-ID: <CAMuHMdUOxNUL9Sm5n+SB01TaF1hgdFvZiAydKGw3OiLbbOCCPw@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: iommu: renesas, ipmmu-vmsa: Update for
 R-Car Gen4
To: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, krzysztof.kozlowski+dt@linaro.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Mon, Mar 20, 2023 at 3:49=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> On Mon, Mar 13, 2023 at 09:40:26PM +0900, Yoshihiro Shimoda wrote:
> > Since R-Car Gen4 does not have the main IPMMU IMSSTR register, update
> > the bindings to drop the interrupt bit number from the
> > renesas,ipmmu-main property.
>
> Wouldn't it be easier to define a value meaning 'no interrupt bit' such
> as 0 or ~0 than having a variable sized property to parse?

(That would be ~0, as 0 is a valid bit number)

In theory: yes.
In practice: it doesn't matter much, as the driver doesn't use the value
anyway. Cfr. its parsing code being reworked in your patch
"[PATCH] iommu: Use of_property_present() for testing DT property presence"
https://lore.kernel.org/all/20230310144709.1542910-1-robh@kernel.org

So yes, using ~0 would simplify the bindings, but would complicate
the DTS files (and probably we should introduce a #define instead of
using ~0 or 0xffffffff or some other value).

> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > [geert: Re-add removed items level, add minItems/maxItems constraints]
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Changes from v3:
> > https://lore.kernel.org/all/20230209133440.2643228-1-yoshihiro.shimoda.=
uh@renesas.com/
> >  - Revise the dt-bindings by Geert-san (Thanks a lot!).
> >
> >  .../bindings/iommu/renesas,ipmmu-vmsa.yaml    | 32 ++++++++++++++-----
> >  1 file changed, 24 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa=
.yaml b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> > index 72308a4c14e7..be90f68c11d1 100644
> > --- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> > @@ -74,16 +74,16 @@ properties:
> >    renesas,ipmmu-main:
> >      $ref: /schemas/types.yaml#/definitions/phandle-array
> >      items:
> > -      - items:
> > +      - minItems: 1
> > +        items:
> >            - description: phandle to main IPMMU
> > -          - description: the interrupt bit number associated with the =
particular
> > -              cache IPMMU device. The interrupt bit number needs to ma=
tch the main
> > -              IPMMU IMSSTR register. Only used by cache IPMMU instance=
s.
> > +          - description:
> > +              The interrupt bit number associated with the particular =
cache
> > +              IPMMU device. If present, the interrupt bit number needs=
 to match
> > +              the main IPMMU IMSSTR register. Only used by cache IPMMU
> > +              instances.
> >      description:
> > -      Reference to the main IPMMU phandle plus 1 cell. The cell is
> > -      the interrupt bit number associated with the particular cache IP=
MMU
> > -      device. The interrupt bit number needs to match the main IPMMU I=
MSSTR
> > -      register. Only used by cache IPMMU instances.
> > +      Reference to the main IPMMU.
> >
> >  required:
> >    - compatible
> > @@ -109,6 +109,22 @@ allOf:
> >        required:
> >          - power-domains
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: renesas,rcar-gen4-ipmmu-vmsa
> > +    then:
> > +      properties:
> > +        renesas,ipmmu-main:
> > +          items:
> > +            - maxItems: 1
> > +    else:
> > +      properties:
> > +        renesas,ipmmu-main:
> > +          items:
> > +            - minItems: 2
> > +

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
