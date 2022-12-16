Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C2377
	for <iommu@lists.linux.dev>; Fri, 16 Dec 2022 01:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F52DC433F2
	for <iommu@lists.linux.dev>; Fri, 16 Dec 2022 01:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671154337;
	bh=WWdQKzHA8nf22v/OFQFI1ds1vcA1UIuh7vvuZYDECOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nCvaCS6gHauVcBnVZfKURpicxhfn6G/YiBVLvNYVEhlboSe3tt6CkCOb2d9V7oWAd
	 gFMyeW9YkLwNH3Ivsu3vHl0iEzbbEXr3CuqgvhFllbiXBrd4brWuM2MvFIO368vk98
	 KSufTeTdJVrOg5YvbCLnmu9FgrLaDneKCi5xvF6mJmdgOLB9hPuhJlG97U3GozqbNL
	 HdLyYdaGSgV9pD9ploRUbnd04XLQ9i2lKVwa3KUdkgEnS3X6jbvSiM7co2dHs96TB0
	 LTQr/Oa8TtTA8DRMp6qPGmYutjdRrN+AoAzuZhXQVIs8gHtIe29Gy57+yejmobNEWF
	 ujPpuADwbP9Qg==
Received: by mail-ed1-f51.google.com with SMTP id i15so1742996edf.2
        for <iommu@lists.linux.dev>; Thu, 15 Dec 2022 17:32:17 -0800 (PST)
X-Gm-Message-State: ANoB5plyyUzEgSSbiuVKuCGtUJjGRYqBZq4ZAJaVgCr9LHBeDIFBZ32O
	BkrFEiVJfQPxJJiSN4ngaBvnWWiwrV/g/QYXiBg=
X-Google-Smtp-Source: AA0mqf42YLAwQARhvxsf7dGvS0oc39aHHg/VjrmuoPl5AnlSakaRzEm4vNH6yBmh16Vo+BrOSyi3tz/l6+TpkPFOfQ4=
X-Received: by 2002:aa7:db07:0:b0:470:44da:db04 with SMTP id
 t7-20020aa7db07000000b0047044dadb04mr1540957eds.419.1671154335559; Thu, 15
 Dec 2022 17:32:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221215073212.1966823-1-guoren@kernel.org> <c10c9742-06d6-f56b-ea55-47f99b06ca32@arm.com>
In-Reply-To: <c10c9742-06d6-f56b-ea55-47f99b06ca32@arm.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 16 Dec 2022 09:32:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRHjhCzDT4J1F=zjcB0Mx+w+Ok0JYuuqorxgnw+KODnDA@mail.gmail.com>
Message-ID: <CAJF2gTRHjhCzDT4J1F=zjcB0Mx+w+Ok0JYuuqorxgnw+KODnDA@mail.gmail.com>
Subject: Re: [PATCH] iommu/renesas: Support riscv compile
To: Robin Murphy <robin.murphy@arm.com>
Cc: palmer@dabbelt.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	iommu@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 16, 2022 at 1:16 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-12-15 07:32, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > After riscv selects ARCH_RENESAS, we need to add ARM64 || ARM
> > dependency here.
>
> This effectively removes all the extra COMPILE_TEST coverage we've been
> enjoying. FWIW I prefer Geert's suggestion to separate the real
> functional dependency from implicit assumptions about ARCH_RENESAS, with
> something like:
>
>         depends on ARCH_RENESAS || COMPILE_TEST
>         depends on !GENERIC_ATOMIC64    #for IOMMU_IO_PGTABLE_LPAE

The problem is from clang version 16.0.0, and gcc version 12.2.0 () is
okay. I didn't recognize COMPILE_TEST could utilize the x86(another
arch) to test the arm driver.

How About:

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dc5f7a156ff5..a2e259da5a6a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -283,6 +283,7 @@ config EXYNOS_IOMMU_DEBUG

 config IPMMU_VMSA
        bool "Renesas VMSA-compatible IPMMU"
+       depends on !RISCV
        depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
        select IOMMU_API
        select IOMMU_IO_PGTABLE_LPAE

>
> Thanks,
> Robin.
>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >   drivers/iommu/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index dc5f7a156ff5..746b95b9f345 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -283,6 +283,7 @@ config EXYNOS_IOMMU_DEBUG
> >
> >   config IPMMU_VMSA
> >       bool "Renesas VMSA-compatible IPMMU"
> > +     depends on ARM64 || ARM
> >       depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
> >       select IOMMU_API
> >       select IOMMU_IO_PGTABLE_LPAE



--
Best Regards
 Guo Ren
