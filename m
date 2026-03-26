Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C36F39FCA9
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552678; cv=none; b=XJKMQEqF2mF6xcPdF1umT4L+zaAHsoayUsW8/uIuuRl8OQHfg12cNn6xmwLWDTnWgjJtGYx1RT/9z3wYV7TgIbrxmw5bZC95jvJPaJE85293WG+/Tt5YNy7Zjv+MhLUQvdE6RkwlLDjEMP6rzzmlRIHiOP+JQDOVW2it7Z2FZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552678; c=relaxed/simple;
	bh=MIPDAAbAiXqMvXBIOxEoTP500rJ337ZU7Yo9oo0ehx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7z+FFd1pbzaItVG86Un97z2KeonMA2lAcheGarzM17cfnRQ401EZJUb4vb30IFFcusJw1xHYqSkqretYz40ZX779FyxEtQLWh8YcYsja3x3K7wfxV7UVEcH+Kf9K1+FRl1GdjF3cnlPll5KLcjJ7RttPE4b8vySzV15ggYxs6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY3JXy0s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY3JXy0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D043BC2BCB4
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 19:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774552677;
	bh=MIPDAAbAiXqMvXBIOxEoTP500rJ337ZU7Yo9oo0ehx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GY3JXy0sfIJdIm0SatxG0BC8n15a+5U7pKcDBxTkUZIG1jg9B5cr2KTikwQjAMblI
	 4aYOyGPGIzkfvg2frCTWc8URL/tqwTN8j0f4wvLeW4D+0y4ZOQcPuLii+ojoJt0wgo
	 /qU9F1CV31X67OmxQ7h/IemwDc2EfQMF11gfk0GX1I/+AAb8zWSf7HC4M6HV69ql2m
	 MFq+KskoO4rnYqaN7PNliHfzEC0afcCfM9Pr7pRBj3AJsqAulLBX1o507F6L7cYikZ
	 sILjk+ZJ4euEamphD7NNno0yAuNu34apLP/g1ykcPkdHqEHbWoyGoklTtMn93SXmnT
	 ZUS9lGeOMmUSQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6686697f578so2162435a12.0
        for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 12:17:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWp8CTvfnp7RjTqgHq3794/vPaVMZOPI4CzucEUEszQNNJjJuctXGpNnJMQnNLeLmhtRg+Hxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTicAmFEuTFgLMR8prfFWvzB3flRY7vmkyraEd6D0k16MME5ga
	SCOVAWpluuGoOqAbMmnIYNxpJZujHid0csU0NplYkDs5Mj1nO8fRSonZAAvRCmJtMqgLjhqzyVN
	4xretxb30FgiZVhBLlpR9tvU5kw44NQ==
X-Received: by 2002:a05:6402:51cf:b0:669:afeb:a6f3 with SMTP id
 4fb4d7f45d1cf-66a8270edbbmr5537445a12.27.1774552676256; Thu, 26 Mar 2026
 12:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20260325090029eucas1p1932917cc4839c3349932aeda37a7125d@eucas1p1.samsung.com>
 <20260325090023.3175348-1-m.szyprowski@samsung.com> <20260325141648.GA2685599-robh@kernel.org>
 <fe9359e0-1c9a-4113-82c3-0275c932a58a@samsung.com>
In-Reply-To: <fe9359e0-1c9a-4113-82c3-0275c932a58a@samsung.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 26 Mar 2026 14:17:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK9Gn4rZAzZ7HN88eeZWcbAvyNj1sCtn140XK83qDGuCA@mail.gmail.com>
X-Gm-Features: AQROBzC6LkjDlFn6WnwHsN-rfeYOnWBi9c0g8XrRpCGf7exOQ4jNH_gHGfxdWqA
Message-ID: <CAL_JsqK9Gn4rZAzZ7HN88eeZWcbAvyNj1sCtn140XK83qDGuCA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Refactor reserved memory regions handling code
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mm@kvack.org, iommu@lists.linux.dev, 
	Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>, 
	Saravana Kannan <saravanak@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 4:58=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Rob
