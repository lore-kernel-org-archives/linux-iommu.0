Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BA11110
	for <iommu@lists.linux.dev>; Thu, 26 Jan 2023 08:34:07 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id x5so753111qti.3
        for <iommu@lists.linux.dev>; Thu, 26 Jan 2023 00:34:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRIB8MnpWStVHpiH44fh5LractuJCY2Y+UfvjAsI8p8=;
        b=c86gG9zuPGI+Xspu+aqWLdsY1dhrHSz83aaEFFAR9xK646RBQ/dmb41AXOXNnYf/iQ
         I9MUE2/VUdYs18E/M40Gw9qfImNsXO/hvGP9c/ywht4+o5okz+IiolTirGvblbGyE8ca
         IJPtQY+ttMcWzXUkRJJrcm9r+4ZQ7i4wEuZxyN+Hc3q44LQMrowOCWWMgfp+nfO6LaP2
         XaZ/pmDH05mDdSkp4He+WLlruDT2o3qd9F95jqFi0ZNgCtXUYZL1vqdknZp3mWTovfuU
         S6rA5N7/AK46rXBGvPUGx+38KLTvCRZMkCxMVRLTTILnQ8Q/gEvHu9U9y4yAre9tBuaq
         oTmQ==
X-Gm-Message-State: AFqh2kqRry3WDUdSQqPBwVJw/9qSH5jNgOo28jKYUuD+Eggzg5+5O6/F
	FsNcLm06g8MmAQLZTXWGPUIssO4C2mGVSQ==
X-Google-Smtp-Source: AMrXdXsXvzmgFzvDRyJNOXZhfQulSQT73Pt937X9fiN8EiM8+x/EP/hbBFTBphwikqL1UhANMgwTrw==
X-Received: by 2002:a05:622a:22a6:b0:39c:da20:f7af with SMTP id ay38-20020a05622a22a600b0039cda20f7afmr52539405qtb.12.1674722046002;
        Thu, 26 Jan 2023 00:34:06 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id y6-20020a05620a25c600b007023fc46b64sm267332qko.113.2023.01.26.00.34.05
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 00:34:05 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-4c24993965eso13537977b3.12
        for <iommu@lists.linux.dev>; Thu, 26 Jan 2023 00:34:05 -0800 (PST)
X-Received: by 2002:a81:4b02:0:b0:507:6027:60e7 with SMTP id
 y2-20020a814b02000000b00507602760e7mr453322ywa.47.1674722045305; Thu, 26 Jan
 2023 00:34:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230123012940.1250879-1-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdX92KMeON0xC9p17kiqWT7ksEBX_NyPiiQk0fLaucDZBA@mail.gmail.com>
 <TYBPR01MB5341B023178B4A10DE52B844D8CE9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <CAMuHMdXXnu88Tn2ucuHZK=3G18v-nCfaTYpomchRXBu3bD7UuA@mail.gmail.com> <3c3e1dc2-1f66-565c-c677-2eae368e10be@arm.com>
In-Reply-To: <3c3e1dc2-1f66-565c-c677-2eae368e10be@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Jan 2023 09:33:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWa3YSX482NTmh1e0LAqEiKrOBTHxrb=cqS3u36c-jw8g@mail.gmail.com>
Message-ID: <CAMuHMdWa3YSX482NTmh1e0LAqEiKrOBTHxrb=cqS3u36c-jw8g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iommu: renesas,ipmmu-vmsa: Update
 descriptions for R-Car Gen4
To: Robin Murphy <robin.murphy@arm.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "joro@8bytes.org" <joro@8bytes.org>, 
	"will@kernel.org" <will@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Wed, Jan 25, 2023 at 11:42 AM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2023-01-25 08:54, Geert Uytterhoeven wrote:
> > BTW, the related IMCTR register is still documented, and the driver
> > does enable the interrupt bit (IMCTR_INTEN), so I'm wondering how the
> > hardware (documentation) people intend this to be used...
> > Perhaps IMCTR_INTEN will be removed/undocumented, too?
> > Or perhaps the removal/undocumentation of IMSSTR was a mistake?
>
> I guess it should be pretty straightforward to just try reading the
> expected IMSSTR register locations on this SoC to double-check whether
> anything is there.

FTR, I did try this.  Unfortunately the IMSSTR register value is zero
by default, and interrupts are generated only for error conditions (how
to trigger them?), so my debug print in ipmmu_irq() never triggered.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
