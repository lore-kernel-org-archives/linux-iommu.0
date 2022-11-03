Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA6F6FCC
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 13:03:20 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so1741140pjk.1
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sCUBB08PoVZ26bcT4Cxprl0+CgnyFaSro8o/etFxILQ=;
        b=NMOF7LMrwGZkM4Tpc29C7h3cTqZFKOVJ3vIia5vjFEJJ4H7B5PBOcPyzkq455HN7gk
         FTmv3c9jmCde5kxbFdR10ZoLz4a0JGb7Znsy/G7IW3aeadZOKKCIwmKa6neDPb/+PMlQ
         G5q3pQ/DzKlFHkwEqE1EWRBb8h1BN/hw2oOsWTTcIxbTC8Rbh0h6JO5zsVlRMtfDcPmG
         EwsBA48uyosKZ2jbVe5iAc8agQJkePiVass7YVRzKWxPROkBwJrrtbt0YtPlspLlftVk
         CaAE3bU5N7T2BznUtAq+AbzJjt2hmk0sVJOfygsa2zvm6OklRDJ4p1kusTQunUxAS2Uc
         +2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCUBB08PoVZ26bcT4Cxprl0+CgnyFaSro8o/etFxILQ=;
        b=mDwvwDpGWGC+J90pYRLZ8wa1eOZaAx+5JyXwb18hbnool8kLBHMCbBHEq+lmIeuXVC
         v7ijGuZFo2AtoH3g6Qr7Lpn9l5qXeAqTcGVvKWogscS7JxkyYwiS1DCVtCKDMFbxoeQs
         r6m0GFAfNTwb0hXCNEC6UpfeNsAJHtngmg5RaN2iKqjs/KFw0JXCzp61ouoQszgsCugA
         Um9JUBCS+tsOkpvVmMuXm9HkMNiccXQwU6xqQbpB3TbD5SWjLeFVO4DWApFU2DcANpGn
         tyF85yiFvLjILaR0ws59zB03c1I2oEiPYfIRvwe0Qw4XXQ71SkpI2f7/JWEjN+NV1ena
         ff4Q==
X-Gm-Message-State: ACrzQf2BKT6B7MgXC5lPMLg0MPXa9tA+M3UW6GsvEQHr6dT4j7ZHzZvI
	WLJtftzWVWyISEMMx5X83TorDUsqSTaL41H+23PezQ==
X-Google-Smtp-Source: AMsMyM7FZiZCLkFDkx1bnVpjXpomckekbyKXpexKWDuVwHGpOCtLDD7blXzZ7m7RqCbEnHJAeDZqypgjZcrJQy4UliA=
X-Received: by 2002:a17:903:41cc:b0:186:b756:a5f0 with SMTP id
 u12-20020a17090341cc00b00186b756a5f0mr30145351ple.132.1667480600358; Thu, 03
 Nov 2022 06:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221028191243.31721-1-semen.protsenko@linaro.org>
 <CGME20221028191256eucas1p1a4fd95cbcc44959fa968956a92738f03@eucas1p1.samsung.com>
 <20221028191243.31721-4-semen.protsenko@linaro.org> <7ed8c884-cee1-7cb0-f2ce-f7ec156cd841@samsung.com>
In-Reply-To: <7ed8c884-cee1-7cb0-f2ce-f7ec156cd841@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 3 Nov 2022 14:03:08 +0100
Message-ID: <CAPLW+4nrns9BovWCTOsi3F7=2FWLi2sK0+Cid4Cva2Vs2ZWdqQ@mail.gmail.com>
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

Hi Marek,

[snip]

> MODULE_DEVICE_TABLE(of, sysmmu_of_match); is missing, so the driver
> won't be automatically loaded, what breaks its operation if compiled as
> module.
>

Right, didn't think about hot-plug case. Will add
MODULE_DEVICE_TABLE() along with MODULE_ALIAS() in v2, thanks.

> Also Exynos DRM and S5P-MFC drivers rely on the Exynos IOMMU being
> built-in, so they need to be adjusted for modularized builds too imho,
> at least in the Kconfig dependency.
>

Sure, I'll check all Kconfigs and defconfigs before sending out v2.

Btw, can you please also check my most recent reply [1] for the
"[PATCH 1/2] iommu/exynos: Abstract getting the fault info"?

[1] https://lore.kernel.org/lkml/CAPLW+4n-Lf6je61rxdJ9nJnX9h9F8F-y+qikG7eFF0avQpMV9Q@mail.gmail.com/

Thanks!

[snip]
