Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C32C433EF
	for <iommu@archiver.kernel.org>; Fri, 21 Jan 2022 11:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 167DE40A40;
	Fri, 21 Jan 2022 11:09:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nhBd4AOGqO6W; Fri, 21 Jan 2022 11:09:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 27B9F40999;
	Fri, 21 Jan 2022 11:09:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08E3AC0039;
	Fri, 21 Jan 2022 11:09:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD58AC002F
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 11:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2ADB409BB
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 11:09:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wFauMjNxx2sX for <iommu@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 11:09:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6CD2140996
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 11:09:08 +0000 (UTC)
Received: by mail-vk1-xa36.google.com with SMTP id m131so5331421vkm.7
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 03:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WyUpFdPwwu3fMiJ/9hEV9RfL0IhWJOMBQfCbot0LIC0=;
 b=cnj5NCChjX5Ou+ftTBTz2yzN1TY9qHPYzGBdKUozgVejGKurQCGa3Y8c/oiRKfrPbK
 JxOC2mg8fLYIItO3UxjpbHqJ77jadUIaCm49C5uSNCt7KPdC06VPtZ2pnKJEpSSw0e7+
 zqNbOQ5TgJ5cYC6pMicUGNhRbtOAxLDwAXO1DzpgNZH9KYiQEJ/5JaPmbSNuKH6yJG0U
 UcHgiG9RJ6BTmfJyV8H0r2mw7zYhBiFSKnSaBzJuSLnKLtEwrcKwWGmnxFhhZh+Pqlk8
 7q8u6/O3LP3SxhemjZOABgpiSIi9TOKsVYjhEOaUmUEjm/0McdfmnL/TciibrQOsc/4x
 QJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WyUpFdPwwu3fMiJ/9hEV9RfL0IhWJOMBQfCbot0LIC0=;
 b=KSS/xiGmI4UpgPERLPdim9BOcdbA0gnwEPgbyraeIOL7lsGgLMDlnI8OsQImKM+g54
 uU138H/u1ypI7MmytenbXcVi9Mzu1NX2G0U2/tcSTxQPOYUJRcYxXqPGS/9Vsop+9xyP
 EbQlIzua/nIvgakwLdUL/lHisMg92/dbjpi+QAIicGDAUpOnIwKapqUhPDeWXjBTqDBd
 mBxRUIis0vY1lr+d3vTAw5fRntYbWZmiSqviJUf63ZRrm0OTj1/0AVKTwClkuuNnYFqD
 3QwOh/tlhhsoXJ7olOClwMcKVch2rHpY7tI9J+++P3hJxO+TjoiC755wbDg1CIakv6t7
 GvYQ==
X-Gm-Message-State: AOAM533OPEX2N+uGdXc8jcN167Xp/wRMJlgUUeqyPyUxGX8ZsqZM3wBB
 hsOotNdxZgPcVydrzIHbfVWUbG6kNQT8+aNV7xM+yA==
X-Google-Smtp-Source: ABdhPJw3NIVk0qJHehAGeNccANJK4kjzFu1/gfyrccc/q61I7lCdu7fcP08+4G4KRhuu8RWU4ZOtNtN0oZ51DLmn6RU=
X-Received: by 2002:ac5:cdb0:: with SMTP id l16mr1274338vka.14.1642763346996; 
 Fri, 21 Jan 2022 03:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20220120201958.2649-1-semen.protsenko@linaro.org>
 <20220120201958.2649-3-semen.protsenko@linaro.org>
 <a111932a-6685-2a9d-abce-87af26b121a4@canonical.com>
In-Reply-To: <a111932a-6685-2a9d-abce-87af26b121a4@canonical.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 21 Jan 2022 13:08:55 +0200
Message-ID: <CAPLW+4kKR+7hM-eZc8-v6Dzeaj+TPBRmCLDSVNEnfx2WmN2TJA@mail.gmail.com>
Subject: Re: [RFC 2/3] iommu/samsung: Introduce Exynos sysmmu-v8 driver
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Carlos Llamas <cmllamas@google.com>,
 Will Deacon <will@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Mark Salyzyn <salyzyn@google.com>,
 Jinkyu Yang <jinkyu1.yang@samsung.com>, Thierry Strudel <tstrudel@google.com>,
 Will McVicker <willmcvicker@google.com>, Cho KyongHo <pullip.cho@samsung.com>,
 linux-arm-kernel@lists.infradead.org, Jonglin Lee <jonglin@google.com>,
 "J . Avila" <elavila@google.com>, Alex <acnwigwe@google.com>,
 linux-kernel@vger.kernel.org, Hyesoo Yu <hyesoo.yu@samsung.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 21 Jan 2022 at 10:40, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 20/01/2022 21:19, Sam Protsenko wrote:
