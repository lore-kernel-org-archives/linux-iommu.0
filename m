Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4989C64A
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 17:01:48 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id j6so1774307qvm.1
        for <iommu@lists.linux.dev>; Thu, 09 Feb 2023 09:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6eP2iG0J519XNQxcdOCAFcleHBjRH+XT7X5573aPPQ=;
        b=he+8+1l5Tef+l5ZYfbbjbuHKQEnOnBGZInsBbyUZf9Gf1WRQjD5wzr7KYbpXoJowva
         SHbYcD6T1eaWCPG9Cs0XXFSbUVutpkiV+8rxYPcOmXF5PV7IYyXIbpwCpwWcckiPyM6o
         rUZVFZdANiSc1UujT0TH5HeYeSarwTTxXEo4H/7uG/dLJGsbtj/q1o+QYE13uHUcdy0/
         sJtwSI2I1Xb1UuZdzvBKXY5bm/Q2ACH5R7iTSKeWNZ3wFBko/XkGZ3jBUPzCH0OFauL9
         bxOhyqWZuWpDUC7dhSFJud41m+PvgDrGoYpn7R5caXVVQz4GmcXnwshvyvQuwBRipth1
         0uiw==
X-Gm-Message-State: AO0yUKXKjgLH47tfNYRa2+wYBN4ehlOTpEh3tTxka748PCLQ4sZDZ9N1
	hFNigyO2zBXyaVHsbw1Lp44RmrQrLfTOkURa
X-Google-Smtp-Source: AK7set+P7aLMdvmRX8HBZUt1XonyN2SULjrzKTh5FT/r3h0cBUEUdkDgKBSd51x7G5+TtR2GFr6oAA==
X-Received: by 2002:a05:6214:765:b0:56c:20e1:2669 with SMTP id f5-20020a056214076500b0056c20e12669mr8540791qvz.42.1675962106861;
        Thu, 09 Feb 2023 09:01:46 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id b124-20020a379982000000b0071bfeaf5688sm1736682qke.72.2023.02.09.09.01.46
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 09:01:46 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-4a263c4ddbaso34172277b3.0
        for <iommu@lists.linux.dev>; Thu, 09 Feb 2023 09:01:46 -0800 (PST)
X-Received: by 2002:a0d:e9c1:0:b0:514:a90f:10ea with SMTP id
 s184-20020a0de9c1000000b00514a90f10eamr1125133ywe.316.1675962105673; Thu, 09
 Feb 2023 09:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230209133440.2643228-1-yoshihiro.shimoda.uh@renesas.com> <167595345406.213374.1795032702431324096.robh@kernel.org>
In-Reply-To: <167595345406.213374.1795032702431324096.robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Feb 2023 18:01:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV_i8crAKW3yxpHWw7MXYsrdpUh4JH6PQZ_kr+qVViH4A@mail.gmail.com>
Message-ID: <CAMuHMdV_i8crAKW3yxpHWw7MXYsrdpUh4JH6PQZ_kr+qVViH4A@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: iommu: renesas,ipmmu-vmsa: Update for
 R-Car Gen4
To: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, will@kernel.org, 
	iommu@lists.linux.dev, joro@8bytes.org, krzysztof.kozlowski+dt@linaro.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	robh+dt@kernel.org, robin.murphy@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

On Thu, Feb 9, 2023 at 3:54 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, 09 Feb 2023 22:34:40 +0900, Yoshihiro Shimoda wrote:
> > Since R-Car Gen4 doens't have the main IPMMU IMSSTR register, update
> > the renesas,ipmmu-main property which sets maxItems as 1.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> > Changes from v2:
> > https://lore.kernel.org/all/20230127140446.1728102-1-yoshihiro.shimoda.uh@renesas.com/
> >  - Set maxItems to renesas,ipmmu-main if R-Car Gen4.
> >
> > Changes from v1:
> > https://lore.kernel.org/all/20230123012940.1250879-1-yoshihiro.shimoda.uh@renesas.com/
> >  - Change number of argument for R-Car Gen4 instead of "module id".
> >    On the discussion, using 'minItems' is a solution. But, it causes
> >    "too short" errors on dtbs_check. So, using "oneOf" instead.
> >
> >  .../bindings/iommu/renesas,ipmmu-vmsa.yaml    | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
>
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
>
> Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230209133440.2643228-1-yoshihiro.shimoda.uh@renesas.com
>
>
> iommu@ee480000: renesas,ipmmu-main: [[40], [10]] is too long
>         arch/arm64/boot/dts/renesas/r8a779f0-spider.dtb

This is expected, as we're changing the bindings to match the (updated)
documentation, but haven't updated the DTS yet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
