Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96854190
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 04:57:48 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-635fa79d7c0so1465166d6.1
        for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 21:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689137867; x=1691729867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/72ZD6lhNsHXkYgqxH4KbAvAYqyJgWt7UVI6+Yu3os=;
        b=SQv+ATSncXbdJ6CvQSuGkwVtXrkdkvN0VsEkwN0f2meVzjcZVDVHotkWnUdRi1+JJ8
         152n9o/c6wKcedfIOWNhscb9a+NIhJJpjGH28gY1CMfMwCBajew9Ou3XGIwTmJVXO+oU
         1d8rLzj6cok8WjK5gE3Z7Ob2u/5A/Oiqm0ChvZYbS9BbNZ6rMJCxqKaHSOQQ3JTNMYqX
         iy3e4ExpJhPEoTW7pKsKCA4zgz7UdaHCKC4ymnJ3mk8l2y3O0B0vazDOCjWVX4GtNDiB
         62Ucoslh+dMNa7rPfdqhLW4dvXqw0YBCfeLdl0Kbe4bh48EFkt4fmOcLMaAiZkg9r//N
         twCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689137867; x=1691729867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/72ZD6lhNsHXkYgqxH4KbAvAYqyJgWt7UVI6+Yu3os=;
        b=fRetFsghj3dWgtLXT7uy5uLqwQpUcTQco/RgBLhEjRU1UeUeiDwNrdDNafXGwxyC8p
         KlwIHtulcIbcRZggt2UqIIvF4cgBkJ0dHlYOohOa7WTgJ445+uJVNOK4IbgHOadn1+1a
         GYK+6Q/eLJiYo6EQi1yUOhwsVOi+adgrLScASSA1VPNyoPYbE6rNlapCjgvfbWHcVhJg
         fmFvps0QbEtKc1ors0YgtCMpnE8b7npyCVPzAk5F08WKEUmsDQ8TDu0bADxAloRukMTH
         ZyrW2n/EUck8kGRmdxhIEjctVfzz3/fWvModQ6VfCV+18XKJbMIoSGNFHRXtMXKVVOh9
         8u3A==
X-Gm-Message-State: ABy/qLYsFSSQ9zpZVphdzp/jpSvdoam2MmokQ6EE+NjAgeSiPP4FJRJh
	FiuHOXycZPgGTeS23ER6zSZoQ1Es32Iqg4HBNrABjA==
X-Google-Smtp-Source: APBJJlH5QzNFAkMi3vMlbJrWM0d6J/fLTqgYF+JAXqPrfBkfUF3EumCUn0rNxoOz7ZOPCK+yLnf1MHjzwmvzO+WlP0A=
X-Received: by 2002:a05:6214:ca2:b0:637:9da3:9193 with SMTP id
 s2-20020a0562140ca200b006379da39193mr1219123qvs.4.1689137867393; Tue, 11 Jul
 2023 21:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230612153201.554742-1-catalin.marinas@arm.com>
 <CAMi1Hd04mu6JojT3y6wyN2YeVkPR5R3qnkKJ8iR8if_YByCn4w@mail.gmail.com>
 <ZKdfVSzbgOonR17A@google.com> <CAMi1Hd2f5GUnu_JGot=CqA9Vy4OD_V7FWYLOhNbJL1Pyd_EGMA@mail.gmail.com>
 <CABfwK138ZbE5=J66esO-VG64tO+e9n1cRRBAE3wOKygJxd_xbw@mail.gmail.com>
In-Reply-To: <CABfwK138ZbE5=J66esO-VG64tO+e9n1cRRBAE3wOKygJxd_xbw@mail.gmail.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Wed, 12 Jul 2023 10:27:11 +0530
Message-ID: <CAMi1Hd3KgZGJTae=fyq4HD3FTuNxNJAnmfyds12JFXenxUtXrw@mail.gmail.com>
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
	Linux regressions mailing list <regressions@lists.linux.dev>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jul 2023 at 01:14, Isaac Manjarres <isaacmanjarres@google.com> w=
rote:
>
> On Sat, Jul 8, 2023 at 6:03=E2=80=AFAM Amit Pundir <amit.pundir@linaro.or=
g> wrote:
> > Hi Issac, I can't reproduce this crash if I have slub_debug enabled
> > https://bugs.linaro.org/attachment.cgi?id=3D1149.
> >
> > But I can still reproduce the crash, with the same build, if I just
> > remove the slub_debug bootarg
> > https://bugs.linaro.org/attachment.cgi?id=3D1150
> >
>
> Hey Amit,
>
> Thanks for trying this out. John Stultz and I tried this out as well, and=
 we
> couldn't reproduce the issue with slub_debug enabled either.
>
> However, we were able to reproduce the issue you reported along with
> KASAN enabled, which also helped us catch an out-of-bounds access
> in the regmap-irq code. Once we fixed it, the memory corruption you
> reported was also fixed. I've sent the patch [1] for review. Can you plea=
se
> test it out and see if it works for you too?

It does fix the v6.5-rc1 boot regression I reported above on
Dragonboard 845c running AOSP. Thank you.

Regards,
Amit Pundir

>
> [1]: https://lore.kernel.org/all/20230711193059.2480971-1-isaacmanjarres@=
google.com/
>
> Thanks,
> Isaac