> > Introduce new driver for modern Exynos ARMv8 SoCs, e.g. Exynos850. Also
> > it's used for Google's GS101 SoC.
> >
> > This is squashed commit, contains next patches of different authors. See
> > `iommu-exynos850-dev' branch for details: [1].
> >
> > Original authors (Samsung):
> >
> >  - Cho KyongHo <pullip.cho@samsung.com>
> >  - Hyesoo Yu <hyesoo.yu@samsung.com>
> >  - Janghyuck Kim <janghyuck.kim@samsung.com>
> >  - Jinkyu Yang <jinkyu1.yang@samsung.com>
> >
> > Some improvements were made by Google engineers:
> >
> >  - Alex <acnwigwe@google.com>
> >  - Carlos Llamas <cmllamas@google.com>
> >  - Daniel Mentz <danielmentz@google.com>
> >  - Erick Reyes <erickreyes@google.com>
> >  - J. Avila <elavila@google.com>
> >  - Jonglin Lee <jonglin@google.com>
> >  - Mark Salyzyn <salyzyn@google.com>
> >  - Thierry Strudel <tstrudel@google.com>
> >  - Will McVicker <willmcvicker@google.com>
> >
> > [1] https://github.com/joe-skb7/linux/tree/iommu-exynos850-dev
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/iommu/Kconfig               |   13 +
> >  drivers/iommu/Makefile              |    3 +
> >  drivers/iommu/samsung-iommu-fault.c |  617 +++++++++++
> >  drivers/iommu/samsung-iommu-group.c |   50 +
> >  drivers/iommu/samsung-iommu.c       | 1521 +++++++++++++++++++++++++++
> >  drivers/iommu/samsung-iommu.h       |  216 ++++
> >  6 files changed, 2420 insertions(+)
> >  create mode 100644 drivers/iommu/samsung-iommu-fault.c
> >  create mode 100644 drivers/iommu/samsung-iommu-group.c
> >  create mode 100644 drivers/iommu/samsung-iommu.c
> >  create mode 100644 drivers/iommu/samsung-iommu.h
> >
>
> Existing driver supports several different Exynos SysMMU IP block
> versions. Several. Please explain why it cannot support one more version?
>
> Similarity of vendor driver with mainline is not an argument.
>
>
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 3eb68fa1b8cc..78e7039f18aa 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -452,6 +452,19 @@ config QCOM_IOMMU
> >       help
> >         Support for IOMMU on certain Qualcomm SoCs.
> >
> > +config SAMSUNG_IOMMU
> > +     tristate "Samsung IOMMU Support"
> > +     select ARM_DMA_USE_IOMMU
> > +     select IOMMU_DMA
> > +     select SAMSUNG_IOMMU_GROUP
> > +     help
> > +       Support for IOMMU on Samsung Exynos SoCs.
> > +
> > +config SAMSUNG_IOMMU_GROUP
> > +     tristate "Samsung IOMMU Group Support"
> > +     help
> > +       Support for IOMMU group on Samsung Exynos SoCs.
> > +
> >  config HYPERV_IOMMU
> >       bool "Hyper-V x2APIC IRQ Handling"
> >       depends on HYPERV && X86
> > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > index bc7f730edbb0..a8bdf449f1d4 100644
> > --- a/drivers/iommu/Makefile
> > +++ b/drivers/iommu/Makefile
> > @@ -27,6 +27,9 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
> >  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
> >  obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
> >  obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
> > +obj-$(CONFIG_SAMSUNG_IOMMU) += samsung_iommu.o
> > +samsung_iommu-objs += samsung-iommu.o samsung-iommu-fault.o
> > +obj-$(CONFIG_SAMSUNG_IOMMU_GROUP) += samsung-iommu-group.o
> >  obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o io-pgfault.o
> >  obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
> >  obj-$(CONFIG_APPLE_DART) += apple-dart.o
> > diff --git a/drivers/iommu/samsung-iommu-fault.c b/drivers/iommu/samsung-iommu-fault.c
> > new file mode 100644
> > index 000000000000..c6b4259976c4
> > --- /dev/null
> > +++ b/drivers/iommu/samsung-iommu-fault.c
> > @@ -0,0 +1,617 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> > + */
> > +
> > +#define pr_fmt(fmt) "sysmmu: " fmt
> > +
> > +#include <linux/smc.h>
> > +#include <linux/arm-smccc.h>
> > +#include <linux/pm_runtime.h>
> > +
> > +#include "samsung-iommu.h"
> > +
> > +#define MMU_TLB_INFO(n)                      (0x2000 + ((n) * 0x20))
> > +#define MMU_CAPA1_NUM_TLB_SET(reg)   (((reg) >> 16) & 0xFF)
> > +#define MMU_CAPA1_NUM_TLB_WAY(reg)   ((reg) & 0xFF)
> > +#define MMU_CAPA1_SET_TLB_READ_ENTRY(tid, set, way, line)            \
> > +                                     ((set) | ((way) << 8) |         \
> > +                                      ((line) << 16) | ((tid) << 20))
> > +
> > +#define MMU_TLB_ENTRY_VALID(reg)     ((reg) >> 28)
> > +#define MMU_SBB_ENTRY_VALID(reg)     ((reg) >> 28)
> > +#define MMU_VADDR_FROM_TLB(reg, idx) ((((reg) & 0xFFFFC) | ((idx) & 0x3)) << 12)
> > +#define MMU_VID_FROM_TLB(reg)                (((reg) >> 20) & 0x7U)
> > +#define MMU_PADDR_FROM_TLB(reg)              ((phys_addr_t)((reg) & 0xFFFFFF) << 12)
> > +#define MMU_VADDR_FROM_SBB(reg)              (((reg) & 0xFFFFF) << 12)
> > +#define MMU_VID_FROM_SBB(reg)                (((reg) >> 20) & 0x7U)
> > +#define MMU_PADDR_FROM_SBB(reg)              ((phys_addr_t)((reg) & 0x3FFFFFF) << 10)
> > +
> > +#define REG_MMU_INT_STATUS           0x060
> > +#define REG_MMU_INT_CLEAR            0x064
> > +#define REG_MMU_FAULT_RW_MASK                GENMASK(20, 20)
> > +#define IS_READ_FAULT(x)             (((x) & REG_MMU_FAULT_RW_MASK) == 0)
> > +
> > +#define SYSMMU_FAULT_PTW_ACCESS   0
> > +#define SYSMMU_FAULT_PAGE_FAULT   1
> > +#define SYSMMU_FAULT_ACCESS       2
> > +#define SYSMMU_FAULT_RESERVED     3
> > +#define SYSMMU_FAULT_UNKNOWN      4
> > +
> > +#define SYSMMU_SEC_FAULT_MASK                (BIT(SYSMMU_FAULT_PTW_ACCESS) | \
> > +                                      BIT(SYSMMU_FAULT_PAGE_FAULT) | \
> > +                                      BIT(SYSMMU_FAULT_ACCESS))
> > +
> > +#define SYSMMU_FAULTS_NUM         (SYSMMU_FAULT_UNKNOWN + 1)
> > +
> > +#if IS_ENABLED(CONFIG_EXYNOS_CONTENT_PATH_PROTECTION)
>
> You just copy-pasted vendor stuff, without actually going through it.
>
> It is very disappointing because instead of putting your own effort, you
> expect community to do your job.
>
> What the hell is CONFIG_EXYNOS_CONTENT_PATH_PROTECTION?
>
> I'll stop reviewing. Please work on extending existing driver. If you
> submitted something nice and clean, ready for upstream, instead of
> vendor junk, you could get away with separate driver. But you did not.
> It looks really bad.
>

Krzysztof, that's not what I asked in my patch 0/3. I probably wasn't
really clear, sorry. Let me please try and describe that better, and
maybe provide some context.

I'm just starting to work on that driver, it's basically downstream
version of it. Of course I'm going to rework it before sending the
actual patch series (that's why this series has RFC tag). I'd never
asked community to do my job for me and really review the downstream
driver! I just want to know from the starters some *very* basic and
high-level info, which could help me to rework the driver in correct
way. Like naming of files, compatible strings, should it be part of
existing driver or it's ok to have it as another platform_driver. In
other words, that kind of "review" shouldn't take more than 2 minutes
of your time. And it could spare us all unneeded extra review rounds
in future. Right now I don't need the code review per se (and I'm
really sorry you had to spend your time on that, knowing how busy
maintainers can be during the MW). I thought about omitting the code
at all, only asking the questions, but then I figured it's a good idea
to attach some code for the reference. Maybe it wasn't a good idea
after all.

For the record, I'm well aware that we don't send downstream code
without making it upstreamable first, and I know it must be tested
well, etc. For example, you already saw me sending clk-exynos850
driver, which I re-implemented from scratch, and it has ~0.0% of
downstream code. So why would I change my policy about that all of the
sudden... Anyway, hope you understand now that there weren't any ill
intentions on my side, w.r.t. this RFC.

> Best regards,
> Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
