Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC02524E
	for <iommu@lists.linux.dev>; Sat,  8 Jul 2023 13:03:21 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-635decc135eso19898306d6.0
        for <iommu@lists.linux.dev>; Sat, 08 Jul 2023 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688821401; x=1691413401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hAhrhxNPcUoTNAjzT4vVa1FtzZBglh2uR41QGwm87tg=;
        b=zV3QLcZA314Ebr9jsapymgyaSo6MIoPHj6pgoVPKdhZNcuHTn0Ad3JQ3TlWqgaknbE
         lFjThsNG/UbBBSayDWwS5zXk0hkGN+btggGlXSJVrDpTeg+kDdwbb6YJEc+A3wToFYXi
         Wp15yTcS8JXUfwIESQo/7sIjonA+i0xYIUTNP7pliC3Xzl7Yk9gWBZmCMzbi5EjdcK9C
         UilQclo0LvNJxrG+NJL4FB8Sagji8s/OdeyK4y27f/Fcmh0ZwYLia4St2G7LNk2ezNi1
         CjO1kj/xHr3GEwgZNYBPVr1SKz5t1Tf4k0g847p7t3LNymcMAGseENrjrTo+dvIEAQ57
         axBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688821401; x=1691413401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAhrhxNPcUoTNAjzT4vVa1FtzZBglh2uR41QGwm87tg=;
        b=cFE2Q0BGRRkeqP7S/EuAJpf7eI9/1ykE1/+2y75TDKD80C7FukllYwArr61y5QhRKF
         chu1RwGPv615tlyYceTVQ+ytvx9j3PqZSuNdwLCN9jqHulu/CYOzi4qTzskbmdUVw859
         3Qc3Jjm1pZ1tsClNg46lA14VWKTI9+jGuilkO3L0HKJc4905StpZ//SeLnxhVbQ7xsSM
         S05zqIzxPZYGn8hUphwn7Mu0Uty924KGHebKUftI01OSWfQhRbjxa7KKG7Pdgx1MTXTQ
         fVCdswnYxcUGMhPVp5X64hEOqKeT5SNaZML6cuNsPw7FlrsklCCzkjP6GWlQxbmSYoC7
         YoKA==
X-Gm-Message-State: ABy/qLaB9kxsey6Z1KRc8CAtmPWoD9qMsOpw3pAvwHt6AO0D6kje7+UT
	e6VAJbXNBUo9JbiGllNqaepSF+xFd64O8Y3IPzaODg==
X-Google-Smtp-Source: APBJJlGXHGy+tSy8IYH5JlnurOryMlyk/mDY1IbM86eZzhVZnwNBgrK2ln+/ENVOLnmMs4hNs+NhAui7pYv9xZwjorY=
X-Received: by 2002:a0c:a9ca:0:b0:621:6804:b8c0 with SMTP id
 c10-20020a0ca9ca000000b006216804b8c0mr9462474qvb.8.1688821400717; Sat, 08 Jul
 2023 06:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230612153201.554742-1-catalin.marinas@arm.com>
 <CAMi1Hd04mu6JojT3y6wyN2YeVkPR5R3qnkKJ8iR8if_YByCn4w@mail.gmail.com> <ZKdfVSzbgOonR17A@google.com>
In-Reply-To: <ZKdfVSzbgOonR17A@google.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Sat, 8 Jul 2023 18:32:44 +0530
Message-ID: <CAMi1Hd2f5GUnu_JGot=CqA9Vy4OD_V7FWYLOhNbJL1Pyd_EGMA@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to 8
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Ard Biesheuvel <ardb@kernel.org>, Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>, 
	Mike Snitzer <snitzer@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Jul 2023 at 06:12, Isaac Manjarres <isaacmanjarres@google.com> wrote:
>
> On Wed, Jul 05, 2023 at 07:10:02PM +0530, Amit Pundir wrote:
> > Hi Catalin,
> >
> > On Wed, 5 Jul 2023 at 18:17, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >
> > > Hi,
> > >
> > > That's v7 of the series reducing the kmalloc() minimum alignment on
> > > arm64 to 8 (from 128). There's no new/different functionality, mostly
> > > cosmetic changes and acks/tested-bys.
> > >
> > > Andrew, if there are no further comments or objections to this version,
> > > are you ok to take the series through the mm tree? The arm64 changes are
> > > fairly small. Alternatively, I can push it into linux-next now to give
> > > it some wider exposure and decide whether to upstream it when the
> > > merging window opens. Thanks.
> >
> > This patch series broke Dragonboard 845c (SDM845) running AOSP.
> > With this series I run into random oops at __kmem_cache_alloc_node().
> > Here is one such boot log https://bugs.linaro.org/attachment.cgi?id=1146
>
> Hey Amit,
>
> From the log that you linked, this looks like there's corruption within
> the kmalloc slab caches. Can you please try enabling slub debug? That
> might give us more information about who is causing the corruption
> you're seeing here.
>
> To enable slub debug, you can add the following to your kernel config:
>
> CONFIG_SLUB_DEBUG=y
>
> and CONFIG_SLUB_DEBUG_ON=y or add slub_debug to the kernel command line.

Hi Issac, I can't reproduce this crash if I have slub_debug enabled
https://bugs.linaro.org/attachment.cgi?id=1149.

But I can still reproduce the crash, with the same build, if I just
remove the slub_debug bootarg
https://bugs.linaro.org/attachment.cgi?id=1150

Is there any specific (slub_debug=) option(s) you want me to try?
May be I can reproduce this bug just with those options.

Regards,
Amit Pundir

>
> --Isaac
