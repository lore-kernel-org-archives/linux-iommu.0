Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE263F
	for <iommu@lists.linux.dev>; Tue, 27 Sep 2022 14:48:41 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id a20so6123739qtw.10
        for <iommu@lists.linux.dev>; Tue, 27 Sep 2022 07:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sIkic6SUoveiF5m/KjLf8xeEdyIptPVHhr889tOMLnU=;
        b=ITNeRx0quGjNKCntkbGhxPEqVrrXphW/0D2A+7cQ2rlCjqb2e5DRs7KE1AmaqR7wYe
         Kk7qsVVee5s36UrolMyLK0lEW+4v0+TYS73kdjWphFfgqIHbHiqVKM/tXTQb2h22xsH4
         6tvUAjEEaK17y0Oy/E0z1c1gDUdf7cVxZDEgxoeAlZ4DjSkBeHw0yIIPEON0LfIRYM1k
         HZuzYX1kOU0sQ1Q6yHPdfF/i6+ngcRYTYkzH0LAMIGTbrYEVXaPfz7S39DswBSwI5dRi
         rwnG8+pb6fbNXln+J23gd0sidQ4PCXIKIVcUdzMfdEN8SseUhRBU4/kOg/9813iFONsE
         VeFw==
X-Gm-Message-State: ACrzQf2BRlHITj85r/GTcTvIwd/p9vkwfqu05iGaqjJcqvTekmUDct35
	4yXJ97J1PcJYBvcWWRN6/kzvFWV2x3F0kw==
X-Google-Smtp-Source: AMsMyM6qJdsYPpX5FTPMKW1pEwLEKWnHCiWiUdkMzbOKd35yexKs/irI38QuzW+vJfOppFY1Quo3Ww==
X-Received: by 2002:ac8:5985:0:b0:35b:ba8c:d522 with SMTP id e5-20020ac85985000000b0035bba8cd522mr22468276qte.213.1664290120036;
        Tue, 27 Sep 2022 07:48:40 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id fv10-20020a05622a4a0a00b003445bb107basm906981qtb.75.2022.09.27.07.48.39
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:48:39 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-349c4310cf7so102622907b3.3
        for <iommu@lists.linux.dev>; Tue, 27 Sep 2022 07:48:39 -0700 (PDT)
X-Received: by 2002:a81:758a:0:b0:345:450b:6668 with SMTP id
 q132-20020a81758a000000b00345450b6668mr24868987ywc.316.1664290119137; Tue, 27
 Sep 2022 07:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <b0981cb5a97452af73b9dd0dd0eb03c5002f7af4.1664285626.git.geert+renesas@glider.be>
 <fe2b1f48-e18a-b1d9-0c62-ddddf9e6515f@arm.com>
In-Reply-To: <fe2b1f48-e18a-b1d9-0c62-ddddf9e6515f@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Sep 2022 16:48:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVFAwqVtrRFf-_jSODWeJuGAzbpoyk65HDOqj9h6AUt2A@mail.gmail.com>
Message-ID: <CAMuHMdVFAwqVtrRFf-_jSODWeJuGAzbpoyk65HDOqj9h6AUt2A@mail.gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable: Make IOMMU_IO_PGTABLE_DART invisible
To: Robin Murphy <robin.murphy@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
	Hector Martin <marcan@marcan.st>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Tue, Sep 27, 2022 at 4:15 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2022-09-27 14:36, Geert Uytterhoeven wrote:
> > There is no point in asking the user about both "Apple DART Formats" and
> > "Apple DART IOMMU Support", as the former is useless without the latter,
> > and the latter auto-selects the former.
> >
> > Fixes: 745ef1092bcfcf3b ("iommu/io-pgtable: Move Apple DART support to its own file")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Should IOMMU_IO_PGTABLE_LPAE and IOMMU_IO_PGTABLE_ARMV7S be made
> > invisible, too?
> > Are there users that do not select them?
>
> The aim was for formats to be independently selectable for COMPILE_TEST
> coverage. The Arm formats are manually selectable for the sake of their
> runtime self-tests, which are self-contained, but since DART format
> doesn't do anything by itself I'd agree there's no need to prompt when
> !COMPILE_TEST here.

IOMMU_IO_PGTABLE_LPAE and IOMMU_IO_PGTABLE_ARMV7S are
selected by other symbols that can be enabled when compile-testing, so
the tests can still be enabled in those cases, too

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
