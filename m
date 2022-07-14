Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89946B9
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 13:11:21 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id u13so2734809lfn.5
        for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3k2QX4bguOE0L7QO8kTytO481rt2YTc1m8KARAq/JE=;
        b=OseFNQWCpneawnk6hDRAcmEjZIvGnmdYZBZowJgnKaUcQMpIn5ZycNGgemvrKty1Ky
         nWVLsrYroWqs1jKbXnmksiWdubrPiOfzYQ/Jadkq28J49HyA2oqZxcSrNwuHFylw1tMP
         0D0tSl58B1KULox2v9JIjxnUoihgdl/zodAm1y54fjNq3nJTJh5aQ5fTFX3O849183pI
         2iN0/YoWII2OUuSKWES3GXfom9+SHS6HWCnsUwx2pkn5N6WnIlLheIE2p79uajKY3WFW
         Qaw+ojqZRkbPpspf8jjzdGecNGvsKzn8V+idkD+PIY60XuTEQOD+mtlp7TerlTUmqxkr
         M5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3k2QX4bguOE0L7QO8kTytO481rt2YTc1m8KARAq/JE=;
        b=3eFvjAwo8xGAKYC4cb/AWiD3jbLAqtJ3uS7yv/8aLEQ4QVfErf7XcRGrykSpAWYT35
         5IMhELjqrEJpTpYGyb3pY2x4eZ5DpK16z03JlvRyXWxOHHWg7viooUQsv3u5AKz0alH9
         1CUNROL5w/5uenOgLY8VdIvzgvEexhbAIvsOLuxck6Ar8iQaOOxST7++cNOaqcyYcT83
         +aYwu49niKko4/zKYW5UcLn+w2/iwOLdyH4jbfAUWdvIkf6hjN8h+yR+ZV3aKAaAA2Ia
         NenMkYMgC7XAMu9/tgfwxrC0Xv2K+wP21hXDonLjVI4wdXk75HIrMwJsHUD9WahmZlOt
         VYVQ==
X-Gm-Message-State: AJIora+quVbsgjxS0MJBHnXxBORsXlXFTrFRqyXU2rQwLeUkWGHuxhbF
	H6VInP3ol4zaM4csZg5FrOYpCacovfeNFuO4KpFTSw==
X-Google-Smtp-Source: AGRyM1uG/EcQ4xkQr2lwBmOJy5j05NRxm363QEGm3+XpW5ztY9XxmPCK2hQgTdMeJgU3mUt6QlIChrPlb/72n9Yjrg8=
X-Received: by 2002:a05:6512:398d:b0:489:c7a2:be6f with SMTP id
 j13-20020a056512398d00b00489c7a2be6fmr4987221lfu.11.1657804279347; Thu, 14
 Jul 2022 06:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
 <20220710230603.13526-5-semen.protsenko@linaro.org> <9eb795cd-999b-73e5-2eeb-c123b1d05a34@arm.com>
In-Reply-To: <9eb795cd-999b-73e5-2eeb-c123b1d05a34@arm.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 14 Jul 2022 16:11:07 +0300
Message-ID: <CAPLW+4=QOv_gAov2KHC4zR881CV3igESMH5JU7XgLbDLS8UNAg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] iommu/exynos: Use lookup based approach to access registers
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Janghyuck Kim <janghyuck.kim@samsung.com>, 
	Cho KyongHo <pullip.cho@samsung.com>, Daniel Mentz <danielmentz@google.com>, 
	David Virag <virag.david003@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Jul 2022 at 19:24, Robin Murphy <robin.murphy@arm.com> wrote:

[snip]

> > No functional change here, just a refactoring patch.
>
> FWIW I'd say that this absolutely *is* a functional change. Achieving
> the same end result, but fundamentally changing the mechanism used to
> get there, is a bit different to simply moving code around.
>

As I understand, usually the "functional change" means some change
that can be observed from the user's point of view (i.e. user of this
driver). But ok, I'll clarify this bit in the commit message.

[snip]

> > +/*
> > + * Some SysMMU versions might not implement some registers from this set, thus
> > + * those registers shouldn't be accessed. Set the offsets for those registers to
> > + * 0x1 to trigger an unaligned access exception, which can help one to debug
> > + * related issues.
> > + */
> > +static const unsigned int sysmmu_regs[MAX_REG_SET][MAX_REG_IDX] = {
>
> Do we really need MAX_REG_SET? Maybe there's a consistency argument, I
> guess :/
>

Here and below: I reworked the register table using approach suggested
by Krzysztof, so those enums won't be present in v2 at all.

> > +     /* SysMMU v1..v3 */
> > +     {
> > +             0x00, 0x04, 0x08, 0x14, 0x0c, 0x10, 0x1, 0x1, 0x1,
> > +             0x18, 0x1c,
>
> This looks fragile and unnecessarily difficult to follow and maintain -
> designated initialisers would be a lot better in all respects, i.e.:
>
>         [REG_SET_V1] = {
>                 ...
>                 [IDX_PT_BASE] = REG_PT_BASE_ADDR,
>                 ...
>
> etc.
>

[snip]

> >   static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
> > @@ -317,31 +348,33 @@ static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
> >
> >       if (MMU_MAJ_VER(data->version) < 5) {
> >               for (i = 0; i < num_inv; i++) {
> > -                     writel((iova & SPAGE_MASK) | 1,
> > -                                  data->sfrbase + REG_MMU_FLUSH_ENTRY);
> > +                     sysmmu_write(data, IDX_FLUSH_ENTRY,
> > +                                  (iova & SPAGE_MASK) | 0x1);
> >                       iova += SPAGE_SIZE;
> >               }
> >       } else {
> >               if (num_inv == 1) {
>
> You could merge this condition into the one above now. That much I'd
> call non-functional refactoring ;)
>

Done, thanks.

[snip]

> > +
> > +static void sysmmu_get_hw_info(struct sysmmu_drvdata *data)
> > +{
>
> Seems a bit unnecessary to split the call up like this - I'd say the
> register set is fundamentally connected to the version, and
> "get_hw_info" is even less meaningfully descriptive than just having
> "get_version" take care of one more assignment, but hey ho, it's not my
> driver.
>

Guess I was looking into downstream vendor's kernel too much :) They
do a bit more things in this function -- like getting TLBs number and
"no block mode" capability; that's why I renamed it. Anyway, don't
have a strong opinion on this one, will use the old name in v2.

Thanks for the review!

> Thanks,
> Robin.
