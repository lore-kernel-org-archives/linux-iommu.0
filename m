Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2873833EC
	for <iommu@lists.linux.dev>; Tue, 27 Sep 2022 15:29:52 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id i15so6429222qvp.5
        for <iommu@lists.linux.dev>; Tue, 27 Sep 2022 08:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Wv/hl+O47KbBKhsHuHGT+af8ji5KfNfvypidSDA5LSc=;
        b=BWvsmVa+iI8xJ8rkrU9r02AjPzsg9eCuW0h7rL3FdLm+z6f2ayGqFHNAg4PV3fnDKi
         nxFipfsJbZUEjhVd/MvylyH8zt/Nu29Jsk0KfzTf+5a9kiBoCCKxMWzxEwp20PWHBw/d
         iPw4e4pM5Wa6zpvTLjUWNyuQnn9Ax7S2s8GUuB6OZY1fGFogYU3K1H7GdYsI13z5mJwF
         mcMxDMCXf0EPbvKBVs1uBNvZb8ITGTbuxDk2lfH5SRWE9X/t/vw0+v7OiTCcfA1YEAqN
         VQTIEjUK/7oFzN0MA1SFS0cnfUYg1HCd6p+TtsEhcqIo/ClQA1G1NwTwHWg02AEiHY8l
         AqGg==
X-Gm-Message-State: ACrzQf0E6L8DeMYLxwLOaR1ZlqzvLBxCTGpvIc4ZdJINN8AyGiwivwJo
	uclNsp5lSZlmhTLf6Ue1RbB/xH/BdgBcyw==
X-Google-Smtp-Source: AMsMyM6pYIhM6w3MfWTyxTu3YRZS5i+B81xjT6327+lxeP987QgiAhprezymsijtN18wnkmRH+TP8Q==
X-Received: by 2002:a05:6214:1c87:b0:4af:8d8d:f319 with SMTP id ib7-20020a0562141c8700b004af8d8df319mr2598444qvb.11.1664292590925;
        Tue, 27 Sep 2022 08:29:50 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id d22-20020ac81196000000b0035d453b8c57sm1024093qtj.11.2022.09.27.08.29.50
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:29:50 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id c9so12668677ybf.5
        for <iommu@lists.linux.dev>; Tue, 27 Sep 2022 08:29:50 -0700 (PDT)
X-Received: by 2002:a25:3851:0:b0:6ad:9cba:9708 with SMTP id
 f78-20020a253851000000b006ad9cba9708mr26843654yba.36.1664292589905; Tue, 27
 Sep 2022 08:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <b0981cb5a97452af73b9dd0dd0eb03c5002f7af4.1664285626.git.geert+renesas@glider.be>
 <fe2b1f48-e18a-b1d9-0c62-ddddf9e6515f@arm.com> <CAMuHMdVFAwqVtrRFf-_jSODWeJuGAzbpoyk65HDOqj9h6AUt2A@mail.gmail.com>
 <9db42ab0-da49-95fd-3fea-eb505af0867e@arm.com>
In-Reply-To: <9db42ab0-da49-95fd-3fea-eb505af0867e@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Sep 2022 17:29:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW1KQ5TTftYuTT4_b6mmCT5Y+_jpSKau46-g8siDKWjGQ@mail.gmail.com>
Message-ID: <CAMuHMdW1KQ5TTftYuTT4_b6mmCT5Y+_jpSKau46-g8siDKWjGQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable: Make IOMMU_IO_PGTABLE_DART invisible
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Sven Peter <sven@svenpeter.dev>, 
	Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Tue, Sep 27, 2022 at 5:09 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2022-09-27 15:48, Geert Uytterhoeven wrote:
> > On Tue, Sep 27, 2022 at 4:15 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >> On 2022-09-27 14:36, Geert Uytterhoeven wrote:
> >>> There is no point in asking the user about both "Apple DART Formats" and
> >>> "Apple DART IOMMU Support", as the former is useless without the latter,
> >>> and the latter auto-selects the former.
> >>>
> >>> Fixes: 745ef1092bcfcf3b ("iommu/io-pgtable: Move Apple DART support to its own file")
> >>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>> ---
> >>> Should IOMMU_IO_PGTABLE_LPAE and IOMMU_IO_PGTABLE_ARMV7S be made
> >>> invisible, too?
> >>> Are there users that do not select them?
> >>
> >> The aim was for formats to be independently selectable for COMPILE_TEST
> >> coverage. The Arm formats are manually selectable for the sake of their
> >> runtime self-tests, which are self-contained, but since DART format
> >> doesn't do anything by itself I'd agree there's no need to prompt when
> >> !COMPILE_TEST here.
> >
> > IOMMU_IO_PGTABLE_LPAE and IOMMU_IO_PGTABLE_ARMV7S are
> > selected by other symbols that can be enabled when compile-testing, so
> > the tests can still be enabled in those cases, too
>
> Sure, but when you want to compile-test a thing, what would you rather
> do: enable the thing, or go hunting to find some other thing that
> happens to select the thing you actually want, then potentially have to
> figure out *that* thing's dependencies, and so on?

Agreed.

> Coverage isn't solely about whether it's technically possible to ever
> reach somewhere at all, it's just as much about how easily and/or often
> you can get there in practice. I don't see who benefits from making
> COMPILE_TEST harder to use :/

So perhaps the visibility of IOMMU_IO_PGTABLE_LPAE and
IOMMU_IO_PGTABLE_ARMV7S should depend on COMPILE_TEST?
Normal users would still get it through select when needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
