Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475087EC
	for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 08:20:53 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id k2so10622008qvd.12
        for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 00:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRHAGhQgk4pQ7LOPV0/iV6SDvyC1guNRZ8CaTTxtQfo=;
        b=1EFJQRkYmlaahd2zNnCJhvUo/3ACENVkrKJkTt9g+RhLZxojTibNDumNMrcdYWJ1Cb
         Te8la6zkdOWOZWPT2I72o9ZUdeXbiVJ0v88gwawTfTARGT/apYa+hyBXOV+0hkhsh+xt
         tpP4L/+zw82K7v8+8GMJlKSixH3ExheH554ZcPeUwVMlMAFlPkVieYPLDfm1Qk6snbTW
         3/LKwAJ4791AjR+yXLwRbm+ZpfEXEy7JHb3H/lqbk0pIFs0n4bMVL3Xbnf5DKM3IYw5J
         qvG3sVdc94iRQ4SJ30V4loWAIlTpBQHWwatxoA5AoW6JDvae8eaJ1n3Y4XAQOjhXM/kF
         iLhA==
X-Gm-Message-State: AFqh2kr6R/Fphv7tZxY3td5PzmuuSUH0qyk34HSPnc9IAsVLE01A52tf
	tLL4/J0YMYtMP5L4itt6IA00P7DYdeqF3Q==
X-Google-Smtp-Source: AMrXdXsDqe/xt3g8FNU2D+YGiQgeqsKFVSRi/Ul9G1w/R+z9LPHdv5i7PBAUqkC6ypTRHAMfCQYl2A==
X-Received: by 2002:ad4:4181:0:b0:535:5a91:f4c8 with SMTP id e1-20020ad44181000000b005355a91f4c8mr53020808qvp.49.1675153251703;
        Tue, 31 Jan 2023 00:20:51 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id op52-20020a05620a537400b007186c9e167esm8009495qkn.52.2023.01.31.00.20.50
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 00:20:51 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id p141so17099356ybg.12
        for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 00:20:50 -0800 (PST)
X-Received: by 2002:a25:4483:0:b0:839:c329:be37 with SMTP id
 r125-20020a254483000000b00839c329be37mr73386yba.89.1675153250731; Tue, 31 Jan
 2023 00:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230123012940.1250879-1-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdX92KMeON0xC9p17kiqWT7ksEBX_NyPiiQk0fLaucDZBA@mail.gmail.com>
 <TYBPR01MB5341B023178B4A10DE52B844D8CE9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <CAMuHMdXXnu88Tn2ucuHZK=3G18v-nCfaTYpomchRXBu3bD7UuA@mail.gmail.com>
 <3c3e1dc2-1f66-565c-c677-2eae368e10be@arm.com> <20230130193604.GA3218335-robh@kernel.org>
In-Reply-To: <20230130193604.GA3218335-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 31 Jan 2023 09:20:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU4j3drFt6jAZPHTJMrrL7GTWHxNqMGHR-1pScqg4H2xg@mail.gmail.com>
Message-ID: <CAMuHMdU4j3drFt6jAZPHTJMrrL7GTWHxNqMGHR-1pScqg4H2xg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iommu: renesas,ipmmu-vmsa: Update
 descriptions for R-Car Gen4
To: Rob Herring <robh@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "joro@8bytes.org" <joro@8bytes.org>, 
	"will@kernel.org" <will@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

On Mon, Jan 30, 2023 at 8:36 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, Jan 25, 2023 at 10:42:13AM +0000, Robin Murphy wrote:
> > On 2023-01-25 08:54, Geert Uytterhoeven wrote:
> > > On Wed, Jan 25, 2023 at 1:49 AM Yoshihiro Shimoda
> > > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > > From: Geert Uytterhoeven, Sent: Tuesday, January 24, 2023 11:35 PM
> > > > > On Mon, Jan 23, 2023 at 2:35 AM Yoshihiro Shimoda
> > > > > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > > > Since R-Car Gen4 doens't have the main IPMMU IMSSTR register, but
> > > > > > each cache IPMMU has own module id. So, update descriptions of
> > > > > > renesas,ipmmu-main property for R-Car Gen4.
> > > > > >
> > > > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > >
> > > > > > ---
> > > > > >   The old R-Car S4-8 datasheet had described IPMMU IMSSTR register, but
> > > > > >   the latest datasheet undocumented the register. So, update the propeties
> > > > > >   description. Note that the second argument is not used on the driver.
> > > > >
> > > > > DT describes hardware, not software policy.
> > > >
> > > > I think so.
> > > >
> > > > > >   So no behavior change.
> > > > >
> > > > > So where do we get the module id numbers to use, if they are no longer
> > > > > documented in the Hardware Manual?
> > > >
> > > > If so, we cannot get the module id numbers. So, should we use other
> > > > information which is completely fixed instead? I have some ideas:
> > > > 1) Just 0 (or other fixed value) if the IMSSTR register doesn't exist.
> > > > 2) Sequential numbers from register base offset.
> > > >     In R-Car S4: ipmmu_rt0 is the first node from register base offset,
> > > >     and ipmmu_rt1 is the second one.
> > > >     So, ipmmu_rt0 is 0, ipmmu_rt1 is 1, ipmmu_ds0 is 2 and ipmmu_hc is 3.
> > > > 3) Using base address upper 16-bits.
> > > >     In R-Car S4: ipmmu_rt0 is 0xee480000. So, the value is 0xee48.
> > > >
> > > > Perhaps, the option 1) is reasonable, I think. But, what do you think?
> > >
> > > I would not make up numbers, as that would cause confusion with SoCs
> > > where the numbers do match the hardware.
> > > As the driver doesn't use the module id number (it already loops
> > > over all domains, instead of checking IMSSTR, probably because of
> > > historical (R-Car Gen2) reasons?), what about dropping it from the
> > > property? I.e. add "minItems: 1", possibly only when compatible with
> > > renesas,rcar-gen4-ipmmu-vmsa?
> >
> > Right, if there really is no meaningful ID for this model then its binding
> > should not require one.
>
> I agree, however that makes parsing the property a pain (for both the
> schema and driver). This property is a matrix. The number of entries is
> already variable. If both dimensions are variable, we have to then look
> at the compatible to know how to parse it. I would go with option 1.

But it does not have to be two-dimensional.
The second dimension was added in commit 39bd2b6a3783b899 ("dt-bindings
 Improve phandle-array schemas"), but is not needed.
Can this be simplified again?

The driver doesn't care, it just checks for the presence of the
property, i.e. treats it as a boolean flag.

> A 4th option is a new property.

If all else fails, a new boolean flag would work...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
