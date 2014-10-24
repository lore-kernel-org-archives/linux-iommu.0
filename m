From: Stefan Hengelein <stefan.hengelein@fau.de>
Subject: Re: [PATCH] arm: dma-mapping: fix compilation error when CONFIG_MMU
 is not present
Date: Fri, 24 Oct 2014 15:15:02 +0200
Message-ID: <CABv5NL_E83CgBcHbAqo9xejWAEamO3oxX6ZjU+fo9X6k4cE_1w@mail.gmail.com>
References: <1413734340-53108-1-git-send-email-stefan.hengelein@fau.de>
	<5444BCFF.8030803@samsung.com>
	<CABv5NL_GdtZegpw8wxau9oD6xXWdX3GUySLqCaoaoa549Kg_GQ@mail.gmail.com>
	<5445A345.7010401@codeaurora.org>
	<5448B930.7070800@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5448B930.7070800@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, Laura Abbott <lauraa@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org, Valentin Rothberg <valentinrothberg@gmail.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hello,

adding a dependency to CONFIG_ARM_DMA_USE_IOMMU is probably not a good
idea anyways.
If you read the Documentation/kbuild/kconfig-language.txt, you will see=
 that:
1. in general, selected options should have no prompt and no dependenci=
es
2. giving ARM_DMA_USE_IOMMU a dependency on MMU will and cannot solve
the problem, since ARM_DMA_USE_IOMMU itself is selected by several
sources and select will not enforce dependencies to be resolved (to be
precise, it will simply ignore them). Thus, CONFIG_MMU will not be
enabled (as you can see in your warning).
If you want to ensure CONFIG_MMU is enabled when
CONFIG_ARM_DMA_USE_IOMMU is selected, the selecting options (e.g.
SHMOBILE_IOMMU) should have a dependency on MMU.
However, i'm not sure if that's the right way to solve it, since it
will hide these options when MMU is not enabled.

Making the whole IOMMU subsystem depend on MMU would probably also
solve the problem. Is there any situation where it would make sense to
use an IOMMU without an MMU?

Best Regards,
Stefan Hengelein

2014-10-23 10:15 GMT+02:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> Hello,
>
>
> On 2014-10-21 02:05, Laura Abbott wrote:
>>
>> On 10/20/2014 6:50 AM, Stefan Hengelein wrote:
>>>
>>> Well,
>>>
>>> arch/arm/mm/dma-mapping.c: In function =E2=80=98__atomic_get_pages=E2=
=80=99:
>>> arch/arm/mm/dma-mapping.c:1265:31: error: =E2=80=98atomic_pool=E2=80=
=99 undeclared
>>> (first use in this function)
>>>
>>> arch/arm/mm/dma-mapping.c: In function =E2=80=98__iommu_get_pages=E2=
=80=99:
>>> arch/arm/mm/dma-mapping.c:1275:2: error: implicit declaration of
>>> function =E2=80=98__in_atomic_pool=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declaration]
>>>
>>>
>>> others:
>>> arch/arm/mm/dma-mapping.c: In function =E2=80=98__iommu_alloc_remap=
=E2=80=99:
>>> arch/arm/mm/dma-mapping.c:1200:4: error: =E2=80=98VM_ARM_DMA_CONSIS=
TENT=E2=80=99
>>> undeclared (first use in this function)
>>> arch/arm/mm/dma-mapping.c:1200:4: note: each undeclared identifier =
is
>>> reported only once for each function it appears in
>>>
>>> arch/arm/mm/dma-mapping.c: In function =E2=80=98__iommu_get_pages=E2=
=80=99:
>>> arch/arm/mm/dma-mapping.c:1282:29: error: =E2=80=98VM_ARM_DMA_CONSI=
STENT=E2=80=99
>>> undeclared (first use in this function)
>>> arch/arm/mm/dma-mapping.c: In function =E2=80=98arm_iommu_free_attr=
s=E2=80=99:
>>> arch/arm/mm/dma-mapping.c:1411:4: error: =E2=80=98VM_ARM_DMA_CONSIS=
TENT=E2=80=99
>>> undeclared (first use in this function)
>>>
>>>
>>> i've attached a configuration where it happens.
>>> when you place the configuration in your tree and compile the file,
>>> the errors should show up.
>>>
>>> However, within the configuration CONFIG_ARM_DMA_USE_IOMMU is defin=
ed
>>> and CONFIG_MMU is not. AFAIUI, if both should be enabled together, =
it
>>> should be mapped in Kconfig somewhere, right?
>>
>>
>> There isn't a nice way to fixup the dma consistent flags so I would
>> say this option should just depend on MMU.
>
>
> The question is which option should depend on MMU? Making
> CONFIG_ARM_DMA_USE_IOMMU
> to depend on MMU doesn't solve this case. It only gives following war=
ning
> with the
> mentioned .config:
> warning: (VIDEO_OMAP3 && EXYNOS_IOMMU && SHMOBILE_IOMMU && IPMMU_VMSA=
 &&
> ARM_SMMU) selects ARM_DMA_USE_IOMMU which has unmet direct dependenci=
es
> (MMU)
>
> IMHO the best solution will be to either make the whole IOMMU subsyst=
em to
> depend
> on MMU or alternatively, add this dependency to all IOMMU drivers whi=
ch can
> be
> enabled by COMPILE_TEST option (here the issue is caused by SHMOBILE_=
IOMMU,
> which
> otherwise cannot be enabled when no-mmu systems are selected).
>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
