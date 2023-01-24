Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9CC63DF
	for <iommu@lists.linux.dev>; Tue, 24 Jan 2023 14:34:58 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id t16so14401766ybk.2
        for <iommu@lists.linux.dev>; Tue, 24 Jan 2023 06:34:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spuGXbnEWjgnG1USxADlTAPQRT06VybqZm5i7nwtOM0=;
        b=ecRODXSRrI+3XqOCFoPadvnO+Oo/zJLB+u8qjy08umuPJExv0c2BpiI7xQhqMfkWEG
         bez6TQ8AU6p2p9vfg1od8acK366aI7qx4G9Y2oZ/5k2l765gwxLHD2+ydJHiAwcBD1YE
         ZwnEUsTZzCe+En3hwXNmUa46qO2cpAlEzWrnT4clBBUcxjYliIP+V4U3XwhpMsj44hc9
         P+lL3DYahK7ZMp1C5L+ClL9XmXDDmLksUU6N075lyrFh48iK+QLD52b2SXMLGMYilBj3
         HptdiNVyAFMoC2VpNIa76S8470JVSfj8G+Fo4i3y9LfppNhyNrO9yqZTNlQicTUswgeg
         9F9w==
X-Gm-Message-State: AFqh2kq8FCAEuEtNH4P1RnBm6aCPh7roYZpsiHA9/aJ2CT64GLvxjImF
	/65hN1fFeGgc8fbJ96YsYFEWBc0Y73V/jw==
X-Google-Smtp-Source: AMrXdXuoVrPx5wETLDnGeSKarYnUGbQoVDzycbVDSvdnTbh1wr2FNyuqgQUqJH8tDvWGyJkXe9fpXQ==
X-Received: by 2002:a5b:8cf:0:b0:6e9:dc1e:6373 with SMTP id w15-20020a5b08cf000000b006e9dc1e6373mr19854041ybq.10.1674570897093;
        Tue, 24 Jan 2023 06:34:57 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 16-20020a370b10000000b006e42a8e9f9bsm1501750qkl.121.2023.01.24.06.34.56
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:34:56 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5063029246dso52444377b3.6
        for <iommu@lists.linux.dev>; Tue, 24 Jan 2023 06:34:56 -0800 (PST)
X-Received: by 2002:a05:690c:c89:b0:4dd:7a8e:1cf3 with SMTP id
 cm9-20020a05690c0c8900b004dd7a8e1cf3mr3005151ywb.384.1674570896091; Tue, 24
 Jan 2023 06:34:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230123012940.1250879-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20230123012940.1250879-1-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Jan 2023 15:34:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX92KMeON0xC9p17kiqWT7ksEBX_NyPiiQk0fLaucDZBA@mail.gmail.com>
Message-ID: <CAMuHMdX92KMeON0xC9p17kiqWT7ksEBX_NyPiiQk0fLaucDZBA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iommu: renesas,ipmmu-vmsa: Update
 descriptions for R-Car Gen4
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Shimoda-san,

On Mon, Jan 23, 2023 at 2:35 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Since R-Car Gen4 doens't have the main IPMMU IMSSTR register, but
> each cache IPMMU has own module id. So, update descriptions of
> renesas,ipmmu-main property for R-Car Gen4.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> ---
>  The old R-Car S4-8 datasheet had described IPMMU IMSSTR register, but
>  the latest datasheet undocumented the register. So, update the propeties
>  description. Note that the second argument is not used on the driver.

DT describes hardware, not software policy.

>  So no behavior change.

So where do we get the module id numbers to use, if they are no longer
documented in the Hardware Manual?

> --- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> @@ -76,14 +76,15 @@ properties:
>      items:
>        - items:
>            - description: phandle to main IPMMU
> -          - description: the interrupt bit number associated with the particular
> -              cache IPMMU device. The interrupt bit number needs to match the main
> -              IPMMU IMSSTR register. Only used by cache IPMMU instances.
> +          - description: The interrupt bit number or module id associated with
> +              the particular cache IPMMU device. The interrupt bit number needs
> +              to match the main IPMMU IMSSTR register. Only used by cache IPMMU
> +              instances.
>      description:
>        Reference to the main IPMMU phandle plus 1 cell. The cell is
> -      the interrupt bit number associated with the particular cache IPMMU
> -      device. The interrupt bit number needs to match the main IPMMU IMSSTR
> -      register. Only used by cache IPMMU instances.
> +      the interrupt bit number or module id associated with the particular
> +      cache IPMMU device. The interrupt bit number needs to match the main
> +      IPMMU IMSSTR register. Only used by cache IPMMU instances.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