>
> On 25.03.2026 15:16, Rob Herring wrote:
> > On Wed, Mar 25, 2026 at 10:00:16AM +0100, Marek Szyprowski wrote:
> >> The reserved memory regions handling code was reworked to handle
> >> unlimited so called "static" memory nodes in commit 00c9a452a235 ("of:
> >> reserved_mem: Add code to dynamically allocate reserved_mem array").
> >>
> >> The side effect of this rework was a set of bugs fixed later by commit=
s
> >> 0fd17e598333 ("of: reserved_mem: Allow reserved_mem framework detect
> >> "cma=3D" kernel param") and 2c223f7239f3 ("of: reserved_mem: Restructu=
re
> >> call site for dma_contiguous_early_fixup()"). As a result, the code in
> >> drivers/of/of_reserved_mem.c became a mix of generic code and CMA
> >> specific fixups.
> >>
> >> In this patchset I try to untangle this spaghetti and perform some cod=
e
> >> cleanup. I hope nothing breaks this time.
> >>
> >> Best regards
> >> Marek Szyprowski, PhD
> >> Samsung R&D Institute Poland
> >>
> >>
> >> Changelog:
> >>
> >> v3:
> >> - fixed more issues pointed by Sashiko in
> >>    https://protect2.fireeye.com/v1/url?k=3Dc0975fdb-a11c4aed-c096d494-=
74fe485cbff1-5d0a8d4ece172e7b&q=3D1&e=3Dabd3a151-11c5-430e-a6ac-b04cc3b34ab=
7&u=3Dhttps%3A%2F%2Fsashiko.dev%2F%23%2Fpatchset%2F20260323100901.4079171-1=
-m.szyprowski%40samsung.com
> >>    (restored use of _OF_DECLARE macro, extended some comments and comm=
it
> >>    descriptions, the remaining items I consider not relevant)
> >>
> >> v2: https://lore.kernel.org/all/20260323100901.4079171-1-m.szyprowski@=
samsung.com/
> >> - added missing ops assignment removal in tegra210-emc-table and swiot=
lb
> >>    drivers
> >> - fixed issues pointed by kernel test robot and Sashiko: removed typos=
,
> >>    improved comments
> >> - fixed incorrect node passed to fdt_validate_reserved_mem_node() in
> >>    fdt_scan_reserved_mem_reg_nodes()
> >>
> >> v1: https://lore.kernel.org/all/20260313150802.1121442-1-m.szyprowski@=
samsung.com/
> >> - initial version
> >>
> >>
> >> Patch summary:
> >>
> >> Marek Szyprowski (7):
> >>    of: reserved_mem: remove fdt node from the structure
> >>    of: reserved_mem: use -ENODEV instead of -ENOENT
> >>    of: reserved_mem: switch to ops based OF_DECLARE()
> >>    of: reserved_mem: replace CMA quirks by generic methods
> >>    of: reserved_mem: rearrange code a bit
> >>    of: reserved_mem: clarify fdt_scan_reserved_mem*() functions
> >>    of: reserved_mem: rework fdt_init_reserved_mem_node()
> > I've applied the series, thanks!
>
> I forgot to mention this earlier. There are other pending changes
> tokernel/dma/contiguous.c like
> https://lore.kernel.org/all/20260303-dma-buf-heaps-as-modules-v3-0-243448=
12c707@kernel.org/
> which I would like to merge to -next. This conflicts with this patchset.
> Could You provide a stable branch with those changes to let me resolve
> conflicts in kernel/dma/contiguous.c on top of it?

Here you go:

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f=
:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
dt-reserved-mem-cleanups

for you to fetch changes up to 34e0e2a8ea9e9e4f4dceb33072103dffaa1366b3:

  of: reserved_mem: rework fdt_init_reserved_mem_node() (2026-03-26
14:12:02 -0500)

----------------------------------------------------------------
Marek Szyprowski (7):
      of: reserved_mem: remove fdt node from the structure
      of: reserved_mem: use -ENODEV instead of -ENOENT
      of: reserved_mem: switch to ops based OF_DECLARE()
      of: reserved_mem: replace CMA quirks by generic methods
      of: reserved_mem: rearrange code a bit
      of: reserved_mem: clarify fdt_scan_reserved_mem*() functions
      of: reserved_mem: rework fdt_init_reserved_mem_node()

 drivers/memory/tegra/tegra210-emc-table.c |  19 +++++-----
 drivers/of/fdt.c                          |   2 +-
 drivers/of/of_private.h                   |   2 +-
 drivers/of/of_reserved_mem.c              | 320
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++------------------------------------------------------=
---------------
 include/linux/cma.h                       |  10 ------
 include/linux/dma-map-ops.h               |   3 --
 include/linux/of_reserved_mem.h           |  16 +++++----
 kernel/dma/coherent.c                     |  19 +++++-----
 kernel/dma/contiguous.c                   |  86
+++++++++++++++++++++++++++++++--------------
 kernel/dma/swiotlb.c                      |  19 +++++-----
 10 files changed, 285 insertions(+), 211 deletions(-)
