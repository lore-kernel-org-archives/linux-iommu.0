Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCD9A4A
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 16:37:26 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id v3so2136430pgh.4
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uRUgy37EWsW5q3ZYSeelIBVgNxGGsV1P48H49SnRSYg=;
        b=mmzSGdm7jx01/1GoeL3dt0cYDfdnZ3FULAVVkbCHHq539FGuok1VuBlP6QXQPXEOzy
         buxL70KCnvS4UxFw0YNACLpRpnqmUjq1SKg/FcRB4nW1d4+qlJ+6r3zf/iG8yVh7vs85
         5sKVA2yy0aMYYLqrD+qmeiu72sBL33C+YQdKuOlVEDeSlXK0wJGjdfATsg25d3g56m7k
         Fl1wtdWQYdIekqAmKl+SeQ5sqk0H49aFNRYpjTqW8Ntnnw13yoc8O2V7Y+qwsNyGpTcR
         KvFGS1BIeiQwXprX0ml1uZbkCMYz5jdz7hxt1H58TV4UIqLvBBxDuonF4y4NEwqvOk02
         FdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRUgy37EWsW5q3ZYSeelIBVgNxGGsV1P48H49SnRSYg=;
        b=xVdPgm5KIW2MKm40NXXoMAkpMZ41vdxcQKgbzcaXia+7ksTF6XngUorZhjVN5wucwq
         RtD7YGuMuSXx/3NLfa8Ff56yCwVFltnOJAnWKd/Drb4Ub0cPGrxC24DrAxxj37teaLiv
         Q1aKYQ3JUs3qANy+Jqsagcw00HZ48jJW4YkJBYaC86MJe9csZj7c9eI9x2arBqynuZhD
         G7QqVGGAJpL0EjHXcrZcPPxvvXVoyauaehyUr+EOL0MCyGakj6r2JOivwr9kN4fqIoGq
         rrMM4mnzvIr0zcT4skm+KJy4pvEBnAUVT98Hb8xD5LaOy9mHKiwYCE/EZnWoPUW8pglp
         tn5g==
X-Gm-Message-State: ACrzQf0YAuXWoBwA7aQdvoFuDQDmV6MRmp7aJk8nID1gIkABqq6RrlgC
	lEpu3BV6nefBDqcJvCpVNU1BAXXPZKNEC6sHTl26Mg==
X-Google-Smtp-Source: AMsMyM7kBQ/J6kBydIrXn7gqcYmvQnUgIueI3rpt5MoW49NHzwJmaLNQ1iOJyufpZcq7S8pqEq6SzlOpo2hgLApqz5M=
X-Received: by 2002:a05:6a00:2386:b0:56c:b791:40f2 with SMTP id
 f6-20020a056a00238600b0056cb79140f2mr31474948pfc.4.1667493445669; Thu, 03 Nov
 2022 09:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221028191243.31721-1-semen.protsenko@linaro.org>
 <CGME20221028191256eucas1p1a4fd95cbcc44959fa968956a92738f03@eucas1p1.samsung.com>
 <20221028191243.31721-4-semen.protsenko@linaro.org> <7ed8c884-cee1-7cb0-f2ce-f7ec156cd841@samsung.com>
 <CAPLW+4nrns9BovWCTOsi3F7=2FWLi2sK0+Cid4Cva2Vs2ZWdqQ@mail.gmail.com>
In-Reply-To: <CAPLW+4nrns9BovWCTOsi3F7=2FWLi2sK0+Cid4Cva2Vs2ZWdqQ@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 3 Nov 2022 17:37:13 +0100
Message-ID: <CAPLW+4niCmJKs9W9kDkU14fXDFbrywZvOZZkShkdQfBs55KbWg@mail.gmail.com>
Subject: Re: [PATCH 3/4] iommu/exynos: Modularize the driver
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Janghyuck Kim <janghyuck.kim@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, 
	Daniel Mentz <danielmentz@google.com>, David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Nov 2022 at 14:03, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Hi Marek,
>
> [snip]
>
> > MODULE_DEVICE_TABLE(of, sysmmu_of_match); is missing, so the driver
> > won't be automatically loaded, what breaks its operation if compiled as
> > module.
> >
>
> Right, didn't think about hot-plug case. Will add
> MODULE_DEVICE_TABLE() along with MODULE_ALIAS() in v2, thanks.
>
> > Also Exynos DRM and S5P-MFC drivers rely on the Exynos IOMMU being
> > built-in, so they need to be adjusted for modularized builds too imho,
> > at least in the Kconfig dependency.
> >
>

Did some research on that question:
  - both DRM_EXYNOS and S5P_MFC drivers are designed to work fine even
when EXYNOS_IOMMU is disabled: they just take another code path in
that case
  - DRM_EXYNOS already uses IS_ENABLE() macro, which covers EXYNOS_IOMMU=m case
  - I'll provide a fix for S5P_MFC in v2 to do the same, as right now
it does the check with #ifdef CONFIG_EXYNOS_IOMMU, which only covers
=y case
  - both DRM_EXYNOS and S5P_MFC don't use EXYNOS_IOMMU driver symbols,
as the latter doesn't export any
  - the correct probe order (EXYNOS_IOMMU first, then its users) is
already ensured in device tree, by referencing sysmmu phandles in
"iommus = <&...>" properties

So I'm not sure if it makes sense to make those drivers depend on
EXYNOS_IOMMU in Kconfig? AFAIR, there could've been some issues if
those used some exported symbols from EXYNOS_IOMMU, but it's not the
case.

Please let me know if I'm missing something.

> Sure, I'll check all Kconfigs and defconfigs before sending out v2.
>
> Btw, can you please also check my most recent reply [1] for the
> "[PATCH 1/2] iommu/exynos: Abstract getting the fault info"?
>
> [1] https://lore.kernel.org/lkml/CAPLW+4n-Lf6je61rxdJ9nJnX9h9F8F-y+qikG7eFF0avQpMV9Q@mail.gmail.com/
>
> Thanks!
>
> [snip]
