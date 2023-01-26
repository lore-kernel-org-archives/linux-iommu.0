Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD91FAC
	for <iommu@lists.linux.dev>; Thu, 26 Jan 2023 08:38:41 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id h24so723204qta.12
        for <iommu@lists.linux.dev>; Thu, 26 Jan 2023 00:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imMQkcCxuclW/Kw/E739M72VzNhM+ffNSWSlrWspFBw=;
        b=z1Nm1Xxak/0NAR+QsICZ7T8I6N8fNGg2NJSW6K7F6HzNTS5DsJlSyY2UgTP8VT/tyJ
         N2dE82ENukCDFsRnaR5gAtFAHehMeJDgJFkcFSq1rypxWRxbIWd34htm51P4OQrcCMMP
         n3xAT1fx+XX9WIRdkskRKu1XLrg3Lq+t6rx7ksU4Zipmqq572arIs+u0gobST9tDZwBt
         fHN46qeFRUB0zaWi3XviOi3uE236cUqnnxDX03abyodOlNi4OVqz9bT7QJBPATB+oJee
         645tCPMCpeNxSwgkSoL/2OjUeQp7sbJyYG0aa7yJoK62yt6mNEqXGTffCuTq5TFOvEei
         6ybA==
X-Gm-Message-State: AFqh2krTtcAbqf5qim+OE5YzZ0NdGvFZ7zoQkLGc8sYk8AgfJSirH41E
	fSQfVkx3K/MkKe3/STy7zrT0aWaLSx/GKw==
X-Google-Smtp-Source: AMrXdXvHidNdYwtVoxBmfaFQmLieYZ3gay483QbZ/fzEEvAGFDZf2ArkoowiLOvywAjrFeWE9KkynA==
X-Received: by 2002:ac8:5444:0:b0:3b3:b561:2e26 with SMTP id d4-20020ac85444000000b003b3b5612e26mr44679363qtq.22.1674722319947;
        Thu, 26 Jan 2023 00:38:39 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id eb10-20020a05620a480a00b007112aa42c4fsm508729qkb.135.2023.01.26.00.38.38
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 00:38:39 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-501c3a414acso13951247b3.7
        for <iommu@lists.linux.dev>; Thu, 26 Jan 2023 00:38:38 -0800 (PST)
X-Received: by 2002:a81:bd6:0:b0:48d:1334:6e38 with SMTP id
 205-20020a810bd6000000b0048d13346e38mr4112101ywl.316.1674722318451; Thu, 26
 Jan 2023 00:38:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230123012940.1250879-1-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdX92KMeON0xC9p17kiqWT7ksEBX_NyPiiQk0fLaucDZBA@mail.gmail.com>
 <TYBPR01MB5341B023178B4A10DE52B844D8CE9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <CAMuHMdXXnu88Tn2ucuHZK=3G18v-nCfaTYpomchRXBu3bD7UuA@mail.gmail.com> <TYBPR01MB5341F8DC36EAD659209A2BDDD8CF9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5341F8DC36EAD659209A2BDDD8CF9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Jan 2023 09:38:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU6fWeQU=kPni5hfP5BC=MzpxSzNNf5ADe37qt1k6mnFw@mail.gmail.com>
Message-ID: <CAMuHMdU6fWeQU=kPni5hfP5BC=MzpxSzNNf5ADe37qt1k6mnFw@mail.gmail.com>
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

On Thu, Jan 26, 2023 at 1:55 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Geert Uytterhoeven, Sent: Wednesday, January 25, 2023 5:55 PM
> > On Wed, Jan 25, 2023 at 1:49 AM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > From: Geert Uytterhoeven, Sent: Tuesday, January 24, 2023 11:35 PM
> > > > On Mon, Jan 23, 2023 at 2:35 AM Yoshihiro Shimoda
> > > > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > > Since R-Car Gen4 doens't have the main IPMMU IMSSTR register, but
> > > > > each cache IPMMU has own module id. So, update descriptions of
> > > > > renesas,ipmmu-main property for R-Car Gen4.
> > > > >
> > > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >
> > > > > ---
> > > > >  The old R-Car S4-8 datasheet had described IPMMU IMSSTR register, but
> > > > >  the latest datasheet undocumented the register. So, update the propeties
> > > > >  description. Note that the second argument is not used on the driver.
> > > >
> > > > DT describes hardware, not software policy.
> > >
> > > I think so.
> > >
> > > > >  So no behavior change.
> > > >
> > > > So where do we get the module id numbers to use, if they are no longer
> > > > documented in the Hardware Manual?
> > >
> > > If so, we cannot get the module id numbers. So, should we use other
> > > information which is completely fixed instead? I have some ideas:
> > > 1) Just 0 (or other fixed value) if the IMSSTR register doesn't exist.
> > > 2) Sequential numbers from register base offset.
> > >    In R-Car S4: ipmmu_rt0 is the first node from register base offset,
> > >    and ipmmu_rt1 is the second one.
> > >    So, ipmmu_rt0 is 0, ipmmu_rt1 is 1, ipmmu_ds0 is 2 and ipmmu_hc is 3.
> > > 3) Using base address upper 16-bits.
> > >    In R-Car S4: ipmmu_rt0 is 0xee480000. So, the value is 0xee48.
> > >
> > > Perhaps, the option 1) is reasonable, I think. But, what do you think?
> >
> > I would not make up numbers, as that would cause confusion with SoCs
> > where the numbers do match the hardware.
>
> I see.
>
> > As the driver doesn't use the module id number (it already loops
> > over all domains, instead of checking IMSSTR, probably because of
> > historical (R-Car Gen2) reasons?), what about dropping it from the
> > property? I.e. add "minItems: 1", possibly only when compatible with
> > renesas,rcar-gen4-ipmmu-vmsa?
>
> It looks a good idea to me.
>
> > BTW, the related IMCTR register is still documented, and the driver
> > does enable the interrupt bit (IMCTR_INTEN), so I'm wondering how the
> > hardware (documentation) people intend this to be used...
> > Perhaps IMCTR_INTEN will be removed/undocumented, too?
> > Or perhaps the removal/undocumentation of IMSSTR was a mistake?
>
> I don't think that IMCTR_INTEN will be removed/undocumented too because
> the IMCTR register is related to IMSTR register, not IMSSTR register ;)
>                                  ~~~~~               ~~~~~~
> About undocumentation of IMSSTR, I found that accessing the register is
> possible to cause a potential issue on both R-Car Gen3/4. That's why
> the IMSSTR register is undocumented on R-Car Gen4. I'm not sure whether
> R-Car Gen3 will be undocumented too in the future though, but at least,
> we should not access the IMSSTR register on both R-Car Gen3/Gen4.
> # I'm not sure, but that's why the driver doesn't check IMSSTR to avoid
> # the potential issue??

IC

> So, to simplify the dt-bindings, just removing the second property without
> any condition is better, I think. But, what do you think?

So just add "minItems: 1", and leave out the second value of the
"renesas,ipmmu-main" property when adding support for new SoCs.
I don't think there is an immediate need to remove the existing second
value on already supported SoCs, as these values are not incorrect
hardware description.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
