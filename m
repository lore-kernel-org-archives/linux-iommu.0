From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v7 00/25] Exynos SYSMMU (IOMMU) integration with DT
 andDMA-mapping subsystem
Date: Fri, 29 May 2015 08:54:36 +0900
Message-ID: <5567AABC.1040008@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
 <CABxcv=nP5n1d=yv5EyD3aUcBBuD7Bka_7VQ1KsbFb9=ju37rdA@mail.gmail.com>
 <555FFA64.6030709@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <555FFA64.6030709@kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Marek Szyprowski <m.szyprowski@samsung.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On 23.05.2015 12:56, Kukjin Kim wrote:
> On 05/20/15 16:31, Javier Martinez Canillas wrote:
>> Hello Marek,
>>
>> On Tue, May 19, 2015 at 3:20 PM, Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>> Hello Everyone,
>>>
>>> This is yet another attempt to get Exynos SYSMMU driver with integrated
>>> with IOMMU & DMA-mapping subsystems. This version includes minor fixes
>>> suggested by Joerg Roedel, Cho KyongHo and Robin Murphy.
>>>
>>> All patches are also available in the following git repository:
>>> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git
>>> branch v4.1-exynos-iommu-v7.
>>>
>>> My plan for merging this patchset is as follows:
>>> - DTS changes and power domain changes should go via Samsung tree to avoid
>>>   conflicts with other pending DTS patches
>>> - all exynos-iommu patches and dma-mapping/reserved iommu region should go
>>>   via IOMMU tree,
>>> - all Exynos DRM patches should go via DRM/Exynos tree.
>>>
>>> There are no build cross-subsystem dependencies and IOMMU on Exynos is
>>> already nonfunctional (and disabled in defconfig), so merging patches in
>>> parts doesn't break anything.
>>>
>>> There are knowns issues with Exynos DRM driver and IOMMU support
>>> (i.e. Xorg freeze reported by Javier Martinez Canillas:
>>> http://www.spinics.net/lists/linux-samsung-soc/msg44350.html ). They
>>> will be handled by a separate fixes to Exynos DRM drivers. This patchset
>>> fixes only those issues in Exynos DRM FIMD driver, which prevents
>>> booting to console.
>>>
>>
>> I tested your v7 using exynos_defconfig + CONFIG_EXYNOS_IOMMU on both
>> Exynos5250 Snow and Exynos5420 Peach Pit Chromebooks.
>>
>> I can only reproduce the complete system hang on Xorg if I use the
>> xf86-video-armsoc DDX. If I use the -fbdev DDX instead, X starts
>> correctly and the system does not freeze. Also, this only happens on
>> Exynos5420 Peach Pit, Exynos5250 Snow is working correctly even when
>> using the -armsoc DDX.
>>
>> So as you said, this is a separate issue with the Exynos DRM driver
>> IOMMU support and is not related to your series. For the whole series:
>>
>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>
> Thanks for your test on the boards.
> 
> I'll sort out the arch/ side changes into samsung tree in this weekend.

Hi Kukjin,

How is the progress of sorting out this patchset? There will be some
conflicts between this and DTS-label-rework so maybe you want something
to be rebased?

Best regards,
Krzysztpf
